.text
.macro ACK rk
    lw      t0,0+\rk
    xor     a1,a1,t0
    lw      t0,4+\rk
    xor     a3,a3,t0
    lw      t0,8+\rk
    xor     a4,a4,t0
    lw      t0,12+\rk
    xor     a5,a5,t0
    lw      t0,16+\rk
    xor     a6,a6,t0
    lw      t0,20+\rk
    xor     a7,a7,t0


.endm

.macro SB x0,x1,x2,x3,x4,x5
    and     t0,\x5,\x4
    xori    t1,\x3,-1
    and     t1,t1,\x0
    or      t0,t0,t1
    and     t0,t0,\x1
    and     t1,\x4,\x2
    xori    t2,\x5,-1
    or      t1,t1,t2
    and     t1,t1,\x3
    or      t0,t0,t1

    or      t1,\x3,\x0
    xori    t1,t1,-1
    and     t1,t1,\x1
    and     t2,\x2,\x0
    and     t2,t2,\x5
    or      t1,t1,t2
    or      t2,\x5,\x4
    xori    t2,t2,-1
    xori    t3,\x2,-1
    and     t3,t3,\x5
    or      t2,t2,t3
    and     t2,t2,\x3
    or      t1,t1,t2

    or      t2,\x5,\x2
    or      t2,t2,\x0
    xori    t2,t2,-1
    or      t3,\x3,\x4
    xori    t3,t3,-1
    and     t3,t3,\x2
    or      t2,t2,t3
    and     t3,\x3,\x1
    xori    t4,\x3,-1
    and     t4,t4,\x4
    or      t3,t3,t4
    and     t3,t3,\x0
    or      t2,t2,t3

    xori    t3,\x0,-1
    and     t3,t3,\x3
    and     t3,t3,\x1
    xori    t4,\x2,-1
    and     t4,t4,\x0
    and     t4,t4,\x5
    or      t3,t3,t4
    and     t4,\x0,\x4
    or      t5,\x0,\x3
    xori    t5,t5,-1
    or      t4,t4,t5
    and     t4,t4,\x2
    or      t3,t3,t4

    xori    t4,\x0,-1
    and     t4,t4,\x4
    and     t4,t4,\x5
    xori    t5,\x3,-1
    and     t5,t5,\x0
    or      t4,t4,t5
    or      t5,\x0,\x1
    or      t6,\x4,\x2
    xori    t6,t6,-1
    and     t5,t5,t6
    or      t4,t4,t5

    and     t5,\x0,\x3
    xori    t6,\x2,-1
    and     t6,t6,\x4
    or      t5,t5,t6
    xori    t6,\x1,-1
    and     t5,t5,t6
    and     t6,\x0,\x1
    or      t6,t6,\x5
    and     t6,t6,\x2
    or      t5,t5,t6

.endm

.macro SC
    mv      a1,t0
    srli    t6,t1,31
    slli    a3,t1,1
    xor     a3,a3,t6
    srli    t6,t2,30
    slli    a4,t2,2
    xor     a4,a4,t6
    srli    t6,t3,29
    slli    a5,t3,3
    xor     a5,a5,t6
    srli    t6,t4,28
    slli    a6,t4,4
    xor     a6,a6,t6
    srli    t6,t5,27
    slli    a7,t5,5
    xor     a7,a7,t6
.endm

