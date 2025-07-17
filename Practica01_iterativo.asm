# Algoritmo iterativo para calcular el n-enesimo n�mero de Fibonacci e imprimirlo
      .globl main
      .data 
fibs: .word   0 : 46        # "Arreglo" de 45 palabras para contar los valores de fibonacci
tama�o: .word  46           # tama�o del "arreglo" 

scan: .asciiz  "Ingrese un n�mero enero n menor o igual a 46:\n"
print: .asciiz  "El termino de Fibonacci F(n) es:\n"
      .text
main:  
      la   $t0, fibs        # cargar direccion del "arreglo"
      la   $t5, tama�o      # cargar dirrecion del tama�o del arreglo
      lw   $t5, 0($t5)      # cargar tama�o de arreglo
encabe:
      li   $v0, 4           # Espesificaci�n de que se quiere imprimir una cadena
      la   $a0, scan        # Cargar direccion para imprimir el encabezado
      syscall  		    # Imprimir encabezado 
      
scanf:     
      li $v0, 5 	    # Leer n  y guargar en $v0
      syscall		    # Leer n�mero entero
      move $t5, $v0	    # Guardar 
      bgt $t5, 46, encabe   # Saltar a scanf si n es mayor a 46

      li   $t2, 1           # Guardar 1 en $t2

      sw   $t2, 0($t0)      # F[0] = 1
      sw   $t2, 4($t0)      # F[1] = F[0] = 1

      addi $t1, $t5, -2     # Contador para bucle, se ejecutar� (tama�o-2) veces


loop: lw   $t3, 0($t0)      # Obtener valor del arreglo en F[n]
      lw   $t4, 4($t0)      # Obtener valor del arreglo en F[n+1]
      add  $t2, $t3, $t4    # $t2=F[n]+F[n+1]
      
      sw   $t2, 8($t0)      # Almacenar F[n+2] = F[n] + F[n+1] en arreglo
      
      addi $t0, $t0, 4      # incrementar la direccion de la fuente de numero fib.
      addi $t1, $t1, -1     # Decrementar en -1 el contador del loop 
      bgtz $t1, loop        # Repetir si contador=0
      la   $a0, fibs        # first argument for print (array)
      add  $a1, $zero, $t5  # second argument for print (size)

      jal  printf        # Saltar al final para imprimir en n�mero. 

      li   $v0, 10          # Espesificaci�n de que se quiere salir del programa
      syscall               # salir del programa

printf:
      add  $t0, $zero, $a0  # inicializar la direcci�n de la arreglo
      add  $t1, $zero, $a1  # inicializar el contador del loop para el tama�o del arreglo

      li   $v0, 4           # espesificacion de que se quiere imprimir una cadena
      la   $a0, print       # Cargar direcci�n para imprimir el encabezado
      syscall               # Imprimir encabezado

resultado: 
      lw   $a0, 0($t0)      # Cargar el n�mero de fibonacci del arreglo
      addi $t0, $t0, 4      # incrementar la direccion de la fuente de numero fib.
      addi $t1, $t1, -1     # Decrementar en -1 en contador del loop
      
      bgtz $t1, resultado      # Repetir si no es el n�mero final que se quiere calcular

      li   $v0, 1           # espesificacion de que se quiere imprimir un n�mero
      syscall               # Imprimir el n�mero de fibonacci

      jr   $ra              # retornar al llamador
