
.text
reverse_bytes: # assume fn argument is in s2, not a0
        # s4 = (s2 >> 24) & 0x000000ff | (s2 >> 8) & 0x0000ff00 | (s2 << 8) & 0x00ff0000 | (s2 << 24) & 0xff000000
        xor s4, s4, s4 # clear s4
        
        srli t0, s2, 24
        addi t1, x0, 0xff
        # and t0, t0, t1 # redundant because the 24 upper bytes of t0 are already 0
        or s4, s4, t0
        
        srli t0, s2, 8
        slli t1, t1, 8
        and t0, t0, t1
        or s4, s4, t0
        
        slli t0, s2, 8
        slli t1, t1, 8
        and t0, t0, t1
        or s4, s4, t0
        
        slli t0, s2, 24
        # slli t1, t1, 8 # redundant because t1 is not used anymore
        # and t0, t0, t1 # redundant bc the 24 lower bytes of t0 are already 0
        or s4, s4, t0
        