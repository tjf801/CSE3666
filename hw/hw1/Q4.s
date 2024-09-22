.text
Q4_start: # assume s1=a; s2=i; s3=r
    # i = 0
        add s2, x0, x0
        beq x0, x0, loop_start
loop:
    # i += 1
        addi s2, s2, 1
loop_start:
    # i < a
        ble s2, s1, loop_end
        
    # if (i & 0xA5 != 0)
        andi t0, s2, 0xa5
        beq t0, x0, else_branch
    # r ^= i << 8;
        slli t0, s2, 8
        xor s3, s3, t0
        beq x0, x0, loop
else_branch:
    # else
    # r += i >> 4
        srli t0, s2, 4
        add s3, s3, t0
        beq x0, x0, loop
loop_end:
        
