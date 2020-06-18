.align 2
.text
.global bitap
.syntax unified
.arm
.type bitap, %function

#define str_size r1
#define pattrn r2
#define alphabet_i r4
#define alphabet_size r9
#define pttrn_begin r10
#define i r11
#define shifter r8
#define j r12
#define u_x_calc_vec d0
#define pattrn_vec d1
#define alphabet_i_vec d2
#define shifter_vec d3
#define mask d4
#define pattrn r2
#define pattrn_size r3
#define presence_bit r7
#define ancestor_vec d0
#define pattrn_size_local r5
#define tmp_vec d2
#define offspring_vec d1
#define string r0
#define ret_val r0
#define string_i r4
#define offset r7
#define found r6

bitap:
    push {r4-r11}
    mov pttrn_begin, pattrn
    mov i, #0
    mov alphabet_i, #0x20
    mov alphabet_size, #94


prefill_u_x_loop:
    mov pattrn, pttrn_begin
    cmp i, alphabet_size
    beq shift_and
    add i, i, #1
    add alphabet_i, alphabet_i, #1
    mov j, #0
    vmov.i64 u_x_calc_vec, #0
    mov shifter, #63
    b pattern_read_loop

pattern_read_loop:
    cmp j, pattrn_size
    bge push_vector

    sub shifter, shifter, j

    vld1.8 {pattrn_vec}, [pattrn]!

    vrev64.8 pattrn_vec, pattrn_vec

    vdup.i8 alphabet_i_vec, alphabet_i

    vceq.i8 alphabet_i_vec, alphabet_i_vec, pattrn_vec
    vmov.i8 mask, #1
    vand.i8 alphabet_i_vec, alphabet_i_vec, mask


    vmov.32 shifter_vec[0], shifter

    vmov.u8 presence_bit, alphabet_i_vec[7]
    cmp presence_bit, #0
    beq next
    vmov.8 mask[0], presence_bit
    vshl.u64 mask, mask, shifter_vec
    vorr u_x_calc_vec, u_x_calc_vec, mask

next:
    sub shifter, shifter, #1
    vmov.32 shifter_vec[0], shifter

    vmov.u8 presence_bit, alphabet_i_vec[6]
    cmp presence_bit, #0
    beq next1
    vmov.8 mask[0], presence_bit
    vshl.u64 mask, mask, shifter_vec
    vorr u_x_calc_vec, u_x_calc_vec, mask

next1:
    sub shifter, shifter, #1
    vmov.32 shifter_vec[0], shifter

    vmov.u8 presence_bit, alphabet_i_vec[5]
    cmp presence_bit, #0
    beq next2
    vmov.8 mask[0], presence_bit
    vshl.u64 mask, mask, shifter_vec
    vorr u_x_calc_vec, u_x_calc_vec, mask

next2:
    sub shifter, shifter, #1
    vmov.32 shifter_vec[0], shifter

    vmov.u8 presence_bit, alphabet_i_vec[4]
    cmp presence_bit, #0
    beq next3
    vmov.8 mask[0], presence_bit
    vshl.u64 mask, mask, shifter_vec
    vorr u_x_calc_vec, u_x_calc_vec, mask

next3:
    sub shifter, shifter, #1
    vmov.32 shifter_vec[0], shifter

    vmov.u8 presence_bit, alphabet_i_vec[3]
    cmp presence_bit, #0
    beq next4
    vmov.8 mask[0], presence_bit
    vshl.u64 mask, mask, shifter_vec
    vorr u_x_calc_vec, u_x_calc_vec, mask

next4:
    sub shifter, shifter, #1
    vmov.32 shifter_vec[0], shifter

    vmov.u8 presence_bit, alphabet_i_vec[2]
    cmp presence_bit, #0
    beq next5
    vmov.8 mask[0], presence_bit
    vshl.u64 mask, mask, shifter_vec
    vorr u_x_calc_vec, u_x_calc_vec, mask

next5:
    sub shifter, shifter, #1
    vmov.32 shifter_vec[0], shifter

    vmov.u8 presence_bit, alphabet_i_vec[1]
    cmp presence_bit, #0
    beq next6
    vmov.8 mask[0], presence_bit
    vshl.u64 mask, mask, shifter_vec
    vorr u_x_calc_vec, u_x_calc_vec, mask

next6:
    sub shifter, shifter, #1
    vmov.32 shifter_vec[0], shifter

    vmov.u8 presence_bit, alphabet_i_vec[0]
    cmp presence_bit, #0
    beq next7
    vmov.8 mask[0], presence_bit
    vshl.u64 mask, mask, shifter_vec
    vorr u_x_calc_vec, u_x_calc_vec, mask

next7:
    add j, j, #8
    b pattern_read_loop

push_vector:
    vpush {u_x_calc_vec}
    b prefill_u_x_loop

shift_and:
    vmov.i64 ancestor_vec, #0
    sub pattrn_size_local, pattrn_size, #1

shift_and_loop:
    ldrb string_i, [string], #1
    cmp string_i, #0
    moveq ret_val, #0
    beq clean

    sub offset, string_i, #0x20
    sub offset, alphabet_size, offset
    lsl offset, offset, #3
    add offset, offset, sp
    vldr.64 offspring_vec, [offset]

shift:
    vsri.i64 ancestor_vec, ancestor_vec, #1
    vmov.i32 mask, #1
    vsli.i64 mask, mask, #63
    vorr.i64 ancestor_vec, ancestor_vec, mask

and:
    vand.i8 ancestor_vec, ancestor_vec, offspring_vec


check_pattern_entrance:
    vmov.32 shifter_vec[0], pattrn_size_local
    vmov.i32 mask, #1
    vsli.i64 mask, mask, #63
    vrshl.u64 mask, mask, shifter_vec
    vand.i64 offspring_vec, ancestor_vec, mask
    vmov.u32 found, offspring_vec[0]
    cmp found, #0
    beq shift_and_loop
    movne ret_val, #1

clean:
    mov i, #0
    clean_loop:
    cmp i, #94
    beq exit
    vpop {tmp_vec}
    add i,i,#1
    b clean_loop

exit:
   pop {r4-r11}
   bx lr
.end
