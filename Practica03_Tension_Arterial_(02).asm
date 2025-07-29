
# PRACTICA DE LABORATORIO III

# Sergio Jose Noguera (30572211)
# Jose Manuel Diaz (25682785)

# ENUNCIADO DEL EJERCICIO 02:

# Un módulo para medir la tensión arterial de una persona está conectado a un computador de 32 bits 
# con procesador MIPS32. El dispositivo tiene los siguientes registros, definidos en la memoria de 
# datos: TensionControl, TensionEstado, TensionSistol y TensionDiastol. El funcionamiento es:

# Escribir el valor 1 en TensionControl para iniciar una medición.
# Mientras TensionEstado sea 0, el dispositivo está midiendo. Cuando vale 1, los resultados están listos.

# Los resultados de la medición (valores enteros de 32 bits) quedan disponibles en TensionSistol y TensionDiastol.

# Escribir un procedimiento en MIPS32 etiquetado como controlador_tension que: Inicie la medición. 
# Espere a que TensionEstado tenga el valor de 1. Retorne como salida (en $v0 y $v1) los valores 
# de tensión sistólica y diastólica, respectivamente.

# ---------------------------------------------------------------------------------------------------------------------------------------------

.data
# Variables del dispositivo (simuladas)
TensionControl:  .word 0       # 0 = Inactivo, 1 = Iniciar medición
TensionEstado:   .word 0       # 0 = Midiendo, 1 = Resultados listos
TensionSistol:   .word 0       # Aquí se guardará la sistólica (ej: 120)
TensionDiastol:  .word 0       # Aquí se guardará la diastólica (ej: 80)

# Mensajes para imprimir
msg_inicio:     .asciiz "Iniciando medición...\n"
msg_sistolica:  .asciiz "Tensión sistólica: "
msg_diastolica: .asciiz "\nTensión diastólica: "
msg_unidad:     .asciiz " mmHg"

.text
.globl main

main:
    # --- Simulación: Valores de ejemplo ---
    li $t0, 120
    sw $t0, TensionSistol     # Guardar 120 en TensionSistol
    li $t0, 80
    sw $t0, TensionDiastol    # Guardar 80 en TensionDiastol
    li $t0, 1
    sw $t0, TensionEstado     # Marcar como "resultados listos" (1)

    # --- Llamar al controlador ---
    li $v0, 4
    la $a0, msg_inicio
    syscall                  # Imprimir "Iniciando medición..."

    jal controlador_tension  # Llamar al procedimiento

    # --- Imprimir resultados ---
    # $v0 = Sistólica, $v1 = Diastólica (retornados por el procedimiento)
    move $t0, $v0           # Guardar sistólica en $t0
    move $t1, $v1           # Guardar diastólica en $t1

    # Imprimir sistólica
    li $v0, 4
    la $a0, msg_sistolica
    syscall                 # Imprimir "Tensión sistólica: "
    li $v0, 1
    move $a0, $t0
    syscall                 # Imprimir valor (120)
    li $v0, 4
    la $a0, msg_unidad
    syscall                 # Imprimir " mmHg"

    # Imprimir diastólica
    li $v0, 4
    la $a0, msg_diastolica
    syscall                 # Imprimir "\nTensión diastólica: "
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
    # 1. Iniciar medición (escribir 1 en TensionControl)
    li $t0, 1
    sw $t0, TensionControl   # Iniciar medición

    # 2. Esperar hasta que TensionEstado = 1
esperar:
    lw $t0, TensionEstado
    beq $t0, $zero, esperar # Si es 0, seguir esperando

    # 3. Leer resultados
    lw $v0, TensionSistol   # Cargar sistólica en $v0
    lw $v1, TensionDiastol  # Cargar diastólica en $v1

    jr $ra                  # Retornar al main