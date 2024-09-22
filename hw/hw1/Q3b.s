.text
hamming_weight: # input is in s0
        addi s1, x0, 0 # s1 = 0
        add t0, x0, s0 # make a copy so s0 is not changed
loop:
        bge t0, x0, skip_add # if t0 >= 0, we know that bit 31 is not set
        addi s1, s1, 1 # increment the popcount
skip_add:
        slli t0, t0, 1 # shift the next bit into bit 31
        bne t0, x0, loop # keep going while there are still bits in t0