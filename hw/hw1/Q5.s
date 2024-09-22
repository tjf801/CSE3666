.text
.globl main
main:
        addi a7, x0, 5
        ecall
        # a0 is now the int
        
        addi s1, x0, 0 # s1 is the count
        
        beq x0, x0, loop_start
loop:
        
        andi t0, a0, 1
        beq t0, x0, div_by_two
        
        # multiply by three and add one
        add t0, a0, a0 # t0 = a0 + a0
        add a0, t0, a0 # a0 += t0
        addi a0, a0, 1 # a0 += 1
        addi s1, s1, 1
        
div_by_two:
        srli a0, a0, 1
        addi s1, s1, 1
        
loop_start:
        addi t0, x0, 1
        bne t0, a0, loop
        
        addi a7, x0, 36
        add a0, x0, s1
        ecall
        