.data
	vector:	.word 10 10 10 10 10 10 10
	size: 	.word 7


.text
.globl main
	main: 
		la $a1, vector		#cargo el vector en $a1
		lw $a2, size		#cargo sice en $a2
		j average
		#########################
		# INSERT YOUR CODE HERE #
		#########################
		li $v0, 10
		syscall
# METHOD AVERAGE 
# Receives as first parameter the direction of the first element of the vector.
# Receives as second parameter the size of the vector. 
# Returns the calculated average
	average:

	li $t0, 0		#contador
	li $t1, 0		#contador de pasar bites
	li $t2, 0		#suma
	move $t5, $a2
	bucle:
		lw $t3, vector($t1)		#cargo el numero que este en la pos $t1 del vector en $t3
		beq $t0, $t5, fin		#llega al final y baja a
		add $t2, $t2, $t3		#voy sumando a la suma
		addi $t1, 4			# sumo 4 al contador de pasar en bites
		addi $t0, 1			# sumo 1 al contador de la posición
		b bucle
		
	fin:
		mtc1 $t2, $f0			#transformamos los enteros a floats para hacer la division
		cvt.s.w $f0, $f0
		mtc1 $t5, $f1
		cvt.s.w $f1, $f1

		div.s $f3, $f0, $f1    #dividimos para hallar la media

		mov.s $f12, $f3         #imprimimos el resultado como float
		li $v0, 2
		syscall

		
	#########################
	# INSERT YOUR CODE HERE #
	#########################

	jr $ra
		
