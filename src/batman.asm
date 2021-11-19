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
;       Reserve 256 bytes for our stack
;   ----------------------------------------------------------------
    .space 256
stack:


;   ****************************************************************
;       Include external source files
;   ****************************************************************

.include "swi.asm"
.include "vdu.asm"
.include "macros.asm"
.include "debug.asm"

.include "memc.asm"
.include "vidc.asm"

.include "tiles.asm"
.include "sprites.asm"

.set    SCANLINE,   352

swap_display_buffers:
    STMFD SP!, {R0-R2,R14}

    ADRL R2,vdu_variables_buffer
    LDR R0,[R2,#0]
    LDR R1,[R2,#4]
    STR R1,[R2,#0]
    STR R0,[R2,#4]
    ADRL R2,memc_address_screen_start
    LDR R0,[R2,#0]
    LDR R1,[R2,#4]
    STR R1,[R2,#0]
    STR R0,[R2,#4]
    MOV R0,R1

    BL memc_set_display_start

    LDMFD SP!, {R0-R2,PC}

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

    STMFD SP!, {R0-R12,R14}     ; store all the registers onto the stack

    MOV R11,R1      ; move destination address into R11
    MOV R10,R2      ; move number of scanlines into R10
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
    STMIA R11!,{R0-R9}          ; move the 4 bytes into 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes into 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes into 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes into 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes into 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes into 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes into 40 bytes of the destination
    STMIA R11!,{R0-R9}          ; move the 4 bytes into 40 bytes of the destination
    STMIA R11!,{R0-R7}          ; move the 4 bytes into 32 bytes of the destination
    SUBS R10,R10,#1             ; decrease number of scanlines to copy by 1
    BNE copy_4byte_to_screen_loop   ; if the number of scanlines left to copy is not zero, branch back to start of loop

    LDMFD SP!, {R0-R12,PC}     ; restore all the registers from the stack


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

    STMFD SP!, {R0-R12,R14}     ; store all the registers onto the stack

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
    ADD R11,R11,#SCANLINE-320
    SUBS R10,R10,#1             ; decrease number of scanlines to copy by 1
    BNE copy_buffer_to_screen_loop      ; if number of scanlines left to copy is not zero branch back to start of loop

    LDMFD SP!, {R0-R12,PC}     ; restore all the registers from the stack


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

    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

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

    LDMFD SP!, {R0-R12,PC}     ; restore all the registers from the stack


; copy_8x8_tile_to_screen:

;     STMFD SP!, {R0-R12}     ; store all registers onto the stack

;     MOV R5,#8*8             ; put the size of a single tile in bytes into R5
;     MLA R12,R0,R5,R1        ; calculate the address of the start of the tile [source = (tile number * (8 * 8)) + address of tileset]
;     MOV R5,#SCANLINE             ; put the width of a scanline into R5
;     MLA R11,R3,R5,R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]
;     ADD R11,R11,R2          ; add x to the destination address

;     LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
;     STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
;     ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
;     STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
;     ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
;     LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
;     STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
;     ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
;     STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
;     ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
;     LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
;     STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
;     ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
;     STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
;     ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
;     LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
;     STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
;     ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
;     STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
;     ADD R11,R11,#SCANLINE        ; move destination address to the next scanline

;     LDMFD SP!, {R0-R12}     ; restore all registers from the stack
;     MOV PC,R14              ; return from function


;   ****************************************************************
;       font_lookup
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
;       R10     :   address of conversion lookup table
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

font_lookup:

    STMFD SP!, {R2-R3,R14}     ; store all the registers onto the stack

    ; ADRL R1,font_lookup_table     ; load address of intro font conversion lookup table into R1
    MOV R3,#0                           ; move 0 into R3

font_lookup_loop:         ; start of loop
    LDRB R2,[R10,R3]                ; load byte from lookup table into R2
    CMP R2,R0                   ; compare with ascii character to convert
    BEQ font_lookup_exit  ; if R2==R0 then exit loop
    ADD R3,R3,#1                ; increase tile index by 1
    B font_lookup_loop    ; go back to start of loop

font_lookup_exit:     ; found character in lookup table
    MOV R0,R3               ; move tile index into R0

    LDMFD SP!, {R2-R3,PC}     ; restore all registers from the stack


;   ****************************************************************
;       draw_font_text
;   ----------------------------------------------------------------
;       Draw zero terminated ascii string using intro font to the
;       screen or display buffer, assumes a scanline width of
;       320 bytes.
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   ascii string to draw
;       R1      :   x coordinate to draw string to
;       R2      :   y coordinate to draw string to
;       R3      :   N/A
;       R4      :   N/A
;       R5      :   N/A
;       R6      :   N/A
;       R7      :   N/A
;       R8      :   N/A
;       R9      :   N/A
;       R10     :   address of conversion lookup table
;       R11     :   destination address of screen or display buffer
;       R12     :   draw character function pointer
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
;       R12     :   Unchanged
;   ****************************************************************

draw_font_string:

    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

    MOV R9,R1       ; keep orignal x-coordinate
    MOV R8,R0      ; move address of ascii string into R11

draw_font_string_loop:                ; start of loop
    LDRB R0,[R8]                           ; load 1 byte from ascii string into R0
    ADD R8,R8,#1                          ; increase address for ascii string by 1 byte
    CMP R0,#0                               ; check to see if we are at the end of a string
    BEQ draw_font_string_exit         ; if byte is zero exit loop
    CMP R0,#0x0a                            ; check to see if we need to move down to the next line
    BEQ draw_font_string_nextline     ; if byte == 0x0a goto next line section
    BL font_lookup                    ; lookup tile number from ascii character in string
    CMP R0,#0                               ; if tile number == 0
    ADDNE R14,PC,#0
    MOVNE PC,R12
    ADD R1,R1,#8                            ; move destination up by 8 bytes (width of 1 character)
    CMP R1,#CLIP_RIGHT                        ; check to see if we've overflowed a line
    BLE draw_font_string_loop         ; if not go back to start of loop
draw_font_string_nextline:            ; next line section
    MOV R1,R9                               ; go to start of scanline
    ADD R2,R2,#8                            ; increase scanline to draw to by 8 (height of 1 character)
    B draw_font_string_loop           ; go back to start of loop

draw_font_string_exit:                ; exit loop

    LDMFD SP!, {R0-R12,PC}     ; restore all registers from the stack


;   ****************************************************************
;       lookup_tilemap_tile
;   ----------------------------------------------------------------
;       Lookup tile at world x/y
;   ----------------------------------------------------------------
;       Parameters
;   ----------------------------------------------------------------
;       R0      :   address of tilemap to lookup
;       R1      :   N/A
;       R2      :   N/A
;       R3      :   world x coordinate of tilemap to lookup tile at
;       R4      :   world y coordinate of tilemap to lookup tile at
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
;       R1      :   Tile number at world x/y
;       R2      :   Address of tile at world x/y
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

lookup_tilemap_tile:
    STMFD SP!, {R3-R4,R14}     ; store all registers onto the stack

    MOV R3,R3,LSR #4
    MOV R4,R4,LSR #4
    CMP R3,#0
    BLT lookup_tilemap_tile_exit
    CMP R3,#256
    BGE lookup_tilemap_tile_exit
    CMP R4,#0
    BLT lookup_tilemap_tile_exit
    CMP R4,#256
    BGE lookup_tilemap_tile_exit
    ADD R2,R0,R3
    ADD R2,R2,R4,LSL #8
    LDRB R1,[R2]

lookup_tilemap_tile_exit:
    LDMFD SP!, {R3-R4,PC}     ; store all registers onto the stack


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

    AND R5,R3,#0b1111   ; get pixel in tile to start from
    AND R6,R4,#0b1111   ; get scanline in tile to start from
    MOV R3,R3,ASR #4    ; divide tilemap x coordinate by 16
    MOV R4,R4,ASR #4    ; divide tilemap y coordinate by 16
    ADD R10,R0,R4,ASL #8    ; calculate top left of tilemap to draw from (source = (y * 256) + tilemap_address)

    MOV R8,R3           ; put tilemap start x-coordinate into R8
    MOV R9,R4           ; put tilemap start y-coordinate into R9

    MOV R4,R2
    MOV R7,#0
    SUB R2,R7,R5
    ADD R2,R2,#16
    SUB R3,R7,R6

draw_tile_map_y_loop:
    MOV R7,#21
draw_tile_map_x_loop:
    LDRB R0,[R10,R8]
    BL draw_16x16_tile
    ADD R2,R2,#16
    ADD R8,R8,#1
    AND R8,R8,#255
    SUBS R7,R7,#1
    BNE draw_tile_map_x_loop
    SUB R2,R2,#21 * 16
    ADD R3,R3,#16
    SUB R8,R8,#21
    AND R8,R8,#255
    ADD R9,R9,#1
    ADD R10,R10,#256
    CMP R9,#48
    SUBEQ R9,R9,#48
    SUBEQ R10,R10,#48*256
    CMP R3,#CLIP_BOTTOM 
    BLT draw_tile_map_y_loop

draw_tile_map_exit:              ; exit loop

    LDMFD SP!, {R0-R12,PC}     ; restore all registers from the stack


fade_screen_to_black:

    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

    ADRL R0,palette_fade
    LDR R1,[R12,#0]
    LDR R2,[R12,#4]
    BL fade_buffer_with_lookup
    BL swap_display_buffers
    
    ADRL R0,palette_fade
    LDR R1,[R12,#0]
    LDR R2,[R12,#4]
    BL fade_buffer_with_lookup
    BL swap_display_buffers

    ADRL R0,palette_fade
    LDR R1,[R12,#0]
    LDR R2,[R12,#4]
    BL fade_buffer_with_lookup
    BL swap_display_buffers

    ADRL R0,palette_fade
    LDR R1,[R12,#0]
    LDR R2,[R12,#4]
    BL fade_buffer_with_lookup
    BL swap_display_buffers

    EOR R0,R0,R0
    LDR R1,[R12,#4]
    MOV R2,#232
    BL copy_4byte_to_screen
    BL swap_display_buffers

    LDMFD SP!, {R0-R12,PC}     ; restore all registers from the stack


clear_edges:
    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

    LDR R11,[R12]

    MOV R0,#0
    MOV R1,R0
    MOV R2,R0
    MOV R3,R0
    MOV R4,R0
    MOV R5,R0
    MOV R6,R0
    MOV R7,R0
    MOV R9,#11

    STMIA R11,{R0-R3}
    ADD R11,R11,#SCANLINE - 16

clear_edges_loop:
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    SUBS R9,R9,#1
    BNE clear_edges_loop
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}
    
clear_edges_exit:
    LDMFD SP!, {R0-R12,PC}     ; restore all registers from the stack, and load saved R14 link registger into PC


;   ****************************************************************
;       initialise
;   ----------------------------------------------------------------
;       Initialise hardware and game state
;   ----------------------------------------------------------------
initialise:
    STMFD SP!,{R0-R12,R14}

    VDU VDU_SelectScreenMode,15,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_SelectScreenMode,13,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_MultiPurpose,1,0,0,0,0,0,0,0,0,0                ; hide the disaply cursor
    ADRL R0,vdu_variables_screen_start                      ; load address of OS_ReadVduVariables input block into R0
    ADRL R1,vdu_variables_buffer                            ; load address of OS_ReadVduVariables output block into R1
    SWI OS_ReadVduVariables                                 ; Call OS_ReadVduVariables SWI

    LDR R0,[R1,#0]
    ADD R0,R0,#SCANLINE
    STR R0,[R1,#0]
    ADD R0,R0,#SCANLINE*233
    STR R0,[R1,#4]

initialise_exit:
    LDMFD SP!,{R0-R12,PC}     ; restore all registers from the stack, and load saved R14 link registger into PC


;   ****************************************************************
;       draw_title_screen
;   ----------------------------------------------------------------
;       Draw title screen, then wait for a key
;   ----------------------------------------------------------------
draw_title_screen:
    STMFD SP!,{R0-R12,R14}

    ADRL R12,vdu_variables_buffer    ; load address of vdu_variables_buffer into R12
    
    MOV R0,#16                      ; OS_File 16 : Load named file without path
    ADRL R1,main_title_filename     ; load address of filename string into R1
    LDR R2,[R12,#0]                 ; load address of display start from vdu_variables_buffer
    MOV R3,#0                       ; set R3 to 0 to use load address in R2

    SWI OS_File                     ; load file
    SWI OS_ReadC                    ; wait for keypress

draw_title_screen_exit:
    LDMFD SP!,{R0-R12,PC}


;   ****************************************************************
;       draw_intro_screen
;   ----------------------------------------------------------------
;       Scroll intro screen onto display and show intro text,
;       wait for a key
;   ----------------------------------------------------------------
draw_intro_screen:
    STMFD SP!,{R0-R12,R14}

    ADRL R12,vdu_variables_buffer

    MOV R0,#16                      ; OS_File 16 : Load named file without path
    ADRL R1,intro_screen_filename   ; load address of filename string into R1
    LDR R2,[R12,#0]                 ; load address of display start from vdu_variables_buffer
    MOV R3,#0                       ; set R3 to 0 to use load address in R2

    SWI OS_File                     ; load file
    SWI OS_ReadC                    ; wait for keypress

    ;   TODO
    ;   Scroll intro screen onto display and draw intro text as it scrolls up

draw_intro_screen_exit:
    LDMFD SP!,{R0-R12,PC}     ; restore all registers from the stack, and load saved R14 link registger into PC


clear_display_buffers:
    STMFD SP!,{R0-R12,R14}

    ADRL R12,vdu_variables_buffer

    MOV R0,#0
    LDR R1,[R12,#0]                 
    MOV R2,#232
    BL copy_4byte_to_screen
    MOV R0,#0
    LDR R1,[R12,#4]                 
    MOV R2,#232
    BL copy_4byte_to_screen

clear_display_buffers_exit:
    LDMFD SP!,{R0-R12,PC}     ; restore all registers from the stack, and load saved R14 link registger into PC


;   ****************************************************************
;       setup_custom_display_mode_352x256
;   ----------------------------------------------------------------
;       Setup our custom VIDC display mode (352x256)
;   ----------------------------------------------------------------
setup_custom_display_mode_352x256:
    STMFD SP!,{R0-R12,R14}

    MOV R1,#45
    BL vidc_set_HDSR
    MOV R1,#221
    BL vidc_set_HDER

setup_custom_display_mode_352x256_exit:
    LDMFD SP!,{R0-R12,PC}     ; restore all registers from the stack, and load saved R14 link registger into PC


;   ****************************************************************
;       setup_custom_display_mode_352x216
;   ----------------------------------------------------------------
;       Setup our custom VIDC display mode (352x216)
;   ----------------------------------------------------------------
setup_custom_display_mode_352x216:
    STMFD SP!,{R0-R12,R14}

    MOV R1,#45
    BL vidc_set_HDSR
    MOV R1,#221
    BL vidc_set_HDER
    MOV R1,#55
    BL vidc_set_VDSR
    MOV R1,#271
    BL vidc_set_VDER

setup_custom_display_mode_352x216_exit:
    LDMFD SP!,{R0-R12,PC}     ; restore all registers from the stack, and load saved R14 link registger into PC


;   ****************************************************************
;       update_game_loop_key_state
;   ----------------------------------------------------------------
;       Update values of game loop key state variables
;   ----------------------------------------------------------------
update_game_loop_key_state:
    STMFD SP!,{R0-R12,R14}

    MVL R12,game_loop_key_state

    MOV R0,#129
    MOV R1,#game_loop_key_up
    MOV R2,#255
    SWI OS_Byte
    STR R2,[R12,#game_loop_key_state_up_offset]

    MOV R0,#129
    MOV R1,#game_loop_key_down
    MOV R2,#255
    SWI OS_Byte
    STR R2,[R12,#game_loop_key_state_down_offset]

    MOV R0,#129
    MOV R1,#game_loop_key_left
    MOV R2,#255
    SWI OS_Byte
    STR R2,[R12,#game_loop_key_state_left_offset]

    MOV R0,#129
    MOV R1,#game_loop_key_right
    MOV R2,#255
    SWI OS_Byte
    STR R2,[R12,#game_loop_key_state_right_offset]

    MOV R0,#129
    MOV R1,#game_loop_key_fire
    MOV R2,#255
    SWI OS_Byte
    STR R2,[R12,#game_loop_key_state_fire_offset]

    MOV R0,#129
    MOV R1,#game_loop_key_quit
    MOV R2,#255
    SWI OS_Byte
    STR R2,[R12,#game_loop_key_state_quit_offset]

update_game_loop_key_state_exit:
    LDMFD SP!,{R0-R12,PC}     ; restore all registers from the stack, and load saved R14 link registger into PC


;   ****************************************************************
;       main
;   ----------------------------------------------------------------
;       Entry point of applicataion
;   ----------------------------------------------------------------
main:

    ADRL SP,stack            ; load stack pointer with our stack address
    STMFD SP!, {R14}        ; store link register R14 onto the stack
    SWI OS_EnterOS          ; enter supervisor mode

    BL initialise
    BL setup_custom_display_mode_352x256
    BL draw_title_screen
    BL draw_intro_screen
    BL setup_custom_display_mode_352x216
    BL clear_display_buffers

    ADRL R12,vdu_variables_buffer

    ADRL R0,status_bar
    LDR R1,[R12]
    ADD R1,R1,#16
    MOV R2,#CLIP_BOTTOM
    MOV R3,#SCANLINE
    MLA R1,R2,R3,R1
    MOV R2,#53
    BL copy_buffer_to_screen
    ADD R1,R1,#SCANLINE*233
    BL copy_buffer_to_screen

    SPRITE sprite_00,draw_batman_sprite,0,4*16,3*16,32,48,0,48
    SPRITE sprite_28,draw_batman_sprite,1*16,6*16,4*16,32,48,0,48
    SPRITE sprite_29,draw_batman_sprite,2*16,8*16,5*16,32,48,0,48
    SPRITE sprite_30,draw_batman_sprite,3*16,10*16,6*16,32,48,0,48
    SPRITE sprite_31,draw_pointers_sprite,0,160,160,11,11,-16,0

    MOV R3,#0
    MOV R4,#0

main_draw_tile_map_loop:

    .ifne DEBUG
        MOV R1,#0b111100000000
        BL vidc_set_border_colour
    .endif

    LDR R0,[R12,#8] ; level_1_map_types / level_1_map_tilemap
    ADRL R1,level_1_tiles
    LDR R2,[R12]

    BL draw_tile_map
    LDR R11,[R12]
    BL draw_sprites

    STMFD SP!,{R0-R2}

    MOV R0,#129
    MOV R1,#-114
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_F1_Key
    ADRL R0,level_1_map_tilemap
    STR R0,[R12,#8]
No_F1_Key:
    MOV R0,#129
    MOV R1,#-115
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_F2_Key
    ADRL R0,level_1_map_types
    STR R0,[R12,#8]
No_F2_Key:
    MOV R0,#129
    MOV R1,#-117
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_F5_Key
    DEBUG_STEP_ON
No_F5_Key:
    MOV R0,#129
    MOV R1,#-118
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_F6_Key
    DEBUG_STEP_OFF
No_F6_Key:

    MOV R0,#129
    MOV R1,#-98
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_Z_Key
    SUB R3,R3,#1
    CMP R3,#0
    MOVLE R3,#0
No_Z_Key:
    MOV R0,#129
    MOV R1,#-67
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_X_Key
    ADD R3,R3,#1
    CMP R3,#256*16
    SUBGE R3,R3,#256*16
No_X_Key:
    MOV R0,#129
    MOV R1,#-87
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_L_Key
    ADD R4,R4,#1
    CMP R4,#48*16
    SUBGE R4,R4,#48*16
No_L_Key:
    MOV R0,#129
    MOV R1,#-56
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_P_Key
    SUB R4,R4,#1
    CMP R4,#0
    MOVLE R4,#0
No_P_Key:
    ADRL R0,sprite_world_offset
    STR R3,[R0,#0]
    STR R4,[R0,#4]
    ; STR R3,sprite_world_offset_x
    ; STR R4,sprite_world_offset_y

    BL update_game_loop_key_state

    MVL R2,game_loop_key_state
    LDR R1,[R2,#game_loop_key_state_up_offset]
    CMP R1,#255
    BNE No_Up_Pressed
    ;   TODO
No_Up_Pressed:
    LDR R1,[R2,#game_loop_key_state_down_offset]
    CMP R1,#255
    BNE No_Down_Pressed
    LDR R0,batman_blocked
    TST R0,#0b00000100
    BEQ No_Down_Pressed
    ADRL R1,sprite_00
    LDR R0,[R1,#sprite_y]
    ADD R0,R0,#1
    STR R0,[R1,#sprite_y]
No_Down_Pressed:
    LDR R1,[R2,#game_loop_key_state_left_offset]
    CMP R1,#255
    BNE No_Left_Pressed
    LDR R0,batman_blocked
    TST R0,#0b10000001
    BNE No_Right_Pressed
    ADRL R1,sprite_00
    LDR R0,[R1,#sprite_x]
    SUB R0,R0,#1
    STR R0,[R1,#sprite_x]
    LDR R0,[R1,#sprite_attributes]
    ORR R0,R0,#1<<31
    STR R0,[R1,#sprite_attributes]
    LDR R0,[R1,#sprite_frame]
    ADD R0,R0,#4
    CMP R0,#8 * 16
    SUBGE R0,R0,#8 * 16
    STR R0,[R1,#sprite_frame]
    B No_Right_Pressed
No_Left_Pressed:
    LDR R1,[R2,#game_loop_key_state_right_offset]
    CMP R1,#255
    BNE No_Right_Pressed
    LDR R0,batman_blocked
    TST R0,#0b10000010
    BNE No_Right_Pressed
    ADRL R1,sprite_00
    LDR R0,[R1,#sprite_x]
    ADD R0,R0,#1
    STR R0,[R1,#sprite_x]
    LDR R0,[R1,#sprite_attributes]
    ORR R0,R0,#1<<31
    EOR R0,R0,#1<<31
    STR R0,[R1,#sprite_attributes]
    LDR R0,[R1,#sprite_frame]
    ADD R0,R0,#4
    CMP R0,#8 * 16
    SUBGE R0,R0,#8 * 16
    STR R0,[R1,#sprite_frame]
No_Right_Pressed:
    LDR R1,[R2,#game_loop_key_state_fire_offset]
    CMP R1,#255
    BNE No_Fire_Pressed
    LDR R1,bat_bullet_debounce
    CMP R1,#0
    BNE Fire_Debounce
    MOV R1,#-1
    STR R1,bat_bullet_debounce
    ADRL R1,sprite_00
    LDR R0,[R1,#sprite_x]
    LDR R2,[R1,#sprite_y]
    LDR R8,[R1,#sprite_attributes]
    TST R8,#1 << 31
    MOVEQ R7,#2
    MOVNE R7,#-2
    LDR R8,bat_bullet_index
    MOV R8,R8,LSL #4
    ADRL R1,bat_bullet_0_x
    ADD R0,R0,#13
    ADD R0,R0,R7,ASL #2
    SUB R2,R2,#27
    STR R0,[R1,R8]
    ADD R8,R8,#4
    STR R2,[R1,R8]
    ADD R8,R8,#4
    STR R7,[R1,R8]
    ADD R8,R8,#4
    MOV R0,#0
    STR R0,[R1,R8]
    LDR R8,bat_bullet_index
    ADD R8,R8,#1
    AND R8,R8,#0b111
    STR R8,bat_bullet_index
    B Fire_Debounce
No_Fire_Pressed:
    MOV R1,#0
    STR R1,bat_bullet_debounce
Fire_Debounce:

    LDMFD SP!,{R0-R2}

    MVL R0,game_loop_key_state
    LDR R1,[R0,#game_loop_key_state_quit_offset]
    CMP R1,#255
    BEQ main_exit

    STMFD SP!, {R0-R8}
    
    SWI OS_Mouse
    LDR R4,monotonic_time
    STR R3,monotonic_time
    SUB R3,R3,R4
    STR R3,monotonic_time_delta

    ADRL R3,sprite_world_offset
    LDR R4,[R3,#0]
    LDR R5,[R3,#4]
    MOV R2,R2,LSL #2
    STR R2,sprite_31_frame
    MOV R2,R0,LSR #2
    MOV R3,R1,LSR #2
    EOR R3,R3,#0b11111111
    ADD R2,R2,R4
    ADD R3,R3,R5
    STR R2,sprite_31_x
    STR R3,sprite_31_y

    ADRL R0,level_1_map_types
    ADRL R10,sprite_00
    LDR R3,[R10,#sprite_x]
    LDR R4,[R10,#sprite_y]
    LDR R7,[R10,#sprite_width]
    LDR R8,[R10,#sprite_frame]
    MOV R5,#0b00000000
    .ifne SPRITE_DEBUG
        LDR R6,[R10,#sprite_attributes]
        AND R6,R6,#0xffffff00
    .endif
    BL lookup_tilemap_tile
    CMP R1,#0x60
    ORREQ R5,R5,#0b10000000
    MOVEQ R8,#0
    .ifne SPRITE_DEBUG
        ORREQ R6,R6,#116
    .endif
    CMP R1,#0x6e
    ORREQ R5,R5,#0b00000100
    .ifne SPRITE_DEBUG
        ORREQ R6,R6,#100
    .endif
    ADD R4,R4,#1
    BL lookup_tilemap_tile
    CMP R1,#0x60
    ORREQ R5,R5,#0b10000000
    MOVEQ R8,#0
    .ifne SPRITE_DEBUG
        ORREQ R6,R6,#116
    .endif
    CMP R1,#0x6d
    BNE batman_cant_drop
    ORR R5,R5,#0b00000100
    SUB R4,R4,#2
    BL lookup_tilemap_tile
    CMP R1,#0x6d
    ORREQ R5,R5,#0b10000000
    MOVEQ R8,#0
    .ifne SPRITE_DEBUG
        ORREQ R6,R6,#116
    .endif

batman_cant_drop:
    SUB R3,R3,R7,LSR #2
    SUB R4,R4,#22
    BL lookup_tilemap_tile
    CMP R1,#0x6f
    ORREQ R5,R5,#0b00000001
    ORREQ R6,R6,#20
    MOVEQ R8,#0
    ADD R3,R3,R7,LSR #1
    BL lookup_tilemap_tile
    CMP R1,#0x6f
    ORREQ R5,R5,#0b00000010
    MOVEQ R8,#0
    .ifne SPRITE_DEBUG
        ORREQ R6,R6,#20
    .endif

    LDR R4,[R10,#sprite_y]
    TST R5,#0b10000000
    ADDNE R4,R4,#1
    ANDNE R5,R5,#0b11111011
    STR R4,[R10,#sprite_y]
    STR R5,batman_blocked
    .ifne SPRITE_DEBUG
        STR R6,[R10,#sprite_attributes]
    .endif
    STR R8,[R10,#sprite_frame]
    
    .ifne DEBUG
        MOV R1,#0b000011111111
        BL vidc_set_border_colour
    .endif

    .ifne DEBUG
        MOV R1,#0b111100001111
        BL vidc_set_border_colour
    .endif

    BL clear_edges

    .ifne DEBUG
        MOV R1,#0b000011110000
        BL vidc_set_border_colour
    .endif

    ADRL R0,level_1_map_types
    ADRL R9,bat_bullets
    MOV R8,#0
    ADRL R6,draw_bat_bullet_sprite
    ADRL R10,sprite_01

update_bat_bullets_loop:
    LDMIA R9,{R3-R6}
    DEBUG_MEMORY -10
    CMP R3,#-1
    BEQ disable_bat_bullet
    ADD R3,R3,R5
    ADD R4,R4,R6
    MVL R2,draw_bat_bullet_sprite
    STR R2,[R10,#sprite_function]
    STR R3,[R10,#sprite_x]
    STR R4,[R10,#sprite_y]
    SUB R3,R3,#12
    BL lookup_tilemap_tile
    ADD R3,R3,#12
    CMP R1,#0xf0
    CMPNE R1,#0xfe
    MOVNE R3,#-1
    LDR R2,[R10,#sprite_frame]
    CMP R5,#0
    ADDGT R2,R2,#2
    SUBLT R2,R2,#2
    AND R2,R2,#0b1111111
    STR R2,[R10,#sprite_frame]
    MOV R2,#9
    STR R2,[R10,#sprite_width]
    MOV R2,#9
    STR R2,[R10,#sprite_height]
    DEBUG_REGISTERS
    BAL update_bat_bullets_next

disable_bat_bullet:
    MOV R2,#0
    STR R6,[R10,#sprite_function]
    
update_bat_bullets_next:
    ADD R10,R10,#40
    STMIA R9!,{R3-R6}
    ADD R8,R8,#1
    CMP R8,#8
    BNE update_bat_bullets_loop

    LDR R11,[R12]
    LDR R0,frame_count
    ADD R0,R0,#1
    STR R0,frame_count

    LDMFD SP!, {R0-R8}

    ADRL R0,level_1_map_types
    ADRL R10,sprite_00
    LDR R1,[R10,#sprite_x]
    LDR R2,[R10,#sprite_y]
    SUB R1,R1,R3
    SUB R2,R2,R4
    CMP R1,#96
    SUBLT R3,R3,#1
    CMP R3,#0
    MOVLT R3,#0
    CMP R1,#224
    ADDGE R3,R3,#1
    CMP R2,#80
    SUBLT R4,R4,#1
    CMP R4,#0
    MOVLT R4,#0
    CMP R2,#144
    ADDGE R4,R4,#1

    DRAW_DEBUG

    MOV R0,#19
    SWI OS_Byte

    BL swap_display_buffers

    ; DEBUG_STEP

    B main_draw_tile_map_loop

main_exit:
    VDU VDU_SelectScreenMode,13,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours)
    TEQP  PC,#0                                             ; switch cpu back to user mode
    MOV   R0,R0                                             ; nop

    LDMFD SP!, {PC}                                         ; load PC from stack

frame_count:
    .4byte  0

batman_blocked:
    .4byte  0

bat_bullet_index:
    .4byte  0
bat_bullet_debounce:
    .4byte  0
bat_bullets:
    bat_bullet_0_x:    .4byte  -1
    bat_bullet_0_y:    .4byte  -1
    bat_bullet_0_xd:   .4byte  0
    bat_bullet_0_xy:   .4byte  0
    bat_bullet_1_x:    .4byte  -1
    bat_bullet_1_y:    .4byte  -1
    bat_bullet_1_xd:   .4byte  0
    bat_bullet_1_xy:   .4byte  0
    bat_bullet_2_x:    .4byte  -1
    bat_bullet_2_y:    .4byte  -1
    bat_bullet_2_xd:   .4byte  0
    bat_bullet_2_xy:   .4byte  0
    bat_bullet_3_x:    .4byte  -1
    bat_bullet_3_y:    .4byte  -1
    bat_bullet_3_xd:   .4byte  0
    bat_bullet_3_xy:   .4byte  0
    bat_bullet_4_x:    .4byte  -1
    bat_bullet_4_y:    .4byte  -1
    bat_bullet_4_xd:   .4byte  0
    bat_bullet_4_xy:   .4byte  0
    bat_bullet_5_x:    .4byte  -1
    bat_bullet_5_y:    .4byte  -1
    bat_bullet_5_xd:   .4byte  0
    bat_bullet_5_xy:   .4byte  0
    bat_bullet_6_x:    .4byte  -1
    bat_bullet_6_y:    .4byte  -1
    bat_bullet_6_xd:   .4byte  0
    bat_bullet_6_xy:   .4byte  0
    bat_bullet_7_x:    .4byte  -1
    bat_bullet_7_y:    .4byte  -1
    bat_bullet_7_xd:   .4byte  0
    bat_bullet_7_xy:   .4byte  0
monotonic_time:
    .4byte 0

monotonic_time_delta:
    .4byte 0

; pointer_mask:
;     .4byte 0x0000ff00

.set batman_frame, sprite_00_frame
.set batman_x,  sprite_00_x
.set batman_y,  sprite_00_y
.set batman_attributes, sprite_00_attributes

;   ****************************************************************
;       DATA section
;   ----------------------------------------------------------------
;       All data goes here, start by aligning to a 16 byte boundary
;   ----------------------------------------------------------------

;   ****************************************************************
;       game_loop_key_state
;   ----------------------------------------------------------------
;       Game loop key state variables
;   ----------------------------------------------------------------
    .align 4
game_loop_key_state:
game_loop_key_state_left:      .4byte  0
game_loop_key_state_right:     .4byte  0
game_loop_key_state_up:        .4byte  0
game_loop_key_state_down:      .4byte  0
game_loop_key_state_fire:      .4byte  0
game_loop_key_state_quit:      .4byte  0

    .set game_loop_key_state_left_offset,      game_loop_key_state_left - game_loop_key_state
    .set game_loop_key_state_right_offset,     game_loop_key_state_right - game_loop_key_state
    .set game_loop_key_state_up_offset,        game_loop_key_state_up - game_loop_key_state
    .set game_loop_key_state_down_offset,      game_loop_key_state_down - game_loop_key_state
    .set game_loop_key_state_fire_offset,      game_loop_key_state_fire - game_loop_key_state
    .set game_loop_key_state_quit_offset,      game_loop_key_state_quit - game_loop_key_state

    .set game_loop_key_left,    -26
    .set game_loop_key_right,   -122
    .set game_loop_key_up,      -58
    .set game_loop_key_down,    -42
    .set game_loop_key_fire,    -99
    .set game_loop_key_quit,    -113
    

;   ****************************************************************
;       intro_font_lookup_table
;   ----------------------------------------------------------------
;       Lookup table to convert from ascii to intro font tile set
;           c = copyright symbol
;           b = blank character symbol
;   ----------------------------------------------------------------
    .align 4
intro_font_lookup_table:
    .byte " 0123456789.!&c,ABCDEFGHIJKLMNOPQRSTUVWXYZ",0

;   ****************************************************************
;       system_font_lookup_table
;   ----------------------------------------------------------------
;       Lookup table to convert from ascii to system font tile set
;   ----------------------------------------------------------------
    .align 4
system_font_lookup_table:
    .byte " !\"#$%&'()*+,-./0123456789:;<>=?ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    .byte "[]\\`_@abcdefghijklmnopqrstuvwxyz{}|",126,169,"£",0

    .align 4
font_test_string:
    .byte "THIS IS A TEST STRING!!!!",0xa,"0x12345678",0xa,"$89ABCDEF",0

;   ****************************************************************
;       draw_intro_screen_text_1
;   ----------------------------------------------------------------
;       Introduction screen text part 1
;   ----------------------------------------------------------------
    .align 4
draw_intro_screen_text_1:
    .byte "         OCEAN SOFTWARE PRESENTS       ",0x0a
    .byte 0x0a
    .byte 0x0a
    .byte 0x0a
    .byte "              ACORN PORT BY            ",0x0a
    .byte 0x0a
    .byte "               SCOTT MOORE             ",0x0a
    .byte 0x00


;   ****************************************************************
;       draw_intro_screen_text_2
;   ----------------------------------------------------------------
;       Introduction screen text part 2
;   ----------------------------------------------------------------
    .align 4
draw_intro_screen_text_2:
    .byte "                 BATMAN                ",0x0a
    .byte 0x0a
    .byte "               THE MOVIE.              ",0


;   ****************************************************************
;       draw_intro_screen_text_3
;   ----------------------------------------------------------------
;       Introduction screen text part 3
;   ----------------------------------------------------------------
    .align 4
draw_intro_screen_text_3:
    .byte "          TM & c DC COMICS INC.         ",0x0a
    .byte "                  1989                  ",0x0a
    .byte 0x0a
    .byte "          c OCEAN SOFTWARE 1989         ",0x0a
    .byte 0x0a
    .byte "            ESC..ABORT GAME             ",0x0a
    .byte "             F1..PAUSE GAME             ",0x0a
    .byte "             F2..TOGGLE MUSIC           ",0


;   ****************************************************************
;       vdu_variables_screen_start
;   ----------------------------------------------------------------
;       VDU variables lookup table, terminated by -1
;           +00   :   get display memory start address
;           +04   :   -1 to end lookup table
;   ----------------------------------------------------------------
    .align 4
vdu_variables_screen_start:
    .4byte 0x00000095       ; display memory start address
    .4byte 0x00000095       ; display memory start address
    .4byte 0xffffffff

;   ****************************************************************
;       vdu_variables_buffer
;   ----------------------------------------------------------------
;       VDU variables lookup table, terminated by -1
;           +00   :   start of display memory address buffer #1
;           +04   :   start of display memory address buffer #2
;   ----------------------------------------------------------------
vdu_variables_buffer:
    .4byte 0x00000000
    .4byte 0x00000000
    .4byte level_1_map_tilemap
    .4byte level_1_map_types
memc_address_screen_start:
    .4byte (SCANLINE * 234) >> 2
    .4byte SCANLINE >> 2

    .nolist

;   ****************************************************************
;       Level 1 tilemap layers
;   ----------------------------------------------------------------
    .include "build/level_1_map.asm"


;   ****************************************************************
;       status_bar
;   ----------------------------------------------------------------
;       Bitmap for status bar
;   ----------------------------------------------------------------
    .align 4
status_bar:
    .incbin "build/status_bar.bin"


;   ****************************************************************
;       main_title_filename
;   ----------------------------------------------------------------
;       filename for bitmap for main title screen
;   ----------------------------------------------------------------
    .align 4
main_title_filename:
    .byte "<Batman$Dir>.MainTitle",0


;   ****************************************************************
;       intro_screen_filename
;   ----------------------------------------------------------------
;       Bitmap for introduction screen
;   ----------------------------------------------------------------
    .align 4
intro_screen_filename:
    .byte "<Batman$Dir>.IntroScreen",0
    

;   ****************************************************************
;       palette_fade
;   ----------------------------------------------------------------
;       Bitmap for palette fade lookup table
;   ----------------------------------------------------------------
    .align 4
palette_fade:
    .incbin "build/palette_fade.bin"


;   ****************************************************************
;       level_1_tiles
;   ----------------------------------------------------------------
;       Bitmap for level 1 tileset
;   ----------------------------------------------------------------
    .align 4
level_1_tiles:
    .incbin "build/level-1.bin"


;   ****************************************************************
;       compiled sprite files
;   ----------------------------------------------------------------
;       Include the compiled sprite files and other LUTs
;   ----------------------------------------------------------------
    .include "build/sprites/batman.asm"
    .include "build/sprites/explosion.asm"
    .include "build/sprites/enemies.asm"
    .include "build/sprites/bullets.asm"
    .include "build/sprites/bat_bullet.asm"
    .include "build/sprites/pointers.asm"
    .include "build/fonts/intro_font.asm"
    .include "build/fonts/system_font.asm"
    .include "build/fonts/system_bold_font.asm"
    .include "build/sincos.asm"
