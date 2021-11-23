;   ****************************************************************
;       tiles.asm
;   ----------------------------------------------------------------
;       Copyright (c) 2021 Scott Moore, all rights reserved.
;   ****************************************************************

;   ****************************************************************
;       Constants
;   ----------------------------------------------------------------
;       Define constants used in this file and calling functions.
;   ****************************************************************

.ifndef __TILES_ASM
    .set    __TILES_ASM,    -1

    .set    CLIP_TOP,       0
    .set    CLIP_BOTTOM,    184 - 16
    .set    CLIP_LEFT,      0
    .set    CLIP_RIGHT,     352

    .set    SCANLINE,       352

;   ****************************************************************
;       draw_16x16_tile
;   ----------------------------------------------------------------
;       Copy a 16x16 tile to the screen or display buffer, source
;       address must be word aligned.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   number of the 16x16 tile in the tileset
;       R1      :   address of the tileset
;       R2      :   x coordinate to copy the tile to
;       R3      :   y coordinate to copy the tile to
;       R4      :   address of the screen or display buffer
;       R5      :   N/A
;       R6      :   N/A
;       R7      :   N/A
;       R8      :   N/A
;       R9      :   N/A
;       R10     :   N/A
;       R11     :   N/A
;       R11     :   N/A
;   ----------------------------------------------------------------
;       Returns
;   ----------------------------------------------------------------
;       R0      :   Unchanged
;       R1      :   Unchanged
;       R2      :   Unchanged
;       R3      :   Unchanged
;       R4      :   Unchanged
;       R5      :   Unchanged
;       R6      :   Unchanged
;       R7      :   Unchanged
;       R8      :   Unchanged
;       R9      :   Unchanged
;       R10     :   Unchanged
;       R11     :   Unchanged
;       R11     :   Unchanged
;   ****************************************************************
draw_16x16_tile:
    STMFD SP!, {R0 - R12, R14}     ; store all the registers on the stack

    CMP R3, #CLIP_TOP                        ; check to see if y coordinate is
    BLT draw_16x16_tile_clipped_top         ;   less than the top clip line
    CMP R3, #CLIP_BOTTOM - 16                ; check to see if y coordinate is
    BGT draw_16x16_tile_clipped_bottom      ;   greater than the bottom clip line
    CMP R2, #CLIP_LEFT                       ; check to see if x coordinate is
    BLT draw_16x16_tile_clipped_left        ;   less than the left clip pixel
    CMP R2, #CLIP_RIGHT - 16                 ; check to see if x coordinate is
    BGT draw_16x16_tile_clipped_right       ;   greater than the right clip pixel

draw_16x16_tile_unclipped:
    AND R8, R2, #0b11         ; get 4 pixel x coordinate offset
    MOV R7, #16*16*4         ; put the size of a single tile in bytes into R7
    MLA R12, R0, R7, R1        ; calculate the address of the start of the tile [source = (tile number * (16 * 16)) + address of tileset]
    ADD R12, R12, R8, LSL #8   ; add 4 pixel x coordinate offset * (16*16) to get pre-shifted tile
    MOV R7, #SCANLINE             ; put the width of a scanline into R7
    MLA R11, R3, R7, R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]
    ADD R11, R11, R2          ; add x to the destination address

    CMP R8, #0b00                        ; check if x coordinate is word aligned
    BEQ draw_16x16_tile_unclipped_00    ;   if so, call word aligned draw function
    CMP R8, #0b01                        ; check if x coordinate is aligned with byte 1
    BEQ draw_16x16_tile_unclipped_01    ;   if so, call byte 1 aligned draw function
    CMP R8, #0b10                        ; check if x coordinate is aligned with byte 2
    BEQ draw_16x16_tile_unclipped_10    ;   if so, call byte 2 aligned draw function
    CMP R8, #0b11                        ; check if x coordinate is aligned with byte 3
    BEQ draw_16x16_tile_unclipped_11    ;   if so, call byte 3 aligned draw function

draw_16x16_tile_unclipped_00:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R3}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    
    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_unclipped_01:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_unclipped_10:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R9}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_unclipped_11:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R9}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_top:
    CMP R3, #CLIP_TOP - 16                   ; check to see if y coordinate is completely off the screen
    BLE draw_16x16_tile_exit                ;   if so, branch to exit function
    CMP R2, #CLIP_LEFT                       ; check to see if x coordinate is less than left clip pixel
    BLT draw_16x16_tile_clipped_top_left    ;   if so, branch to clipped top & left function
    CMP R2, #CLIP_RIGHT - 16                 ; check to see if x coordinate is greater than right clip pixel
    BGT draw_16x16_tile_clipped_top_right   ;   if so, branch to clipped top & right function

