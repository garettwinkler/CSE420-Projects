.data 
	string: .asciiz "HI HI"

.text

main:
	la $s0, string						#load string into $s0
	add $t0, $t0, $zero					#zero our $t0 for counter
	
	lowerCaseLoop:
		add $s1, $s0, $t0				#$s1 = $s0[$t0]
		lb $s2, 0($s1)					#$s2 = character to shift
		beq $s2, $zero, exit			#if $s2 = null (end of string) exit the program
		bne $s2, 0x20, charToLowerCase	#only add 20 if not the space charater
		finishLoop:
			sb $s2, ($s1)				#load shifted char from $s2 back into $s1
			addi $t0, $t0, 1			#increment i
			j lowerCaseLoop
		
	charToLowerCase:
		add $s2, $s2, 0x20				#add 20 to char in $s2 to get to lowercase
		j finishLoop					#back to finish loop
	
	exit:
		li $v0, 10
    	syscall