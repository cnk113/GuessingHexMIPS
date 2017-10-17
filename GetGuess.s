    .data
invalid:    .asciiz "Not a valid hexadecimal number"
badrange:   .asciiz "Guess not in range"
    .text
    .globl  GetGuess
# 
# int GetGuess(char * question, int min, int max)
#
#
GetGuess:
    # stack frame must contain $ra (4bytes)
    # plus room for theguess (int) (4bytes)
    # plus room for a 16-byte string
    # plus room for arguments (16)
    # total: 40 bytes
    #  16 byte buffer buf is at 16($sp)
    sub     $sp,$sp,40
    sw      $ra,36($sp)
    sw      $a0,40($sp)
    sw      $a1,44($sp)
    sw      $a2,48($sp)
    # theguess is at 32($sp)
    # buf is at 16($sp)
    #
.Lloop:
    # now output the prompt and get the guess
    li      $a2,12
    addi    $a1,$sp,16
    lw      $a0,40($sp)
    jal     InputDialogString
    # function result is negative if quit indicated
    beq     $v0,-1,.Lretguess
    add     $a0,$sp,32      #address of theguess
    add     $a1,$sp,16
    jal     axtoi
    beq     $v0,1,.Lgotguess
    # output 'Not a valid hex number' message
    # and try again
    li      $a1,0
    la      $a0,invalid
    jal     MessageDialog
    j       .Lloop
.Lgotguess:
    lw      $t0,32($sp)     #theguess
    lw      $a0,44($sp)     #min
    lw      $a1,48($sp)     #max
    # if (theguess > max) goto Lbadrange
    bgt     $t0,$a1,.Lbadrange
    # if (theguess < min) goto Lbadrange
    blt     $t0,$a0,.Lbadrange
    # the guess is in range. We're done
    b       .Lgoodguess
.Lbadrange:
    li      $a1,0
    la      $a0,badrange
    jal     MessageDialog
    b       .Lloop
.Lgoodguess:
    lw      $v0,32($sp)
.Lretguess:
    lw      $ra,36($sp)
    addiu   $sp,$sp,40
    jr      $ra
