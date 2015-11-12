.data
	string:	.asciiz "nice work..."
	espacio: .byte ' '
.text
.globl main
	main: 

	la $a0, string 		 #meto string en $a0
	lb $a1, espacio
	j strlength   			 #hago el salto a strlength



	#########################
	# INSERT YOUR CODE HERE #
	#########################
	
	li $v0, 10
	syscall

# METHOD STRLENGTH
# Receives as first parameter the direction of the first character of string.
# Returns the length of the string.
	strlength:

	li $t0, 0		#inicializo una variable contador
	li $t2, 0
	move $t3, $a1
        
            bucle:
                lb $t1, string($t0)
                beqz $t1,  fin	 				#salta a fin cuando se encuentra un 0 que es el final del string
                addi $t0, $t0,1					#le sumo 1 al contador
                beq $t3, $t1, contar_espacio
                b bucle							#vuelve a blucle en caso de que no se cumplan las coincidencias


    contar_espacio:
    			addi $t2,1 						#contamos los espacios
    			b bucle



	fin:
		sub $t0, $t0, $t2 						#restamos los espacios del resultado total
		move $a0, $t0
		li $v0, 1 								#imprimimos el tamaño
		syscall
		jr $ra
	#########################
	# INSERT YOUR CODE HERE #
	#########################

	jr $ra