draw_16x16_tile_clipped_top_unclipped_left_right:
    AND R8, R2, #0b11         ; get 4 pixel x coordinate offset
    MOV R7, #16*16*4         ; put the size of a single tile in bytes into R7
    MLA R12, R0, R7, R1        ; calculate the address of the start of the tile [source = (tile number * (16 * 16)) + address of tileset]
    ADD R12, R12, R8, LSL #8   ; add 4 pixel x coordinate offset * (16*16) to get pre-shifted tile
    MOV R7, #SCANLINE             ; put the width of a scanline into R7
    MOV R11, R4              ; move destination address into R11
    ADD R11, R11, R2          ; add x to the destination address
    MOV R7, #CLIP_TOP        ; move 0 into R7
    SUB R7, R7, R3            ; subtract y coordinate (-15...-1) from 0 to calculate how many tile lines to clip

    CMP R8, #0b00                                                ; check if x coordinate is word aligned
    BEQ draw_16x16_tile_clipped_top_unclipped_left_right_00     ;   if so, call word aligned draw function
    CMP R8, #0b01                                                ; check if x coordinate is aligned with byte 1
    BEQ draw_16x16_tile_clipped_top_unclipped_left_right_01     ;   if so, call byte 1 aligned draw function
    CMP R8, #0b10                                                ; check if x coordinate is aligned with byte 2
    BEQ draw_16x16_tile_clipped_top_unclipped_left_right_10     ;   if so, call byte 2 aligned draw function
    CMP R8, #0b11                                                ; check if x coordinate is aligned with byte 3
    BEQ draw_16x16_tile_clipped_top_unclipped_left_right_11     ;   if so, call byte 3 aligned draw function

draw_16x16_tile_clipped_top_unclipped_left_right_00:
    ADRL R0, draw_16x16_tile_unclipped_00    ; get address of word aligned draw function into R0
    MOV R1, #16                              ; move 16 into R1
    MLA R12, R1, R7, R12                       ; calculate start address of clipped tile : (16 * clip_y) + tile_start_address
    MOV R1, #3 * 4                           ; put length of instructions needed per scanline
    MLA R0, R1, R7, R0                         ; calculate code start address : (12 * clip_y) + code_start_address
    MOV PC, R0                               ; move calculated code start address into program counter

draw_16x16_tile_clipped_top_unclipped_left_right_01:
    ADRL R0, draw_16x16_tile_unclipped_01    ; get address of byte 1 aligned draw function into R0
    MOV R1, #16                              ; move 16 into R1
    MLA R12, R1, R7, R12                       ; calculate start address of clipped tile : (16 * clip_y) + tile_start_address
    MOV R1, #8 * 4                           ; put length of instructions needed per scanline
    MLA R0, R1, R7, R0                         ; calculate code start address : (32 * clip_y) + code_start_address
    MOV PC, R0                               ; move calculated code start address into program counter
draw_16x16_tile_clipped_top_unclipped_left_right_10:
    ADRL R0, draw_16x16_tile_unclipped_10    ; get address of byte 2 aligned draw function into R0
    MOV R1, #16                              ; move 16 into R1
    MLA R12, R1, R7, R12                       ; calculate start address of clipped tile : (16 * clip_y) + tile_start_address
    MOV R1, #10 * 4                          ; put length of instructions needed per scanline
    MLA R0, R1, R7, R0                         ; calculate code start address : (40 * clip_y) + code_start_address
    MOV PC, R0                               ; move calculated code start address into program counter
draw_16x16_tile_clipped_top_unclipped_left_right_11:
    ADRL R0, draw_16x16_tile_unclipped_11    ; get address of byte 3 aligned draw function into R0
    MOV R1, #16                              ; move 16 into R1
    MLA R12, R1, R7, R12                       ; calculate start address of clipped tile : (16 * clip_y) + tile_start_address
    MOV R1, #8 * 4                           ; put length of instructions needed per scanline
    MLA R0, R1, R7, R0                         ; calculate code start address : (32 * clip_y) + code_start_address
    MOV PC, R0                               ; move calculated code start address into program counter

draw_16x16_tile_clipped_top_left:

    B draw_16x16_tile_exit                  ; branch to exit function

draw_16x16_tile_clipped_top_right:

    B draw_16x16_tile_exit                  ; branch to exit function

