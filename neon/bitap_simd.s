.align 2
.text
.global bitap
.syntax unified
.arm
.type bitap, %function
bitap:
    push {r4-r11}
    mov r5, #0
    mov r6, #0
    vmov.i64 d0, #0
    vmov.i64 d1, #0
    vld1.8 {d1}, [r2]!
    vrev64.8 d1, d1

bitap_loop:
    ldrb r4, [r0], #1
    cmp r4, #0
    moveq r0, #0
    beq exit

bit_shift:
    vsri.i64 d0, d0, #1
    vmov.i32 d2, #1
    vsli.i64 d2, d2, #63
    vorr.i64 d0, d0, d2

ux_find:
    vmov d2[0], r4
    vdup.i8 d2, d2[0]

    vceq.i8 d1, d1, d2
    vmov.i8 d2, #1
    vand.i8 d1, d1, d2

    vmov.u8 r7, d1[7]
    orr r6, r6, r7, lsl #31

    vmov.u8 r7, d1[6]
    orr r6, r6, r7, lsl #30

    vmov.u8 r7, d1[5]
    orr r6, r6, r7, lsl #29

    vmov.u8 r7, d1[4]
    orr r6, r6, r7, lsl #28

    vmov.u8 r7, d1[3]
    orr r6, r6, r7, lsl #27

    vmov.u8 r7, d1[2]
    orr r6, r6, r7, lsl #26

    vmov.u8 r7, d1[1]
    orr r6, r6, r7, lsl #25

    vmov.u8 r7, d1[0]
    orr r6, r6, r7, lsl #24

    mov r7, #0
    vmov d1, r7, r6

and_vectors:
    vand.i8 d0, d0, d1

check_entrance:
    vmov.i32 d4, #1
    vsli.i64 d4, d4, #63
    vmov.u32 r5, d0[1]
    vmov.u32 r6, d4[1]

    sub r8, r3, #1
    lsr r6, r6, r8
    and r5, r5, r6
    cmp r5, #0
    beq bitap_loop
    movne r0, #1
    moveq r0, #0
    b exit

exit:
    pop {r4-r11}
    bx lr
.end
