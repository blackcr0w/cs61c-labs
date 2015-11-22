        .data
n:      .word 9
        .text
		
# int main() {
# 	x = 5;
# 	y = 7;
# 	sumSquare(x, y);
# }

# int sumSquare(int x, int y) {
# 	return mult(x, x) + y;
# }
# return value should be: 5 * 5 + 7 = 32
main: 
		addi    $a0, $zero, 5	# x = 5
		addi    $a1, $zero, 7	# y = 7
		jal     sumSquare
		li      $v0, 1		# print: 32
		syscall 		
		addi    $a0, $zero, 14	# $a0 = 14
		addi    $a1, $zero, 17	# $a1 = 17
		j	exit
		
sumSquare:	
		addi	$sp, $sp, -8	# change the statck pointer first
		sw	$ra, 4($sp)		# always store $ra first
		sw	$a1, 0($sp)		# store y = 7: used in outside function
		add	$a1, $a0, $zero # mult functions needs two arguments: $a0 and $a1, now both x
		jal	mult
		lw	$a1, 0($sp)		# recover a1: y = 7 first
		add	$v0, $v0, $a1	# calculate return = v0 + y
		lw	$ra, 4($sp)		# recover return address second
		addi	$sp, $sp, 8 # recover stack pointer
		jr	$ra				# jump to main function

mult:		
		addi	$sp, $sp, -4	# only store return address is enough
		sw	$ra, 0($sp)	
		add	$t0,  $a0, $zero
		add	$t1,  $a1, $zero		
		mul	$v0, $t0, $t1	# do multiplication
		lw	$ra, 0($sp)			
		# recover return address, [trick] This return address in stack is the same as storing
		jr 	$ra
		
exit:				
		li      $v0, 10		
		syscall			
