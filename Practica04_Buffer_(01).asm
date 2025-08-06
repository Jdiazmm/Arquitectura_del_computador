
# PRACTICA DE LABORATORIO IV

# Sergio Jose Noguera (30572211)
# Jose Manuel Diaz (25682785)

# ENUNCIADO DEL EJERCICIO 01:

# Buffer de Entrada de Teclado con Temporizador (Interrupciones simuladas). 
# Desarrollar un programa en MIPS32 que funcione de la siguiente manera:

# Durante un intervalo de 20 segundos, el programa debe permitir la entrada 
# de caracteres por teclado, que se ir�n almacenando en un buffer circular.

# Transcurridos los 20 segundos, el programa imprime todo el contenido del buffer en la consola.

# Despu�s de vaciar el buffer, el proceso se repite indefinidamente.

# ---------------------------------------------------------------------------------------------------------------------------------------------

# Buffer de Entrada de Teclado con Temporizador - Versi�n corregida para MARS
# Soluciona el error ".word en segmento de texto"

.data
# Buffer y variables de control
buffer:         .space 256        # Buffer circular de 256 bytes
buffer_index:   .word 0           # �ndice actual en el buffer
timer_flag:     .word 0           # Bandera de temporizador
start_time:     .word 0           # Tiempo de inicio para el temporizador

# Mensajes
prompt_msg:     .asciiz "\nIngrese caracteres (tiene 20 segundos):\n"
output_msg:     .asciiz "\nContenido del buffer:\n"
newline:        .asciiz "\n"
time_up_msg:    .asciiz "\n�Tiempo terminado! Mostrando buffer...\n"

.text
.globl main

main:
    # Configuraci�n inicial
    jal init_timer
    
main_loop:
    # Reiniciar variables de estado
    la $t0, buffer_index
    sw $zero, 0($t0)            # Reiniciar �ndice del buffer
    la $t0, timer_flag
    sw $zero, 0($t0)            # Reiniciar bandera del temporizador
    
    # Mostrar mensaje de inicio
    li $v0, 4
    la $a0, prompt_msg
    syscall
    
    # Registrar tiempo de inicio
    li $v0, 30                  # Syscall para obtener tiempo del sistema
    syscall
    la $t0, start_time
    sw $a0, 0($t0)              # Guardar tiempo de inicio
    
input_loop:
    # Verificar si el temporizador ha expirado
    jal check_timer
    la $t0, timer_flag
    lw $t1, 0($t0)
    bnez $t1, time_expired      # Si timer_flag != 0, salir del loop
    
    # Leer un car�cter del teclado (con espera)
    li $v0, 12                  # C�digo para leer car�cter
    syscall
    
    # Si no se ingres� ning�n car�cter (no deber�a pasar con esta syscall)
    beq $v0, $zero, input_loop
    
    # Almacenar el car�cter en el buffer circular
    la $t0, buffer_index
    lw $t1, 0($t0)              # Cargar �ndice actual
    la $t2, buffer
    add $t2, $t2, $t1           # Calcular direcci�n en el buffer
    sb $v0, 0($t2)              # Almacenar el car�cter
    
    # Incrementar el �ndice (circular)
    addi $t1, $t1, 1
    li $t3, 256
    blt $t1, $t3, no_wrap       # Si no excede el tama�o, saltar
    li $t1, 0                   # Si excede, volver al inicio
    
no_wrap:
    sw $t1, 0($t0)              # Guardar nuevo �ndice
    j input_loop                # Repetir el loop de entrada

time_expired:
    # Mostrar mensaje de tiempo terminado
    li $v0, 4
    la $a0, time_up_msg
    syscall
    
    # Peque�a pausa para asegurar que el mensaje se muestre
    li $a0, 500                 # 500 ms de espera
    li $v0, 32
    syscall
    
print_buffer:
    # Mostrar mensaje de salida
    li $v0, 4
    la $a0, output_msg
    syscall
    
    # Imprimir el contenido del buffer
    li $t0, 0                   # Contador
    la $t1, buffer              # Direcci�n del buffer
    
print_loop:
    bge $t0, 256, end_print     # Hemos impreso todo el buffer?
    
    # Leer y mostrar el car�cter actual
    lb $a0, 0($t1)
    beqz $a0, skip_print        # No imprimir bytes nulos
    
    # Verificar si es un car�cter imprimible (entre 32 y 126 ASCII)
    li $t2, 32
    blt $a0, $t2, skip_print
    li $t2, 126
    bgt $a0, $t2, skip_print
    
    li $v0, 11                  # Imprimir car�cter
    syscall
    
skip_print:
    # Avanzar al siguiente car�cter
    addi $t1, $t1, 1
    addi $t0, $t0, 1
    j print_loop

end_print:
    # Nueva l�nea al final
    li $v0, 4
    la $a0, newline
    syscall
    
    # Configurar el temporizador de nuevo
    jal init_timer
    
    j main_loop                 # Repetir el proceso

init_timer:
    # Configurar el temporizador para 20 segundos (20000 ms)
    li $a0, 20000
    li $v0, 32                  # Syscall para temporizador
    syscall
    jr $ra

check_timer:
    # Obtener tiempo actual
    li $v0, 30
    syscall                     # $a0 = tiempo actual en ms
    
    # Calcular si ha pasado el tiempo
    la $t0, start_time
    lw $t1, 0($t0)              # Tiempo de inicio
    sub $t2, $a0, $t1           # Tiempo transcurrido
    
    li $t3, 20000               # 20 segundos
    blt $t2, $t3, timer_not_expired
    
    # Establecer bandera
    la $t0, timer_flag
    li $t1, 1
    sw $t1, 0($t0)
    
timer_not_expired:
    jr $ra
