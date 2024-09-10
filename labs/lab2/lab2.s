#       CSE 3666 Lab 2

        .text
main:   
        # use system call 5 to read integer
        addi    a7, x0, 5
        ecall
        addi    s1, a0, 0       # copy to s1
        
        #   reverse bits in s1 and save the results in s2
# for (int t0 = 32; i > 0; --i)
        addi t0, x0, 32
        beq x0, x0, entry
loop:
        # s1 >>= 1;
        srli s1, s1, 1
        # s2 <<= 1;
        slli s2, s2, 1
entry:  # s2 += s1 & 1;
        andi t1, s1, 1
        add s2, s2, t1
        
        addi t0, t0, -1
        bne t0, x0, loop
# end of loop
        
        add s3, x0, a0 # save a0 (original value) in s3
        
        #   print s1 in binary, with a system call
        addi a7, x0, 35
        # add a0, x0, s1 # NOTE: s1 original value is still in a0
        ecall
        
        #   print newline
        addi a7, x0, 11
        addi a0, x0, '\n'
        ecall
        
        #   print '=' if s1 is palindrome, otherwise print s2 in binary
        bne s3, s2, not_palindrome
        
        # addi a7, x0, 11
        # addi a0, x0, '='
        # ecall
        
        beq x0, x0, exit # if_end
not_palindrome:
        
        addi a7, x0, 35
        add a0, x0, s2
        ecall
       
# if_end: 
        #   print newline
        addi a7, x0, 11
        addi a0, x0, '\n'
        ecall
        
        # exit
exit:   addi    a7, x0, 10      
        ecall
