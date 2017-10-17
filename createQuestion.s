
#char * createQuestion( char *beforeMin, int min,
#        char *betweenMinMax, int max, char * afterMax) {
	.globl createQuestion
createQuestion:
	addiu	$sp,$sp,-52
	sw		$ra,48($sp)
	sw		$s1,44($sp)
	sw		$s0,40($sp)
#    char minbuf[12];
	# minbuf is at 28($sp)
#    char maxbuf[12];
	# maxbuf is at 16($sp)
#    char *result,*result1;
	# result is $s0
	#result1 is $s1
	# home arguments
	sw		$a0,52($sp)
	sw		$a2,60($sp)
	sw		$a3,64($sp)
#
#    // encode min into minbuf
#    itoax(min, minbuf);
	move	$a0,$a1
#	addi	$a1,$sp,28
	la		$a1,28($sp)
	jal		itoax
#
#    // concatenate beforeMin and minbuf
#    result = strdup2(beforeMin,minbuf)
	 lw		$a0,52($sp)
	 la		$a1,28($sp)
	 jal	strdup2
	 move	$s0,$v0
#
#    // concatenate result with betweenMinMax
#	 result1 = result;
	 move	$s1,$s0
#    result = strdup2(result,betweenMinMax);
	 move	$a0,$s0
	 lw		$a1,60($sp)
	 jal	strdup2
	 move	$s0,$v0
#	 free(result1);
	 move	$a0,$s1
	 jal	free
#
#    // encode max into maxbuf
#    itoax (max, maxbuf);
	lw		$a0,64($sp)
	la		$a1,16($sp)
	jal		itoax
#
#    // concatenate result with maxbuf)
#	 result1 = result;
	 move	$s1,$s0
#    result = strdup2(result,maxbuf);
	 move	$a0,$s0
	 la		$a1,16($sp)
	 jal	strdup2
	 move	$s0,$v0
#	 free(result1);
	 move	$a0,$s1
	 jal	free
#
#    // append the afterMax string
#	 result1 = result;
	 move	$s1,$s0
#    result = strdup2(result,afterMax);
	 move	$a0,$s0
	 lw		$a1,68($sp)
	 jal	strdup2
	 move	$s0,$v0
#	 free(result1);
	 move	$a0,$s1
	 jal	free
#
#    return result;
	 move	$v0,$s0
	lw		$ra,48($sp)
	lw		$s1,44($sp)
	lw		$s0,40($sp)
	addiu	$sp,$sp,52
	 jr		$ra
#}
