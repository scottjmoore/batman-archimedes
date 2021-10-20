;   ****************************************************************
;       Batman.asm
;   ----------------------------------------------------------------
;       Copyright (c) 2021 Scott Moore, all rights reserved.
;   ****************************************************************


;   ****************************************************************
;       Entry point of application
;   ----------------------------------------------------------------
;       Set code to assemble from address 0x8000 and branch to
;       main function.
;   ****************************************************************

.org 0x00008000
    B main


;   ****************************************************************
;       stack
;   ----------------------------------------------------------------
;       Reserve 1024 bytes for our stack
;   ----------------------------------------------------------------
    .space 256
stack:


;   ****************************************************************
;       Include external source files
;   ****************************************************************

.include "swi.asm"
.include "vdu.asm"
.include "macros.asm"


;   ****************************************************************
;       set_display_start
;   ----------------------------------------------------------------
;       Copy 4 bytes from a register to the screen or display
;       buffer, function assumes a 320 byte wide scanline width.
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
set_display_start:
    ; MOV R1,#0x3600000       ; Move VIDC address into R1
    ; ADD R0,R0,R1            ; Add pre-shifted screen start address to VIDC address
    ADD R0,R0,#0x3600000    ; Add pre-shifted screen start address to VIDC address
    STR R0,[R0]             ; Put VIDC address and screen start address onto address bus

    MOV PC,R14              ; return from function


;   ****************************************************************
;       copy_4byte_to_screen
;   ----------------------------------------------------------------
;       Copy 4 bytes from a register to the screen or display
;       buffer, function assumes a 320 byte wide scanline width.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   4 bytes to copy to the screen
;       R1      :   screen or display buffer address
;       R2      :   Number of scanlines to copy
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
copy_4byte_to_screen:

    STMFD SP!, {R0-R12}     ; store all the registers onto the stack

    MOV R11,R1      ; move destination address into R11
    MOV R10,R2      ; move number of scanlines into R12
    MOV R1,R0       ; move the 4 bytes to write into R1-R9
    MOV R2,R0       ; move the 4 bytes to write into R1-R9
    MOV R3,R0       ; move the 4 bytes to write into R1-R9
    MOV R4,R0       ; move the 4 bytes to write into R1-R9
    MOV R5,R0       ; move the 4 bytes to write into R1-R9
    MOV R6,R0       ; move the 4 bytes to write into R1-R9
    MOV R7,R0       ; move the 4 bytes to write into R1-R9
    MOV R8,R0       ; move the 4 bytes to write into R1-R9
    MOV R9,R0       ; move the 4 bytes to write into R1-R9

copy_4byte_to_screen_loop:      ; start of copy loop
    STMIA R11!,{R0-R9}          ; move the 4 bytes intto 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes intto 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes intto 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes intto 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes intto 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes intto 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes intto 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes intto 40 bytes of the destination
    SUBS R10,R10,#1             ; decrease number of scanlines to copy by 1
    BNE copy_4byte_to_screen_loop   ; if the number of scanlines left to copy is not zero, branch back to start of loop

    LDMFD SP!, {R0-R12}     ; restore all the registers from the stack
    MOV PC,R14              ; return from function


;   ****************************************************************
;       copy_buffer_to_screen
;   ----------------------------------------------------------------
;       Copy display buffer to screen or another display buffer,
;       assumes a scanline width of 320 bytes.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   source address of buffer
;       R1      :   destination address of screen or buffer
;       R2      :   Number of scanlines to copy
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
copy_buffer_to_screen:

    STMFD SP!, {R0-R12}     ; store all the registers onto the stack

    MOV R12,R0      ; move source address into R11
    MOV R11,R1      ; move destination address into R12
    MOV R10,R2      ; move number of scanlines to copy into R10

