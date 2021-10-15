; start program for $8000 in memory
.org 0x00008000
    b main

copy_buffer_to_screen:
    STMFD SP!, {R0-R12}
    
    MOV R12,R0
    MOV R11,R1
    MOV R10,#256

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
    SUBS R10,R10,#2
    BNE .loop

    LDMFD SP!, {R0-R12}
    MOV PC,R14

.include "swi.asm"
.include "vdu.asm"
.include "macros.asm"

; main entry point of code
main:
    ADRL SP,stack       ; load stack pointer with our stack address
    STMFD SP!, {R14}

    VDU VDU_SelectScreenMode,13,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_MultiPurpose,1,0,0,0,0,0,0,0,0,0
    ADRL R0,vdu_variables_screen_start
    ADRL R1,buffer
    SWI OS_ReadVduVariables

    ADRL R0,main_title
    ADRL R1,buffer
    LDR R1,[R1]
    BL copy_buffer_to_screen

    ADRL R1,buffer
    ADRL R12,level_1_tiles  ; move address of the level 1 tiles into R12
    LDR R10,[R1]            ; move address of the start of screen memory into R11

    ADD R10,R10,#320*32     ; move place to draw tile down 32 scanlines (320 bytes per scanline)
    
    MOV R0,#16*16           ; put size of tile in bytes (16 x 16 pixels) into R0
    MOV R1,#73              ; put tile index '70' into R1
    MLA R12,R0,R1,R12       ; calculate address of tile

    MOV R11,R10

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
    
    ADD R11,R10,#16

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

    ADD R11,R10,#32

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

    ADRL R12,level_1_tiles  ; move address of the level 1 tiles into R12
    ADRL R1,buffer
    LDR R10,[R1]            ; move address of the start of screen memory into R11

    ADD R10,R10,#320*32     ; move place to draw tile down 32 scanlines (320 bytes per scanline)
    ADD R10,R10,#320*16

    MOV R0,#16*16           ; put size of tile in bytes (16 x 16 pixels) into R0
    MOV R1,#89              ; put tile index '41' into R1
    MLA R12,R0,R1,R12       ; calculate address of tile

    MOV R11,R10

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
    
    ADD R11,R10,#16

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

    ADD R11,R10,#32

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

    ADRL R12,level_1_tiles  ; move address of the level 1 tiles into R12
    ADRL R1,buffer
    LDR R10,[R1]            ; move address of the start of screen memory into R11

    ADD R10,R10,#320*32     ; move place to draw tile down 32 scanlines (320 bytes per scanline)
    ADD R10,R10,#320*32

    MOV R0,#16*16           ; put size of tile in bytes (16 x 16 pixels) into R0
    MOV R1,#105              ; put tile index '41' into R1
    MLA R12,R0,R1,R12       ; calculate address of tile

    MOV R11,R10

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
    
    ADD R11,R10,#16

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

    ADD R11,R10,#32

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

    SWI OS_ReadC

    ADRL R0,intro_screen
    ADRL R1,buffer
    LDR R1,[R1]
    BL copy_buffer_to_screen

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


    .nolist    
    .balign 16

main_title:
    .incbin "build/main_title.bin"
intro_screen:
    .incbin "build/intro_screen.bin"
level_1_tiles:
    .incbin "build/level-1.bin"

; reserve 256 bytes for a stack
.space 256
stack:

