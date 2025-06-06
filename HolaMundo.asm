# Profesor: Jos� Canache
# Estudiante: Jos� Manuel D�az Moreno. C.I. No. 25.682.785
# Hacer un algoritmo en lenguaje en MIPS 32 que imprima por pantalla 

.data						# Secci�n de declaraci�n de datos
HolaMundo:	.asciiz "Hola Mundo! \n"	# Cadena identificada por etiqueta "HolaMundo"
		.text				# Secci�n de c�digo de usuario
		
main:
	la, $a0, HolaMundo			# Se caga la direcci�n del mensaje en el registro $a0.						
						
	li, $v0, 4				# Se carga 4 en el registro $v0 para decirle al procesador
						# que se quiere escribir una cadena.
						
	syscall					# Se hace una llamada al sistema para imprimir todos los 
						# caracteres desde direcc. "HolaMundo" hasta caracter fin
						# de cadena (NULL)	
	
	
	# Se hace una salida limpia del sistema
	li $v0, 10				# Funci�n de syscall: fin de segmento
	syscall					# Llamada al sistema
	
.end main

	