copy_buffer_to_screen_loop:     ; start of copy loop
    LDMIA R12!,{R0-R9}          ; load 40 bytes from source into R0-R9
    STMIA R11!,{R0-R9}          ; store 40 bytes from R0-R9 to destination address
    LDMIA R12!,{R0-R9}          ; load 40 bytes from source into R0-R9
    STMIA R11!,{R0-R9}          ; store 40 bytes from R0-R9 to destination address
    LDMIA R12!,{R0-R9}          ; load 40 bytes from source into R0-R9
    STMIA R11!,{R0-R9}          ; store 40 bytes from R0-R9 to destination address
    LDMIA R12!,{R0-R9}          ; load 40 bytes from source into R0-R9
    STMIA R11!,{R0-R9}          ; store 40 bytes from R0-R9 to destination address
    LDMIA R12!,{R0-R9}          ; load 40 bytes from source into R0-R9
    STMIA R11!,{R0-R9}          ; store 40 bytes from R0-R9 to destination address
    LDMIA R12!,{R0-R9}          ; load 40 bytes from source into R0-R9
    STMIA R11!,{R0-R9}          ; store 40 bytes from R0-R9 to destination address
    LDMIA R12!,{R0-R9}          ; load 40 bytes from source into R0-R9
    STMIA R11!,{R0-R9}          ; store 40 bytes from R0-R9 to destination address
    LDMIA R12!,{R0-R9}          ; load 40 bytes from source into R0-R9
    STMIA R11!,{R0-R9}          ; store 40 bytes from R0-R9 to destination address
    SUBS R10,R10,#1             ; decrease number of scanlines to copy by 1
    BNE copy_buffer_to_screen_loop      ; if number of scanlines left to copy is not zero branch back to start of loop

    LDMFD SP!, {R0-R12}     ; restore all the registers from the stack
    MOV PC,R14              ; return from function


;   ****************************************************************
;       fade_buffer_with_lookup
;   ----------------------------------------------------------------
;       Do a lookup on each byte of screen or display buffer and
;       replace with a byte from a lookup table
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   address of lookup table
;       R1      :   address of source screen or display buffer
;       R2      :   address of destination screen or display buffer
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
fade_buffer_with_lookup:

    STMFD SP!, {R0-R12}     ; store all registers onto the stack

    MOV R11,R1
    MOV R12,R2

    MOV R1,#5120
fade_buffer_with_lookup_loop:
    LDMIA R11!,{R2-R5}

    AND R10,R2,#255
    ADD R10,R10,R0
    LDRB R6,[R10]

    MOV R2,R2,ROR #8
    AND R10,R2,#255
    ADD R10,R10,R0
    LDRB R7,[R10]
    MOV R7,R7,LSL #8
    ORR R6,R6,R7

    MOV R2,R2,ROR #8
    AND R10,R2,#255
    ADD R10,R10,R0
    LDRB R7,[R10]
    MOV R7,R7,LSL #16
    ORR R6,R6,R7

    MOV R2,R2,ROR #8
    AND R10,R2,#255
    ADD R10,R10,R0
    LDRB R7,[R10]
    MOV R7,R7,LSL #24
    ORR R6,R6,R7

    AND R10,R3,#255
    ADD R10,R10,R0
    LDRB R7,[R10]

    MOV R3,R3,ROR #8
    AND R10,R3,#255
    ADD R10,R10,R0
    LDRB R8,[R10]
    MOV R8,R8,LSL #8
    ORR R7,R7,R8

    MOV R3,R3,ROR #8
    AND R10,R3,#255
    ADD R10,R10,R0
    LDRB R8,[R10]
    MOV R8,R8,LSL #16
    ORR R7,R7,R8

    MOV R3,R3,ROR #8
    AND R10,R3,#255
    ADD R10,R10,R0
    LDRB R8,[R10]
    MOV R8,R8,LSL #24
    ORR R7,R7,R8

    AND R10,R4,#255
    ADD R10,R10,R0
    LDRB R8,[R10]

    MOV R4,R4,ROR #8
    AND R10,R4,#255
    ADD R10,R10,R0
    LDRB R9,[R10]
    MOV R9,R9,LSL #8
    ORR R8,R8,R9

    MOV R4,R4,ROR #8
    AND R10,R4,#255
    ADD R10,R10,R0
    LDRB R9,[R10]
    MOV R9,R9,LSL #16
    ORR R8,R8,R9

    MOV R4,R4,ROR #8
    AND R10,R4,#255
    ADD R10,R10,R0
    LDRB R9,[R10]
    MOV R9,R9,LSL #24
    ORR R8,R8,R9

    AND R10,R5,#255
    ADD R10,R10,R0
    LDRB R9,[R10]

    MOV R5,R5,ROR #8
    AND R10,R5,#255
    ADD R10,R10,R0
    LDRB R2,[R10]
    MOV R2,R2,LSL #8
    ORR R9,R9,R2

    MOV R5,R5,ROR #8
    AND R10,R5,#255
    ADD R10,R10,R0
    LDRB R2,[R10]
    MOV R2,R2,LSL #16
    ORR R9,R9,R2

    MOV R5,R5,ROR #8
    AND R10,R5,#255
    ADD R10,R10,R0
    LDRB R2,[R10]
    MOV R2,R2,LSL #24
    ORR R9,R9,R2

    STMIA R12!,{R6-R9}

    SUBS R1,R1,#1
    BNE fade_buffer_with_lookup_loop

    LDMFD SP!, {R0-R12}     ; restore all the registers from the stack
    MOV PC,R14              ; return from function