draw_16x16_tile_clipped_bottom:
    CMP R3, #CLIP_BOTTOM                         ; check to see if y coordinate is completely off the screen
    BGE draw_16x16_tile_exit                    ;   if so, branch to exit function
    CMP R2, #CLIP_LEFT                           ; check to see if x coordinate is less than left clip pixel
    BLT draw_16x16_tile_clipped_bottom_left     ;   if so, branch to clipped bottom & left function
    CMP R2, #CLIP_RIGHT - 16                     ; check to see if x coordinate is greater than right clip pixel
    BGT draw_16x16_tile_clipped_bottom_right    ;   if so, branch to clipped bottom & right function

draw_16x16_tile_clipped_bottom_unclipped_left_right:
    AND R8, R2, #0b11         ; get 4 pixel x coordinate offset
    MOV R7, #16*16*4         ; put the size of a single tile in bytes into R7
    MLA R12, R0, R7, R1        ; calculate the address of the start of the tile [source = (tile number * (16 * 16)) + address of tileset]
    ADD R12, R12, R8, LSL #8   ; add 4 pixel x coordinate offset * (16*16) to get pre-shifted tile
    MOV R7, #SCANLINE             ; put the width of a scanline into R7
    MLA R11, R3, R7, R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]
    ADD R11, R11, R2          ; add x to the destination address
    MOV R7, #CLIP_BOTTOM     ; move clip bottom scanline into R7
    SUB R7, R7, R3            ; subtract y coordinate from clip bottom scanline to calculate how many tile lines to draw

    CMP R8, #0b00                                                    ; check if x coordinate is word aligned
    BEQ draw_16x16_tile_clipped_bottom_unclipped_left_right_00      ;   if so, call word aligned draw function
    CMP R8, #0b01                                                    ; check if x coordinate is aligned with byte 1
    BEQ draw_16x16_tile_clipped_bottom_unclipped_left_right_01      ;   if so, call byte 1 aligned draw function
    CMP R8, #0b10                                                    ; check if x coordinate is aligned with byte 2
    BEQ draw_16x16_tile_clipped_bottom_unclipped_left_right_10      ;   if so, call byte 2 aligned draw function
    CMP R8, #0b11                                                    ; check if x coordinate is aligned with byte 3
    BEQ draw_16x16_tile_clipped_bottom_unclipped_left_right_11      ;    if so, call byte 3 aligned draw function

draw_16x16_tile_clipped_bottom_unclipped_left_right_00:
    ADRL R0, draw_16x16_tile_unclipped_00    ; get address of word aligned draw function into R0
    MOV R1, #16                              ; move 16 into R1
    SUB R7, R1, R7                            ; calculate number of tile rows to clip : 16 - draw_y
    MOV R1, #3 * 4                           ; put length of instructions needed per scanline
    MLA R0, R1, R7, R0                         ; calculate code start address : (12 * clip_y) + code_start_address
    MOV PC, R0                               ; move calculated code start address into program counter

draw_16x16_tile_clipped_bottom_unclipped_left_right_01:
    ADRL R0, draw_16x16_tile_unclipped_01    ; get address of byte 1 aligned draw function into R0
    MOV R1, #16                              ; move 16 into R1
    SUB R7, R1, R7                            ; calculate number of tile rows to clip : 16 - draw_y
    MOV R1, #8 * 4                           ; put length of instructions needed per scanline
    MLA R0, R1, R7, R0                         ; calculate code start address : (32 * clip_y) + code_start_address
    MOV PC, R0                               ; move calculated code start address into program counter
draw_16x16_tile_clipped_bottom_unclipped_left_right_10:
    ADRL R0, draw_16x16_tile_unclipped_10    ; get address of byte 2 aligned draw function into R0
    MOV R1, #16                              ; move 16 into R1
    SUB R7, R1, R7                            ; calculate number of tile rows to clip : 16 - draw_y
    MOV R1, #10 * 4                          ; put length of instructions needed per scanline
    MLA R0, R1, R7, R0                         ; calculate code start address : (40 * clip_y) + code_start_address
    MOV PC, R0                               ; move calculated code start address into program counter
draw_16x16_tile_clipped_bottom_unclipped_left_right_11:
    ADRL R0, draw_16x16_tile_unclipped_11    ; get address of byte 3 aligned draw function into R0
    MOV R1, #16                              ; move 16 into R1
    SUB R7, R1, R7                            ; calculate number of tile rows to clip : 16 - draw_y
    MOV R1, #8 * 4                           ; put length of instructions needed per scanline
    MLA R0, R1, R7, R0                         ; calculate code start address : (32 * clip_y) + code_start_address
    MOV PC, R0                               ; move calculated code start address into program counter

