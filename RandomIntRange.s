.globl RandomIntRange        
# int RandomIntRange(int low, int high)
RandomIntRange:
	addiu $sp,$sp,-20
	sw $ra,16($sp)
	sw $a0,20($sp)
	sw $a1,24($sp)
# unsigned int random(void)
	jal random
	lw $a0,20($sp)
	lw $a1,24($sp)
	divu $v0,$v0,$a1
	mfhi $v0
	addi $v0,$v0,1
# if(guess>=low)
	bge $v0,$a0,end
# low+guess=guess
	add $v0,$v0,$a0	
end:
	lw $ra,16($sp)
	addiu $sp,$sp,-20
    	jr      $ra
 
.globl InitRandom
# void InitRandom(int offset)
InitRandom:
	addiu $sp,$sp,-20
	sw $ra,16($sp)
	sw $a0,20($sp)
# unsigned int time(0)
	li $a0,0
	jal time
# add offset number to time
	lw $a0,20($sp)
	add $a0,$v0,$a0
# void srandom(unsigned int seed)
	jal srandom
	lw $ra,16($sp)
	addiu $sp,$sp,-20
        jr      $ra
