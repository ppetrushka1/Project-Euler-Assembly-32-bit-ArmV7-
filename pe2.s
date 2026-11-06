.global _start
_start:
    mov r0, #1 @f(n-2)
    mov r1, #1 @f(n-1)
    mov r2, #1 @counter
    mov r3, #0 @sum
    ldr r5, =4000000 @upper limit
    
    loop:
	
        cmp r0, r5 @check against four million
        bge exit

        cmp r2, #3 @check counter
        addeq r3, r3, r0 @increment sum
	moveq r2, #0 @reset counter to 0

        add r2, r2, #1 @increment counter

        eor r0, r0, r1 @swap
        eor r1, r1, r0
        eor r0, r0, r1

        add r1, r1, r0 @and set the new fib. number

        b loop
    exit:

