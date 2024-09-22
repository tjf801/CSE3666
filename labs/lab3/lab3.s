#       CSE 3666 Lab 3: remove spaces

        .data
        # allocating space for both strings
str:    .space  128
res:    .space  128

        .text
main:   
        # load (hard-coded) address of strings 
        lui     s0, 0x10010    # str
        addi    s1, s0, 128    # res

        # read a string into str
        addi    a0, s0, 0 
        addi    a1, x0, 120
        addi    a7, x0, 8
        ecall

        # str's addres is already in s0
        # copy res's address to a1
        addi    a1, s1, 0
        
        # copy all characters from [a0] into [a1], skipping spaces
        # NOTE: since .data is zero initialized, no additional null terminator is needed for the string
        addi    t1, x0, ' '
        beq     x0, x0, skip_copy
main_loop:
        beq     t0, t1, skip_copy
        sb      t0, 0(a1)
        addi    a1, a1, 1
skip_copy:
        lb      t0, 0(a0)
        addi    a0, a0, 1
        bne     t0, x0, main_loop
        
        # print [s1]
        add     a0, x0, s1
        addi    a7, x0, 4
        ecall
        
exit:   addi    a7, x0, 10
        ecall
