# Addition of decimal strings

.data   
dst:            .space  128
str1:           .space  128
str2:           .space  128
error_message:  .asciz "Invalid input.\n"

.text
main: 
        # load adresses of strings into s1, s2, and s3
        # s3 is dst, where we store the result
        lui     s3, 0x10010
        addi    s1, s3, 128
        addi    s2, s1, 128
        # read the first number as a string
        addi    a0, s1, 0
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall   
        # read the second number as a string
        addi    a0, s2, 0
        addi    a1, x0, 100
        addi    a7, x0, 8
        ecall   
        # find the length of str1 and store it in s4
        add     t1, s1, x0
strlen_loop:    # NOTE: don't need to jump to comparison first, since the scanned string will have '\n' before the null terminator, and so will have length > 0
        addi    t1, t1, 1
        lb      t2, 0(t1)
        bne     t2, x0, strlen_loop
        sub     s4, t1, s1      # t1 has the address of '\0', so t1 - s1 is the length of the string
        # first assert str1[s4] == str2[s4] == '\n'
        addi    s4, s4, -1
        addi    t3, x0, '\n'
        add     t1, s1, s4
        lb      t0, 0(t1)
        bne     t0, t3, error
        add     t2, s2, s4
        lb      t0, 0(t2)
        bne     t0, t3, error
        # t3 = s3 + i
        add     t3, s3, s4
        addi    t0, x0, '\n'
        sb      t0, 0(t3)
        # use t0 as the carry bit
        addi    t0, x0, 0
addition_loop: # t2 is &str2[i-1] and t1 is &str1[i-1]
        # actually do the addition, using t1 as the carry bit
        # NOTE: dst[i] = (str1[i]-'0') + (str2[i]-'0') + carry mod 10
        addi    t1, t1, -1
        addi    t2, t2, -1
        addi    t3, t3, -1
        lb      t4, 0(t1)
        addi    t4, t4, -48 # -'0'
        lb      t5, 0(t2)
        addi    t5, t5, -48 # -'0'
        add     t4, t4, t5
        add     t4, t4, t0 # add the carry
        # compare value to 10
        addi    t5, x0, 10
        blt     t4, t5, skip_carry
        addi    t4, t4, -10
        addi    t0, x0, 1
skip_carry:
        # store the value
        addi    t4, t4, '0'
        sb      t4, 0(t3)
        # keep going until t1 gets back to s1
        bne     t1, s1, addition_loop
        
        # print the result
        addi    a7, x0, 4
        add     a0, s3, x0
        ecall
        # exit
        addi    a7, x0, 10
        ecall
error:  # print the error message
        addi    a7, x0, 4
        addi    a0, s2, 128
        ecall   
        # exit
        addi    a7, x0, 10
        ecall
