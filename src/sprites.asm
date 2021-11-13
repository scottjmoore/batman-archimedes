;   ****************************************************************
;       sprites.asm
;   ----------------------------------------------------------------
;       Copyright (c) 2021 Scott Moore, all rights reserved.
;   ****************************************************************

;   ****************************************************************
;       draw_sprite_outline
;   ----------------------------------------------------------------
;       Draw an outline around a sprite in 1 pixel width/height
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   byte/colour to store in framebuffer
;       R1      :   x coordinate of sprite
;       R2      :   y coordinate of sprite
;       R3      :   N/A
;       R4      :   width of sprite
;       R5      :   height of sprite
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

draw_sprite_outline:
    STMFD SP!,{R0-R5,R10,R11}

    CMP R1,#CLIP_LEFT
    BGE draw_sprite_outline_noclip_left
    ADD R4,R4,R1
    MOV R1,#CLIP_LEFT
    CMP R4,#0
    BLE draw_sprite_outline_exit
draw_sprite_outline_noclip_left:
    CMP R1,#CLIP_RIGHT
    BGE draw_sprite_outline_exit
    ADD R3,R1,R4
    CMP R3,#CLIP_RIGHT
    BLE draw_sprite_outline_noclip_right
    SUB R3,R3,#CLIP_RIGHT
    SUB R4,R4,R3
    CMP R4,#0
    BLE draw_sprite_outline_exit
draw_sprite_outline_noclip_right:
    CMP R2,#CLIP_TOP
    BGE draw_sprite_outline_noclip_top
    ADD R5,R5,R2
    MOV R2,#CLIP_TOP
    CMP R5,#0
    BLE draw_sprite_outline_exit
draw_sprite_outline_noclip_top:
    CMP R2,#CLIP_BOTTOM
    BGE draw_sprite_outline_exit
    ADD R3,R2,R5
    CMP R3,#CLIP_BOTTOM
    BLE draw_sprite_outline_noclip_bottom
    SUB R3,R3,#CLIP_BOTTOM
    SUB R5,R5,R3
    CMP R5,#0
    BLE draw_sprite_outline_exit
draw_sprite_outline_noclip_bottom:

    MOV R0,#255
    ADD R11,R11,R1
    MOV R3,#SCANLINE
    MLA R11,R2,R3,R11
    MLA R10,R5,R3,R11
    SUB R10,R10,#SCANLINE
    SUB R3,R4,#1

draw_sprite_outline_horizontal:
    SUBS R4,R4,#1
    STRB R0,[R11,R4]
    STRB R0,[R10,R4]
    BNE draw_sprite_outline_horizontal

draw_sprite_outline_vertical:
    STRB R0,[R11]
    STRB R0,[R11,R3]
    ADD R11,R11,#SCANLINE * 1
    SUBS R5,R5,#1
    BNE draw_sprite_outline_vertical

draw_sprite_outline_exit:
    LDMFD SP!,{R0-R5,R10,R11}
    MOV PC,R14