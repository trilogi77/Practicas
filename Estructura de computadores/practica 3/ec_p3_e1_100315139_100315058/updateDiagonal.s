.data
	array:		.word 1, 1, 1, 1
				.word 1, 1, 1, 1
				.word 1, 1, 1, 1
				.word 1, 1, 1, 1
				
	x:			.word 4
	y:			.word 4
.text
.globl main

main:
lw $a0, x
lw $a1, y
la $a2, array		#cargamos parametros
li $t0, 0
move $a3, $t0  		#contador x_pos
li $t1, 0			#contador y_pos
sub $sp, $sp, 4
sw $t1, ($sp) 		#guarda el contador de y en la pila

jal print 			#imprimimos la primera matriz
move $t1, $a0 
li $a0, 32
li $v0, 11
syscall
move $a0, $t1 		#damos espacio para la siguiente matriz

add $sp, $sp, 12		#desmonta pila
li $t0, 0
move $a3, $t0       
		
jal update_diagonal
lw $a0, x
lw $a1, y
la $a2, array 		#retomamos valores
li $t0, 0
move $a3, $t0  		#contador x_pos
li $t1, 0			#contador y_pos
sub $sp, $sp, 4
sw $t1, ($sp) 		#guarda el contador de y en la pila
					
move $t1, $a0 		#saltos de línea
li $a0, 10
li $v0, 11
syscall
move $a0, $t1
move $t1, $a0 
li $a0, 10
li $v0, 11
syscall
move $a0, $t1

jal print 			#imprimimos la segunda matriz

	li $v0, 10 		#fin del programa
	syscall


get: 					#funcion que recoge el valor de una posicion de un array
	move $t0, $a3		#carga contador de x
	li $t1, 0			#carga number
	lw $t2, 8($sp)		#carga contador y
	move $t3, $a0		#carga x
	move $t4, $a1 		#carga la y
	move $t5, $a2 		#carga la posicion del  array

	mul $t6, $t3, $t0	#multiplica x por el contador de x
	mul $t6, $t6, 4 	#multiplica por 4 el valor de la anterior multiplicación para colocarlo en la fila
	mul $t7, $t2, 4		#multiplica el valor del contador y por 4
	add $t6, $t7, $t6	#suma la posición de x y de y para situarse en el array
	add $t6, $t6, $t5	# se posiciona al completo en el array
	lw $t8, ($t6)		#guarda el number del array
	move $v0, $t8		#guarda el number en el $v0 para devolverlo

	
	jr $ra

neighbors: 			#funcion que suma los valores de las posiciones adyacentes a una dada
	
	move $t0, $a0	#x
	move $t1, $a1	#y
	move $t2, $a2	#array
	move $t3, $a3	#contador de posicion x
	lw $t8, ($sp)	#contador de posicion y
	add $sp, $sp, 4 
	li $t4, 0		#neighbors
	move $t5, $t0	#ajuste de x_pos
	move $t6, $t1	#ajuste de y_pos
	sub $sp, $sp 4
	sw $ra, ($sp)	#volver a update diagonal

if1:

sub $t5, $t3, 1
blt $t5, 0, if2 		#comparamos para ver si el valor entra en la matriz

move $a3, $t5
sub $sp, $sp 4
sw $t8, ($sp)
sub $sp, $sp 4 	
sw $t4, ($sp) 		#pasamos parametros para el get
sub $sp, $sp 4 	
sw $t3, ($sp)

jal get
lw $t3, ($sp)
lw $t4, 4($sp)
lw $t8, 8($sp)
move $t7, $v0
add $t4, $t4, $t7 	#actualizamos neighbors
add $sp, $sp 12 	#restauramos parametros


if2:

sub $t6, $t8, 1
blt $t6, 0, if3		#comparamos para ver si el valor entra en la matriz

move $a3, $t3
sub $sp, $sp 4
sw $t6, ($sp)
sub $sp, $sp 4	
sw $t4, ($sp) 	#pasamos parametros para el get
sub $sp, $sp 4
sw $t8, ($sp)


