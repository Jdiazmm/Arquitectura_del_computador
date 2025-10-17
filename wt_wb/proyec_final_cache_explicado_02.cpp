


#include <iostream>     // Para imprimir en consola (std::cout)
#include <vector>       // Para usar std::vector (cache y RAM)
#include <cstdint>      // Para tipos con tamaño fijo (uint32_t)
#include <ctime>        // Para medir tiempo de ejecución (clock)
#include <climits>      // Para constantes como INT_MAX
#include <algorithm>    // Para std::fill

// ---------------------------
// Configuración del simulador
// ---------------------------

// Número de líneas (bloques) en la caché.
// En una implementación real este valor sería mucho mayor.
// Aquí lo mantenemos pequeño para facilitar la visualización y pruebas.
constexpr int CACHE_SIZE = 4;

// Tamaño de bloque en bytes (simplificado).
// En este simulador tratamos cada bloque como una única "entrada" identificada por el tag.
// BLOCK_SIZE permite convertir una dirección en un número de bloque (tag) mediante división.
constexpr int BLOCK_SIZE = 16;

// Tamaño de la memoria principal (número de bloques).
// RAM_SIZE debe ser mayor que el número de tags que use tu dataset.
constexpr int RAM_SIZE = 256;

// ---------------------------
// Estructuras y variables
// ---------------------------

// Representa una línea en la caché.
// Cada línea contiene metadatos necesarios para simular comportamiento real:
struct CacheLine {
    bool valid = false;      // Indica si la línea contiene datos válidos (si no, puede usarse libremente)
    uint32_t tag = 0;        // Identificador del bloque que actualmente almacena la línea
    bool dirty = false;      // Marca si la línea fue modificada (true => write-back requiere escribir a RAM al expulsar)
    int data = 0;            // Dato simulado almacenado en la línea (aquí un int para simplificar)
    int last_used = 0;       // Contador para implementar LRU (almacena "timestamp" lógico del último acceso)
};

// Representación de la caché: vector con CACHE_SIZE líneas.
// Usamos std::vector para comodidad; en hardware sería un array con comparadores paralelos.
std::vector<CacheLine> cache(CACHE_SIZE);

// Representación de la memoria principal (RAM).
// Cada índice representa un "bloque" simplificado; inicializamos con ceros.
std::vector<int> RAM(RAM_SIZE, 0);

// ---------------------------
// Estadísticas para output
// ---------------------------

// Contadores globales que nos permiten comparar el comportamiento de las dos estrategias.
int write_through_writes_to_ram = 0; // Número de escrituras reales a RAM en write-through
int write_back_writes_to_ram = 0;    // Número de escrituras reales a RAM en write-back
int write_back_replacements = 0;     // Número de reemplazos que implicaron escritura (bloque dirty)

// Contador global lógico (no tiempo real) que usamos para simular timestamps de acceso.
// Cada vez que accedemos a una línea, incrementamos este contador y guardamos su valor en last_used.
int global_access_counter = 0;

// ---------------------------
// Inicialización
// ---------------------------

// Inicializa (o reinicia) la caché y RAM antes de cada simulación.
// Esto asegura que cada estrategia parte de un estado limpio y comparable.
void init_cache_ram() {
    for (auto &line : cache) {
        line.valid = false;       // Línea inválida → disponible
        line.tag = 0;             // Limpiamos el identificador
        line.dirty = false;       // No hay datos "sucios"
        line.data = 0;            // Datos a 0 por defecto
        line.last_used = 0;       // Sin uso previo
    }
    // Llenamos toda la RAM con ceros (estado inicial).
    std::fill(RAM.begin(), RAM.end(), 0);
    // Reseteamos el contador lógico de accesos.
    global_access_counter = 0;
}

// ---------------------------
// Operaciones de búsqueda
// ---------------------------

