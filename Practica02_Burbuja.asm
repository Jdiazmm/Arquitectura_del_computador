
# PRACTICA DE LABORATORIO II

# Sergio Jose Noguera (30572211)
# Jose Manuel Diaz (25682785)

.data
	array:   .space 20      # Espacio para 5 enteros (5 * 4 bytes)
	msg1:    .asciiz 	"Elementos del arreglo: \n"
	msg2:    .asciiz 	"\nArreglo ordenado: \n"
	space:   .asciiz 	" "

.text
main:
   	# Inicializar dirección base del array en $t0
    	la $t0, array
    
    	# Inicializar manualmente valores del array
    	li $t1, 14   	# num[0]
    	sw $t1, 0($t0)
    
    	li $t1, 18   	# num[1]
    	sw $t1, 4($t0)
    
    	li $t1, 9     	# num[2]
    	sw $t1, 8($t0)
    
    	li $t1, 2      	# num[3]
    	sw $t1, 12($t0)
    
    	li $t1, 4     	# num[4]
    	sw $t1, 16($t0)

    	# Mostrar mensaje inicial
    	la $a0, msg1
    	li $v0, 4
    	syscall

    	# Imprimir elementos originales
    	move $s0, $zero		# i = 0
    	
imprimir_origen:
    	slti $t1, $s0, 5   	# if i < 5
    	beq $t1, $zero, burbuja
    
    	# Calcular offset y cargar elemento
    	mul $t1, $s0, 4
    	add $t1, $t1, $t0
    	lw $a0, 0($t1)
    	li $v0, 1
    	syscall
    
    	la $a0, space
    	li $v0, 4
    	syscall
    
    	addi $s0, $s0, 1
    	j imprimir_origen

# Algoritmo burbuja
burbuja:
   	move $s0, $zero		# i = 0
bucle_i:
    	slti $t1, $s0, 4  	# if i < 4
    	beq $t1, $zero, fin_burbuja
    
    	move $s1, $zero    	# j = 0
    	
	bucle_j:
    		slti $t1, $s1, 4	# if j < 4
    		beq $t1, $zero, incrementar_i
    
    		# Calcular offsets para num[j] y num[j+1]
    		mul $t1, $s1, 4
    		add $t1, $t1, $t0    	# dirección de num[j]
    		lw $t2, 0($t1)        	# cargar num[j]
    
    		addi $t3, $t1, 4     	# dirección de num[j+1]
    		lw $t4, 0($t3)        	# cargar num[j+1]
    
    		# Comparar elementos
    		slt $t5, $t4, $t2    	# si num[j] > num[j+1]
    		beq $t5, $zero, incrementar_j
    
    		# Intercambiar elementos
    		sw $t4, 0($t1)        	# num[j] = num[j+1]
    		sw $t2, 0($t3)        	# num[j+1] = num[j]
    
	incrementar_j:
    		addi $s1, $s1, 1
    		j bucle_j

incrementar_i:
    	addi $s0, $s0, 1
    	j bucle_i

fin_burbuja:
   	# Mostrar mensaje final
    	la $a0, msg2
    	li $v0, 4
    	syscall

# Imprimir arreglo ordenado
	move $s0, $zero    # i = 0
imprimir_final:
    	slti $t1, $s0, 5   # if i < 5
    	beq $t1, $zero, fin
    
    	# Calcular offset y cargar elemento
    	mul $t1, $s0, 4
    	add $t1, $t1, $t0
    	lw $a0, 0($t1)
    	li $v0, 1
    	syscall
    
    	la $a0, space
    	li $v0, 4
    	syscall
    
    	addi $s0, $s0, 1
    	j imprimir_final

fin:
    	li $v0, 10      # Terminar programa
    	syscall