jal get
move $t3, $a3
lw $t8, ($sp)
lw $t4, 4($sp)
move $t7, $v0
add $t4, $t4, $t7  	#actualizamos neighbors
add $sp, $sp 12 	#restauramos parametros


if3:

sub $t5, $t3, 1
sub $t6, $t8, 1
blt $t5, 0, if4		#comparamos para ver si el valor entra en la matriz
blt $t6, 0, if4 

move $a3, $t5
sub $sp, $sp 4
sw $t3, ($sp)
sub $sp, $sp 4 	
sw $t6, ($sp)
sub $sp, $sp 4
sw $t4, ($sp) 		#pasamos parametros para el get
sub $sp, $sp 4
sw $t8, ($sp)

jal get
lw $t8, ($sp)
lw $t3, 12($sp)
lw $t4, 4($sp)
move $t7, $v0
add $t4, $t4, $t7 		#actualizamos neighbors
add $sp, $sp 16 		#restauramos parametros



if4:
add $t5, $t3, 1
bge $t5, $a0 , if5 		#comparamos para ver si el valor entra en la matriz

move $a3, $t5
sub $sp, $sp 4
sw $t8, ($sp)
sub $sp, $sp 4	
sw $t4, ($sp) 			#pasamos parametros para el get
sub $sp, $sp 4	
sw $t3, ($sp)

jal get
lw $t8, 8($sp)
lw $t3, ($sp)
lw $t4, 4($sp)
move $t7, $v0
add $t4, $t4, $t7		#actualizamos neighbors
add $sp, $sp 12 		#restauramos parametros


if5:
add $t6, $t8, 1
bge $t6, $a1 , if6 		#comparamos para ver si el valor entra en la matriz

move $a3, $t3
sub $sp, $sp 4
sw $t6, ($sp)
sub $sp, $sp 4	
sw $t4, ($sp) 			#pasamos parametros para el get
sub $sp, $sp 4	
sw $t8, ($sp)

jal get
move $t3, $a3
lw $t8, ($sp)
lw $t4, 4($sp)
move $t7, $v0
add $t4, $t4, $t7		#actualizamos neighbors
add $sp, $sp 12 		#restauramos parametros



if6:
add $t5, $t3, 1
add $t6, $t8, 1
bge $t5, $a0 , if7 		#comparamos para ver si el valor entra en la matriz
bge $t6, $a1 , if7

move $a3, $t5
sub $sp, $sp 4
sw $t3, ($sp)
sub $sp, $sp 4 	
sw $t6, ($sp)
sub $sp, $sp 4
sw $t4, ($sp) 			#pasamos parametros para el get
sub $sp, $sp 4	
sw $t8, ($sp)
jal get

lw $t8, ($sp)
lw $t3, 12($sp)
lw $t4, 4($sp)
move $t7, $v0
add $t4, $t4, $t7 		#actualizamos neighbors
add $sp, $sp 16 		#restauramos parametros

if7:
sub $t5, $t3, 1
add $t6, $t8, 1
blt $t5, 0 if8 			#comparamos para ver si el valor entra en la matriz
bge $t6, $a1 , if8

move $a3, $t5
sub $sp, $sp 4
sw $t3, ($sp)
sub $sp, $sp 4 	
sw $t6, ($sp)
sub $sp, $sp 4
sw $t4, ($sp) 			#pasamos parametros para el get
sub $sp, $sp 4
sw $t8, ($sp)


jal get

lw $t8, ($sp)
lw $t3, 12($sp)
lw $t4, 4($sp)
move $t7, $v0
add $t4, $t4, $t7  		#actualizamos neighbors
add $sp, $sp 16  		#restauramos parametros


if8:
add $t5, $t3, 1
sub $t6, $t8, 1
bge $t5, $a0, fin_neighbor 		#comparamos para ver si el valor entra en la matriz
blt $t6, 0,  fin_neighbor

move $a3, $t5
sub $sp, $sp 4
sw $t3, ($sp)
sub $sp, $sp 4 	
sw $t6, ($sp)
sub $sp, $sp 4
sw $t4, ($sp) 			#pasamos parametros para el get
sub $sp, $sp 4
sw $t8, ($sp)

