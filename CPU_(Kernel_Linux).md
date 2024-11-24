<!-- Texto -->
# Arquitectura del Computador
## Integrantes:
- José Manuel Díaz Moreno. (CI: 25682785)
##

## PROPUESTA DE COMO ARMAR UNA PC QUE COMPILE KERNEL LINUX.

##

**1) KERNEL LINUX.**

<P>  
El Kernel Linux representa el núcleo los sistemas operativos (SO) Linux y se instala como software en la computadora. Es la parte de software más importante de cualquier sistema operativo ya que su principal función es encargarse de controlar todas las funciones principales del hardware del ordenador; es decir, permite a todo el software tener acceso al hardware. Por esto mismo, es responsable de la comunicación y gestión de recursos entre el hardware de la computadora y los procesos del sistema.

Por ejemplo, para desbloquear un teléfono utilizando un escáner de huella digital, el dueño del dispositivo debe dirigir su dedo al escáner (hardware) y este le indicará al Kernel que se ha reconocido la huella. A partir de ahí, el Kernel le indicará al software que verifique si esa huella es correcta o no y, en caso de ser así, tu teléfono se iniciará.
<p>

##

##

**2) COMPILACIÓN DE KERNEL LINUX.**

<P>
Existen muchas maneras de compilar el Kernel (casi una por cada distribución). Esto implica que hay que estar informado sobre la versión que se pretenda usar (ya sea Red Hat, Debian, Slackware, etc) pues es probable que por algún módulo excluido o incluido sin necesidad se podrían generar conflictos e incluso podría no funcionar correctamente.

De vez en cuando surgen dudas acerca de la necesidad de compilar el Kernel cuando se libera una nueva versión; sin embargo, solamente se compila una nueva versión de Kernel cuando se tienen dispositivos de hardware muy recientes y forzosamente se tiene que migrar hacia una versión que incluya módulos para el soporte de este.

**Todo el proceso se puede resumir en los siguientes pasos generales para todas las distros:**
1.	Obtener las fuentes del Kernel.
2.	Instalar las herramientas necesarias para la compilación (gcc, build-essentials, etc.).
3.	Descomprimir las fuentes del Kernel en /usr/src/
4.	Configurar el Kernel (ej. make menuconfig).
5.	Compilar (make), compilar los módulos (make modules), instalar los módulos (make modules_install).
6.	Instalar el Kernel compilado (make install).
7.	Crear la imagen (initrd) para el nuevo Kernel y ajustar grub para que la encuentre.

**Consideraciones importantes:**
-  La compilación del Kernel es un proceso intensivo en términos de recursos de la computadora.
-  Requiere tiempo significativo (horas o incluso días dependiendo de la velocidad del equipo).
-  Es posible compilar el Kernel en máquinas virtuales, pero requiere ajustes adicionales.

**Recomendaciones prácticas:**
-  Usar una versión estable del Kernel como base para la compilación.
-  Basar la configuración en el Kernel existente para minimizar cambios.
-  Dividir la compilación en etapas si el tiempo de compilación es excesivo.

Hay que recordar que aunque estas son recomendaciones generales, la experiencia personal juega un papel importante en la elección del equipo adecuado para el caso específico de cada quien

<p>

##

##

**3) ARMAR PC (PARA COMPILAR KERNEL LINUX).**

<P>
**Para que una computadora pueda compilar el Kernel de Linux es necesario que cumpla con los siguientes requisitos mínimos:**

-  Procesador de 64 bits (x86-64 o AMD64)
-  Al menos 8 GB de RAM
-  Disco duro SSD con al menos 10 GB de espacio libre
-  Sistema operativo Linux instalado

**También existen recomendaciones alternativas como:**

-  Procesador de alto rendimiento (Core i7 o superior)
-  Más RAM (16 GB o más)
-  Disco duro SSD rápido
-  Sistemas operativos modernos como Ubuntu o Fedora

Es importante tener en cuenta que existen muchas distribuciones de Linux, y cada una puede tener componentes adicionales o personalizaciones específicas. Por lo tanto, los componentes mencionados anteriormente son los principales y más comunes en los sistemas operativos Linux con Kernel Linux, pero no los únicos.

En este caso, los componentes a utilizar para armar el computador serán: un procesador, una placa base, una memoria RAM, un disco duro de almacenamiento, una tarjeta gráfica y una fuente de alimentación.

<p>

## 

