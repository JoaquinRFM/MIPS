.data
    array: .word 0, -1, 4, -3, 7, 4
    size:  .word 6
    space: .asciiz " "
    newline: .asciiz "\n"

.text
.globl main

main:
    la $a0, array
    lw $a1, size
    li $t0, 0
    
    loop:
    	bge $t0, $a1, end
    	move $t1, $t0
    	addi $t2, $t0, 1
    	
    buscar_menor:
    	bge $t2, $a1, swap
    	mul $t3, $t2, 4
    	mul $t4, $t1, 4
    	add $t5, $a0, $t3
    	add $t6, $a0, $t4
    	lw $t7, 0($t5)
    	lw $t8, 0($t6)
    	bge $t7, $t8, aumentar_j
    	move $t1, $t2

    aumentar_j:
    	addi $t2, $t2, 1
    	j buscar_menor

    swap:
    	beq $t1, $t0, aumentar_i
    	mul $t3, $t0, 4
    	mul $t4, $t1, 4
    	add $t5, $a0, $t3
    	add $t6, $a0, $t4
    	lw $t7, 0($t5)
    	lw $t8, 0($t6)
    	sw $t8, 0($t5)
    	sw $t7, 0($t6)

    aumentar_i:
    	addi $t0, $t0, 1
    	j loop

    end:
    	jal print_array
    	li $v0, 10
    	syscall
    	
    print_array:
    	addi $sp, $sp, -4
    	sw $ra, 0($sp)
    	li $t0, 0
    	move $t1, $a0

    print_loop:
    	bge $t0, $a1, end_print
    	lw $a0, 0($t1)
    	li $v0, 1
    	syscall
    	la $a0, space
    	li $v0, 4
    	syscall
    	addi $t0, $t0, 1
    	addi $t1, $t1, 4
    	j print_loop

    end_print:
    	la $a0, newline
    	li $v0, 4
    	syscall
    	lw $ra, 0($sp)
    	addi $sp, $sp, 4
    	jr $ra