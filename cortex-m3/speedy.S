.syntax unified
.thumb

.macro SB
    //y0
    and r10, r6, r8
    orn r10, r10, r9
    and r10, r10, r7
    and r11, r9, r8
    orn r12, r7, r4
    orn r11, r11, r12
    and r11, r5, r11
    orr r1, r11, r10
    //y1
    and r10, r4, r6
    orn r11, r6, r7
    orn r10, r10, r11
    and r10, r10, r9
    orr r11, r9, r8
    orn r11, r11, r7
    orn r10, r10, r11
    orr r11, r4, r7
    orn r11, r11, r5
    orn r2, r10, r11 
    //y2
    and r10, r5, r7
    orn r11, r7, r8
    orn r10, r10, r11
    and r10, r4, r10
    orr r11, r7, r8
    orn r11, r11, r6
    orn r10, r10, r11
    orr r11, r4, r6
    orr r11, r11, r9
    orn r3, r10, r11
    //y3
    and r10, r4, r8
    orr r11, r4, r7
    orn r10, r10, r11
    and r10, r10, r6
    and r11, r4, r9
    orn r11, r6, r11
    orn r10, r10, r11
    and r11, r5, r7
    orn r11, r4, r11
    orn r10, r10, r11
    //y4
    mov r14, #0
    orr r11, r8, r6
    orr r12, r4, r5
    orn r11, r11, r12
    orn r11, r14, r11
    orn r12, r7, r4
    orn r11, r11, r12
    and r12, r8, r9
    orn r12, r4, r12
    orn r11, r11, r12
    //y5
    and r14, r4, r7
    orn r12, r6, r8
    orn r14, r14, r12
    orn r14, r5, r14
    and r12, r5, r4
    orr r12, r12, r9
    and r12, r12, r6
    orn r12, r12, r14
.endm

.macro SC
    mov r4, r1
    mov r5, r2, ror #31 
    mov r6, r3, ror #30
    mov r7, r10, ror #29
    mov r8, r11, ror #28
    mov r9, r12, ror #27
.endm
.macro MC
    eor r4, r4, r1, ror #31
    eor r4, r4, r1, ror #27
    eor r4, r4, r1, ror #23
    eor r4, r4, r1, ror #17
    eor r4, r4, r1, ror #11
    eor r4, r4, r1, ror #6
    
    eor r5, r5, r2, ror #30
    eor r5, r5, r2, ror #26
    eor r5, r5, r2, ror #22
    eor r5, r5, r2, ror #16
    eor r5, r5, r2, ror #10
    eor r5, r5, r2, ror #5
    
    eor r6, r6, r3, ror #29
    eor r6, r6, r3, ror #25
    eor r6, r6, r3, ror #21
    eor r6, r6, r3, ror #15
    eor r6, r6, r3, ror #9
    eor r6, r6, r3, ror #4

    eor r7, r7, r10, ror #28
    eor r7, r7, r10, ror #24
    eor r7, r7, r10, ror #20
    eor r7, r7, r10, ror #14
    eor r7, r7, r10, ror #8
    eor r7, r7, r10, ror #3
    
    eor r8, r8, r11, ror #27
    eor r8, r8, r11, ror #23
    eor r8, r8, r11, ror #19
    eor r8, r8, r11, ror #13
    eor r8, r8, r11, ror #7
    eor r8, r8, r11, ror #2
    
    eor r9, r9, r12, ror #26
    eor r9, r9, r12, ror #22
    eor r9, r9, r12, ror #18
    eor r9, r9, r12, ror #12
    eor r9, r9, r12, ror #6
    eor r9, r9, r12, ror #1
.endm
.macro ACK n
    ldr.w   r10, [r0, \n*24] 
    eor     r4, r4, r10
    ldr.w   r10, [r0, \n*24 + 4] 
    eor     r5, r5, r10
    ldr.w   r10, [r0, \n*24 + 8] 
    eor     r6, r6, r10
    ldr.w   r10, [r0, \n*24 + 12] 
    eor     r7, r7, r10
    ldr.w   r10, [r0, \n*24 + 16] 
    eor     r8, r8, r10
    ldr.w   r10, [r0, \n*24 + 20] 
    eor     r9, r9, r10
.endm
.macro ROUND n
    SB
    SC
    SB
    SC
    MC
    ACK \n
.endm

.macro LASTROUND n
    SB
    SC
    SB
    ldr.w   r4, [r0, \n*24] 
    eor     r4, r1, r4
    ldr.w   r5, [r0, \n*24 + 4] 
    eor     r5, r2, r5
    ldr.w   r6, [r0, \n*24 + 8] 
    eor     r6, r3, r6
    ldr.w   r7, [r0, \n*24 + 12] 
    eor     r7, r10, r7
    ldr.w   r8, [r0, \n*24 + 16] 
    eor     r8, r11, r8
    ldr.w   r9, [r0, \n*24 + 20] 
    eor     r9, r12, r9