;   ****************************************************************
;       copy_16x16_tile_to_screen
;   ----------------------------------------------------------------
;       Copy a 16x16 tile to the screen or display buffer, must be
;       word aligned.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   number of the 16x16 tile in the tileset
;       R1      :   address of the tileset
;       R2      :   x coordinate to copy the tile to
;       R3      :   y coordinate to copy the tile to
;       R4      :   address of the screen or display buffer
;       R5      :   scanlines to clip from top of tile
;       R6      :   scanlines to clip from bottom of tile
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
copy_16x16_tile_to_screen:

    STMFD SP!, {R0-R12}     ; store all the registers on the stack

    MOV R7,#16*16           ; put the size of a single tile in bytes into R7
    MLA R12,R0,R7,R1        ; calculate the address of the start of the tile [source = (tile number * (16 * 16)) + address of tileset]
    MOV R7,#320             ; put the width of a scanline into R7
    MLA R11,R3,R7,R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]
    ADD R11,R11,R2          ; add x to the destination address

    CMP R5,#0
    BEQ copy_16x16_tile_to_screen_full_tile
    B copy_16x16_tile_to_screen_cropped_tile
copy_16x16_tile_to_screen_full_tile:
    CMP R6,#0
    BNE copy_16x16_tile_to_screen_cropped_tile

    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMFD SP!, {R0-R12}     ; restore all the registers from the stack
    MOV PC,R14              ; return from function

copy_16x16_tile_to_screen_cropped_tile:
    ADRL R0,copy_16x16_tile_to_screen_cropped_tile_start
    MOV R1,#16
    MLA R12,R1,R5,R12
    MOV R1,#20
    MLA R0,R1,R5,R0
    MOV PC,R0
copy_16x16_tile_to_screen_cropped_tile_start:
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R3}       ; store 16 bytes from R0-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    SUBS R6,R6,#1
    BEQ copy_16x16_tile_to_screen_exit_cropped_tile

copy_16x16_tile_to_screen_exit_cropped_tile:
    LDMFD SP!, {R0-R12}     ; restore all the registers from the stack
    MOV PC,R14              ; return from function




;   ****************************************************************
;       copy_8x8_tile_to_screen
;   ----------------------------------------------------------------
;       Copy a 8x8 tile to the screen or display buffer, must be
;       word aligned.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   number of the 8x8 tile in the tileset
;       R1      :   address of the tileset
;       R2      :   x coordinate to copy the tile to
;       R3      :   y coordinate to copy the tile to
;       R4      :   address of the screen or display buffer
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
copy_8x8_tile_to_screen:

    STMFD SP!, {R0-R12}     ; store all registers onto the stack

    MOV R5,#8*8             ; put the size of a single tile in bytes into R5
    MLA R12,R0,R5,R1        ; calculate the address of the start of the tile [source = (tile number * (8 * 8)) + address of tileset]
    MOV R5,#320             ; put the width of a scanline into R5
    MLA R11,R3,R5,R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]
    ADD R11,R11,R2          ; add x to the destination address

    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline
    STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
    ADD R11,R11,#320        ; move destination address to the next scanline

    LDMFD SP!, {R0-R12}     ; restore all registers from the stack
    MOV PC,R14              ; return from function


