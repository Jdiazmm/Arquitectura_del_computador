#PRACTICA DE LABORATORIO II

#Sergio Jose Noguera(30572211)
#Jose Manuel Diaz(25682785)

# Algoritmo de ordenamiento selection sort
.data
arreglo: .word 52, 21, 2, 13, 35 # El arreglo a ordenar
tamano: .word 5                  # Tamano del arreglo
mensaje_1:  .asciiz "Arreglo original: \n"
mensaje_2:  .asciiz "Arreglo ordenado: \n"
espacio:    .asciiz " "
nuevaLinea: .asciiz "\n"

.text
.globl main

main:
    li $v0, 4              # Servicio para imprimir cadena
    la $a0, mensaje_1      # Cargar direccion de la cadena
    syscall

    la $s4, arreglo        # $s4=direccion base del arreglo
    lw $s0, tamano         # $s0=tamano del arreglo

    li $t0, 0              # $t0=contador de bucle (i=0) para impresion

loop_imprimir_original:
    bge $t0, $s0, fin_loop_imprimir_original # if (i>=tamano)ir a fin_loop_imprimir_original

    sll $t1, $t0, 2        # $t1=i*4(offset en bytes)
    add $t1, $s4, $t1      # $t1=direccion de arreglo[i]

    lw $a0, 0($t1)         # Cargar el valor de arreglo[i] en $a0 para imprimir
    li $v0, 1              # Servicio para imprimir entero
    syscall

    li $v0, 4              # Servicio para imprimir cadena
    la $a0, espacio        # Cargar direccion del espacio
    syscall

    addiu $t0, $t0, 1      # i++
    j loop_imprimir_original

fin_loop_imprimir_original:
    li $v0, 4              # Servicio para imprimir cadena
    la $a0, nuevaLinea     # Cargar direccion de la nueva linea
    syscall

    la $a0, arreglo        # $a0=direccion base del arreglo
    lw $a1, tamano         # $a1=tamano del arreglo
    jal selectionSort      # Llamar a la funcion selectionSort

    li $v0, 4              # Servicio para imprimir cadena
    la $a0, mensaje_2      # Cargar direccion de la cadena
    syscall

    la $s4, arreglo        # $s4=direccion base del arreglo
    lw $s0, tamano         # $s0=tamano del arreglo

    li $t0, 0              # $t0=contador de bucle (i=0) para impreson

loop_imprimir_ordenado:
    bge $t0, $s0, fin_loop_imprimir_ordenado # if(i>=tamano) ir a fin_loop_imprimir_ordenado

    sll $t1, $t0, 2        # $t1=i*4(offset en bytes)
    add $t1, $s4, $t1      # $t1=direccion de arreglo[i]

    lw $a0, 0($t1)         # Cargar el valor de arreglo[i] en $a0 para imprimir
    li $v0, 1              # Servicio para imprimir entero
    syscall

    li $v0, 4              # Servicio para imprimir cadena
    la $a0, espacio        # Cargar direccion del espacio
    syscall

    addiu $t0, $t0, 1      # i++
    j loop_imprimir_ordenado

fin_loop_imprimir_ordenado:
    li $v0, 10             # Servicio para terminar el programa
    syscall

selectionSort:
    move $s4, $a0          # $s4=direccion base del arreglo
    move $s0, $a1          # $s0=tamano del arreglo (n)

    li $s1, 0              # i=0(loop externo)

loop_externo_selection:
    addiu $t9, $s0, -1      # $t9=n-1
    bge $s1, $t9, fin_loop_externo_selection #if(i>=n-1)ir a fin_bucle_externo

    move $s3, $s1          # indiceMinimo=i

    addiu $s2, $s1, 1      # j=i+1(bucle interno)

loop_interno_selection:
    bge $s2, $s0, fin_loop_interno_selection #if(j>=n) ir a fin_bucle_interno

    sll $t0, $s2, 2        # $t0=j*4(offset en bytes)
    add $t0, $s4, $t0      # $t0=direccion de arreglo[j]
    lw $t0, 0($t0)         # $t0=valor de arreglo[j]

    sll $t1, $s3, 2        # $t1=indiceMinimo*4(offset en bytes)
    add $t1, $s4, $t1      # $t1=direccion de arreglo[indiceMinimo]
    lw $t1, 0($t1)         # $t1= valor de arreglo[indiceMinimo]

    bge $t0, $t1, siguiente_j # if(arrego[j]>=arreglo[indiceMinimo]) ir a siguiente_j

    move $s3, $s2          # indiceMinimo=j

siguiente_j:
    addiu $s2, $s2, 1      # j++
    j loop_interno_selection

fin_loop_interno_selection:
    sll $t2, $s1, 2        # $t2=i*4(offset en bytes)
    add $t2, $s4, $t2      # $t2=direccion de arreglo[i]
    lw $s5, 0($t2)         # $s5 (temp)=arreglo[i]

    sll $t3, $s3, 2        # $t3=indiceMinimo*4(offset en bytes)
    add $t3, $s4, $t3      # $t3=direccion de arr[indiceMinimo]
    lw $t1, 0($t3)         # $t1=arr[indiceMinimo]

    sw $t1, 0($t2)         # Guardar arreglo[indiceMinimo] en la posicion de arreglo[i]

    sw $s5, 0($t3)         # Guardar temp en la posicion de arr[indiceMinimo]

    addiu $s1, $s1, 1      # i++
    j loop_externo_selection

fin_loop_externo_selection:
    jr $ra                 # Volver al llamador
