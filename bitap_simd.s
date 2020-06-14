.global   bitap
    .p2align 2
.type    bitap,%function

bitap:
    .fnstart
    push {r4-r11, lr}

    cmp r1,r3
    movls r0, #0
    bls exit

    cmp r3, #8
    movne r0, #0
    bne exit


    mov r5, #0
    mov r6, #0
    vmov.i64 d0, #0
    vmov.i64 d1, #0
    vld1.8 {d1}, [r2]!

bitap_loop:
@begin
    ldrb r4, [r0], #1
    cmp r4, #0
    moveq r0, #0
    beq exit

    bl bit_shift
    bl ux_find
    bl and_vectors
    bl check_entrance
    b bitap_loop
@end

bit_shift:
@begin
    vsri.i64 d0, d0, #1
    vmov.i32 d2, #1
    vsli.i64 d2, d2, #63
    vorr.i64 d0, d0, d2
    bx lr
@end


ux_find:
@begin
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
    bx lr
@end

and_vectors:
@begin
    vand.i8 d0, d0, d1
    bx lr
@end

check_entrance:
@begin
    mov r7, #1
    mov r5, r7, lsl #31
    sub r8, r3, #1
    lsr r5, r5, r8

    vmov.i32 d4, #1
    vsli.i64 d4, d4, #63
    vmov.u32 r5, d0[1]
    vmov.u32 r6, d4[1]

    sub r8, r3, #1
    lsr r6, r6, r8
    and r5, r5, r6
    cmp r5, #0
    bxeq lr

    movne r0, #1
    bne exit
@end

exit:
@begin
    pop  {r4-r11, lr}
    bx lr
@end
    .fnend