.endm

.macro STEP1
ldr.w   r10, [r1] 
    UBFX r9, r10, #0, #2
    lsl r9, #30
    UBFX r8, r10, #2, #6
    lsl r8, #26
    UBFX r7, r10, #8, #6
    lsl r7, #26
    UBFX r6, r10, #14, #6
    lsl r6, #26
    UBFX r5, r10, #20, #6
    lsl r5, #26
    UBFX r4, r10, #26, #6
    lsl r4, #26
    
    ldr.w   r10, [r1, #4]
    
    bfi r8, r10, #22, #4
    lsr r10, #4
    bfi r7, r10, #20, #6
    lsr r10, #6
    bfi r6, r10, #20, #6
    lsr r10, #6
    bfi r5, r10, #20, #6
    lsr r10, #6
    bfi r4, r10, #20, #6
    lsr r10, #6
    bfi r9, r10, #26, #4

    ldr.w   r10, [r1, #8]
    
    bfi r7, r10, #14, #6
    lsr r10, #6
    bfi r6, r10, #14, #6
    lsr r10, #6
    bfi r5, r10, #14, #6
    lsr r10, #6
    bfi r4, r10, #14, #6
    lsr r10, #6
    bfi r9, r10, #20, #6
    lsr r10, #6
    bfi r8, r10, #20, #2

    ldr.w   r10, [r1, #12]
    
    bfi r7, r10, #12, #2
    lsr r10, #2
    bfi r6, r10, #8, #6
    lsr r10, #6
    bfi r5, r10, #8, #6
    lsr r10, #6
    bfi r4, r10, #8, #6
    lsr r10, #6
    bfi r9, r10, #14, #6
    lsr r10, #6
    bfi r8, r10, #14, #6

    ldr.w   r10, [r1, #16]
    
    bfi r6, r10, #4, #4
    lsr r10, #4
    bfi r5, r10, #2, #6
    lsr r10, #6
    bfi r4, r10, #2, #6
    lsr r10, #6
    bfi r9, r10, #8, #6
    lsr r10, #6
    bfi r8, r10, #8, #6
    lsr r10, #6
    bfi r7, r10, #8, #4

    ldr.w   r10, [r1, #20]
    mov r11, r10, lsr #12
    
    bfi r9, r11, #2, #6
    lsr r11, #6
    bfi r8, r11, #2, #6
    lsr r11, #6
    bfi r7, r11, #2, #6
    lsr r11, #6
    bfi r6, r11, #2, #2
.endm

.macro STEP2
    mov r11, #1
    mov r12, #2

    and r3, r12, r10, lsr #10
    and r1, r11, r10, lsr #5
    eor r4, r4, r3
    eor r4, r4, r1
    
    and r3, r12, r10, lsr #9
    and r1, r11, r10, lsr #4
    eor r5, r5, r3
    eor r5, r5, r1

    and r3, r12, r10, lsr #8
    and r1, r11, r10, lsr #3
    eor r6, r6, r3
    eor r6, r6, r1

    and r3, r12, r10, lsr #7
    and r1, r11, r10, lsr #2
    eor r7, r7, r3
    eor r7, r7, r1

    and r3, r12, r10, lsr #6
    and r1, r11, r10, lsr #7
    eor r8, r8, r3
    eor r8, r8, r1

    and r3, r12, r10, lsr #5
    and r1, r11, r10 
    eor r9, r9, r3
    eor r9, r9, r1
.endm

.macro STEP3
    movw    r12, #0x5554 
    movt    r12, #0x5555 

    eor     r11, r4, r5, lsr #1
    and     r11, r12
    eor     r4, r4, r11
    eor     r5, r5, r11, lsl #1

    eor     r11, r6, r7, lsr #1
    and     r11, r12
    eor     r6, r6, r11
    eor     r7, r7, r11, lsl #1
    
    eor     r11, r8, r9, lsr #1
    and     r11, r12
    eor     r8, r8, r11
    eor     r9, r9, r11, lsl #1
    
    movw    r12, #0xC30C 
    movt    r12, #0x0C30 

    eor     r11, r4, r8, lsr #4
    and     r11, r12
    eor     r4, r4, r11
    eor     r8, r8, r11, lsl #4

    eor     r11, r5, r9, lsr #4
    and     r11, r12
    eor     r5, r5, r11
    eor     r9, r9, r11, lsl #4

    eor     r11, r6, r8, lsr #2
    and     r11, r12
    eor     r6, r6, r11
    eor     r8, r8, r11, lsl #2

    eor     r11, r7, r9, lsr #2
    and     r11, r12
    eor     r7, r7, r11
    eor     r9, r9, r11, lsl #2


    lsl r12, #2
    eor     r11, r4, r6, lsr #2
    and     r11, r12
    eor     r4, r4, r11
    eor     r6, r6, r11, lsl #2
    
    eor     r11, r5, r7, lsr #2
    and     r11, r12
    eor     r5, r5, r11
    eor     r7, r7, r11, lsl #2
    
.endm

.macro PACK
    STEP1
    STEP2
    STEP3
.endm

.macro UNPACK
    STEP3
    mov r12, #0;    //지워
    mov r11, #0;    //지워
    mov r10, #0;    //지워
    mov r3, #0;    //지워
    mov r2, #0;    //지워
    mov r1, #0;    //지워
    
    
    bfi r12, r9, #0, #1
    lsr r9, #1
    bfi r12, r9, #6, #1
    lsr r9, #1
    bfi r12, r9, #12, #6
    lsr r9, #6
    bfi r11, r9, #16, #6
    lsr r9, #6
    bfi r10, r9, #20, #6
    lsr r9, #6
    bfi r3, r9, #24, #6
    lsr r9, #6
    bfi r2, r9, #28, #4
    lsr r9, #4
    bfi r1, r9, #0, #2

    bfi r12, r8, #1, #1
    lsr r8, #1
    bfi r12, r8, #7, #1
    lsr r8, #1
    bfi r12, r8, #18, #6
    lsr r8, #6
    bfi r11, r8, #22, #6
    lsr r8, #6
    bfi r10, r8, #26, #6
    lsr r8, #6
    bfi r3, r8, #30, #2
    lsr r8, #2
    bfi r2, r8, #0, #4
    lsr r8, #4
    bfi r1, r8, #2, #6

    bfi r12, r7, #2, #1
    lsr r7, #1
    bfi r12, r7, #8, #1
    lsr r7, #1
    bfi r12, r7, #24, #6
    lsr r7, #6
    bfi r11, r7, #28, #4
    lsr r7, #4
    bfi r10, r7, #0, #2
    lsr r7, #2
    bfi r3, r7, #0, #6
    lsr r7, #6
    bfi r2, r7, #4, #6
    lsr r7, #6
    bfi r1, r7, #2, #6

    bfi r12, r6, #3, #1
    lsr r6, #1
    bfi r12, r6, #9, #1
    lsr r6, #1
    bfi r12, r6, #30, #2
    lsr r6, #2
    bfi r11, r6, #0, #4
    lsr r6, #4
    bfi r10, r6, #2, #6
    lsr r6, #6
    bfi r3, r6, #6, #6
    lsr r6, #6
    bfi r2, r6, #10, #6
    lsr r6, #6
    bfi r1, r6, #14, #6

    bfi r12, r5, #4, #1
    lsr r5, #1
    bfi r12, r5, #10, #1
    lsr r5, #1
    bfi r11, r5, #4, #6
    lsr r5, #6
    bfi r10, r5, #8, #6
    lsr r5, #6
    bfi r3, r5, #12, #6
    lsr r5, #6
    bfi r2, r5, #16, #6
    lsr r5, #6
    bfi r1, r5, #20, #6

    bfi r12, r4, #5, #1
    lsr r4, #1
    bfi r12, r4, #11, #1
    lsr r4, #1
    bfi r11, r4, #10, #6
    lsr r4, #6
    bfi r10, r4, #14, #6
    lsr r4, #6
    bfi r3, r4, #18, #6
    lsr r4, #6
    bfi r2, r4, #22, #6
    lsr r4, #6
    bfi r1, r4, #26, #6
    

    
.endm

@ void encrypt(const uint32_t (*rkey)[6], uint32_t* ptext, uint32_t* ctext );
.global encrypt
.type   encrypt,%function
.align 2
encrypt:

    push    {r0-r12,r14}
    //sub.w   sp, #4
    str r2, [sp, #0]

    PACK
    
    ACK #0
    ROUND #1
    ROUND #2
    ROUND #3
    ROUND #4
    ROUND #5
    ROUND #6
    LASTROUND #7

    UNPACK
    

    
    
    ldr r0, [sp, #0]
   
    add.w   sp, #4
    str.w   r1, [r0]              
    str     r2, [r0, #4]
    str     r3, [r0, #8]
    str     r10, [r0, #12]
    str     r11, [r0, #16]
    str     r12, [r0, #20]


    
    pop     {r0,r1, r3-r12, r14}           
    bx      lr
