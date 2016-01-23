.data
	intpromptU: .asciiz "Enter the value for 'u': "
	intpromptV: .asciiz "Enter the value for 'v': "
	newline: .asciiz "\n"
	result:	 .asciiz "Result is: "		
	equation: .asciiz "10u2 + 4uv + v2 - 1 = "
	
.text
.globl main

main:
	#Prints, gets, and saves prompt for u
	la  $a0, intpromptU		#load the prompt for u
	jal printstring			#print the prompt for u
	jal getint				#gets u
	add $s0, $zero, $v0		#saves u in $s0

	#Prints new line
	la $a0, newline			#loads newLine string into $a0
	li $v0, 4				#prepares for printing
	syscall					#prints

	#Prints, gets, and saves prompt for v
	la $a0, intpromptV		#load the prompt for v
	jal printstring			#print the prompt for v
	jal getint				#gets v
	add $s1, $zero, $v0		#saves v in $s1

	add $a0, $s0, $zero		#$a0 = $s0 + 0 = (u + 0)
	jal Square 				#computes u^2
	add $s2, $zero, $v0		#$s2 = $s1 * $s1, u^2

	add $a0, $s1, $zero		#loads v into $a0
	jal Square 				#computes v^2
	add $s3, $zero, $v0		#$s3 = v^2

	add $a0, $s2, $zero		#loads u^2 into $a0 for multiplcation with 10
	addi $a1, $zero, 10	#loads 10 into $a1 for 10 * u^2
	jal Multiply 			#computes 10 * u^2
	add $s4, $zero, $v0		#loads 10 * u^2 into $s4

	add $a0, $s0, $zero		#puts u into $a0
	addi $a1, $zero, 4	#puts 4 into $a1
	jal Multiply 			#computes 4 * u
	add $s5, $zero, $v0 	#loads 4 * u into $s5

	add $a0, $s5, $zero 	#loads 4 * u into $a0
	add $a1, $s1, $zero		#loads v into $a1
	jal Multiply 			#computes 4 * u * v
	add $s5, $zero, $v0 	#loads 4 * u * v into $s5

	#$s0 = u, $s1 = v, $s2 = u^2, $s3 = v^2, $s4 = 10 * u^2, $s5 = 4 * u * v,

	add $s6, $s4, $s5		#$s6 = 10 * u^2 + 4 * u * v
	add $s6, $s6, $s3 		#$s6 += v^2
	addi $s6, $s6, -1		#$s6 -= 1
	
	#Prints new line
	la $a0, newline			
	li $v0, 4			
	syscall

	la $a0, equation		#load the result output line
	jal printstring			#print the result line

	li $v0, 1			#print the result
	add $a0, $s6, $zero
	syscall

	li $v0, 10			#exits program
   	syscall

printstring:
#Input parameters:	$a0, address of the string to print
#Return values:		none
#Description: 		print the given string to the screen (console) (hint: 

	li $v0, 4		#prints the string loaded into $a0 in main
	syscall			#print
	jr $ra 			#jumps back to main

getint:
# Input parameters:	none
# Return values: 	$v0 = integer input by user
# Description: 		This procedure will return the integer entered by the user 
#					on the keyboard (console input)

	li $v0, 5 			# read integer
	syscall				# do it
	jr $ra				# return, result is already in $v0

Square:
# Input parameters:	int to square
# Return values:	$v0 = int after it's been squared
# Description:		Takes the argument integer, squares it, and returns the square

	add $t0, $a0, $zero	#adds $a0 into temp $t0 for multiplication
	mult $a0, $t0		#multiplies $a0 and $t0 (which is $a0 * $a0, squaring the number)
	mflo $v0			#moves multiplcation product from LO into $v0 for return
	jr $ra 				#jumps back to main

Multiply:
# Input parameters:	ints to multiply
# Return values:	$v0 = product of two arguments
# Description:		Takes two ints to multiply and returns the product

	mult $a0, $a1	#multiples two argument ints
	mflo $v0		#moves from LO register into $v0
	jr $ra 			#jumps back to main
