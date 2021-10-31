;   ****************************************************************
;       memc.asm
;   ----------------------------------------------------------------
;       Copyright (c) 2021 Scott Moore, all rights reserved.
;   ****************************************************************

;   ****************************************************************
;       Constants
;   ----------------------------------------------------------------
;       Define constants used in this file and calling functions.
;   ****************************************************************

.set    MEMC,   0x3600000

;   ****************************************************************
;       memc_set_display_start
;   ----------------------------------------------------------------
;       Sets the MEMC register for video display start.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   physical address of screen display buffer >> 2
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
;       R11     :   N/A
;       R11     :   N/A
;   ----------------------------------------------------------------
;       Returns
;   ----------------------------------------------------------------
;       R0      :   Corrupted
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
memc_set_display_start:
    ADD R0,R0,#MEMC         ; Add pre-shifted screen start address to VIDC address
    STR R0,[R0]             ; Put VIDC address and screen start address onto address bus

    MOV PC,R14              ; return from function

