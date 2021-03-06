;   ****************************************************************
;       vidc.asm
;   ----------------------------------------------------------------
;       Copyright (c) 2021 Scott Moore, all rights reserved.
;   ****************************************************************

;   ****************************************************************
;       Constants
;   ----------------------------------------------------------------
;       Define constants used in this file and calling functions.
;   ****************************************************************

.set    VIDC,   0x3400000

;   ****************************************************************
;       vidc_set_border_colour
;   ----------------------------------------------------------------
;       Set VIDC register for border colour, 
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   N/A
;       R1      :   red (0-3), green (4-7), blue (8-11) values for border
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
;       R1      :   Corrupted
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

vidc_set_border_colour:
    MOV R0,#0x40 << 24
    MOV R1,R1,LSL #20
    ORR R0,R0,R1,LSR #20
    MOV R1,#VIDC
    STR R0,[R1]
    MOV PC,R14

vidc_set_HBSR:
    MOV R0,#0x88 << 24
    MOV R1,R1,LSL #22
    ORR R0,R0,R1,LSR #8
    MOV R1,#VIDC
    STR R0,[R1]
    MOV PC,R14

vidc_set_HDSR:
    MOV R0,#0x8c << 24
    MOV R1,R1,LSL #22
    ORR R0,R0,R1,LSR #8
    MOV R1,#VIDC
    STR R0,[R1]
    MOV PC,R14

vidc_set_HBER:
    MOV R0,#0x94 << 24
    MOV R1,R1,LSL #22
    ORR R0,R0,R1,LSR #8
    MOV R1,#VIDC
    STR R0,[R1]
    MOV PC,R14

vidc_set_HDER:
    MOV R0,#0x90 << 24
    MOV R1,R1,LSL #22
    ORR R0,R0,R1,LSR #8
    MOV R1,#VIDC
    STR R0,[R1]
    MOV PC,R14

vidc_set_VDSR:
    MOV R0,#0xac << 24
    MOV R1,R1,LSL #22
    ORR R0,R0,R1,LSR #8
    MOV R1,#VIDC
    STR R0,[R1]
    MOV PC,R14

vidc_set_VDER:
    MOV R0,#0xb0 << 24
    MOV R1,R1,LSL #22
    ORR R0,R0,R1,LSR #8
    MOV R1,#VIDC
    STR R0,[R1]
    MOV PC,R14

