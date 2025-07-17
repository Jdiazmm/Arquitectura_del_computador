
# PRACTICA DE LABORATORIO I

# Sergio Jose Noguera (30572211)
# Jose Manuel Diaz (25682785)

# Algoritmo recursivo para calcular el n-enesimo n�mero de Fibonacci e imprimirlo
.data
    scan: .asciiz "Ingrese un numero entero n menor o igual a 23 para Fibonacci:\n"
    print: .asciiz "El termino de Fibonacci F(n) es:\n"
.text
.globl main

main:
    li $v0, 4           # espesificacion de que se quiere imprimir una cadena
    la $a0, scan        # Cargar direccion para imprimir el encabezado
    syscall

    li $v0, 5           # syscall para leer entero
    syscall
    move $s0, $v0       # guardar n en $s0
    bgt $s0,23, main   # Saltar a scanf si n es mayor a 23

    # Llamar a la funcion fibo
    move $a0, $s0       # Guardar n como argumento en $a0
    jal fibo             # Saltar a fibo para imprimir en n�mero. 

    # Imprimir el resultado
    move $s1, $v0       # Guardar el resultado de fibo en $s1

    li $v0, 4           # Espesificaci�n de que se quiere imprimir una cadena
    la $a0, print  # cargar la direccion del string
    syscall

    li $v0, 1           # syscall para imprimir entero
    move $a0, $s1       # cargar el resultado de fib
    syscall

    li $v0, 10          # syscall para salir
    syscall
# Funci�n recursiva para calcular en termino 
fibo:
    addi $sp, $sp, -12  # Reservar espacio para 3 palabras 
    sw $ra, 8($sp)      # Guardar $ra para la dirrecion de retorno
    sw $s0, 4($sp)      # Guardar el n en $s0 
    sw $s1, 0($sp)      # Guardar el resultado de F(n-1) en $s1 

    beqz $a0, fibo_0    # Si n=0, salta a fibo_0

    li $t0, 1
    beq $a0, $t0, fibo_1# Si n=1, salta a fibo_1

    move $s0, $a0       # Guardar n en $s0

    addi $a0, $s0, -1   # $a0 = n - 1
    jal fibo            # Saltar a fibo
    move $s1, $v0       # Guardar el resultado en $s1

    addi $a0, $s0, -2   # $a0=n-2 
    jal fibo             # Saltar a fibo

    add $v0, $s1, $v0   # $v0=F(n-1)+F(n-2)

    j final             # Saltar a final

fibo_0:
    li $v0, 0           # F(0)=0
    j final	        # Saltar a final

fibo_1:
    li $v0, 1           # F(1)=1

final:
    lw $s1, 0($sp)      # Restaurar $s1
    lw $s0, 4($sp)      # Restaurar $s0
    lw $ra, 8($sp)      # Restaurar $ra
    addi $sp, $sp, 12   # Liberar espacio de la pila

    jr $ra              # Retornar al llamador
