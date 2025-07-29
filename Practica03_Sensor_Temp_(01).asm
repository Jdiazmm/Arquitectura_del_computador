
# PRACTICA DE LABORATORIO III

# Sergio Jose Noguera (30572211)
# Jose Manuel Diaz (25682785)

# ENUNCIADO DEL EJERCICIO 01:

# Sensor de Temperatura. Un computador de 32 bits con procesador MIPS32 y mapa de E/S simulada 
# en memoria dispone de un sensor de temperatura con tres registros de 32 bits, definidos en la 
# memoria de datos y que funcionan de la siguiente manera:

# Registro de control (SensorControl): Cuando se escribe en el registro el valor 0x2 se inicializa 
# el sensor. El sensor se encuentra inicializado cuando en el registro de estado se almacena un 1. 
# Mientras haya un valor 0, el registro no se considera inicializado.

# Registro de estado (SensorEstado):
# 0: El sensor no está listo o aún no hay lectura disponible.
# 1: El sensor está inicializado y listo para leer; el dato de temperatura está en SensorDatos.
# -1: Se ha producido un error y debe reinicializarse.

# Registro de datos (SensorDatos): Contiene la última lectura de temperatura (entero de 32 bits).

# Escriba el código de los siguientes procedimientos:

# InicializarSensor: Inicializa el sensor.
# LeerTemperatura: Lee el valor de temperatura. Devuelve dos resultados: el valor leído y un código: 
# 0 si se ha leído correctamente y -1 en caso de error.

# ---------------------------------------------------------------------------------------------------------------------------------------------

.data
    # Direcciones de los registros del sensor
    REG_CONTROL:   .word 0x0   # Registro de control
    REG_ESTADO:    .word 0x0   # Registro de estado
    REG_DATOS:     .word 0x0   # Registro de datos
    Temp: .asciiz  "\nValor de temperatura leido:\n"
    Cod: .asciiz  "Codigo:\n"
    NLISTO: .asciiz  "El sensor no esta listo\n"
    Salto:"\n"
.text
.globl main
.globl InicializarSensor
.globl LeerTemperatura
main:
    jal InicializarSensor       # Inicializar el sensor
    jal LeerTemperatura         # Leer la temperatura
    li $v0, 10			# Terminar programa
    syscall

# Procedimiento InicializarSensor-----------------------------
InicializarSensor:
    
    lw $t0, REG_CONTROL         # Cargar la direccion del registro de control

    # 
    li      $t1, 0x00000002           # Cargar la inializacion del valor 0x2 en $t1
    sw      $t1, REG_CONTROL    # Escribir 0x2 en el registro de control para inicializar el sensor
    move $s1, $t1 
    
    
    sw $t1, REG_CONTROL         # Escribir la direccion del registro de control
    
esperar_inicializacion:
    lw $t1, REG_CONTROL         # Cargar la direccion del registro de control

    beq $t1, 2, inicializacion_hecha  # Si es 2, el sensor de control esta inicializado
    j esperar_inicializacion    # Si no, seguir esperando

inicializacion_hecha:
    lw $t0, REG_ESTADO          # Cargar la direccion del registro de estado
    
    li      $t1, 1              # Cargar la inializacion del valor 1 en $t1
    sw      $t1, REG_ESTADO     # Escribir 1 en el registro de estado

        jr $ra                      # Retornar

# Procedimiento LeerTemperatura-------------------------------
LeerTemperatura:
    li $t2, -1			# Comprobar si hay un error (registro de estado igual a -1)
    beq $t1, $t2, lectura_error # Si hay error saltar a lectura_error

    # Comprobar si la lectura estÃ¡ lista (registro de estado = 1)
    li $t2, 1			# Comprobar si no hay un error (registro de estado igual a 1)
    beq $t1, $t2, lectura_lista # Si no hay error saltar a lectura_lista

    # Si no es 1 ni -1, el sensor no esta listo
    j NO_LISTO        		# Si no esta listo saltar a NO_LISTO

lectura_lista:
    li   $v0, 4                 # Espesificacion de que se quiere imprimir una cadena
    la   $a0, Temp              # Cargar direccion para imprimir encabezado
    syscall
    # Leer el valor de temperatura del registro de datos
    lw $t0, REG_DATOS           # Cargar la direccion del registro de control
    li $t3, 28
    sw $t3, REG_DATOS
    move $s1, $t3
    
    li $v0, 1                   # syscall para imprimir entero
    move $a0, $s1               # cargar el resultado de codigo
    syscall
    
    li   $v0, 4                 # Espesificacion de que se quiere imprimir una cadena
    la   $a0, Salto             # Cargar direccion para imprimir el encabezado
    syscall
    
    li   $v0, 4                 # Espesificacion de que se quiere imprimir una cadena
    la   $a0, Cod               # Cargar direccion para imprimir el encabezado
    syscall
    move $s1, $v1 
    
    li $v0, 1                   # syscall para imprimir entero
    move $a0, $s1               # cargar el resultado de codigo
    syscall
    # Devolver cÃ³digo de estado 0 (Ã©xito)
    li $v1, 0
    jr $ra                      # Retornar

lectura_error:
    li   $v0, 4                 # Espesificacion de que se quiere imprimir una cadena
    la   $a0, Temp              # Cargar direccion para imprimir el encabezado
    syscall
    # Leer el valor de temperatura del registro de datos
    lw $t0, REG_DATOS           # Cargar la direccion del registro de control
    li $t3, 28			# Cargar el valor 28 en $t13
    sw $t3, REG_DATOS		# Escribir la temperatura en el registro de datos
    move $s1, $t3
    
    li $v0, 1                   # syscall para imprimir entero
    move $a0, $s1               # cargar el resultado de temperatura
    syscall
    
    li   $v0, 4                 # Espesificacion de que se quiere imprimir una cadena
    la   $a0, Salto             # Cargar direccion para imprimir el encabezado
    syscall
    
    li   $v0, 4                 # Espesificacion de que se quiere imprimir una cadena
    la   $a0, Cod               # Cargar direccion para imprimir el encabezado
    syscall
    move $s1, $v1 
        
    li $v0, 1                   # syscall para imprimir entero
    move $a0, $t1               # cargar el resultado de codigo
    syscall

    jr $ra                      # Retornar
    
NO_LISTO:
    li   $v0, 4                 # Espesificacion de que se quiere imprimir una cadena
    la   $a0, NLISTO            # Cargar direccion para imprimir el encabezado
    syscall
        jr $ra                  # Retornar
    