.macro MC
    srli    t6,t0,31
    xor     a1,a1,t6
    slli    t6,t0,1
    xor     a1,a1,t6
    srli    t6,t0,27
    xor     a1,a1,t6
    slli    t6,t0,5
    xor     a1,a1,t6
    srli    t6,t0,23
    xor     a1,a1,t6
    slli    t6,t0,9
    xor     a1,a1,t6
    srli    t6,t0,17
    xor     a1,a1,t6
    slli    t6,t0,15
    xor     a1,a1,t6
    srli    t6,t0,11
    xor     a1,a1,t6
    slli    t6,t0,21
    xor     a1,a1,t6
    srli    t6,t0,6
    xor     a1,a1,t6
    slli    t6,t0,26
    xor     a1,a1,t6

    srli    t6,t1,30
    xor     a3,a3,t6
    slli    t6,t1,2
    xor     a3,a3,t6
    srli    t6,t1,26
    xor     a3,a3,t6
    slli    t6,t1,6
    xor     a3,a3,t6
    srli    t6,t1,22
    xor     a3,a3,t6
    slli    t6,t1,10
    xor     a3,a3,t6
    srli    t6,t1,16
    xor     a3,a3,t6
    slli    t6,t1,16
    xor     a3,a3,t6
    srli    t6,t1,10
    xor     a3,a3,t6
    slli    t6,t1,22
    xor     a3,a3,t6
    srli    t6,t1,5
    xor     a3,a3,t6
    slli    t6,t1,27
    xor     a3,a3,t6

    srli    t6,t2,29
    xor     a4,a4,t6
    slli    t6,t2,3
    xor     a4,a4,t6
    srli    t6,t2,25
    xor     a4,a4,t6
    slli    t6,t2,7
    xor     a4,a4,t6
    srli    t6,t2,21
    xor     a4,a4,t6
    slli    t6,t2,11
    xor     a4,a4,t6
    srli    t6,t2,15
    xor     a4,a4,t6
    slli    t6,t2,17
    xor     a4,a4,t6
    srli    t6,t2,9
    xor     a4,a4,t6
    slli    t6,t2,23
    xor     a4,a4,t6
    srli    t6,t2,4
    xor     a4,a4,t6
    slli    t6,t2,28
    xor     a4,a4,t6

    srli    t6,t3,28
    xor     a5,a5,t6
    slli    t6,t3,4
    xor     a5,a5,t6
    srli    t6,t3,24
    xor     a5,a5,t6
    slli    t6,t3,8
    xor     a5,a5,t6
    srli    t6,t3,20
    xor     a5,a5,t6
    slli    t6,t3,12
    xor     a5,a5,t6
    srli    t6,t3,14
    xor     a5,a5,t6
    slli    t6,t3,18
    xor     a5,a5,t6
    srli    t6,t3,8
    xor     a5,a5,t6
    slli    t6,t3,24
    xor     a5,a5,t6
    srli    t6,t3,3
    xor     a5,a5,t6
    slli    t6,t3,29
    xor     a5,a5,t6

    srli    t6,t4,27
    xor     a6,a6,t6
    slli    t6,t4,5
    xor     a6,a6,t6
    srli    t6,t4,23
    xor     a6,a6,t6
    slli    t6,t4,9
    xor     a6,a6,t6
    srli    t6,t4,19
    xor     a6,a6,t6
    slli    t6,t4,13
    xor     a6,a6,t6
    srli    t6,t4,13
    xor     a6,a6,t6
    slli    t6,t4,19
    xor     a6,a6,t6
    srli    t6,t4,7
    xor     a6,a6,t6
    slli    t6,t4,25
    xor     a6,a6,t6
    srli    t6,t4,2
    xor     a6,a6,t6
    slli    t6,t4,30
    xor     a6,a6,t6

    srli    t6,t5,26
    xor     a7,a7,t6
    slli    t6,t5,6
    xor     a7,a7,t6
    srli    t6,t5,22
    xor     a7,a7,t6
    slli    t6,t5,10
    xor     a7,a7,t6
    srli    t6,t5,18
    xor     a7,a7,t6
    slli    t6,t5,14
    xor     a7,a7,t6
    srli    t6,t5,12
    xor     a7,a7,t6
    slli    t6,t5,20
    xor     a7,a7,t6
    srli    t6,t5,6
    xor     a7,a7,t6
    slli    t6,t5,26
    xor     a7,a7,t6
    srli    t6,t5,1
    xor     a7,a7,t6
    slli    t6,t5,31
    xor     a7,a7,t6
