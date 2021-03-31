.syntax unified
.cpu cortex-m4
//.fpu softvfp
.thumb

#define A #4
#define B #2
#define C #3

.global vtable_kernel
.global __kernel_reset__

.type vtable_kernel, %object
.type __kernel_reset__, %function

.section .interrupt_vector
vtable_kernel:
    .word __stack_start
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel

.section .rodata
    data: .asciz "kernel started!\n"
    data_end: .asciz "kernel ended!\n"
.section .text
__kernel_reset__:
	ldr r0, =data
	bl dbgput_line


	// calculate (a+b)/2 + c!
        mov r0, A
    	mov r1, B
    	mov r2, C 
    	bl test_var
	test_var:
    		push { r0, r1, r2, lr } 
    		ADD r0, r0, r1 // a + b
   	 	ASR r0, #1  //  / 2
    		mov r3, #1
    		cfact:		// !
   		 	cmp r2, #1 
	    		bEQ res	
	    		MUL r3, r2 
		 	SUB r2, #1
	    		bNE cfact
    	res:
		ADD r0, r3
	mov r3, r0
	ldr r0, =data_end
	bl dbgput
	mov r0, r3
	bl dbgput_num

	end:
	b end