;   ****************************************************************
;       intro_font_lookup
;   ----------------------------------------------------------------
;       Calculate tile number from an ascii charaction for the
;       intro font tileset.
;       Returns the tile number in R0.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   ascii character to convert
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
;       R0      :   number of tile for intro font tileset
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

intro_font_lookup:

    STMFD SP!, {R1-R12}     ; store all the registers onto the stack

    ADRL R1,intro_font_lookup_table     ; load address of intro font conversion lookup table into R1
    MOV R3,#0                           ; move 0 into R3

intro_font_lookup_loop:         ; start of loop
    LDRB R2,[R1]                ; load byte from lookup table into R2
    CMP R2,R0                   ; compare with ascii character to convert
    BEQ intro_font_lookup_exit  ; if R2==R0 then exit loop
    ADD R1,R1,#1                ; increase address of lookup table by 1 byte
    ADD R3,R3,#1                ; increase tile index by 1
    B intro_font_lookup_loop    ; go back to start of loop

intro_font_lookup_exit:     ; found character in lookup table
    MOV R0,R3               ; move tile index into R0

    LDMFD SP!, {R1-R12}     ; restore all registers from the stack
    MOV PC,R14              ; return from function


;   ****************************************************************
;       draw_intro_font_text
;   ----------------------------------------------------------------
;       Draw zero terminated ascii string using intro font to the
;       screen or display buffer, assumes a scanline width of
;       320 bytes.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   ascii string to draw
;       R1      :   address of the tileset
;       R2      :   x coordinate to draw string to
;       R3      :   y coordinate to draw string to
;       R4      :   destination address of screen or display buffer
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

draw_intro_font_text:

    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

    MOV R10,R0      ; move address of ascii string into R10
    EOR R0,R0,R0    ; clear R0 to zero

draw_intro_font_text_loop:              ; start of loop
    LDRB R0,[R10]                       ; load 1 byte from ascii string into R0
    ADD R10,R10,#1                      ; increase address for ascii string by 1 byte
    CMP R0,#0                           ; check to see if we are at the end of a string
    BEQ draw_intro_font_text_exit       ; if byte is zero exit loop
    CMP R0,#0x0a                        ; check to see if we need to move down to the next line
    BEQ draw_intro_font_text_nextline   ; if byte == 0x0a goto next line section
    BL intro_font_lookup                ; lookup tile number from ascii character in string
    CMP R0,#0                           ; if tile number == 0
    BEQ draw_intro_font_text_skip_tile  ; skip this tile
    BL copy_8x8_tile_to_screen          ; draw the tile onto screen or display buffer
draw_intro_font_text_skip_tile:         ; skip tile section
    ADD R2,R2,#8                        ; move destination up by 8 bytes (width of 1 character)
    CMP R2,#320                         ; check to see if we've overflowed a line
    BLT draw_intro_font_text_loop       ; if not go back to start of loop
draw_intro_font_text_nextline:          ; next line section
    MOV R2,#0                           ; go to start of scanline
    ADD R3,R3,#8                        ; increase scanline to draw to by 8 (height of 1 character)
    B draw_intro_font_text_loop         ; go back to start of loop

draw_intro_font_text_exit:              ; exit loop

    LDMFD SP!, {R0-R12,R14}     ; restore all registers from the stack, including R14 Link registger
    MOV PC,R14                  ; exit function


;   ****************************************************************
;       draw_tile_map
;   ----------------------------------------------------------------
;       Draw 16x16 pixel tile map to screen or display buffer
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   address of tilemap to draw
;       R1      :   address of tileset to draw
;       R2      :   address of screen or display buffer
;       R3      :   x coordinate of tilemap in pixels to start from
;       R4      :   y coordinate of tilemap in pixels to start from
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

