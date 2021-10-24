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

    CMP R3,#CLIP_TOP + 16
    BLT draw_16x16_tile_clipped_top
    CMP R3,#CLIP_BOTTOM - 16
    BGT draw_16x16_tile_clipped_bottom
    CMP R2,#CLIP_LEFT + 16
    BLT draw_16x16_tile_clipped_left
    CMP R2,#CLIP_TOP - 16
    BGT draw_16x16_tile_clipped_right

draw_16x16_tile_clipped_top:
    CMP R3,#CLIP_TOP - 16
    BLE draw_16x16_tile_exit
    CMP R2,#CLIP_LEFT + 16
    BLT draw_16x16_tile_clipped_top_left
    CMP R2,#CLIP_TOP - 16
    BGT draw_16x16_tile_clipped_top_right


draw_16x16_tile_clipped_top_left:

draw_16x16_tile_clipped_top_right:

draw_16x16_tile_clipped_bottom:
    CMP R3,#CLIP_BOTTOM + 16
    BGE draw_16x16_tile_exit
    CMP R2,#CLIP_LEFT + 16
    BLT draw_16x16_tile_clipped_bottom_left
    CMP R2,#CLIP_TOP - 16
    BGT draw_16x16_tile_clipped_bottom_right

draw_16x16_tile_clipped_bottom_left:

draw_16x16_tile_clipped_bottom_right:

draw_16x16_tile_clipped_left:
    CMP R2,#CLIP_LEFT - 16
    BLE draw_16x16_tile_clipped_right

draw_16x16_tile_clipped_right:
    CMP R2,#CLIP_RIGHT + 16
    BGE draw_16x16_tile_clipped_right

draw_16x16_tile_exit:       ; exit function code

    LDMFD SP!, {R0-R12}     ; restore all the registers from the stack
    MOV PC,R14              ; return from function

