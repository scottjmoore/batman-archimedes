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
    
.endif
