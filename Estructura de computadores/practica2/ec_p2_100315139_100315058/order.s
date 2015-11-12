.data
vector:	.word 4 5 6 7 8 2 1
size: 	.word 7


.text
.globl main
	main: 
	la $a0, vector
	lw $a1, size
	
	#########################
	# INSERT YOUR CODE HERE #
	#########################
	jal order

	li $t5, 0
	li $t6, 0
	
	bucle:                       #con este bucle imprimimos el nuevo vector
	beq $t6, $t1 fin
    lw $t3, vector($t5)
    move $a0, $t3
    li $v0, 1
    syscall
    addi $t5, 4
    addi $t6, 1
	b bucle
    
    fin:
	

	
	
	li $v0, 10
	syscall

# METHOD ORDER
# Receives as first parameter the direction of the first element of the vector.
# Receives as second parameter the size of the vector. 
# Returns the direction of the first element of the reordered vector. 
	order:
	move $t0, $a0
	move $t1, $a1
	li $t2, 0			#contador de 4 en 4
	li $t5, 0			#contador de 4 en 4
	li $t4, 0			#contador de 1 en 1
	li $t9, 0			#contador de 1 en 1
	
	recorre_vector:								#recorremos el vector para cambiar posiciones con el mínimo en orden

	lw $t6, vector($t2)
	move $t7, $t6 
	
	beq $t9, $t1 imprimir							#tras ordenar todo el vector terminamos

	li $t3, 0   								#contadores de 4 en 4
	min:

		beq $t4, $t1, buscar_posicion			# si está en el final del vector va a buscar_posicion
		lw $t6, vector($t2)						# meto el valor de turno en $t6
		addi $t4, 1								#sumo contadores
		addi $t2, 4	
		blt $t6, $t7, cambiomin					#voy a cambio minimo
		b min
		
		cambiomin:
		move $t7, $t6							#actualizo el minimo
		b min
		
		buscar_posicion:						#miro en que posición del vector se encuentra $t7
                lw $t0, vector($t3)			
                addi $t3, $t3, 4				#le sumo 4 al contador
                beq $t0, $t7, mover_menor     	#salta a mover_menor cuando encuentra la coincidencia
				b buscar_posicion				#vuelve a blucle en caso de que no se cumplan las coincidencias


	mover_menor:
	lw $t8, vector($t5)						#muevo a un temporal lo que hay en la posicion del vector a ordenar
    sw $t8, vector($t3)						#muevo a la posicion de vector donde esaba el minimo lo que habia en la posicíon a ordenar
	sw $t7, vector($t5)						 #muevo a la posicion de vector a ordenar el minimo
	
	add $t9, 1									#actualizo contadores
	move $t4, $t9	
	move $t2, $t9
	li $t0, 4
	mul $t2, $t2, $t0
	addi $t5, 4

	b recorre_vector
	
	imprimir: #mandamos a imprimir en el main
	
	
	#########################
	# INSERT YOUR CODE HERE #
	#########################

	jr $ra