draw_16x16_tile_clipped_bottom_left:
    B draw_16x16_tile_exit                  ; branch to exit function

draw_16x16_tile_clipped_bottom_right:
    B draw_16x16_tile_exit                  ; branch to exit function

draw_16x16_tile_clipped_left:
    CMP R2, #CLIP_LEFT - 16                  ; check to see if x coordinate is completely off the screen
    BLE draw_16x16_tile_exit                ;   if so, branch to exit function

draw_16x16_tile_clipped_left_00:
    ADD R2, R2, #CLIP_LEFT + 16
    AND R8, R2, #0b11         ; get 4 pixel x coordinate offset
    AND R9, R2, #0b1100       ; get 4 word x coordinate offset
    MOV R7, #16*16*4         ; put the size of a single tile in bytes into R7
    MLA R12, R0, R7, R1        ; calculate the address of the start of the tile [source = (tile number * (16 * 16)) + address of tileset]
    ADD R12, R12, R8, LSL #8   ; add 4 pixel x coordinate offset * (16*16) to get pre-shifted tile
    MOV R7, #SCANLINE             ; put the width of a scanline into R7
    MLA R11, R3, R7, R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]

    TEQ R9, #0b1100
    BEQ draw_16x16_tile_clipped_left_00_11
    TEQ R9, #0b1000
    BEQ draw_16x16_tile_clipped_left_00_10
    TEQ R9, #0b0100
    BEQ draw_16x16_tile_clipped_left_00_01

draw_16x16_tile_clipped_left_00_00:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}
    
    B draw_16x16_tile_exit                  ; branch to exit function

draw_16x16_tile_clipped_left_00_01:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R3}
    STR R0, [R11, #4]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
  
    B draw_16x16_tile_exit                  ; branch to exit function

draw_16x16_tile_clipped_left_00_10:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R2 - R3}
    STR R0, [R11, #8]       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    
    B draw_16x16_tile_exit                  ; branch to exit function

draw_16x16_tile_clipped_left_00_11:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R1 - R3}       ; store 12 bytes from R1 - R3 to the destination address without incrementing it
    STR R0, [R11, #12]        ; store pre-shifted end of tile
    
    B draw_16x16_tile_exit                  ; branch to exit function

draw_16x16_tile_clipped_right:
    CMP R2, #CLIP_RIGHT                  ; check to see if x coordinate is completely off the screen
    BGE draw_16x16_tile_exit                ;   if so, branch to exit function

    AND R8, R2, #0b11         ; get 4 pixel x coordinate offset
    AND R9, R2, #0b1100       ; get 4 word x coordinate offset
    MOV R7, #16*16*4         ; put the size of a single tile in bytes into R7
    MLA R12, R0, R7, R1        ; calculate the address of the start of the tile [source = (tile number * (16 * 16)) + address of tileset]
    ADD R12, R12, R8, LSL #8   ; add 4 pixel x coordinate offset * (16*16) to get pre-shifted tile
    MOV R7, #SCANLINE             ; put the width of a scanline into R7
    MLA R11, R3, R7, R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]
    ADD R11, R11, R2          ; add x to the destination address

    TEQ R9, #0b1100
    BEQ draw_16x16_tile_clipped_right_11
    TEQ R9, #0b1000
    BEQ draw_16x16_tile_clipped_right_10
    TEQ R9, #0b0100
    BEQ draw_16x16_tile_clipped_right_01

draw_16x16_tile_clipped_right_00:
    CMP R8, #0b00                                ; check if x coordinate is word aligned
    BEQ draw_16x16_tile_clipped_right_00_00     ;   if so, call word aligned draw function
    CMP R8, #0b01                                ; check if x coordinate is aligned with byte 1
    BEQ draw_16x16_tile_clipped_right_00_01     ;   if so, call byte 1 aligned draw function
    CMP R8, #0b10                                ; check if x coordinate is aligned with byte 2
    BEQ draw_16x16_tile_clipped_right_00_10     ;   if so, call byte 2 aligned draw function
    CMP R8, #0b11                                ; check if x coordinate is aligned with byte 3
    BEQ draw_16x16_tile_clipped_right_00_11     ;   if so, call byte 3 aligned draw function

