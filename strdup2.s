#/* strdup2.c - C code for strdup2 function:
#
#    char * strdup2(char *str1, char *str2)
#
#    strdup2 takes two strings, allocates new space big enough to hold 
#    of them concatenated (str1 followed by str2), then copies each 
#    string to the new space and returns a pointer to the result.
#
#    strdup2 assumes neither str1 no str2 is NULL AND that malloc
#    returns a valid pointer.
#
#*/
#char * strdup2 (char * str1, char * str2) {
#    // get the lengths of each string 
#    int len1 = strlen(str1);
#    int len2 = strlen(str2);
#    // allocate space for the new concatenated string 
#    char *new = malloc(len1+len2+1);
#
#    // copy each to the new area 
#    strcpy(new,str1);
#    strcpy(new+len1,str2);
#
#    // return the new string
#    return(new);
#}
.globl strdup2
strdup2:
	addiu $sp,$sp,-32
	sw $ra,28($sp)
	sw $s0,16($sp)	# len1
	sw $s1,20($sp)  # len2
	sw $s2,24($sp)  # malloc pointer, *new
	sw $a0,32($sp)
	sw $a1,36($sp)
#    int len1 = strlen(str1);
	jal strlen
	move $s0,$v0
#    int len2 = strlen(str2);
	move $a0,$s1
	jal strlen
	move $s1,$v0
#    char *new = malloc(len1+len2+1);
	add $a0,$s0,$s1
	addi $a0,$a0,1
	jal malloc
	move $s2,$v0
#    strcpy(new,str1);
	lw $a1,32($sp)
	move $a0,$s2
	jal strcpy
#    strcpy(new+len1,str2);
	add $a0,$s2,$s0
	lw $a1,36($sp)
	jal strcpy
#    return(new);
	move $v0,$s2
	lw $s0,16($sp)
	lw $s1,20($sp)
	lw $s2,24($sp)	
	lw $ra,28($sp)
	addiu $sp,$sp,32
	jr $ra
	