## Propuesta: $ 2500,00

<!-- Tablas -->

|Componentes|Precio|
|--------|--------|
|   Procesador    | $ 439,00   |
|   Placa base  | $ 529,99   |
|   Memoria RAM    | $ 102,99   |
|   Almacenamiento    | $ 193,95   |
|   Tarjeta gráfica    |   $  1.029,99   |
|  Fuente de alimentación   |  $ 159,99     |
|  Gabinete o Carcasa   |  $ 37,99     |
|  Pasta térmica   |  $ 6,10       |
| TOTAL                |  $ 2500,00      |
| Sobrante             |  $    0,00      |
| Presupuesto       | $ 2500,00               |


##

##

**COMPONENTES:**

##
**1) Procesador.**
##
El procesador o unidad central de procesamiento (CPU) es el "motor" de la computadora y es esencial para el rendimiento del sistema. Al elegir una CPU, hay que tener en cuenta la velocidad de reloj (GHz) y el número de núcleos. Cuanto más alto sea el GHz, más rápido será el procesador. Además, el número de núcleos determina la capacidad de realizar múltiples tareas simultáneamente.
##
**Características:**
- Marca:    Intel
- Fabricante de CPU:    Intel
- Modelo de CPU:      Core i9
- Velocidad de la CPU:  6 GHz
- Zócalo de CPU:    LGA 771
##
### Especificaciones:
<https://www.amazon.com/-/es/i9-14900K-procesador-escritorio-gr%C3%A1ficos-integrados/dp/B0CGJDBCTK?th=1>

![Esta es una imagen de ejemplo](https://raw.githubusercontent.com/Jdiazmm/Arquitectura_del_computador/refs/heads/main/CPU_(pictures)/01%20-%20Procesadpr.png)


##
**2) Placa base.**
##
La placa base es el componente principal que conecta todos los demás componentes de la computadora. Hay asegurarse de que la placa base sea compatible con el procesador que se elija y tenga los puertos necesarios para otros componentes, como la memoria RAM y el almacenamiento. 
##
**Características:**
- Marca:						ASUS
- Zócalo de CPU:					LGA 1700
- Dispositivos compatibles:			Ordenador personal
- Tecnología de memoria RAM:			DDR5
- Procesadores compatibles:			Intel Core de 14ª y 13ª generación
- Tipo de set de chips:				Intel Z790
- Plataforma:						Windows
- Nombre del modelo:				ROG MAXIMUS Z790 HÉROE OSCURO
- Modelo de CPU:          Pentium
- Capacidad de almacenamiento de memoria:  64 GB
##
### Especificaciones:
<https://www.amazon.com/-/es/ROG-Maximus-Z790-generaci%C3%B3n-Thunderbolt/dp/B0CJMT2723/ref=sr_1_13?__mk_es_US=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=15H20G77XBXZ5&dib=eyJ2IjoiMSJ9.t_0619WSs-fo2BlfNwIdHF08CecmPNDEzBfTYyxKTctZx-PbHiRJNJ84VlbqHB9TJ0sFROYyAV2SIqCroFPzNZZb3dFyF49OVzgRHnTV4551AEYRNuJG3r6nn_WWkqb8sQlzE9dQgCFfBIQdmMR2MmHsy-gOjE_4X6LtNfiHmg9rHc60TLKQXcmWkmbeNgtHl365DXirlaMFW3DSXVBjeXcSTeI2bDWcQqZTRiIs7OY.B-tAwvCPw5AGqLlmf9OQQF1MMnNzp2_weTgVT-RC6RI&dib_tag=se&keywords=ASUS%2BPlaca%2Bbase&qid=1731286283&sprefix=asus%2Bplaca%2Bbase%2B%2Caps%2C133&sr=8-13&th=1>

![Esta es una imagen de ejemplo](https://raw.githubusercontent.com/Jdiazmm/Arquitectura_del_computador/refs/heads/main/CPU_(pictures)/02%20-%20placa%20Base.png)


##
**3) Memoria RAM.**
##
La Memoria RAM o memoria de acceso aleatorio por su nombre en inglés, Random Access Memory, es donde se almacenan los datos y programas en ejecución. Es usada por el sistema operativo y los programas del PC para cargar instrucciones que luego ejecutará el procesador. Es una parte indispensable del PC y sin esta no puede funcionar. Para un buen rendimiento, se recomienda tener al menos 8 GB de RAM, aunque esto puede variar según las necesidades del usuario y presupuesto. 
##
**Características:**
- Marca:	Corsair
- Tamaño de la memoria de la computadora:	32 GB
- Tecnología de memoria RAM:	DDR5
- Velocidad de memoria:	6400 MHz
- Dispositivos compatibles:	Computadora de Escritorio
##
### Especificaciones:
<https://www.amazon.com/-/es/CORSAIR-VENGEANCE-Memoria-computadora-compatible/dp/B0BXHC74WD?th=1>

