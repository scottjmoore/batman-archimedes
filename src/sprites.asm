;   ****************************************************************
;       sprites.asm
;   ----------------------------------------------------------------
;       Copyright (c) 2021 Scott Moore, all rights reserved.
;   ****************************************************************

.set    sprite_function,    0
.set    sprite_frame,       4
.set    sprite_x,           8
.set    sprite_y,           12
.set    sprite_attributes,  16
.set    sprite_width,       20
.set    sprite_height,      24
.set    sprite_collision,   28
.set    sprite_offset_x,    32
.set    sprite_offset_y,    36

sprite_world_offset_x:        .4byte  0
sprite_world_offset_y:        .4byte  0

sprites:

sprite_00:
sprite_00_function:     .4byte  0x00000000
sprite_00_frame:        .4byte  0
sprite_00_x:            .4byte  0
sprite_00_y:            .4byte  0
sprite_00_attributes:   .4byte  0x0000ff00
sprite_00_width:        .4byte  0
sprite_00_height:       .4byte  0
sprite_00_collision:    .4byte  0b00000000000000000000000000000000
sprite_00_offset_x:     .4byte  0
sprite_00_offset_y:     .4byte  0

sprite_01:
sprite_01_function:     .4byte  0x00000000
sprite_01_frame:        .4byte  0x00000000
sprite_01_x:            .4byte  0x00000000
sprite_01_y:            .4byte  0x00000000
sprite_01_attributes:   .4byte  0x0000ff00
sprite_01_width:        .4byte  0x00000000
sprite_01_height:       .4byte  0x00000000
sprite_01_collision:    .4byte  0x00000000
sprite_01_offset_x:     .4byte  0
sprite_01_offset_y:     .4byte  0

sprite_02:
sprite_02_function:     .4byte  0x00000000
sprite_02_frame:        .4byte  0x00000000
sprite_02_x:            .4byte  0x00000000
sprite_02_y:            .4byte  0x00000000
sprite_02_attributes:   .4byte  0x0000ff00
sprite_02_width:        .4byte  0x00000000
sprite_02_height:       .4byte  0x00000000
sprite_02_collision:    .4byte  0x00000000
sprite_02_offset_x:     .4byte  0
sprite_02_offset_y:     .4byte  0

sprite_03:
sprite_03_function:     .4byte  0x00000000
sprite_03_frame:        .4byte  0x00000000
sprite_03_x:            .4byte  0x00000000
sprite_03_y:            .4byte  0x00000000
sprite_03_attributes:   .4byte  0x0000ff00
sprite_03_width:        .4byte  0x00000000
sprite_03_height:       .4byte  0x00000000
sprite_03_collision:    .4byte  0x00000000
sprite_03_offset_x:     .4byte  0
sprite_03_offset_y:     .4byte  0

sprite_04:
sprite_04_function:     .4byte  0x00000000
sprite_04_frame:        .4byte  0x00000000
sprite_04_x:            .4byte  0x00000000
sprite_04_y:            .4byte  0x00000000
sprite_04_attributes:   .4byte  0x0000ff00
sprite_04_width:        .4byte  0x00000000
sprite_04_height:       .4byte  0x00000000
sprite_04_collision:    .4byte  0x00000000
sprite_04_offset_x:     .4byte  0
sprite_04_offset_y:     .4byte  0

sprite_05:
sprite_05_function:     .4byte  0x00000000
sprite_05_frame:        .4byte  0x00000000
sprite_05_x:            .4byte  0x00000000
sprite_05_y:            .4byte  0x00000000
sprite_05_attributes:   .4byte  0x0000ff00
sprite_05_width:        .4byte  0x00000000
sprite_05_height:       .4byte  0x00000000
sprite_05_collision:    .4byte  0x00000000
sprite_05_offset_x:     .4byte  0
sprite_05_offset_y:     .4byte  0