.endm

.macro ROUND n
    SB      a1,a3,a4,a5,a6,a7
    SC
    SB      a1,a3,a4,a5,a6,a7
    SC
    MC
    ACK     24*\n(a0)
.endm

.macro LASTROUND n
    SB      a1,a3,a4,a5,a6,a7
    SC
    SB      a1,a3,a4,a5,a6,a7
    lw      t6,0+24*\n(a0)
    xor     a1,t0,t6
    lw      t6,4+24*\n(a0)
    xor     a3,t1,t6
    lw      t6,8+24*\n(a0)
    xor     a4,t2,t6
    lw      t6,12+24*\n(a0)
    xor     a5,t3,t6
    lw      t6,16+24*\n(a0)
    xor     a6,t4,t6
    lw      t6,20+24*\n(a0)
    xor     a7,t5,t6


.endm

.globl encrypt
.type encrypt, %function
.align 2
encrypt:

    lw      t0,0(a1)
    lw      t1,4(a1)
    lw      t2,8(a1)
    lw      t3,12(a1)
    lw      t4,16(a1)
    lw      t5,20(a1)


    and     a7,t0,3
    srli    a7,a7,4
    srli    t0,t0,2
    and     a6,t0,0x3f
    slli    a6,a6,4
    srli    t0,t0,6
    and     a5,t0,0x3f
    slli    a5,a5,6
    srli    t0,t0,6
    and     a4,t0,0x3f
    slli    a4,a4,6
    srli    t0,t0,6
    and     a3,t0,0x3f
    slli    a3,a3,6
    srli    t0,t0,6
    and     a1,t0,0x3f
    slli    a1,a1,6


    and     t6,t1,0xf
    xor     a6,a6,t6
    slli    a6,a6,2
    srli    t1,t1,4
    and     t6,t1,0x3f
    xor     a5,a5,t6
    slli    a5,a5,6
    srli    t1,t1,6
    and     t6,t1,0x3f
    xor     a4,a4,t6
    slli    a4,a4,6
    srli    t1,t1,6
    and     t6,t1,0x3f
    xor     a3,a3,t6
    slli    a3,a3,6
    srli    t1,t1,6
    and     t6,t1,0x3f
    xor     a1,a1,t6
    slli    a1,a1,6
    srli    t1,t1,6
    xor     a7,a7,t1
    slli    a7,a7,6



    and     t6,t2,0x3f
    xor     a5,a5,t6
    slli    a5,a5,2
    srli    t2,t2,6
    and     t6,t2,0x3f
    xor     a4,a4,t6
    slli    a4,a4,6
    srli    t2,t2,6
    and     t6,t2,0x3f
    xor     a3,a3,t6
    slli    a3,a3,6
    srli    t2,t2,6
    and     t6,t2,0x3f
    xor     a1,a1,t6
    slli    a1,a1,6
    srli    t2,t2,6
    and     t6,t2,0x3f
    xor     a7,a7,t6
    slli    a7,a7,6
    srli    t2,t2,6
    xor     a6,a6,t2
    slli    a6,a6,6


    and     t6,t3,0x3
    xor     a5,a5,t6
    slli    a5,a5,4
    srli    t3,t3,2
    and     t6,t3,0x3f
    xor     a4,a4,t6
    slli    a4,a4,4
    srli    t3,t3,6
    and     t6,t3,0x3f
    xor     a3,a3,t6
    slli    a3,a3,6
    srli    t3,t3,6
    and     t6,t3,0x3f
    xor     a1,a1,t6
    slli    a1,a1,6
    srli    t3,t3,6
    and     t6,t3,0x3f
    xor     a7,a7,t6
    slli    a7,a7,6
    srli    t3,t3,6
    xor     a6,a6,t3
    slli    a6,a6,6

    and     t6,t4,0xf
    xor     a4,a4,t6
    slli    a4,a4,2
    srli    t4,t4,4
    and     t6,t4,0x3f
    xor     a3,a3,t6
    slli    a3,a3,1
    srli    t4,t4,6
    and     t6,t4,0x3f
    xor     a1,a1,t6
    slli    a1,a1,1
    srli    t4,t4,6
    and     t6,t4,0x3f
    xor     a7,a7,t6
    slli    a7,a7,6
    srli    t4,t4,6
    and     t6,t4,0x3f
    xor     a6,a6,t6
    slli    a6,a6,6
    srli    t4,t4,6
    xor     a5,a5,t4
    slli    a5,a5,6

    srli    t6,t5,12
    and     t6,t6,0x3f
    xor     a7,a7,t6
    slli    a7,a7,1
    srli    t6,t5,18
    and     t6,t6,0x3f
    xor     a6,a6,t6
    slli    a6,a6,1
    srli    t6,t5,24
    and     t6,t6,0x3f
    xor     a5,a5,t6
    slli    a5,a5,1
    srli    t6,t5,30
    and     t6,t6,0x3
    xor     a4,a4,t6
    slli    a4,a4,1

    srli    t6,t5,6
    and     t6,t6,0x1
    xor     a7,a7,t6
    slli    a7,a7,1
    srli    t6,t5,7
    and     t6,t6,0x1
    xor     a6,a6,t6
    slli    a6,a6,1
    srli    t6,t5,8
    and     t6,t6,0x1
    xor     a5,a5,t6
    slli    a5,a5,1
    srli    t6,t5,9
    and     t6,t6,0x1
    xor     a4,a4,t6
    slli    a4,a4,1
    srli    t6,t5,10
    and     t6,t6,0x1
    xor     a3,a3,t6
    slli    a3,a3,1
    srli    t6,t5,11
    and     t6,t6,0x1
    xor     a1,a1,t6
    slli    a1,a1,1

    and     t6,t5,0x1
    xor     a7,a7,t6
    srli    t6,t5,1
    and     t6,t6,0x1
    xor     a6,a6,t6
    srli    t6,t5,2
    and     t6,t6,0x1
    xor     a5,a5,t6
    srli    t6,t5,3
    and     t6,t6,0x1
    xor     a4,a4,t6
    srli    t6,t5,4
    and     t6,t6,0x1
    xor     a3,a3,t6
    srli    t6,t5,5
    and     t6,t6,0x1
    xor     a1,a1,t6


    li      t0,0x55555554

    srli    t1,a3,1
    xor     t1,t1,a1
    and     t1,t1,t0
    xor     a1,a1,t1
    slli    t1,t1,1
    xor     a3,a3,t1

    srli    t1,a5,1
    xor     t1,t1,a4
    and     t1,t1,t0
    xor     a4,a4,t1
    slli    t1,t1,1
    xor     a5,a5,t1

    srli    t1,a7,1
    xor     t1,t1,a6
    and     t1,t1,t0
    xor     a6,a6,t1
    slli    t1,t1,1
    xor     a7,a7,t1


    li      t0,0x0c30c30c

    srli    t1,a6,4
    xor     t1,t1,a1
    and     t1,t1,t0
    xor     a1,a1,t1
    slli    t1,t1,4
    xor     a6,a6,t1

    srli    t1,a7,4
    xor     t1,t1,a3
    and     t1,t1,t0
    xor     a3,a3,t1
    slli    t1,t1,4
    xor     a7,a7,t1

    srli    t1,a6,2
    xor     t1,t1,a4
    and     t1,t1,t0
    xor     a4,a4,t1
    slli    t1,t1,2
    xor     a6,a6,t1

    srli    t1,a7,2
    xor     t1,t1,a5
    and     t1,t1,t0
    xor     a5,a5,t1
    slli    t1,t1,2
    xor     a7,a7,t1

    slli    t0,t0,2

    srli    t1,a4,2
    xor     t1,t1,a1
    and     t1,t1,t0
    xor     a1,a1,t1
    slli    t1,t1,2
    xor     a4,a4,t1

    srli    t1,a5,2
    xor     t1,t1,a3
    and     t1,t1,t0
    xor     a3,a3,t1
    slli    t1,t1,2
    xor     a5,a5,t1

    ACK 0(a0)
    ROUND 1
    ROUND 2
    ROUND 3
    ROUND 4
    ROUND 5
    ROUND 6
    LASTROUND 7




    li      t0,0x55555554

    srli    t1,a3,1
    xor     t1,t1,a1
    and     t1,t1,t0
    xor     a1,a1,t1
    slli    t1,t1,1
    xor     a3,a3,t1

    srli    t1,a5,1
    xor     t1,t1,a4
    and     t1,t1,t0
    xor     a4,a4,t1
    slli    t1,t1,1
    xor     a5,a5,t1

    srli    t1,a7,1
    xor     t1,t1,a6
    and     t1,t1,t0
    xor     a6,a6,t1
    slli    t1,t1,1
    xor     a7,a7,t1


    li      t0,0x0c30c30c

    srli    t1,a6,4
    xor     t1,t1,a1
    and     t1,t1,t0
    xor     a1,a1,t1
    slli    t1,t1,4
    xor     a6,a6,t1

    srli    t1,a7,4
    xor     t1,t1,a3
    and     t1,t1,t0
    xor     a3,a3,t1
    slli    t1,t1,4
    xor     a7,a7,t1

    srli    t1,a6,2
    xor     t1,t1,a4
    and     t1,t1,t0
    xor     a4,a4,t1
    slli    t1,t1,2
    xor     a6,a6,t1

    srli    t1,a7,2
    xor     t1,t1,a5
    and     t1,t1,t0
    xor     a5,a5,t1
    slli    t1,t1,2
    xor     a7,a7,t1

    slli    t0,t0,2

    srli    t1,a4,2
    xor     t1,t1,a1
    and     t1,t1,t0
    xor     a1,a1,t1
    slli    t1,t1,2
    xor     a4,a4,t1

    srli    t1,a5,2
    xor     t1,t1,a3
    and     t1,t1,t0
    xor     a3,a3,t1
    slli    t1,t1,2
    xor     a5,a5,t1

    //c0
    srli    t0,a1,26
    slli    t0,t0,6
    slli    a1,a1,6
    srli    t6,a3,26
    xor     t0,t0,t6
    slli    t0,t0,6
    slli    a3,a3,6
    srli    t6,a4,26
    xor     t0,t0,t6
    slli    t0,t0,6
    slli    a4,a4,6
    srli    t6,a5,26
    xor     t0,t0,t6
    slli    t0,t0,6
    slli    a5,a5,6
    srli    t6,a6,26
    xor     t0,t0,t6
    slli    t0,t0,2
    slli    a6,a6,6
    srli    t6,a7,30
    xor     t0,t0,t6
    slli    a7,a7,2

    //c1
    srli    t1,a7,28
    slli    t1,t1,6
    slli    a7,a7,4
    srli    t6,a1,26
    xor     t1,t1,t6
    slli    t1,t1,6
    slli    a1,a1,6
    srli    t6,a3,26
    xor     t1,t1,t6
    slli    t1,t1,6
    slli    a3,a3,6
    srli    t6,a4,26
    xor     t1,t1,t6
    slli    t1,t1,6
    slli    a4,a4,6
    srli    t6,a5,26
    xor     t1,t1,t6
    slli    t1,t1,4
    slli    a5,a5,6
    srli    t6,a6,28
    xor     t1,t1,t6
    slli    a6,a6,4

    //c2
    srli    t2,a6,30
    slli    t2,t2,6
    slli    a6,a6,2
    srli    t6,a7,26
    xor     t2,t2,t6
    slli    t2,t2,6
    slli    a7,a7,6
    srli    t6,a1,26
    xor     t2,t2,t6
    slli    t2,t2,6
    slli    a1,a1,6
    srli    t6,a3,26
    xor     t2,t2,t6
    slli    t2,t2,6
    slli    a3,a3,6
    srli    t6,a4,26
    xor     t2,t2,t6
    slli    t2,t2,6
    slli    a4,a4,6
    srli    t6,a5,26
    xor     t2,t2,t6
    slli    a5,a5,6

    //c3
    srli    t3,a6,26
    slli    t3,t3,6
    slli    a6,a6,6

    srli    t6,a7,26
    xor     t3,t3,t6
    slli    t3,t3,6
    slli    a7,a7,6

    srli    t6,a1,26
    xor     t3,t3,t6
    slli    t3,t3,6
    slli    a1,a1,6

    srli    t6,a3,26
    xor     t3,t3,t6
    slli    t3,t3,6
    slli    a3,a3,6

    srli    t6,a4,26
    xor     t3,t3,t6
    slli    t3,t3,2
    slli    a4,a4,6

    srli    t6,a5,30
    xor     t3,t3,t6
    slli    a5,a5,2

    //c4
    srli    t4,a5,28
    slli    t4,t4,6
    slli    a5,a5,4

    srli    t6,a6,26
    xor     t4,t4,t6
    slli    t4,t4,6
    slli    a6,a6,6

    srli    t6,a7,26
    xor     t4,t4,t6
    slli    t4,t4,6
    slli    a7,a7,6

    srli    t6,a1,26
    xor     t4,t4,t6
    slli    t4,t4,6
    slli    a1,a1,6

    srli    t6,a3,26
    xor     t4,t4,t6
    slli    t4,t4,4
    slli    a3,a3,6

    srli    t6,a4,28
    xor     t4,t4,t6
    slli    a4,a4,4

    //c5
    srli    t5,a4,30
    slli    t5,t5,6
    slli    a4,a4,2

    srli    t6,a5,26
    xor     t5,t5,t6
    slli    t5,t5,6
    slli    a5,a5,6

    srli    t6,a6,26
    xor     t5,t5,t6
    slli    t5,t5,6
    slli    a6,a6,6

    srli    t6,a7,26
    xor     t5,t5,t6
    slli    t5,t5,1
    slli    a7,a7,6

    srli    t6,a1,31
    xor     t5,t5,t6
    slli    t5,t5,1
    slli    a1,a1,1

    srli    t6,a3,31
    xor     t5,t5,t6
    slli    t5,t5,1
    slli    a3,a3,1

    srli    t6,a4,31
    xor     t5,t5,t6
    slli    t5,t5,1
    slli    a4,a4,1

    srli    t6,a5,31
    xor     t5,t5,t6
    slli    t5,t5,1
    slli    a5,a5,1

    srli    t6,a6,31
    xor     t5,t5,t6
    slli    t5,t5,1
    slli    a6,a6,1

    srli    t6,a7,31
    xor     t5,t5,t6
    slli    t5,t5,1
    slli    a7,a7,1

    srli    t6,a1,31
    xor     t5,t5,t6
    slli    t5,t5,1

    srli    t6,a3,31
    xor     t5,t5,t6
    slli    t5,t5,1

    srli    t6,a4,31
    xor     t5,t5,t6
    slli    t5,t5,1

    srli    t6,a5,31
    xor     t5,t5,t6
    slli    t5,t5,1

    srli    t6,a6,31
    xor     t5,t5,t6
    slli    t5,t5,1

    srli    t6,a7,31
    xor     t5,t5,t6


    sw      t0,0(a2)
    sw      t1,4(a2)
    sw      t2,8(a2)
    sw      t3,12(a2)
    sw      t4,16(a2)
    sw      t5,20(a2)

    ret

.size encrypt,.-encrypt