![Esta es una imagen de ejemplo](https://raw.githubusercontent.com/Jdiazmm/Arquitectura_del_computador/refs/heads/main/CPU_(pictures)/03%20-%20Memoria%20RAM.png)


##
**4) Almacenamiento.**
##
Los dispositivos de almacenamiento, como un disco duro o una unidad de estado sólido (SSD), se usan guardar el sistema operativo y los datos. Un SSD proporcionará tiempos de carga más rápidos y mayor rendimiento en comparación con un disco duro tradicional.
##
**Características:**
- Capacidad de almacenamiento digital:	2 TB
- Interfaz de disco duro:	PC Card
- Tecnología de conectividad:	NVMe
- Marca:	SAMSUNG
- Características especiales:	Portátil
- Factor de forma de disco duro:	2,5 Pulgadas
- Descripción del disco duro:	Disco SSD
- Dispositivos compatibles:	Laptop, PC, Portátil, Consola de juegos, Playstation5
- Tipo de instalación:    Disco duro interno
- Color:	Negro
##
### Especificaciones:
<https://www.amazon.com/-/es/Samsung-2000-Express-V-NAND-W127158676/dp/B0B9C4DKKG>

![Esta es una imagen de ejemplo](https://raw.githubusercontent.com/Jdiazmm/Arquitectura_del_computador/refs/heads/main/CPU_(pictures)/04%20-%20Almacenamiento.png)


##
**5) Tarjeta gráfica.**
##
La tarjeta gráfica o tarjeta de vídeo de un componente, es la que viene integrado en la placa base del PC o se instala a parte para ampliar sus capacidades. Está dedicada al procesamiento de datos relacionados con el vídeo y las imágenes que se están reproduciendo en el ordenador.

Si se planea utilizar un CPU para tareas gráficas intensivas, como juegos o diseño gráfico, se necesitará una tarjeta gráfica dedicada. Sin embargo, si solo se usa la CPU para tareas básicas, la mayoría de las CPU modernas incluyen una GPU integrada que es suficiente.
##
**Características:**
- Coprocesador de gráficos:  NVIDIA GeForce RTX 3090
- Marca: PNY
- Tamaño de gráficos de RAM: 24 GB
- Interfaz de salida de video: HDMI
- Fabricante de procesador de gráficos: NVIDIA
##
### Especificaciones:
<https://www.amazon.com/-/es/Tarjeta-gr%C3%A1fica-GeForce-Gaming-renovada/dp/B092XB1JGD/ref=sr_1_7?__mk_es_US=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=1KJFOEWBVJQ0Y&dib=eyJ2IjoiMSJ9.ox3rEiUQ9OihNtAZj_VhqtwT-THtQeb1VGqLWgJ-fy5ixJukLO9_FTiPS8CAxiTK_rDL9CpkEJ2JZuInmw2fJClVXQpAsOAfL2bOhScn-3Zzx-hjXp378476ZQ5x988GGSQu5485C1O38CxwFGAx2FUYtMSr-xXuIVmba_rfiUVXeo4eYqlQWrPxv6U3t_GQZh22coJBUDb3akG7EgGK_ZLe1S3l9AJqgaX3xPmXktU.2PpFLzkJGVkzZBmCZUdgmTm3fB7kfLA8_23LZ_1z9vk&dib_tag=se&keywords=Tarjeta+gr%C3%A1fica+de+triple+ventilador&qid=1731284808&sprefix=tarjeta+gr%C3%A1fica+de+triple+ventilador%2Caps%2C107&sr=8-7#renewedProgramDescriptionBtf_feature_div>

![Esta es una imagen de ejemplo](https://raw.githubusercontent.com/Jdiazmm/Arquitectura_del_computador/refs/heads/main/CPU_(pictures)/05%20-%20Targeta%20Gr%C3%A1fica.png)


##
**6) Fuente de alimentación.**
##
La fuente de alimentación es responsable de suministrar energía a todos los componentes del sistema de la CPU, por lo que, no solo alimenta a la tarjeta madre, sino que también a los otros dispositivos complementarios que son insertados en la PC, como tarjetas, unidades ópticas, dispositivos que se conectan por puerto USB, el mouse o ratón, el teclado, los altavoces, entre otros. Hay que asegurarse de elegir una fuente de alimentación con suficiente capacidad para alimentar todos los componentes de manera segura y eficiente.
##
**Características:**
##
- Nombre del modelo:    RM1000e
- Marca:	Corsair
- Dispositivos compatibles:	Computadora Personal
- Tipo de conector:	ATX
- Potencia de salida:	1000
- Factor de forma:  ATX
- Potencia:	1000 vatios
- Método de refrigeración: Aire
- Dimensiones del artículo LxWxH:	5,91 x 5,51 x 3,39 pulgadas
- Peso del artículo:	3,66 Libras

##
### Especificaciones:
<https://www.amazon.com/-/es/Corsair-alimentaci%C3%B3n-totalmente-modular-RM1000e/dp/B0BYQHWJXC?th=1>

![Esta es una imagen de ejemplo](https://raw.githubusercontent.com/Jdiazmm/Arquitectura_del_computador/refs/heads/main/CPU_(pictures)/06%20-%20Fuente%20de%20Alimentaci%C3%B3n.png)


##
**7) Gabinete o Carcasa.**
##
El gabinete de una computadora es la pieza encargada de proteger las partes que componen a la CPU, este elemento recibe distintos nombres, por lo que también se le conoce como caja, carcasa, chasis o torre de computadoras.
##
**Características:**
##
- Marca:	Cooler Master
- Compatibilidad de la placa base:	Micro-ATX y Mini-ITX
- Tipo de estuche:	Minitorre
- Usos Recomendados Para Producto:	Videojuegos
- Color:	Negro
- Material:	Acero aleado Plástico
- Tipo de montaje de fuente de alimentación:	Montaje inferior
- Método de refrigeración:	Aire
- Nombre del modelo:  Q300L
- Peso del artículo:	480 Gramos
##
### Especificaciones:
<https://www.amazon.com/-/es/Cooler-Master-enfriadora-micro-ATX-soporte/dp/B0785GRMPG>

![Esta es una imagen de ejemplo](https://raw.githubusercontent.com/Jdiazmm/Arquitectura_del_computador/refs/heads/main/CPU_(pictures)/07%20-%20Gabinete%20o%20Carcasa.png)


##
**8) Pasta térmica.**
##
La pasta térmica, es una sustancia de color gris plateado que se aplica al procesador antes de instalar una solución de refrigeración. Permite una transferencia de calor eficiente desde el IHS del procesador al plato base o al bloque líquido del refrigerador de la CPU diseñados para disipar ese calor.
##
**Características:**

##
- Tipo de producto:			Pasta térmica
- Número de fabricante:		No aplicable
- Marca:				Sin marca
- EAN:					4060787071071
##
### Especificaciones:
<https://www.ebay.com/itm/281172235978?_skw=pasta+termica+para+pc&itmmeta=01JCCRBZTMNPN0FYPH3EVJSWEM&hash=item41772bd6ca:g:Z8AAAOSwXTVcMVzZ&itmprp=enc%3AAQAJAAAA8HoV3kP08IDx%2BKZ9MfhVJKmslnsguxnXuf%2BPBLrRYAng29c7MWsinNTmqCNs0Xixq%2FWiraM9W5BRVBDp6glIHN7eerT4mNI%2FynjPk3hWyjci0h2vqKyCTOmoNyp7oznKuJMTjTlfJLWwbpleeRpu132PDVchBafqaXlDk5f9g7r9O4YBnltFrkibxSGb6GyESFIOGg3lEHeNQgNBdqOWoyExUpi7aBa1yDeCauwI%2FLt7hHND2t9bhwxU0WJGBPwhS3ztCCwtsOwQrymkzFbot1Qf2EmsSaKgomBCTHhDrpBV51OsmyjUKWAoeewuHXvQhg%3D%3D%7Ctkp%3ABFBMuP2vmONk>

![Esta es una imagen de ejemplo](https://raw.githubusercontent.com/Jdiazmm/Arquitectura_del_computador/refs/heads/main/CPU_(pictures)/08%20-%20Pasta%20T%C3%A9rmica.png)