sprite_06:
sprite_06_function:     .4byte  0x00000000
sprite_06_frame:        .4byte  0x00000000
sprite_06_x:            .4byte  0x00000000
sprite_06_y:            .4byte  0x00000000
sprite_06_attributes:   .4byte  0x0000ff00
sprite_06_width:        .4byte  0x00000000
sprite_06_height:       .4byte  0x00000000
sprite_06_collision:    .4byte  0x00000000
sprite_06_offset_x:     .4byte  0
sprite_06_offset_y:     .4byte  0

sprite_07:
sprite_07_function:     .4byte  0x00000000
sprite_07_frame:        .4byte  0x00000000
sprite_07_x:            .4byte  0x00000000
sprite_07_y:            .4byte  0x00000000
sprite_07_attributes:   .4byte  0x0000ff00
sprite_07_width:        .4byte  0x00000000
sprite_07_height:       .4byte  0x00000000
sprite_07_collision:    .4byte  0x00000000
sprite_07_offset_x:     .4byte  0
sprite_07_offset_y:     .4byte  0

sprite_08:
sprite_08_function:     .4byte  0x00000000
sprite_08_frame:        .4byte  0x00000000
sprite_08_x:            .4byte  0x00000000
sprite_08_y:            .4byte  0x00000000
sprite_08_attributes:   .4byte  0x0000ff00
sprite_08_width:        .4byte  0x00000000
sprite_08_height:       .4byte  0x00000000
sprite_08_collision:    .4byte  0x00000000
sprite_08_offset_x:     .4byte  0
sprite_08_offset_y:     .4byte  0

sprite_09:
sprite_09_function:     .4byte  0x00000000
sprite_09_frame:        .4byte  0x00000000
sprite_09_x:            .4byte  0x00000000
sprite_09_y:            .4byte  0x00000000
sprite_09_attributes:   .4byte  0x0000ff00
sprite_09_width:        .4byte  0x00000000
sprite_09_height:       .4byte  0x00000000
sprite_09_collision:    .4byte  0x00000000
sprite_09_offset_x:     .4byte  0
sprite_09_offset_y:     .4byte  0

sprite_10:
sprite_10_function:     .4byte  0x00000000
sprite_10_frame:        .4byte  0x00000000
sprite_10_x:            .4byte  0x00000000
sprite_10_y:            .4byte  0x00000000
sprite_10_attributes:   .4byte  0x0000ff00
sprite_10_width:        .4byte  0x00000000
sprite_10_height:       .4byte  0x00000000
sprite_10_collision:    .4byte  0x00000000
sprite_10_offset_x:     .4byte  0
sprite_10_offset_y:     .4byte  0

sprite_11:
sprite_11_function:     .4byte  0x00000000
sprite_11_frame:        .4byte  0x00000000
sprite_11_x:            .4byte  0x00000000
sprite_11_y:            .4byte  0x00000000
sprite_11_attributes:   .4byte  0x0000ff00
sprite_11_width:        .4byte  0x00000000
sprite_11_height:       .4byte  0x00000000
sprite_11_collision:    .4byte  0x00000000
sprite_11_offset_x:     .4byte  0
sprite_11_offset_y:     .4byte  0

sprite_12:
sprite_12_function:     .4byte  0x00000000
sprite_12_frame:        .4byte  0x00000000
sprite_12_x:            .4byte  0x00000000
sprite_12_y:            .4byte  0x00000000
sprite_12_attributes:   .4byte  0x0000ff00
sprite_12_width:        .4byte  0x00000000
sprite_12_height:       .4byte  0x00000000
sprite_12_collision:    .4byte  0x00000000
sprite_12_offset_x:     .4byte  0
sprite_12_offset_y:     .4byte  0

sprite_13:
sprite_13_function:     .4byte  0x00000000
sprite_13_frame:        .4byte  0x00000000
sprite_13_x:            .4byte  0x00000000
sprite_13_y:            .4byte  0x00000000
sprite_13_attributes:   .4byte  0x0000ff00
sprite_13_width:        .4byte  0x00000000
sprite_13_height:       .4byte  0x00000000
sprite_13_collision:    .4byte  0x00000000
sprite_13_offset_x:     .4byte  0
sprite_13_offset_y:     .4byte  0

