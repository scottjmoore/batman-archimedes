; start program for $8000 in memory
.org 0x00008000
    b main

.include "swi.asm"
.include "vdu.asm"
.include "macros.asm"

copy_buffer_to_screen:
    ; R0 = buffer (source)
    ; R1 = screen (destination)
    ; R2 = Number of scanlines to copy

    STMFD SP!, {R0-R12}
    
    MOV R12,R0
    MOV R11,R1
    MOV R10,R2

.loop:
    LDMIA R12!,{R0-R9}
    STMIA R11!,{R0-R9}
    LDMIA R12!,{R0-R9}
    STMIA R11!,{R0-R9}
    LDMIA R12!,{R0-R9}
    STMIA R11!,{R0-R9}
    LDMIA R12!,{R0-R9}
    STMIA R11!,{R0-R9}
    LDMIA R12!,{R0-R9}
    STMIA R11!,{R0-R9}
    LDMIA R12!,{R0-R9}
    STMIA R11!,{R0-R9}
    LDMIA R12!,{R0-R9}
    STMIA R11!,{R0-R9}
    LDMIA R12!,{R0-R9}
    STMIA R11!,{R0-R9}
    SUBS R10,R10,#1
    BNE .loop

    LDMFD SP!, {R0-R12}
    MOV PC,R14

copy_16x16_tile_to_screen:
    ; R0 = tile
    ; R1 = tile_set
    ; R2 = x coordinate
    ; R3 = y coordinate
    ; R4 = display start

    STMFD SP!, {R0-R12}
    MOV R5,#16*16
    MLA R12,R0,R5,R1
    MOV R5,#320
    MLA R11,R3,R5,R4
    ADD R11,R11,R2

    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R3}
    ADD R11,R11,#320

    LDMFD SP!, {R0-R12}
    MOV PC,R14

copy_8x8_tile_to_screen:
    ; R0 = tile
    ; R1 = tile_set
    ; R2 = x coordinate
    ; R3 = y coordinate
    ; R4 = display start

    STMFD SP!, {R0-R12}
    MOV R5,#8*8
    MLA R12,R0,R5,R1
    MOV R5,#320
    MLA R11,R3,R5,R4
    ADD R11,R11,R2

    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R1}
    ADD R11,R11,#320
    STMIA R11,{R2-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R1}
    ADD R11,R11,#320
    STMIA R11,{R2-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R1}
    ADD R11,R11,#320
    STMIA R11,{R2-R3}
    ADD R11,R11,#320
    LDMIA R12!,{R0-R3}
    STMIA R11,{R0-R1}
    ADD R11,R11,#320
    STMIA R11,{R2-R3}
    ADD R11,R11,#320

    LDMFD SP!, {R0-R12}
    MOV PC,R14

; main entry point of code
main:
    ADRL SP,stack       ; load stack pointer with our stack address
    STMFD SP!, {R14}

    SWI OS_EnterOS

    VDU VDU_SelectScreenMode,13,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_MultiPurpose,1,0,0,0,0,0,0,0,0,0
    ADRL R0,vdu_variables_screen_start
    ADRL R1,buffer
    SWI OS_ReadVduVariables

    MOV R12,R1

    ADRL R0,main_title
    LDR R1,[R12]
    MOV R2,#256
    BL copy_buffer_to_screen

    SWI OS_ReadC

    ADRL R0,intro_screen
    MOV R2,#1
    MOV R3,#255
    MOV R4,#320
    MUL R5,R3,R4
.intro_screen_loop:
    STMFD SP!, {R0-R2}
    MOV R0,#19
    SWI OS_Byte
    LDMFD SP!, {R0-R2}
    LDR R1,[R12]
    ADD R1,R1,R5
    ;VDU 19,0,24,0,0,240,-1,-1,-1,-1
    BL copy_buffer_to_screen
    ;VDU 19,0,24,0,0,0,-1,-1,-1,-1
    SUB R5,R5,#320
    ADD R2,R2,#1
    CMP R2,#256
    BLE .intro_screen_loop

    MOV R0,#0
    ADRL R1,intro_font
    MOV R2,#0
    MOV R3,#128
    LDR R4,[R12]
.intro_font_loop:
    BL copy_8x8_tile_to_screen
    ADD R0,R0,#1
    ADD R2,R2,#8
    CMP R2,#320
    BNE .no_skip_line
    MOV R2,#0
    ADD R3,R3,#8
.no_skip_line:
    CMP R0,#64
    BNE .intro_font_loop


.exit:
    TEQP  PC,#0
    MOV   R0,R0 
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


    .nolist    
    .balign 16

main_title:
    .incbin "build/main_title.bin"
intro_screen:
    .incbin "build/intro_screen.bin"

intro_font:
    .incbin "build/intro_font.bin"
level_1_tiles:
    .incbin "build/level-1.bin"

; reserve 256 bytes for a stack
.space 256
stack:

