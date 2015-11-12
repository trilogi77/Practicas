.data
	string1:	.asciiz "Good work..."
	string2:	.asciiz "Yeah, good work."
.text
.globl main
	main: 
	la $a2 string1
	la $a1 string2
	jal concat
	#########################
	# INSERT YOUR CODE HERE #
	#########################
	 move $t5, $v0
    
        move $a0, $t5
        li $v0, 4               #imprimimos el nuevo string
        syscall

	li $v0, 10
	syscall

# METHOD CONCAT 
# Receives as first parameter the direction of the first character of string1.
# Receives as second parameter the direction of the first character of string2.
# Returns the direction of the first character of the new string. 
	concat:
	li $t0, 0		#inicializo una variable contador
	li $t2, 0
        
            string_long1:
                lb $t1, string1($t0)
                beq $t1, $zero,  string_long2	 		#salta a string_long cuando se encuentra un 0 que es el final del string
                addi $t0, $t0,1			#le sumo 1 al contador
                b string_long1				#vuelve a blucle en caso de que no se cumplan las coincidencias
			string_long2:
                lb $t1, string2($t2)
                beq $t1, $zero,  fincuenta	 		#salta a fincuenta cuando se encuentra un 0 que es el final del string
                addi $t2, $t2,1			#le sumo 1 al contador
                b string_long2				#vuelve a blucle en caso de que no se cumplan las coincidencias
      fincuenta:        
     	add $t3, $t2, $t0     #sumamos los tamaños de los vectores
     	move $a0, $t3
     	li $v0, 9         #hacemos el sbkr para reservar memoria
     	syscall

     	li $t0, 0		#inicializo una variable contador
		li $t2, 0
		move $t5, $v0
     		string_1dentro:                              #metemos dentro del nuevo string el primero
     		    lb $t1, string1($t0)
                beq $t1, $zero, string_2dentro	 		#salta a string_2dentro cuando se encuentra un 0 que es el final del string
                sb $t1, ($t5)
                addi $t5, $t5, 1
                addi $t0, $t0,1			#le sumo 1 al contador
                b string_1dentro
            string_2dentro:                             #metemos dentro del nuevo string el segundo
            	 lb $t1, string2($t2)
                beq $t1, $zero,  imprimir	 		#salta a imprimir cuando se encuentra un 0 que es el final del string
                sb $t1, ($t5)
                addi $t5, $t5,1			#le sumo 1 al contador
                addi $t2, $t2,1
                b string_2dentro   
          

imprimir:

       
	#########################
	# INSERT YOUR CODE HERE #
	#########################

	jr $ra
