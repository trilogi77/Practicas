.data
vector:	.word 4 5 6 7 8 2 1
size: 	.word 7
salto: .asciiz "\n"				# para saltar de linea entre minimo y maximo

.text
.globl main
	main: 
	la $a1, vector		#guardo vector en $a1
	lw $a2, size		#guardo el tamaño en $a2
	la $a3, salto
	j minmax
	#########################
	# INSERT YOUR CODE HERE #
	#########################
	
	li $v0, 10
	syscall

# METHOD MINMAX
# Receives as first parameter the direction of the first element of the vector.
# Receives as second parameter the size of the vector. 
# Returns the minimum.
# Returns the maximum. 
	minmax:
	li $t0, 0		#contador
	li $t1, 0		#contador bites +4
	lw $t4, vector($t1)
	move $t2, $t4 		#minimo
	move $t3, $t4		#maximo
	move $t5, $a3		#paso el salto de liniea a $t5
	move $t6, $a2
	bucle:
				
		beq $t0, $t6, fin			# si está en el final del vector va a fin
		lw $t4, vector($t1)			# meto el valor de turno en $t4
		addi $t0, 1			    	#sumo contadores
		addi $t1, 4
		bgt $t4, $t3, cambiomax		#voy a cambio maximo
		blt $t4, $t2, cambiomin		#voy a cambio minimo

		b bucle
		



	cambiomin:
	move $t2, $t4			#actualizo el minimo
	b bucle

	cambiomax:
	move $t3, $t4			#actualizo el maximo
	b bucle

	fin:
	move $a0, $t2			#imprimo minimo
	li $v0, 1
	syscall	
	move $a0, $t5			#imprimo salto de linea
	li $v0, 4
	syscall
	move $a0, $t3			#imprimo maximo
	li $v0, 1
	syscall

	
	


	#########################
	# INSERT YOUR CODE HERE #
	#########################

	jr $ra