sprite_14:
sprite_14_function:     .4byte  0x00000000
sprite_14_frame:        .4byte  0x00000000
sprite_14_x:            .4byte  0x00000000
sprite_14_y:            .4byte  0x00000000
sprite_14_attributes:   .4byte  0x0000ff00
sprite_14_width:        .4byte  0x00000000
sprite_14_height:       .4byte  0x00000000
sprite_14_collision:    .4byte  0x00000000
sprite_14_offset_x:     .4byte  0
sprite_14_offset_y:     .4byte  0

sprite_15:
sprite_15_function:     .4byte  0x00000000
sprite_15_frame:        .4byte  0x00000000
sprite_15_x:            .4byte  0x00000000
sprite_15_y:            .4byte  0x00000000
sprite_15_attributes:   .4byte  0x0000ff00
sprite_15_width:        .4byte  0x00000000
sprite_15_height:       .4byte  0x00000000
sprite_15_collision:    .4byte  0x00000000
sprite_15_offset_x:     .4byte  0
sprite_15_offset_y:     .4byte  0

sprite_16:
sprite_16_function:     .4byte  0x00000000
sprite_16_frame:        .4byte  0x00000000
sprite_16_x:            .4byte  0x00000000
sprite_16_y:            .4byte  0x00000000
sprite_16_attributes:   .4byte  0x0000ff00
sprite_16_width:        .4byte  0x00000000
sprite_16_height:       .4byte  0x00000000
sprite_16_collision:    .4byte  0x00000000
sprite_16_offset_x:     .4byte  0
sprite_16_offset_y:     .4byte  0

sprite_17:
sprite_17_function:     .4byte  0x00000000
sprite_17_frame:        .4byte  0x00000000
sprite_17_x:            .4byte  0x00000000
sprite_17_y:            .4byte  0x00000000
sprite_17_attributes:   .4byte  0x0000ff00
sprite_17_width:        .4byte  0x00000000
sprite_17_height:       .4byte  0x00000000
sprite_17_collision:    .4byte  0x00000000
sprite_17_offset_x:     .4byte  0
sprite_17_offset_y:     .4byte  0

sprite_18:
sprite_18_function:     .4byte  0x00000000
sprite_18_frame:        .4byte  0x00000000
sprite_18_x:            .4byte  0x00000000
sprite_18_y:            .4byte  0x00000000
sprite_18_attributes:   .4byte  0x0000ff00
sprite_18_width:        .4byte  0x00000000
sprite_18_height:       .4byte  0x00000000
sprite_18_collision:    .4byte  0x00000000
sprite_18_offset_x:     .4byte  0
sprite_18_offset_y:     .4byte  0

sprite_19:
sprite_19_function:     .4byte  0x00000000
sprite_19_frame:        .4byte  0x00000000
sprite_19_x:            .4byte  0x00000000
sprite_19_y:            .4byte  0x00000000
sprite_19_attributes:   .4byte  0x0000ff00
sprite_19_width:        .4byte  0x00000000
sprite_19_height:       .4byte  0x00000000
sprite_19_collision:    .4byte  0x00000000
sprite_19_offset_x:     .4byte  0
sprite_19_offset_y:     .4byte  0

sprite_20:
sprite_20_function:     .4byte  0x00000000
sprite_20_frame:        .4byte  0x00000000
sprite_20_x:            .4byte  0x00000000
sprite_20_y:            .4byte  0x00000000
sprite_20_attributes:   .4byte  0x0000ff00
sprite_20_width:        .4byte  0x00000000
sprite_20_height:       .4byte  0x00000000
sprite_20_collision:    .4byte  0x00000000
sprite_20_offset_x:     .4byte  0
sprite_20_offset_y:     .4byte  0

