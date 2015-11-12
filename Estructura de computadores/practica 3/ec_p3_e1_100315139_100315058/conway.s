.data
	array:		.word 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0
				.word 0, 0, 1, 1, 1
				.word 0, 0, 1, 0, 0
				.word 0, 0, 0, 1, 0
	x:			.word 5
	y:			.word 5
	
.text
.globl main

main:
lw $a0, x
lw $a1, y
la $a2, array
li $a3, 4 		#numero de iteraciones, hemos puesto este valor, a falta de otro, ya que el enunciado no nos lo da
jal game_of_life
li $v0, 10			
syscall

	jr $ra

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
	lw $t4, ($sp)	#numero a insertar
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

malloc:					#funcion que reserva espacio para una matriz
	move $t0, $a0
	move $t1, $a1
	li $t2, 0		#contador de posicion
	li $t3, 0		#puntero p, inicio de array y
	li $t4, 0		#puntero p, inicio de array x
	mul $t3, $t1, 4		#numero de posiciones del array y a reservar
	move $a0, $t3	#el numero de posiciones, al a0
	li $v0, 9	
	syscall			#syscall que crea el array
	move $t3, $v0	#en $t3 tenemos la direccion de inicio del array

	buclecreacion:
	bge $t2, $t1 fincreacion
	mul $t4, $t0, 4		#numero de posiciones del array x a reservar
	move $a0, $t4	#el numero de posiciones, al a0
	li $v0, 9	
	syscall			#syscall que crea el array
	move $t4, $v0	#direccion de inicio del array[i]
	addi $t2, 1
	fincreacion:

	move $v0, $t3		#direccion de inicio

	jr $ra

copy_array: 			#funcion que copia una matriz en otra del mismo tamaño
	
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3		#array de destino
	sub $sp, $sp 4
	sw $ra, ($sp)		#guardo la direccion de memoria de retorno
	
	li $t4, 0		#number (lo que se copia en cada paso)
	li $t5, 0		#contador del for de x
	

	bucleconx:
		bge $t5, $t0 fin_copy
	li $t6, 0		#contador del for de y
	buclecony:
		bge $t6, $t1 minisuma
	move $a3, $t5
	sub $sp, $sp 4
	sw $t6, ($sp)
	sub $sp, $sp 8 	#paso parametros para el get
	jal get
	move $t4, $v0  	#numero a copiar
	add $sp, $sp 12

	move $a2, $t3
	sub $sp, $sp, 4
	sw $t4, ($sp)
	sub $sp, $sp, 4
	sw $t6, ($sp)		#paso parametros para el set

	jal set
	move $a2, $t2
	addi $t6, 1
	b buclecony
	
	minisuma: 			#actualiza el for
		addi $t5, 1
		b bucleconx

fin_copy: 				#terminamos la copia
	move $t3, $a3
	lw $ra, ($sp)
	add $sp, $sp, 4
	jr $ra

clean_array: 		#funcion que coloca un 0 en todas las posiciones de una matriz
	
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	li $t3, 0		#contador x
	
	li $t5, 0		#paso 0 para limpiar el array
	sub $sp, $sp, 4
	sw $ra, ($sp) 	#guardo retorno
buclex:
	bge $t3, $t0 fin_clean
	li $t4, 0		#contador y
	bucley:
		bge $t4, $t1 minisuma2
	
	move $a3, $t3
	sub $sp, $sp, 4
	sw $t5, ($sp)
	sub $sp, $sp, 4
	sw $t4, ($sp)		#paso parametros para el set
	
	jal set
	
	addi $t4, 1
	b bucley
	
	minisuma2:         #actualizo el for
		addi $t3, 1
		b buclex

fin_clean:

	lw $ra, ($sp)
	add $sp, $sp, 4

	jr $ra

game_of_life: 		#funcion que simula "el juego de la vida", con un numero de iteraciones dada
	
	move $t0, $a0
	move $t1, $a1
	move $t2, $a2
	move $t3, $a3	#iteraciones
	sub $sp, $sp, 4
	sw $ra, ($sp)	#guardo en la pila $ra al main
	jal malloc		#creamos la matriz auxiliar
	move $t9, $v0	#direccion de inicio de la matriz auxiliar
	li $t4, 0	#neighbors
	li $t5, 0	#cell
	li $t6, 0	#iteraciones
	
	

	forit:
		bge $t6, $t3 fin
		move $a2, $t9		#paso el auxiliar en esta ocasion por el a2
		jal clean_array
		li $t7, 0	#contador de x
	forx:
		bge $t7, $t0 mini1
		li $t8, 0 	#contador de y
	fory:
		bge $t8, $t1 mini2
	
	move $a3, $t7
	sub $sp, $sp 4
	sw $t8, ($sp)
	sub $sp, $sp 8 	#muevo parametros para llamar al get

	jal get

	move $t5, $v0		#get cell (0 o 1)
	add $sp, $sp, 12
	
	move $a2, $t2 		#a2 vuelve a ser la direccion de inicio del array original
	sub $sp, $sp 4
	sw $t8, ($sp)     #paso el contador de y para el neighbors

	jal neighbors  		#esta funcion tambien suma 4 a la pila, no hace falta hacerlo ahora
	
	move $t4, $v0
	move $a2, $t9
	move $a3, $t7
	beq $t5, 0 celdacero	#primer if, si hay cero en esa posicion
	beq $t4, 2 vive			#colocar 1 si es 2 o 3
	beq $t4, 3 vive			#colocar 1 si es 2 o 3
	
	sub $sp, $sp, 4
	sw $zero, ($sp)
	sub $sp, $sp, 4
	sw $t8, ($sp)		#set, pone 0 en esa posicion del array auxiliar
	jal set
	b finy
	
	celdacero:
	beq $t4, 3 vive
	
	sub $sp, $sp, 4
	sw $zero, ($sp)
	sub $sp, $sp, 4
	sw $t8, ($sp)		#set, pone 0 en esa posicion del array auxiliar
	jal set
	b finy

	vive:
	
	sub $sp, $sp, 4
	li $t5, 1
	sw $t5, ($sp) 		#podemos modificar el t5
	sub $sp, $sp, 4
	sw $t8, ($sp)		
	jal set 			#set, pone 1 en esa posicion del array auxiliar
	b finy

	finy:
	addi $t8, 1
	b fory
	
	mini2:
		addi $t7, 1
		b forx
	
	mini1:
		move $a3, $t9	#mover el array auxiliar a $a3...resto de parametros en su sitio
		jal copy_array 	#copiamos el array
		addi $t6, 1
		b forit

fin:		
	lw $ra, ($sp)
	add $sp, $sp, 4
	jr $ra
