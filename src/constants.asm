;   ****************************************************************
;       constants.asm
;   ----------------------------------------------------------------
;       Copyright (c) 2021 Scott Moore, all rights reserved.
;   ****************************************************************

;   ****************************************************************
;       Constants
;   ----------------------------------------------------------------
;       Define constants used in this file and calling functions.
;   ****************************************************************

.ifndef __CONSTANTS_ASM
    .set    __CONSTANTS_ASM,    -1

    .set    CLIP_TOP,       0
    .set    CLIP_BOTTOM,    184 - 16
    .set    CLIP_LEFT,      0
    .set    CLIP_RIGHT,     352
    .set    SCANLINE,       352

    .set    TILE_BLOCKED,           0x9f
    .set    TILE_LADDER,            0x9e
    .set    TILE_PLATFORM,          0x9d
    .set    TILE_PLATFORM_BLOCKED,  0x9c
    .set    TILE_CLEAR,             0x90

    .set    BLOCKED_LEFT,           1<<0
    .set    BLOCKED_RIGHT,          1<<1
    .set    BLOCKED_DOWN,           1<<2
    .set    BLOCKED_UP,             1<<3
    .set    CAN_GO_DOWN_LADDER,     1<<4
    .set    CAN_GO_UP_LADDER,       1<<5
    .set    CAN_FALL_DOWN,          1<<6
    .set    IS_FALLING,             1<<7
    .set    IS_DEAD,                1<<31

    .set    PRESSED_LEFT,           1<<0
    .set    PRESSED_RIGHT,          1<<1
    .set    PRESSED_UP,             1<<2
    .set    PRESSED_DOWN,           1<<3
    .set    PRESSED_FIRE,           1<<4

    .set    FATAL_FALL_HEIGHT,      200
    .set    NO_CROUCH_FALL_HEIGHT,  24
    
.endif
