Q_2:    # T is in s9
        # NOTE: iterating over the loop backwards so i can compare to x0
        li      t1, 15          # int i = 0
        li      t2, 7           # int j = 8
loop:
        # NOTE: T[i][j] = T + (i*8 + j)*4
        slli    t0, t1, 3       # i * 8
        add     t0, t0, t2      # t0 += j
        slli    t0, t0, 2       # t0 *= 4
        add     t0, t0, s9
        # t3 = 256 * i + j
        slli    t3, t1, 8
        add     t3, t3, t2
        # actually do the assignment
        sw      t3, 0(t0)
        # inner loop
        addi    t2, t2, -1      # j -= 1
        bge     t2, x0, loop
        # outer loop
        addi    t1, t1, -1      # i -= 1
        bge     t1, x0, loop
