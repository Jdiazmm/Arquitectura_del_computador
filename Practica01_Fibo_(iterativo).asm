
# PRACTICA DE LABORATORIO I

# Sergio Jose Noguera (30572211)
# Jose Manuel Diaz (25682785)

# Algoritmo iterativo para calcular el n-enesimo numero de Fibonacci e imprimirlo.
      .globl main
      .data 
fibs: .word   0 : 46        # "Arreglo" de 45 palabras para contar los valores de fibonacci
tamanio: .word  46          # tamanio del "arreglo" 

scan: .asciiz  "Ingrese un numero enero n menor o igual a 46:\n"
print: .asciiz  "El termino de Fibonacci F(n) es:\n"
      .text
main:  
      la   $t0, fibs        # cargar direccion del "arreglo"
      la   $t5, tamanio     # cargar dirrecion del tamanio del arreglo
      lw   $t5, 0($t5)      # cargar tamanio de arreglo
      
encabezado:
      li   $v0, 4           # Espesificacion de que se quiere imprimir una cadena
      la   $a0, scan        # Cargar direccion para imprimir el encabezado
      syscall  		    # Imprimir encabezado 
           
      li $v0, 5 	    	# Leer n  y guargar en $v0
      syscall		    	# Leer numero entero
      move $t5, $v0	    	# Guardar 
      bgt $t5, 46, encabezado   # Saltar a encabezado si n es mayor a 46

      li   $t2, 1           # Guardar 1 en $t2

      sw   $t2, 0($t0)      # F[0] = 1
      sw   $t2, 4($t0)      # F[1] = F[0] = 1

      addi $t1, $t5, -2     # Contador para bucle, se ejecutará (tamanio-2) veces


loop: lw   $t3, 0($t0)      # Obtener valor del arreglo en F[n]
      lw   $t4, 4($t0)      # Obtener valor del arreglo en F[n+1]
      add  $t2, $t3, $t4    # $t2=F[n]+F[n+1]
      
      sw   $t2, 8($t0)      # Almacenar F[n+2] = F[n] + F[n+1] en arreglo
      
      addi $t0, $t0, 4      # incrementar la direccion de la fuente de numero fib.
      addi $t1, $t1, -1     # Decrementar en -1 el contador del loop 
      bgtz $t1, loop        # Repetir si contador>0
      la   $a0, fibs        # Cargar direccion de arreglo para poder imprimir el termino
      add  $a1, $zero, $t5  # Argumento para poder imprimir con el tamaño

    
printf:
      add  $t0, $zero, $a0  # inicializar la direccion de la arreglo
      add  $t1, $zero, $a1  # inicializar el contador del loop para el tamanio del arreglo

      li   $v0, 4           # espesificacion de que se quiere imprimir una cadena
      la   $a0, print       # Cargar direccion para imprimir el encabezado
      syscall               # Imprimir encabezado

resultado: 
      lw   $a0, 0($t0)      # Cargar el numero de fibonacci del arreglo
      addi $t0, $t0, 4      # incrementar la direccion de la fuente de numero fib.
      addi $t1, $t1, -1     # Decrementar en -1 en contador del loop
      
      bgtz $t1, resultado      # Repetir si el contador es mayor a cero      
      

      li   $v0, 1           # espesificacion de que se quiere imprimir un numero
      syscall               # Imprimir el numero de fibonacci

      li   $v0, 10          # Espesificacion de que se quiere salir del programa
      syscall		    # salir del programa
