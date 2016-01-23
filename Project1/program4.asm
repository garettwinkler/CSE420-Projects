.data
	intPromptI: .asciiz "Enter the value for 'i': "
	intPromptX: .asciiz "Enter the value for 'x': "

.text
.globl main

main:

	la	$a0, intPromptI 	#load the prompt for i
	jal	printstring			#print the prompt for i
	jal getint				#gets i
	add $s0, $zero, $v0		#saves i in $s0

	la	$a0, intPromptX 	#load the prompt for i
	jal	printstring			#print the prompt for i
	jal getint				#gets i
	add $s1, $zero, $v0		#saves i in $s0

	addi $a0, $s0, $zero 	#puts i into argument reg
	addi $a1, $s1, $zero	#puts x into argument reg
	jal fix

fix:

	bgt $a1, $zero, fixPlusOne
	bgt $a0, $zero, fixPLusFive



	fixPlusOne:
		addi $a1, $a1, -1	#x = x - 1
		


	fixPlusFive



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

	li 	$v0, 5 			#read integer
	syscall				#do it
	jr $ra				#`return, result is already in $v0