// Busca una línea en caché cuyo tag coincida con el proporcionado.
// Si la encuentra, actualiza su last_used para LRU y devuelve su índice.
// Si no la encuentra, devuelve -1.
int find_line(uint32_t tag) {
    for (int i = 0; i < CACHE_SIZE; i++) {
        // Solo consideramos líneas válidas.
        if (cache[i].valid && cache[i].tag == tag) {
            // Actualizamos el contador lógico para registrar la recurrencia de acceso
            // (LRU se basa en estos valores).
            cache[i].last_used = ++global_access_counter;
            return i;
        }
    }
    return -1; // Miss en caché
}

// Busca una línea libre (inválida) en la caché y devuelve su índice.
// Si no hay líneas libres, devuelve -1.
int find_free_line() {
    for (int i = 0; i < CACHE_SIZE; i++) {
        if (!cache[i].valid) {
            // Si encontramos una línea inválida, la "reservamos" lógicamente actualizando last_used
            cache[i].last_used = ++global_access_counter;
            return i;
        }
    }
    return -1; // No hay espacio libre
}

// ---------------------------
// Reemplazo LRU (Least Recently Used)
// ---------------------------

// Implementa LRU buscando la línea con menor valor de last_used (menos recientemente usada).
// Si la línea seleccionada está marcada como dirty (sucia), primero la escribe en RAM
// antes de invalidarla y devolver su índice para reutilización.
int replace_line_lru() {
    int lru_index = -1;        // Índice candidato a reemplazo
    int min_used = INT_MAX;    // Minimo valor de last_used encontrado

    // Recorremos la caché buscando la línea menos recientemente usada.
    for (int i = 0; i < CACHE_SIZE; i++) {
        if (cache[i].last_used < min_used) {
            min_used = cache[i].last_used;
            lru_index = i;
        }
    }

    // Seguridad: en teoría lru_index siempre se establece si CACHE_SIZE>0.
    if (lru_index == -1) {
        // Situación improbable (por seguridad); retornamos 0 para no bloquear la ejecución.
        return 0;
    }

    // Si la línea está sucia, escribir el dato a RAM antes de eliminarla.
    // En un sistema real esto es un write-back físico a memoria principal.
    if (cache[lru_index].dirty) {
        uint32_t block_address = cache[lru_index].tag;
        // Escribimos el dato almacenado en la línea a la RAM (simulación).
        RAM[block_address] = cache[lru_index].data;
        // Actualizamos contadores estadísticos.
        write_back_writes_to_ram++;
        write_back_replacements++;
        // Mensaje informativo (útil al depurar o analizar la ejecución).
        std::cout << "Write-back: Escribiendo bloque sucio (tag " << block_address << ") en RAM antes de reemplazar\n";
    }

    // Invalida la línea para que pueda ser reutilizada por la carga de un nuevo bloque.
    cache[lru_index].valid = false;
    cache[lru_index].dirty = false;
    cache[lru_index].data = 0;
    cache[lru_index].last_used = 0;

    return lru_index; // Retornamos el índice que ahora está disponible
}

// ---------------------------
// Estrategias de escritura
// ---------------------------

