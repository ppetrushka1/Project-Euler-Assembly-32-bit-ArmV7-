.global _start
_start:
	ldr r4, =1000
	@sum stored in r5. r0 through r2 reserved for muliples of 3,5 and 15.
	
	loop:
		cmp r0, r4 
		bge exit
		add r5, r5, r0
		add r0,r0,#3

		cmp r1, r4
		addlt r5, r5, r1
		addlt r1,r1,#5
		
		cmp r2, r4
		sublt r5, r5, r2
		addlt r2,r2,#15	
		
		b loop
	exit: