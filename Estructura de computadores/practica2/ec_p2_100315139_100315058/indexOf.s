.data
string:	.asciiz "nice work..."
char:	.byte 'w'

.text
.globl main
	main: 
	la $a0, string  #meto string en $a0
    lb $a1, char   #meto char en $a1
    
    j indexof    #hago el salto a indexof
   
	#########################
	# INSERT YOUR CODE HERE #
	#########################
	
	li $v0, 10
	syscall

# METHOD INDEXOF
# Receives as first parameter the direction of the first character of string.
# Receives as second parameter the character to be searched. 
# Returns the index of the first ocurrence of the character.
	indexof:

        li $t0, 0		#inicializo una variable contador
        
            bucle:
                lb $t1, string($t0)
                beqz $t1,  not_found 		#salta a not_found cuando no la encuentra y llega al final 
                beq $t1, $a1, fin_bucle     	#salta a fin_bucle cuando encuentra la coincidencia
                addi $t0, $t0,1			#le sumo 1 al contador

                b bucle				#vuelve a blucle en caso de que no se cumplan las coincidencias


            fin_bucle:
                move $a0, $t0			#paso el valor de $t0 a $a0
                li $v0, 1			#le doy al $v0 el valor para que imprima int
                syscall				#llamada al sistema
             	jr $ra				#vuelve a donde estabamos en el main


            not_found:
                la $a0, -1			# cargo -1 en $a0
                li $v0, 1			#cargo en $v0 1 para que imprima 1
                syscall				#llamada al sistema
          	jr $ra	
	#########################
	# INSERT YOUR CODE HERE #
	#########################

	jr $ra
