.data
	var1:		.word 258			
	hueco:		.space 16			
	var2:		.word 0x000F0101
	var3:		.double 665.125
	var4:		.float 522.130
	var5:		.word 10
	cadena:		.asciiz "My first program in MIPS32 assembly language"
	caracter1:	.byte 17, 18, 19
				.align 1
	caracter2:	.byte 20, 21, 22
				.align 2
	caracter3:	.byte 23
	
.text
.globl main
	main: 
		lw $t0 var1
		lw $t1 var2
		l.d $f8 var3
		l.s $f16 var4
		lw $t2 var5
		
		add $t0,$t0,$t2
		sw $t0, hueco
		
		add.d $f8, $f8, $f8
		s.d $f8, hueco+4
		l.d $f10 hueco+4
		
		add.s $f16, $f16, $f16
		li $t3 12
		s.s $f16, hueco($t3)
		l.s $f17, hueco($t3)
		
		la $a0 cadena+1
		li $v0, 4
		syscall
		
		#Reserva de memoria dinamica de 4 bytes
			li $v0, 9
			li $a0, 4
			syscall
		#Se obtiene en $v0 el comienzo de la direccion reservada
		
		move $t4, $v0
		sw $t2, ($t4)
		
		jr $ra