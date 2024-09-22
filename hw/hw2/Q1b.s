        addi s4, x0, 100
        addi s1, x0, 0
loop:   
        slli t0, s1, 2  # t0 = i * 4 
        add t2, t0, s2  # compute addr of A[i]
        add t3, t0, s3  # compute addr of B[i]
        lw t1, 0(t2)    # t1 = *t2 = *&A[i]
        addi t1, t1, 4  # t1 += 4 = A[i] + 4
        sw t1, 0(t3)    # B[i] = t1 = A[i] + 4
        lw t1, 4(t2)
        addi t1, t1, 4
        sw t1, 4(t3)    # B[i+1] = A[i+1] + 4
        lw t1, 8(t2)
        addi t1, t1, 4
        sw t1, 8(t3)    # B[i+2] = A[i+2] + 4
        lw t1, 12(t2)
        addi t1, t1, 4
        sw t1, 12(t3)   # B[i+3] = A[i+3] + 4
        addi s1, s1, 4  # i += 4
        blt s1, s4, loop
