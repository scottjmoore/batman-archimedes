; start program for $8000 in memory
.org 0x00008000
    b main

.include "swi.asm"
.include "vdu.asm"
.include "macros.asm"

copy_4byte_to_screen:
    ; R0 = 4 bytes to copy to screen
    ; R1 = screen (destination)
    ; R2 = Number of scanlines to copy

    STMFD SP!, {R0-R12}
    
    MOV R11,R1
    MOV R10,R2
    MOV R1,R0
    MOV R2,R0
    MOV R3,R0
    MOV R4,R0
    MOV R5,R0
    MOV R6,R0
    MOV R7,R0
    MOV R8,R0
    MOV R9,R0

    .1:
    STMIA R11!,{R0-R9}
    STMIA R11!,{R0-R9}
    STMIA R11!,{R0-R9}
    STMIA R11!,{R0-R9}
    STMIA R11!,{R0-R9}
    STMIA R11!,{R0-R9}
    STMIA R11!,{R0-R9}
    STMIA R11!,{R0-R9}
    SUBS R10,R10,#1
    BNE .1

    LDMFD SP!, {R0-R12}
    MOV PC,R14

copy_buffer_to_screen:
    ; R0 = buffer (source)
    ; R1 = screen (destination)
    ; R2 = Number of scanlines to copy

    STMFD SP!, {R0-R12}
    
    MOV R12,R0
    MOV R11,R1
    MOV R10,R2

    .1:
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
    BNE .1

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

intro_font_lookup:
    ; R0 = ascii input character / on exit R0 = intro font tile number

    STMFD SP!, {R1-R12}

    ADRL R1,intro_font_lookup_table
    MOV R3,#0

intro_font_lookup_loop:
    LDRB R2,[R1]
    CMP R2,R0
    BEQ intro_font_lookup_exit
    ADD R1,R1,#1
    ADD R3,R3,#1
    B intro_font_lookup_loop

intro_font_lookup_exit:
    MOV R0,R3

    LDMFD SP!, {R1-R12}
    MOV PC,R14

draw_intro_font_text:
    ; R0 = ascii text to print
    ; R1 = tile map to use
    ; R2 = x
    ; R3 = y
    ; R4 = display buffer start

    STMFD SP!, {R0-R12,R14}

    MOV R10,R0
    EOR R0,R0,R0

draw_intro_font_text_loop:
    LDRB R0,[R10]
    ADD R10,R10,#1
    CMP R0,#0
    BEQ draw_intro_font_text_exit
    CMP R0,#0x0a
    BEQ draw_intro_font_text_nextline
    BL intro_font_lookup
    CMP R0,#0
    BEQ draw_intro_font_text_skip_tile
    BL copy_8x8_tile_to_screen
draw_intro_font_text_skip_tile:
    ADD R2,R2,#8
    CMP R2,#320
    BLT draw_intro_font_text_loop
draw_intro_font_text_nextline:
    MOV R2,#0
    ADD R3,R3,#8
    B draw_intro_font_text_loop

draw_intro_font_text_exit:
    LDMFD SP!, {R0-R12,R14}
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

    EOR R0,R0,R0
    LDR R1,[R12]
    MOV R2,#256
    BL copy_4byte_to_screen

    ADRL R0,intro_screen
    MOV R2,#1
    MOV R3,#255
    MOV R4,#320
    MUL R5,R3,R4
intro_screen_loop:
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
    BLE intro_screen_loop

    ADRL R0,intro_text_3
    ADRL R1,intro_font
    MOV R2,#0
    MOV R3,#35
    LDR R4,[R12]
    BL draw_intro_font_text

exit:
    TEQP  PC,#0
    MOV   R0,R0 
    LDMFD SP!, {PC}

.balign 16

intro_font_lookup_table:
    .byte " 0123456789.!&c-ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    .byte 0x00

intro_text_1:
    .byte "          OCEAN SOFTWARE PRESENTS      "
    .byte 0x00

intro_text_2:
    .byte "            BATMAN THE MOVIE           ",0
intro_text_3:
    .byte "          TM & c DC COMICS INC.         ",0x0a
    .byte "                  1989                  ",0x0a
    .byte 0x0a
    .byte "          c OCEAN SOFTWARE 1989         ",0x0a
    .byte 0x0a
    .byte "            ESC..ABORT GAME             ",0x0a
    .byte "             F1..PAUSE GAME             ",0x0a
    .byte "             F2..TOGGLE MUSIC           ",0

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

; reserve 512 bytes for a stack
.space 512
stack:

