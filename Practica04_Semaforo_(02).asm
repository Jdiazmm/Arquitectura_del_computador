
# PRACTICA DE LABORATORIO IV

# Sergio Jose Noguera (30572211)
# Jose Manuel Diaz (25682785)

# ENUNCIADO DEL EJERCICIO 02:

# Semáforo con Pulsador (Interrupciones de Teclado y Temporizador). Desarrollar un 
# programa en MIPS32 que simule un semáforo controlado por un pulsador (tecla s) con el siguiente funcionamiento:

# El semáforo comienza en verde mostrando: “Semáforo en verde, esperando pulsador”.
# Al pulsar la tecla s, el semáforo debe mostrar: “Pulsador activado: en 20 segundos, el semáforo cambiará a amarillo”. 
# Iniciar un temporizador de 20 segundos.
# Tras los 20 segundos, el semáforo pasa a amarillo mostrando: “Semáforo en amarillo, en 10 segundos, semáforo en rojo”.
# Pasados 10 segundos, pasa a rojo mostrando: “Semáforo en rojo, en 30 segundos, semáforo en verde”
# Después de 30 segundos, vuelve a verde y se repite el ciclo.

# ---------------------------------------------------------------------------------------------------------------------------------------------


.data
    encabezado:        .asciiz "\nSemaforo en verde, esperando pulsador.\n"
    verde:             .asciiz "\nPulsador activado, esta en verde en 20 segundos el semaforo cambiara a amarillo\n"
    amarillo:          .asciiz "\nSemaforo en amarrillo en 10 segundos pasara a rojo\n"
    rojo:              .asciiz "\nSemaforo en rojo en 30 segundo pasara a verde\n"
.text
.globl main

main:
    li $v0, 4            # Codigo para imprimir string
    la $a0, encabezado   # Cargar la direccion del encabezado
    syscall              # Ejecutar la syscall

    li  $t0, 0xFFFF0000
cargar_s:
    lw      $t2, 0xFFFF0004  

    li $t1, 's'          # Cargar el valor de 's' en $t0
    bne $t2, $t1, cargar_s  # Si no es 's',ir a final
    

estado_verde:
        la $a0, verde
        li $v0, 4
        syscall 	 # Ejecutar syscall
       
        # Temporizador (simulado)
        li $a0, 20000    # 20 segundos en milisegundos
        li $v0, 32       # Codigo para delay
        syscall		 # Ejecutar syscall
       
   
estado_amarillo:
        la $a0, amarillo
        li $v0, 4
        syscall
       
        # Temporizador (simulado)
        li $a0, 10000    # 10 segundos en milisegundos
        li $v0, 32	 #Codigo para delay
        syscall		 # Ejecutar syscall

   
 estado_rojo:
        la $a0, rojo
        li $v0, 4
        syscall		 # Ejecutar la syscall
       
        # Temporizador (simulado)
        li $a0, 30000    # 30 segundos en milisegundos
        li $v0, 32	 #Codigo para delay
        syscall		 # Ejecutar syscall
       
        j estado_verde       
fin:
    li $v0, 10
    syscall 
	