sprite_21:
sprite_21_function:     .4byte  0x00000000
sprite_21_frame:        .4byte  0x00000000
sprite_21_x:            .4byte  0x00000000
sprite_21_y:            .4byte  0x00000000
sprite_21_attributes:   .4byte  0x0000ff00
sprite_21_width:        .4byte  0x00000000
sprite_21_height:       .4byte  0x00000000
sprite_21_collision:    .4byte  0x00000000
sprite_21_offset_x:     .4byte  0
sprite_21_offset_y:     .4byte  0

sprite_22:
sprite_22_function:     .4byte  0x00000000
sprite_22_frame:        .4byte  0x00000000
sprite_22_x:            .4byte  0x00000000
sprite_22_y:            .4byte  0x00000000
sprite_22_attributes:   .4byte  0x0000ff00
sprite_22_width:        .4byte  0x00000000
sprite_22_height:       .4byte  0x00000000
sprite_22_collision:    .4byte  0x00000000
sprite_22_offset_x:     .4byte  0
sprite_22_offset_y:     .4byte  0

sprite_23:
sprite_23_function:     .4byte  0x00000000
sprite_23_frame:        .4byte  0x00000000
sprite_23_x:            .4byte  0x00000000
sprite_23_y:            .4byte  0x00000000
sprite_23_attributes:   .4byte  0x0000ff00
sprite_23_width:        .4byte  0x00000000
sprite_23_height:       .4byte  0x00000000
sprite_23_collision:    .4byte  0x00000000
sprite_23_offset_x:     .4byte  0
sprite_23_offset_y:     .4byte  0

sprite_24:
sprite_24_function:     .4byte  0x00000000
sprite_24_frame:        .4byte  0x00000000
sprite_24_x:            .4byte  0x00000000
sprite_24_y:            .4byte  0x00000000
sprite_24_attributes:   .4byte  0x0000ff00
sprite_24_width:        .4byte  0x00000000
sprite_24_height:       .4byte  0x00000000
sprite_24_collision:    .4byte  0x00000000
sprite_24_offset_x:     .4byte  0
sprite_24_offset_y:     .4byte  0

sprite_25:
sprite_25_function:     .4byte  0x00000000
sprite_25_frame:        .4byte  0x00000000
sprite_25_x:            .4byte  0x00000000
sprite_25_y:            .4byte  0x00000000
sprite_25_attributes:   .4byte  0x0000ff00
sprite_25_width:        .4byte  0x00000000
sprite_25_height:       .4byte  0x00000000
sprite_25_collision:    .4byte  0x00000000
sprite_25_offset_x:     .4byte  0
sprite_25_offset_y:     .4byte  0

sprite_26:
sprite_26_function:     .4byte  0x00000000
sprite_26_frame:        .4byte  0x00000000
sprite_26_x:            .4byte  0x00000000
sprite_26_y:            .4byte  0x00000000
sprite_26_attributes:   .4byte  0x0000ff00
sprite_26_width:        .4byte  0x00000000
sprite_26_height:       .4byte  0x00000000
sprite_26_collision:    .4byte  0x00000000
sprite_26_offset_x:     .4byte  0
sprite_26_offset_y:     .4byte  0

sprite_27:
sprite_27_function:     .4byte  0x00000000
sprite_27_frame:        .4byte  0x00000000
sprite_27_x:            .4byte  0x00000000
sprite_27_y:            .4byte  0x00000000
sprite_27_attributes:   .4byte  0x0000ff00
sprite_27_width:        .4byte  0x00000000
sprite_27_height:       .4byte  0x00000000
sprite_27_collision:    .4byte  0x00000000
sprite_27_offset_x:     .4byte  0
sprite_27_offset_y:     .4byte  0

sprite_28:
sprite_28_function:     .4byte  0x00000000
sprite_28_frame:        .4byte  0x00000000
sprite_28_x:            .4byte  0x00000000
sprite_28_y:            .4byte  0x00000000
sprite_28_attributes:   .4byte  0x0000ff00
sprite_28_width:        .4byte  0x00000000
sprite_28_height:       .4byte  0x00000000
sprite_28_collision:    .4byte  0x00000000
sprite_28_offset_x:     .4byte  0
sprite_28_offset_y:     .4byte  0

