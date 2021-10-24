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

.set    CLIP_TOP,       0
.set    CLIP_BOTTOM,    256
.set    CLIP_LEFT,      0
.set    CLIP_RIGHT,     320

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
    STMFD SP!, {R0-R12}     ; store all the registers on the stack

    CMP R3,#CLIP_TOP
    BLT draw_16x16_tile_clipped_top
    CMP R3,#CLIP_BOTTOM - 16
    BGT draw_16x16_tile_clipped_bottom
    CMP R2,#CLIP_LEFT
    BLT draw_16x16_tile_clipped_left
    CMP R2,#CLIP_RIGHT - 16
    BGT draw_16x16_tile_clipped_right

draw_16x16_tile_unclipped:
    AND R8,R2,#0b11         ; get 4 pixel x coordinate offset
    MOV R7,#16*16*4         ; put the size of a single tile in bytes into R7
    MLA R12,R0,R7,R1        ; calculate the address of the start of the tile [source = (tile number * (16 * 16)) + address of tileset]
    ADD R12,R12,R8,LSL #8   ; add 4 pixel x coordinate offset * (16*16) to get pre-shifted tile
    MOV R7,#320             ; put the width of a scanline into R7
    MLA R11,R3,R7,R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]
    ADD R11,R11,R2          ; add x to the destination address

    CMP R8,#0b00
    BEQ draw_16x16_tile_unclipped_00
    CMP R8,#0b01
    BEQ draw_16x16_tile_unclipped_01
    CMP R8,#0b10
    BEQ draw_16x16_tile_unclipped_10
    CMP R8,#0b11
    BEQ draw_16x16_tile_unclipped_11

draw_16x16_tile_unclipped_00:
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    
    B draw_16x16_tile_exit

draw_16x16_tile_unclipped_01:
    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R0,R0,#0x000000ff   ; mask out the destination we want to keep
    AND R9,R5,#0x000000ff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xffffff00   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address

    B draw_16x16_tile_exit

draw_16x16_tile_unclipped_10:
    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    MOV R0,R0,LSL #16       ; mask out the destination we want to keep by shifting
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    MOV R9,R5,LSL #16       ; get the shifted end of the tile into R9
    MOV R9,R9,LSR #16       ; shift back to the right bit position
    MOV R5,R5,LSR #16       ; mask out the shifted end of the tile
    MOV R5,R5,LSL #16       ; shift back to the right bit position
    ORR R5,R5,R0,LSR #16    ; put back the destination pixels we need to keep and shift them into the correct position
    STMIA R11,{R5-R9}       ; store 20 bytes from R5-R9 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    B draw_16x16_tile_exit

draw_16x16_tile_unclipped_11:
    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMIA R11,{R0}          ; load the destination word so we can keep some of it
    AND R0,R0,#0x00ffffff   ; mask out the destination we want to keep
    LDMIA R12!,{R5-R8}      ; load 16 bytes from the soure address into R5-R8
    AND R9,R5,#0x00ffffff   ; get the shifted end of the tile into R9
    AND R5,R5,#0xff000000   ; mask out the shifted end of the tile
    ORR R5,R5,R0            ; put back the destination pixels we need to keep
    STMIA R11,{R5-R9}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    B draw_16x16_tile_exit

draw_16x16_tile_clipped_top:
    CMP R3,#CLIP_TOP - 16
    BLE draw_16x16_tile_exit
    CMP R2,#CLIP_LEFT + 16
    BLT draw_16x16_tile_clipped_top_left
    CMP R2,#CLIP_TOP - 16
    BGT draw_16x16_tile_clipped_top_right

    B draw_16x16_tile_exit

draw_16x16_tile_clipped_top_left:
    B draw_16x16_tile_exit

draw_16x16_tile_clipped_top_right:
    B draw_16x16_tile_exit

draw_16x16_tile_clipped_bottom:
    CMP R3,#CLIP_BOTTOM + 16
    BGE draw_16x16_tile_exit
    CMP R2,#CLIP_LEFT + 16
    BLT draw_16x16_tile_clipped_bottom_left
    CMP R2,#CLIP_TOP - 16
    BGT draw_16x16_tile_clipped_bottom_right

    B draw_16x16_tile_exit

draw_16x16_tile_clipped_bottom_left:
    B draw_16x16_tile_exit

draw_16x16_tile_clipped_bottom_right:
    B draw_16x16_tile_exit

draw_16x16_tile_clipped_left:
    CMP R2,#CLIP_LEFT - 16
    BLE draw_16x16_tile_clipped_right

    B draw_16x16_tile_exit

draw_16x16_tile_clipped_right:
    CMP R2,#CLIP_RIGHT + 16
    BGE draw_16x16_tile_exit

draw_16x16_tile_exit:       ; exit function code

    LDMFD SP!, {R0-R12}     ; restore all the registers from the stack
    MOV PC,R14              ; return from function