// WRITE-THROUGH:
// - Si el bloque (tag) no está en caché: se carga desde RAM (miss handling).
// - En cualquier caso, la escritura actualiza la línea de caché y *además* actualiza RAM inmediatamente.
// - Esto garantiza coherencia inmediata entre caché y RAM pero genera muchas escrituras a memoria.
void write_through(uint32_t address, int value) {
    // Calculamos el tag (número de bloque) a partir de la dirección y el tamaño del bloque.
    // En una simulación simplificada se asume una correspondencia directa: dirección / BLOCK_SIZE.
    uint32_t tag = address / BLOCK_SIZE;

    // Buscamos si el bloque ya está en caché (hit).
    int idx = find_line(tag);

    // Si miss, debemos traer el bloque desde RAM.
    if (idx == -1) {
        // Intentamos encontrar una línea libre.
        int free_idx = find_free_line();
        if (free_idx == -1) {
            // Si no hay línea libre, reemplazamos según LRU.
            free_idx = replace_line_lru();
        }

        // Cargamos el bloque desde la RAM a la línea seleccionada.
        cache[free_idx].valid = true;
        cache[free_idx].tag = tag;
        cache[free_idx].dirty = false;         // En write-through no dejamos la línea como sucia tras cargar
        cache[free_idx].data = RAM[tag];       // Copiamos el dato actual desde RAM
        cache[free_idx].last_used = ++global_access_counter;
        idx = free_idx;

        std::cout << "Write-through: Carga bloque " << tag << " a cache\n";
    } else {
        // Si hit, solo informamos (y la línea ya actualizó last_used en find_line).
        std::cout << "Write-through: Bloque " << tag << " ya esta en cache\n";
    }

    // Actualizamos el dato en caché...
    cache[idx].data = value;
    // ...y escribimos inmediatamente el mismo dato en RAM (característica de write-through).
    RAM[tag] = value;

    // Estadística: contamos una escritura a RAM para esta operación.
    write_through_writes_to_ram++;

    std::cout << "Write-through: Escritura valor " << value << " en cache y en RAM (bloque " << tag << ")\n";
}

// WRITE-BACK:
// - Si el bloque no está en caché: se carga desde RAM (miss handling).
// - La escritura se realiza **solo en caché** y la línea se marca como 'dirty'.
// - La RAM se actualiza únicamente cuando la línea dirty es reemplazada (o al flush final).
void write_back(uint32_t address, int value) {
    uint32_t tag = address / BLOCK_SIZE;
    int idx = find_line(tag);

    // Si miss en caché, traemos el bloque desde RAM (posible reemplazo LRU).
    if (idx == -1) {
        int free_idx = find_free_line();
        if (free_idx == -1) {
            free_idx = replace_line_lru();
        }

        // Cargamos bloque desde RAM a caché (estado limpio justo después de cargar)
        cache[free_idx].valid = true;
        cache[free_idx].tag = tag;
        cache[free_idx].dirty = false;    // tras carga no está modificado todavía
        cache[free_idx].data = RAM[tag];  // copiamos el dato desde RAM
        cache[free_idx].last_used = ++global_access_counter;
        idx = free_idx;

        std::cout << "Write-back: Carga bloque " << tag << " a cache\n";
    } else {
        std::cout << "Write-back: Bloque " << tag << " ya esta en cache\n";
    }

    // Actualizamos el dato solo en caché y marcamos la línea como sucia (dirty).
    cache[idx].data = value;
    cache[idx].dirty = true;
    // Actualizamos last_used para reflejar el acceso (LRU).
    cache[idx].last_used = ++global_access_counter;

    std::cout << "Write-back: Escritura valor " << value << " en cache, bloque marcado como dirty\n";
}

// ---------------------------
// Verificación de coherencia
// ---------------------------

// Comprueba que los valores en caché y en RAM sean consistentes según la estrategia:
// - Para write-through: la caché y la RAM deben coincidir siempre.
// - Para write-back: si la línea NO está sucia (dirty == false), los valores deben coincidir;
//   si la línea está sucia, es esperable que la RAM tenga el valor "antiguo" hasta el write-back.
void verificar_coherencia(bool es_write_back) {
    std::cout << "\nVerificando coherencia (" << (es_write_back ? "Write-Back" : "Write-Through") << ")...\n";
    int incoherencias = 0;

    for (int i = 0; i < CACHE_SIZE; i++) {
        if (cache[i].valid) {
            uint32_t tag = cache[i].tag;
            int cache_value = cache[i].data;
            int ram_value = RAM[tag];

            if (es_write_back) {
                // En write-back es válido que la línea esté sucia (dirty==true) y la RAM no refleje
                // el valor más reciente aún. Solo detectamos incoherencia si no está dirty pero sus
                // valores no coinciden (situación errónea).
                if (!cache[i].dirty && cache_value != ram_value) {
                    std::cout << "Incoherencia: Bloque " << tag << " → Cache = " << cache_value << ", RAM = " << ram_value << '\n';
                    incoherencias++;
                }
            } else {
                // En write-through, memoria y caché deberían coincidir siempre.
                if (cache_value != ram_value) {
                    std::cout << "Incoherencia: Bloque " << tag << " → Cache = " << cache_value << ", RAM = " << ram_value << '\n';
                    incoherencias++;
                }
            }
        }
    }

    if (incoherencias == 0) {
        std::cout << "Coherencia garantizada.\n";
    } else {
        std::cout << incoherencias << " incoherencias detectadas.\n";
    }
}

