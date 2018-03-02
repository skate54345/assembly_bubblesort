#Austin Kelly
#CS200
#Project 7

.data #start of data segment

#sets up variables
seed_msg: .asciiz "Input your seed integer: "
min_msg: .asciiz "Input your min integer: "
max_msg: .asciiz "Input your max integer: "
again_msg: .asciiz "Generate another? 1 for yes: "
one: .word 1 #makes word of 1
multiplier: .word 1664525 #assigns word to multiplier from example on wikipedia
increment: .word 1013904223 #assigns increment to good value from same example
current_num: .word 0 #sets up default seed
pseudorand: .word 0 #sets up max
min: .word 0 #sets up min variable for convenience
max: .word 0 #sets up max
inner_parenth: .word 0 #sets up variable for inner parenthesis of equation
outer_parenth: .word 0 #sets up variable for outer parenthesis of equation
num_low_to_high: .word 0 #sets up variable for outer parenthesis of equatio
 
.text #start of text segment
loop_start:
#taking in seed
	#printing out seed prompt
	li $v0, 4 #says we are going to print
	la $a0, seed_msg #takes argument
	syscall 

	#getting user seed input
	li $v0, 5 #read integer
	syscall #calls
	
	sw $v0, current_num #stores number to seed
	
#taking in min number
	#printing out min prompt
	li $v0, 4 #says we will print
	la $a0, min_msg #takes in argument
	syscall  #calls

	#getting user min input
	li $v0, 5 #read integer
	syscall #calls
	
	sw $v0, min #stores number to min
	 
#taking in max number
	#printing out min prompt
	li $v0, 4 #says we will print
	la $a0, max_msg #takes in argument
	syscall  #calls

	#getting user min input
	li $v0, 5 #read integer
	syscall #calls

	sw $v0, max #stores number to max 
	
	
#arithmetic
	lw $t0, multiplier #loads multiplier to $t0
	lw $t1, current_num #loads seed to $t1
	mulu $s0, $t0, $t1 #stores product of multiplier and seed to $s0 with overflow
	mflo $t0 #loads lo to temp
	mfhi $t1 #loads hi to $t1
	sw $t0, current_num #stores contents of LO from mulu to seed
	sw $t1, pseudorand #stores contents of HI from mulu to pseudorand
	lw $t3, max #sets $t3 to max
	lw $t4, min #sets $t4 to min
	sub $s0, $t3, $t4 #subtracts min from max and sets to $s0
	lw $t5, one #sets $t5 to 1
	add $t6, $s0, $t5 #adds 1
	sw $t6, inner_parenth #stores $t6 to variable
	
	rem $s1, $t1, $t6 #mods pseudorand and inner_parenth, stores to $s1
	sw $s1, outer_parenth #stores result to variable
	lw $t0, min #loads $t0 as min
	add $s2, $s1, $t0 #adds outer parentheses to low, stores to $s2
	sw $s2, num_low_to_high #stores final result to variable
	
	li $v0, 1 #says we will print
	lw $a0, num_low_to_high #takes in argument
	syscall  #calls
	
	li $v0, 11 #says to print character
	syscall #prints space to look nice
	
	#printing out prompt
	li $v0, 4 #says we will print
	la $a0, again_msg #takes in argument
	syscall  #calls

	#getting user again input
	li $v0, 5 #read integer
	syscall #calls

	move $t7, $v0 #stores number to
	beqz $t7, end_loop
	b loop_start
end_loop:

	li $v0, 10 #sets up exit
	syscall
