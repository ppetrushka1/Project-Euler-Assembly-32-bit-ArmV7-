.global _main

//IMPORTANT: This program is in 64-bit v8 ASM. 

//Pretty much a direct / literal ASM implementation of the classic trial division algorithm
//See here: https://cp-algorithms.com/algebra/factorization.html

mod: //modulo function, for later use. Arguments in x0, x1; return value in x0. 
	udiv x2, x0, x1
	mul x2, x2, x1
	sub x0, x0, x2 //r0 % r1 in r2
	ret

_main: //main factorization algorithm

	//initialization
	ldr x0, =600851475143 //which number do we want to factorize? 
	mov x1, #2 //divisor (candidate)
	mul x2, x1, x1 //d^2 (loop condition d^2 <= n) 
	
	loop: //for(int d=2;d*d<=n;d++...)
		cmp x2, x0
		b.gt exit
		
        stp x0, x1, [sp, #-16]! //store registers on the stack
        str x2, [sp, #-16]!

        bl mod
        mov x3, x0    

        ldr x2, [sp], #16 // Restore registers
        ldp x0, x1, [sp], #16
		
		cmp x3, #0 //if the remainder is zero, we've found a factor
        b.ne divloop
		mov x4, x1 //move x1 (the new, greater factor) into x4 (holds the max. factor)
		
		divloop: //while (n%d==0) n/=d;
			cmp x3, #0
			b.gt divexit

			udiv x0, x0, x1 // n/=d
			
            stp x0, x1, [sp, #-16]! //store registers, again...
            str x2, [sp, #-16]!

            bl mod //calculate n%d again
            mov x3, x0   
            
            ldr x2, [sp], #16
            ldp x0, x1, [sp], #16
			
			b divloop
		divexit:
		
		add x1, x1, #1 //increment divisor
		mul x2, x1, x1 //update its square
		b loop
	exit:

    cmp x0, #1 //final check on x0. Is it one or prime?
    b.le write
    cmp x0, x4
    b.le write
    mov x4, x0

    write: //add your own syscall for printing x4 here! 

 