draw_tile_map:

    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

    AND R5,R4,#15       ; get scanline in tile to start from
    MOV R3,R3,LSR #4    ; divide tilemap x coordinate by 16
    MOV R4,R4,LSR #4    ; divide tilemap y coordinate by 16
    MOV R8,#128         ; move width of tilemap into R5
    MLA R7,R4,R8,R0     ; calculate top left of tilemap to draw from (source = (y * 128) + tilemap_address)
    ADD R7,R7,R3        ; add x tile to start from to tilemap source address

    MOV R4,R2
    MOV R2,#0
    MOV R3,#0
    MOV R6,#0
    STMFD SP!, {R5}
    CMP R5,#0
    BEQ draw_tile_map_loop

draw_tile_map_cropped_top_row:
    LDRB R0,[R7]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#1]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#2]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#3]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#4]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#5]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#6]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#7]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#8]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#9]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#10]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#11]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#12]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#13]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#14]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#15]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#16]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#17]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#18]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#19]
    BL copy_16x16_tile_to_screen
    MOV R2,#0
    ADD R3,R3,#16
    SUB R3,R3,R5
    ADD R7,R7,#128
    MOV R5,#0

draw_tile_map_loop:
    LDRB R0,[R7]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#1]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#2]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#3]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#4]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#5]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#6]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#7]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#8]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#9]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#10]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#11]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#12]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#13]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#14]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#15]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#16]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#17]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#18]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#19]
    BL copy_16x16_tile_to_screen
    MOV R2,#0
    ADD R3,R3,#16
    ADD R7,R7,#128
    CMP R3,#192
    BLE draw_tile_map_loop

    LDMFD SP!, {R6}
    CMP R6,#0
    BEQ draw_tile_map_exit
