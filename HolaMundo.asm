# Profesor: José Canache
# Estudiante: José Manuel Díaz Moreno. C.I. No. 25.682.785
# Hacer un algoritmo en lenguaje en MIPS 32 que imprima por pantalla 

.data						# Sección de declaración de datos
HolaMundo:	.asciiz "Hola Mundo! \n"	# Cadena identificada por etiqueta "HolaMundo"
		.text				# Sección de código de usuario
		
main:
	la, $a0, HolaMundo			# Se caga la dirección del mensaje en el registro $a0.						
						
	li, $v0, 4				# Se carga 4 en el registro $v0 para decirle al procesador
						# que se quiere escribir una cadena.
						
	syscall					# Se hace una llamada al sistema para imprimir todos los 
						# caracteres desde direcc. "HolaMundo" hasta caracter fin
						# de cadena (NULL)	
	
	
	# Se hace una salida limpia del sistema
	li $v0, 10				# Función de syscall: fin de segmento
	syscall					# Llamada al sistema
	
.end main

	

