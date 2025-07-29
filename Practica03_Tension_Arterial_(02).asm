
# PRACTICA DE LABORATORIO III

# Sergio Jose Noguera (30572211)
# Jose Manuel Diaz (25682785)

# ENUNCIADO DEL EJERCICIO 02:

# Un m�dulo para medir la tensi�n arterial de una persona est� conectado a un computador de 32 bits 
# con procesador MIPS32. El dispositivo tiene los siguientes registros, definidos en la memoria de 
# datos: TensionControl, TensionEstado, TensionSistol y TensionDiastol. El funcionamiento es:

# Escribir el valor 1 en TensionControl para iniciar una medici�n.
# Mientras TensionEstado sea 0, el dispositivo est� midiendo. Cuando vale 1, los resultados est�n listos.

# Los resultados de la medici�n (valores enteros de 32 bits) quedan disponibles en TensionSistol y TensionDiastol.

# Escribir un procedimiento en MIPS32 etiquetado como controlador_tension que: Inicie la medici�n. 
# Espere a que TensionEstado tenga el valor de 1. Retorne como salida (en $v0 y $v1) los valores 
# de tensi�n sist�lica y diast�lica, respectivamente.

# ---------------------------------------------------------------------------------------------------------------------------------------------

.data
# Variables del dispositivo (simuladas)
TensionControl:  .word 0       # 0 = Inactivo, 1 = Iniciar medici�n
TensionEstado:   .word 0       # 0 = Midiendo, 1 = Resultados listos
TensionSistol:   .word 0       # Aqu� se guardar� la sist�lica (ej: 120)
TensionDiastol:  .word 0       # Aqu� se guardar� la diast�lica (ej: 80)

# Mensajes para imprimir
msg_inicio:     .asciiz "Iniciando medici�n...\n"
msg_sistolica:  .asciiz "Tensi�n sist�lica: "
msg_diastolica: .asciiz "\nTensi�n diast�lica: "
msg_unidad:     .asciiz " mmHg"

.text
.globl main

main:
    # --- Simulaci�n: Valores de ejemplo ---
    li $t0, 120
    sw $t0, TensionSistol     # Guardar 120 en TensionSistol
    li $t0, 80
    sw $t0, TensionDiastol    # Guardar 80 en TensionDiastol
    li $t0, 1
    sw $t0, TensionEstado     # Marcar como "resultados listos" (1)

    # --- Llamar al controlador ---
    li $v0, 4
    la $a0, msg_inicio
    syscall                  # Imprimir "Iniciando medici�n..."

    jal controlador_tension  # Llamar al procedimiento

    # --- Imprimir resultados ---
    # $v0 = Sist�lica, $v1 = Diast�lica (retornados por el procedimiento)
    move $t0, $v0           # Guardar sist�lica en $t0
    move $t1, $v1           # Guardar diast�lica en $t1

    # Imprimir sist�lica
    li $v0, 4
    la $a0, msg_sistolica
    syscall                 # Imprimir "Tensi�n sist�lica: "
    li $v0, 1
    move $a0, $t0
    syscall                 # Imprimir valor (120)
    li $v0, 4
    la $a0, msg_unidad
    syscall                 # Imprimir " mmHg"

    # Imprimir diast�lica
    li $v0, 4
    la $a0, msg_diastolica
    syscall                 # Imprimir "\nTensi�n diast�lica: "
    li $v0, 1
    move $a0, $t1
    syscall                 # Imprimir valor (80)
    li $v0, 4
    la $a0, msg_unidad
    syscall                 # Imprimir " mmHg"

    # Terminar programa
    li $v0, 10
    syscall

# --- Procedimiento controlador_tension ---
controlador_tension:
    # 1. Iniciar medici�n (escribir 1 en TensionControl)
    li $t0, 1
    sw $t0, TensionControl   # Iniciar medici�n

    # 2. Esperar hasta que TensionEstado = 1
esperar:
    lw $t0, TensionEstado
    beq $t0, $zero, esperar # Si es 0, seguir esperando

    # 3. Leer resultados
    lw $v0, TensionSistol   # Cargar sist�lica en $v0
    lw $v1, TensionDiastol  # Cargar diast�lica en $v1

    jr $ra                  # Retornar al main