jal get
lw $t8, ($sp)
lw $t3, 12($sp)
lw $t4, 4($sp)
move $t7, $v0
add $t4, $t4, $t7 		 #actualizamos neighbors
add $sp, $sp 16		#restauramos parametros

fin_neighbor:
move $v0, $t4
move $a3, $t3
lw $ra, ($sp)
add $sp, $sp 4 	#restauramos pila y pasamos parametros
	
	jr $ra


set: 				#funcion que guarda un valor en una posicion de un array
	
	move $t0, $a0	#x
	move $t1, $a1	#y
	move $t2, $a2	#array
	move $t3, $a3	#contador de posicion x
	lw $t8, ($sp)	#contador de posicion y
	add $sp, $sp, 4
	lw $t4, ($sp)	#numero a guardar
	add $sp, $sp, 4
	move $t5, $t0	#ajuste de x_pos
	move $t6, $t1	#ajuste de y_pos


	mul $t6, $t3, $t0	#multiplica x por el contador de x
	mul $t6, $t6, 4 	#multiplica por 4 el valor de la anterior multiplicación para colocarlo en la fila
	mul $t7, $t8, 4		#multiplica el valor del contador y por 4
	add $t6, $t6, $t7
	add $t6, $t2, $t6
	sw $v0,($t6)  		#guarda el number en el array

	jr $ra



print: 				#funcion que imprime en la consola una matriz

move $t0, $a3 		#contador de x
lw $t1, ($sp)		#contador de y
move $t2, $a0	#valor de x
move $t3, $a1	#valor de y
move $t4, $a2	#posicion del array

li $t5, 0			# number
sub $sp, $sp, 4
sw $t5, ($sp)		#guarda el valor de number en la pila
sub $sp, $sp, 4
sw $ra, ($sp)		#guarda el $ra en la pila

sumay:

jal get				#salta al get
move $t2, $a0
move $t5, $v0		#mueve el $v0 con number al temporal $t5 que es el correspondiente al number
move $a0, $t5
li $v0, 1
syscall				#imprime   
li $a0, 32					
li $v0, 11
syscall	


move $a0, $t2 		#renueva $a0 con el valor de x
lw $t1, 8($sp)
addi $t1, 1			#suma 1 a y
sw $t1, 8($sp)		#sobreescribe el valor del contador de y
beq $t1, $a1, sumax
b sumay

sumax:
move $t7, $a0
li $a0, 10					#imprimir salto de línea
li $v0, 11
syscall	
move $a0, $t7
move $t0, $a3
addi $t0, 1 		#suma 1 a x
move $a3, $t0		#mueve el valor de x a $a3
li $t1, 0
sw $t1, 8($sp)
beq $t0, $a0, fin_print
b sumay

fin_print:

lw $ra, ($sp)
	
	jr $ra


update_diagonal: 	#funcion que actualiza una matriz sumando los valores adyacentes de cada
					#posicion de la diagonal principal de la matriz original y los sustituye en la misma

	move $t0 $a0	#x
	move $t1 $a1	#y
	move $t2 $a2	#array
	sub $sp, $sp 4
	sw $ra, ($sp)  	#guardo la direccion de retorno al main

	li $t3, 0
	bucle_diagonal:   			
		move $a3, $t3		  
		beq $t3, $a0, final 
		beq $t3, $a1, final 		#comparamos si hemos llegado al fin de la diagonal
		sub $sp, $sp, 4
		sw $t3, ($sp)

		jal neighbors
		
		move $t4, $v0
		sub $sp, $sp, 4
		sw $t4, ($sp)
		sub $sp, $sp, 4
		sw $t3, ($sp)   		#pasamos parametros para llamar a la funcion set
		jal set


		addi $t3, 1
		move $a3, $t3 			#avanzamos por la diagonal
		b bucle_diagonal

	final:

	lw $ra, ($sp)
	add $sp, $sp, 4
	jr, $ra 		#al main