draw_16x16_tile_clipped_right_00_00:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    
    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_00_01:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_00_10:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R8}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_00_11:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R8}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_11:
    CMP R8, #0b00                                ; check if x coordinate is word aligned
    BEQ draw_16x16_tile_clipped_right_11_00     ;   if so, call word aligned draw function
    CMP R8, #0b01                                ; check if x coordinate is aligned with byte 1
    BEQ draw_16x16_tile_clipped_right_11_01     ;   if so, call byte 1 aligned draw function
    CMP R8, #0b10                                ; check if x coordinate is aligned with byte 2
    BEQ draw_16x16_tile_clipped_right_11_10     ;   if so, call byte 2 aligned draw function
    CMP R8, #0b11                                ; check if x coordinate is aligned with byte 3
    BEQ draw_16x16_tile_clipped_right_11_11     ;   if so, call byte 3 aligned draw function

draw_16x16_tile_clipped_right_11_00:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_11_01:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_11_10:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_11_11:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_10:
    CMP R8, #0b00                                ; check if x coordinate is word aligned
    BEQ draw_16x16_tile_clipped_right_10_00     ;   if so, call word aligned draw function
    CMP R8, #0b01                                ; check if x coordinate is aligned with byte 1
    BEQ draw_16x16_tile_clipped_right_10_01     ;   if so, call byte 1 aligned draw function
    CMP R8, #0b10                                ; check if x coordinate is aligned with byte 2
    BEQ draw_16x16_tile_clipped_right_10_10     ;   if so, call byte 2 aligned draw function
    CMP R8, #0b11                                ; check if x coordinate is aligned with byte 3
    BEQ draw_16x16_tile_clipped_right_10_11     ;   if so, call byte 3 aligned draw function

draw_16x16_tile_clipped_right_10_00:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R1}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_10_01:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_10_10:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R6}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_10_11:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R6}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function
draw_16x16_tile_clipped_right_01:
    CMP R8, #0b00                                ; check if x coordinate is word aligned
    BEQ draw_16x16_tile_clipped_right_01_00     ;   if so, call word aligned draw function
    CMP R8, #0b01                                ; check if x coordinate is aligned with byte 1
    BEQ draw_16x16_tile_clipped_right_01_01     ;   if so, call byte 1 aligned draw function
    CMP R8, #0b10                                ; check if x coordinate is aligned with byte 2
    BEQ draw_16x16_tile_clipped_right_01_10     ;   if so, call byte 2 aligned draw function
    CMP R8, #0b11                                ; check if x coordinate is aligned with byte 3
    BEQ draw_16x16_tile_clipped_right_01_11     ;   if so, call byte 3 aligned draw function

draw_16x16_tile_clipped_right_01_00:
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline
    LDMIA R12!, {R0 - R3}      ; load 16 bytes from the soure address into R0 - R3
    STMIA R11, {R0 - R2}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it

    B draw_16x16_tile_exit  ; branch to exit function
draw_16x16_tile_clipped_right_01_01:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x000000ff   ; mask out the destination we want to keep
    AND R9, R5, #0x000000ff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xffffff00   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_clipped_right_01_10:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    MOV R0, R0, LSL #16       ; mask out the destination we want to keep by shifting
    MOV R9, R5, LSL #16       ; get the shifted end of the tile into R9
    MOV R5, R5, LSR #16       ; mask out the shifted end of the tile
    MOV R9, R9, LSR #16       ; shift back to the right bit position
    MOV R5, R5, LSL #16       ; shift back to the right bit position
    ORR R5, R5, R0, LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11, {R5 - R7}       ; store 20 bytes from R5 - R9 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function
draw_16x16_tile_clipped_right_01_11:
    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    LDMIA R11, {R0}          ; load the destination word so we can keep some of it
    LDMIA R12!, {R5 - R8}      ; load 16 bytes from the soure address into R5 - R8
    AND R0, R0, #0x00ffffff   ; mask out the destination we want to keep
    AND R9, R5, #0x00ffffff   ; get the shifted end of the tile into R9
    AND R5, R5, #0xff000000   ; mask out the shifted end of the tile
    ORR R5, R5, R0            ; put back the destination pixels we need to keep
    STMIA R11, {R5 - R7}       ; store 16 bytes from R0 - R3 to the destination address with incrementing it
    ADD R11, R11, #SCANLINE        ; move destination address to the next scanline

    B draw_16x16_tile_exit  ; branch to exit function

draw_16x16_tile_exit:       ; exit function code

    LDMFD SP!, {R0 - R12, PC}     ; restore all the registers from the stack
.endif