// ---------------------------
// Función principal (simulaciones)
// ---------------------------

int main() {
    // --------------------------------------------------
    // Datos de prueba (datos sintéticos definidos explícitamente)
    // --------------------------------------------------
    // writes: direcciones (en bytes) que se escribirán
    // values: valores que se escribirán en dichas direcciones
    // Nota: cada dirección se mapea a un "tag" mediante address/BLOCK_SIZE
    std::vector<uint32_t> writes = {0, 16, 32, 0, 48, 64, 16, 80};
    std::vector<int> values = {10, 20, 30, 40, 50, 60, 70, 80};
    int n = static_cast<int>(writes.size());

    // --------------------------------------------------
    // Simulación: WRITE-THROUGH
    // --------------------------------------------------
    std::cout << "Simulacion Write-Through (con LRU)\n";

    // Inicializamos caché y RAM a estado conocido
    init_cache_ram();
    write_through_writes_to_ram = 0; // reset estadística

    // Tomamos un timestamp de inicio para medir tiempo de ejecución
    clock_t start = clock();

    // Ejecutamos las escrituras secuencialmente según el vector writes/values
    for (int i = 0; i < n; i++) {
        // write_through gestiona miss/hit, carga de bloques, y escritura en RAM
        write_through(writes[i], values[i]);
    }

    // Tomamos timestamp de finalización y calculamos duración en milisegundos
    clock_t end = clock();
    double duration_ms = ((double)(end - start) / CLOCKS_PER_SEC) * 1000.0;

    // Outputs estadísticos para write-through
    std::cout << "Total escrituras en RAM: " << write_through_writes_to_ram << '\n';
    std::cout << "Tiempo total (Write-Through): " << duration_ms << " ms\n";

    // Verificamos coherencia (función separada)
    verificar_coherencia(false); // false => write-through

    // --------------------------------------------------
    // Simulación: WRITE-BACK
    // --------------------------------------------------
    std::cout << "\n--------------------------\nSimulacion Write-Back (con LRU)\n";

    // Re-inicializamos el estado (para comparar escenarios desde el mismo punto)
    init_cache_ram();
    write_back_writes_to_ram = 0;
    write_back_replacements = 0;

    start = clock();

    // Ejecutamos las mismas escrituras, pero usando la política write-back
    for (int i = 0; i < n; i++) {
        write_back(writes[i], values[i]);
    }

    // Después de procesar todas las operaciones, hacemos un "flush" final:
    // escribimos a RAM todas las líneas que queden sucias en caché para garantizar coherencia final.
    for (int i = 0; i < CACHE_SIZE; i++) {
        if (cache[i].valid && cache[i].dirty) {
            // Volcar la línea sucia a RAM.
            RAM[cache[i].tag] = cache[i].data;
            write_back_writes_to_ram++;
            std::cout << "Write-back: Escritura final de bloque sucio (tag " << cache[i].tag << ") a RAM\n";
            // opcionalmente podríamos invalidar, pero no es necesario antes de terminar.
        }
    }

    end = clock();
    duration_ms = ((double)(end - start) / CLOCKS_PER_SEC) * 1000.0;

    // Verificación final y estadísticas
    verificar_coherencia(true); // true => write-back

    std::cout << "Total escrituras en RAM: " << write_back_writes_to_ram << '\n';
    std::cout << "Total reemplazos con escritura en RAM: " << write_back_replacements << '\n';
    std::cout << "Tiempo total (Write-Back): " << duration_ms << " ms\n";

    return 0;
}