draw_tile_map_cropped_bottom_row:

    LDRB R0,[R7]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#1]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#2]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#3]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#4]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#5]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#6]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#7]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#8]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#9]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#10]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#11]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#12]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#13]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#14]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#15]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#16]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#17]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#18]
    BL copy_16x16_tile_to_screen
    ADD R2,R2,#16
    LDRB R0,[R7,#19]
    BL copy_16x16_tile_to_screen

draw_tile_map_exit:              ; exit loop

    LDMFD SP!, {R0-R12,R14}     ; restore all registers from the stack, including R14 Link registger
    MOV PC,R14                  ; exit function


fade_screen_to_black:

    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

    ADRL R0,palette_fade
    LDR R1,[R12,#0]
    LDR R2,[R12,#4]
    BL fade_buffer_with_lookup
    MOV R0,#80*256
    BL set_display_start

    ADRL R0,palette_fade
    LDR R1,[R12,#4]
    LDR R2,[R12,#0]
    BL fade_buffer_with_lookup
    MOV R0,#0
    BL set_display_start

    ADRL R0,palette_fade
    LDR R1,[R12,#0]
    LDR R2,[R12,#4]
    BL fade_buffer_with_lookup
    MOV R0,#80*256
    BL set_display_start

    ADRL R0,palette_fade
    LDR R1,[R12,#4]
    LDR R2,[R12,#0]
    BL fade_buffer_with_lookup
    MOV R0,#0
    BL set_display_start

    EOR R0,R0,R0
    LDR R1,[R12]
    MOV R2,#256
    BL copy_4byte_to_screen

    LDMFD SP!, {R0-R12,R14}     ; restore all registers from the stack, including R14 Link registger
    MOV PC,R14

;   ****************************************************************
;       main
;   ----------------------------------------------------------------
;       Entry point of applicataion
;   ----------------------------------------------------------------
main:

    ADRL SP,stack       ; load stack pointer with our stack address
    STMFD SP!, {R14}    ; store link register R14 onto the stack

    SWI OS_EnterOS      ; enter supervisor mode

    VDU VDU_SelectScreenMode,15,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_SelectScreenMode,13,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_MultiPurpose,1,0,0,0,0,0,0,0,0,0
    ADRL R0,vdu_variables_screen_start
    ADRL R1,vdu_variables_screen_start_buffer
    SWI OS_ReadVduVariables

    MOV R12,R1

    LDR R1,[R12,#0]
    ADD R1,R1,#320*256
    STR R1,[R12,#4]

        B main_draw_tile_map

    ADRL R0,main_title
    LDR R1,[R12]
    MOV R2,#256
    BL copy_buffer_to_screen

    SWI OS_ReadC

    BL fade_screen_to_black

    ADRL R0,intro_text_1
    ADRL R1,intro_font
    MOV R2,#0
    MOV R3,#40
    ADRL R4,intro_screen
    BL draw_intro_font_text

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
    CMP R2,#200
    BNE intro_screen_skip_1

    STMFD SP!,{R0-R4}
    ADRL R0,intro_text_1_clear
    ADRL R1,intro_font
    MOV R2,#0
    MOV R3,#40
    ADRL R4,intro_screen
    BL draw_intro_font_text
    ADRL R0,intro_text_2
    ADRL R1,intro_font
    MOV R2,#0
    MOV R3,#72
    ADRL R4,intro_screen
    BL draw_intro_font_text
    LDMFD SP!,{R0-R4}

intro_screen_skip_1:
    CMP R2,#256
    BLE intro_screen_loop

    ADRL R0,intro_text_2_clear
    ADRL R1,intro_font
    MOV R2,#0
    MOV R3,#72
    LDR R4,[R12]
    BL draw_intro_font_text

    ADRL R0,intro_text_3
    ADRL R1,intro_font
    MOV R2,#0
    MOV R3,#32
    LDR R4,[R12]
    BL draw_intro_font_text

    SWI OS_ReadC

    BL fade_screen_to_black

main_draw_tile_map:
    MOV R3,#0
    MOV R4,#0

    ADRL R0,status_bar
    LDR R1,[R12]
    MOV R2,#208
    MOV R3,#320
    MLA R1,R2,R3,R1
    MOV R2,#48
    BL copy_buffer_to_screen
main_draw_tile_map_loop:
    ADRL R0,level_1_map_tilemap
    ADRL R1,level_1_tiles
    LDR R2,[R12]

    BL draw_tile_map

    VDU 19,0,24,0,0,0,-1,-1,-1,-1

    ; ADD R3,R3,#4
    ; CMP R3,#102*16
    ; MOVEQ R3,#0
    ADD R4,R4,#1
    CMP R4,#29*16
    MOVEQ R4,#0
    ADDEQ R3,R3,#16
    CMP R3,#102*16
    BEQ main_draw_tile_map_loop

    MOV R0,#19
    SWI OS_Byte
    VDU 19,0,24,0,0,240,-1,-1,-1,-1

    B main_draw_tile_map_loop
exit:

    BL fade_screen_to_black

    TEQP  PC,#0
    MOV   R0,R0
    LDMFD SP!, {PC}


;   ****************************************************************
;       DATA section
;   ----------------------------------------------------------------
;       All data goes here, start by aligning to a 32 byte boundary
;   ----------------------------------------------------------------
.balign 32


;   ****************************************************************
;       intro_font_lookup_table
;   ----------------------------------------------------------------
;       Lookup table to convert from ascii to intro font tile set
;           c = copyright symbol
;           b = blank character symbol
;   ----------------------------------------------------------------
intro_font_lookup_table:
    .byte " 0123456789.!&cbABCDEFGHIJKLMNOPQRSTUVWXYZ"
    .byte 0x00


;   ****************************************************************
;       intro_text_1
;   ----------------------------------------------------------------
;       Introduction screen text part 1
;   ----------------------------------------------------------------
intro_text_1:
    .byte "         OCEAN SOFTWARE PRESENTS       ",0x0a
    .byte 0x0a
    .byte 0x0a
    .byte 0x0a
    .byte "              ACORN PORT BY            ",0x0a
    .byte 0x0a
    .byte "               SCOTT MOORE             ",0x0a
    .byte 0x00


;   ****************************************************************
;       intro_text_1_clear
;   ----------------------------------------------------------------
;       Introduction screen clear part 1 text
;   ----------------------------------------------------------------
intro_text_1_clear:
    .byte "         bbbbbbbbbbbbbbbbbbbbbbb       ",0x0a
    .byte 0x0a
    .byte 0x0a
    .byte 0x0a
    .byte "              bbbbbbbbbbbbb            ",0x0a
    .byte 0x0a
    .byte "               bbbbbbbbbbb             ",0x0a
    .byte 0x00


;   ****************************************************************
;       intro_text_2
;   ----------------------------------------------------------------
;       Introduction screen text part 2
;   ----------------------------------------------------------------
intro_text_2:
    .byte "                 BATMAN                ",0x0a
    .byte 0x0a
    .byte "               THE MOVIE.              ",0


;   ****************************************************************
;       intro_text_2_clear
;   ----------------------------------------------------------------
;       Introduction screen clear part 2 text
;   ----------------------------------------------------------------
intro_text_2_clear:
    .byte "                 bbbbbb                ",0x0a
    .byte 0x0a
    .byte "               bbbbbbbbbb              ",0


;   ****************************************************************
;       intro_text_3
;   ----------------------------------------------------------------
;       Introduction screen text part 3
;   ----------------------------------------------------------------
intro_text_3:
    .byte "          TM & c DC COMICS INC.         ",0x0a
    .byte "                  1989                  ",0x0a
    .byte 0x0a
    .byte "          c OCEAN SOFTWARE 1989         ",0x0a
    .byte 0x0a
    .byte "            ESC..ABORT GAME             ",0x0a
    .byte "             F1..PAUSE GAME             ",0x0a
    .byte "             F2..TOGGLE MUSIC           ",0


    .balign 32

;   ****************************************************************
;       vdu_variables_screen_start
;   ----------------------------------------------------------------
;       VDU variables lookup table, terminated by -1
;           +00   :   get display memory start address
;           +04   :   -1 to end lookup table
;   ----------------------------------------------------------------
vdu_variables_screen_start:
    .4byte 0x00000095       ; display memory start address
    .4byte 0x00000095       ; display memory start address
    .4byte 0xffffffff


    .balign 32

;   ****************************************************************
;       vdu_variables_screen_start_buffer
;   ----------------------------------------------------------------
;       VDU variables lookup table, terminated by -1
;           +00   :   start of display memory address buffer #1
;           +04   :   start of display memory address buffer #2
;           +08   :   not used
;           +12   :   not used
;   ----------------------------------------------------------------
vdu_variables_screen_start_buffer:
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte 0x00000000


;   ****************************************************************
;       Level 1 tilemap layers
;   ----------------------------------------------------------------
    .include "build/level_1_map.asm"


    .nolist

;   ****************************************************************
;       main_title
;   ----------------------------------------------------------------
;       Bitmap for main title screen
;   ----------------------------------------------------------------
main_title:
    .incbin "build/main_title.bin"


;   ****************************************************************
;       intro_screen
;   ----------------------------------------------------------------
;       Bitmap for introduction screen
;   ----------------------------------------------------------------
intro_screen:
    .incbin "build/intro_screen.bin"


;   ****************************************************************
;       status_bar
;   ----------------------------------------------------------------
;       Bitmap for status bar
;   ----------------------------------------------------------------
status_bar:
    .incbin "build/status_bar.bin"


;   ****************************************************************
;       palette_fade
;   ----------------------------------------------------------------
;       Bitmap for palette fade lookup table
;   ----------------------------------------------------------------
palette_fade:
    .incbin "build/palette_fade.bin"


;   ****************************************************************
;       intro_font
;   ----------------------------------------------------------------
;       Bitmap for introduction screen font tileset
;   ----------------------------------------------------------------
intro_font:
    .incbin "build/intro_font.bin"


;   ****************************************************************
;       level_1_tiles
;   ----------------------------------------------------------------
;       Bitmap for level 1 tileset
;   ----------------------------------------------------------------
level_1_tiles:
    .incbin "build/level-1.bin"
