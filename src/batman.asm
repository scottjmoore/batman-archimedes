.include "swi.asm"
.include "vdu.asm"
.include "macros.asm"

; start program for $8000 in memory
.org 0x00008000

; start of our code
main:
    ADRL SP,stack       ; load stack pointer with our stack address
    STMFD SP!, {R14}

    VDU VDU_SelectScreenMode,13,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_MultiPurpose,1,0,0,0,0,0,0,0,0,0
    ADRL R0,vdu_variables_screen_start
    ADRL R1,buffer
    SWI OS_ReadVduVariables

.exit:
    LDMFD SP!, {PC}

.balign 16
vdu_variables_screen_start:
    .4byte 0x00000095       ; display memory start address
    .4byte 0xffffffff

.balign 16
buffer:
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000

;    .nolist    
    .balign 16

.incbin "build/level-1.bin"

; reserve 256 bytes for a stack
.space 256
stack:

