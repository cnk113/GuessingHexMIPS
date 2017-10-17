#int min=0;
	.data
min:	.word	42
#int max=100;
max:		.word  165
LbeforeMin:	.asciiz	"Enter a hexadecimal number between 0x"
LbetweenMinMax: .asciiz " and 0x"
LafterMax:	.asciiz "\nEnter your guess:"
Lmessage:	.asciiz ""
Llow:		.asciiz "Guess is too low"
Lhigh:		.asciiz "Guess is too high"
correct:	.asciiz "Correct"
newGame:	.asciiz "New Game (type q to quit)"
		.align 2
		.text
		.globl main
main:
	addiu	$sp,$sp,-32
	sw		$ra,28($sp)
	sw $s0,20($sp)
	sw $s1,24($sp)
# void InitRandom(int offset)
	 li $a0,2222
	 jal InitRandom
#
#main() {
#
#    char *beforeMin = "Enter a hexadecimal number between 0x";
#    char *betweenMinMax = " and 0x";
#    char *afterMax = "\nEnter your guess:";
#    char *question;
#
#    question = createQuestion(beforeMin, min, betweenMinmax, max, afterMax);
	 la		$a0,LbeforeMin
	 lw		$a1,min
	 la		$a2,LbetweenMinMax
	 lw		$a3,max
	 la		$t0,LafterMax
	 sw		$t0,16($sp)
	 jal	createQuestion
	 move $s1,$v0
new:
# int RandomIntRange(int low, int high)
	 lw $a0,min
	 lw $a1,max
	 jal RandomIntRange
	 move $s0,$v0
Lloop:
# int GetGuess(char * question, int min, int max)
	 move $a0,$s1
	 lw $a1,min
	 lw $a2,max
	 jal GetGuess
	 beq $v0,$s0,Lcorrect
	 bltz $v0,endGame
	 bgt $v0,$s0,greater
# less than guess
	 la $a0,Lmessage 
	 la $a1,Llow
	 jal MessageDialogString
	 b Lloop
# greater than guess
greater:
	 la $a0,Lmessage
	 la $a1,Lhigh
	 jal MessageDialogString
	 b Lloop
Lcorrect:
 	 la $a0,Lmessage
 	 la $a1,correct
	 jal MessageDialogString
end:
	 la $a0,Lmessage
	 la $a1,newGame
	 jal MessageDialogString
	 b new
endGame:
		
	 lw		$ra,28($sp)
	 addiu	$sp,$sp,32
	 jr		$ra
#.include "/pub/cs/gboyd/cs270/util.s"

#
#}