sprite_29:
sprite_29_function:     .4byte  0x00000000
sprite_29_frame:        .4byte  0x00000000
sprite_29_x:            .4byte  0x00000000
sprite_29_y:            .4byte  0x00000000
sprite_29_attributes:   .4byte  0x0000ff00
sprite_29_width:        .4byte  0x00000000
sprite_29_height:       .4byte  0x00000000
sprite_29_collision:    .4byte  0x00000000
sprite_29_offset_x:     .4byte  0
sprite_29_offset_y:     .4byte  0

sprite_30:
sprite_30_function:     .4byte  0x00000000
sprite_30_frame:        .4byte  0x00000000
sprite_30_x:            .4byte  0x00000000
sprite_30_y:            .4byte  0x00000000
sprite_30_attributes:   .4byte  0x0000ff00
sprite_30_width:        .4byte  0x00000000
sprite_30_height:       .4byte  0x00000000
sprite_30_collision:    .4byte  0x00000000
sprite_30_offset_x:     .4byte  0
sprite_30_offset_y:     .4byte  0

sprite_31:
sprite_31_function:     .4byte  0x00000000
sprite_31_frame:        .4byte  0x00000000
sprite_31_x:            .4byte  0x00000000
sprite_31_y:            .4byte  0x00000000
sprite_31_attributes:   .4byte  0x0000ff00
sprite_31_width:        .4byte  0x00000000
sprite_31_height:       .4byte  0x00000000
sprite_31_collision:    .4byte  -1
sprite_31_offset_x:     .4byte  0
sprite_31_offset_y:     .4byte  0

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

    CMP R1,#CLIP_LEFT + 16
    BGE draw_sprite_outline_noclip_left
    ADD R4,R4,R1
    SUB R4,R4,#16
    MOV R1,#CLIP_LEFT + 16
    CMP R4,#0
    BLE draw_sprite_outline_exit

draw_sprite_outline_noclip_left:
    CMP R1,#CLIP_RIGHT - 16
    BGE draw_sprite_outline_exit
    ADD R3,R1,R4
    CMP R3,#CLIP_RIGHT - 16
    BLE draw_sprite_outline_noclip_right
    SUB R3,R3,#CLIP_RIGHT - 16
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

;   ****************************************************************
;       draw_sprites
;   ----------------------------------------------------------------
;       Draw all sprites
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   N/A
;       R1      :   N/A
;       R2      :   N/A
;       R3      :   N/A
;       R4      :   N/A
;       R5      :   N/A
;       R6      :   N/A
;       R7      :   N/A
;       R8      :   N/A
;       R9      :   N/A
;       R10     :   N/A
;       R11     :   framebuffer destination
;       R12     :   N/A
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

draw_sprites:
    STMFD SP!,{R0-R12,R14}

    MOV R9,#32
    ADRL R10,sprites
draw_sprites_loop:
    LDR R12,[R10],#4
    LDMFD R10!,{R0-R8}
    MOV R0,R0,LSR #4
    SUB R1,R1,R7
    SUB R2,R2,R8
    LDR R7,sprite_world_offset_x
    LDR R8,sprite_world_offset_y
    SUB R1,R1,R7
    SUB R2,R2,R8

    CMP R12,#0
    BEQ draw_sprites_skip
    ADD R14,PC,#0
    MOV PC,R12

    .ifne SPRITE_DEBUG
        CMP R6,#0
        MOVEQ R0,#255
        MOVNE R0,#23
        BL draw_sprite_outline
    .endif
    
draw_sprites_skip:
    SUBS R9,R9,#1
    BNE draw_sprites_loop

draw_sprites_exit:
    LDMFD SP!,{R0-R12,R14}
    MOV PC,R14
