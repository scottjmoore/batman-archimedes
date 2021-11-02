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

.include "memc.asm"
.include "vidc.asm"
.include "tiles.asm"

.set    SCANLINE,   352

swap_display_buffers:
    STMFD SP!, {R0-R2,R14}

    ADRL R2,vdu_variables_screen_start_buffer
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

    LDMFD SP!, {R0-R2,R14}
    MOV PC,R14

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
    ADD R11,R11,#SCANLINE-320
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

copy_8x8_tile_to_screen:

    STMFD SP!, {R0-R12}     ; store all registers onto the stack

    MOV R5,#8*8             ; put the size of a single tile in bytes into R5
    MLA R12,R0,R5,R1        ; calculate the address of the start of the tile [source = (tile number * (8 * 8)) + address of tileset]
    MOV R5,#SCANLINE             ; put the width of a scanline into R5
    MLA R11,R3,R5,R4        ; calculate the address of the destination [destination = (y * 320) + address of screen or buffer]
    ADD R11,R11,R2          ; add x to the destination address

    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
    ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
    STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
    ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
    ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
    STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
    ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
    ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
    STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
    ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
    LDMIA R12!,{R0-R3}      ; load 16 bytes from the soure address into R0-R3
    STMIA R11,{R0-R1}       ; store first 8 bytes from R0-R1 to the destination address with incrementing it
    ADD R11,R11,#SCANLINE        ; move destination address to the next scanline
    STMIA R11,{R2-R3}       ; store second 8 bytes from R2-R3 to the destination address with incrementing it
    ADD R11,R11,#SCANLINE        ; move destination address to the next scanline

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

    STMFD SP!, {R1-R3}     ; store all the registers onto the stack

    ADRL R1,intro_font_lookup_table     ; load address of intro font conversion lookup table into R1
    MOV R3,#0                           ; move 0 into R3

intro_font_lookup_loop:         ; start of loop
    LDRB R2,[R1,R3]                ; load byte from lookup table into R2
    CMP R2,R0                   ; compare with ascii character to convert
    BEQ intro_font_lookup_exit  ; if R2==R0 then exit loop
    ADD R3,R3,#1                ; increase tile index by 1
    B intro_font_lookup_loop    ; go back to start of loop

intro_font_lookup_exit:     ; found character in lookup table
    MOV R0,R3               ; move tile index into R0

    LDMFD SP!, {R1-R3}     ; restore all registers from the stack
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
;       R1      :   x coordinate to draw string to
;       R2      :   y coordinate to draw string to
;       R3      :   N/A
;       R4      :   N/A
;       R5      :   N/A
;       R6      :   N/A
;       R7      :   N/A
;       R8      :   N/A
;       R9      :   N/A
;       R10     :   N/A
;       R11     :   N/A
;       R11     :   destination address of screen or display buffer 
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

draw_intro_font_string:

    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

    MOV R10,R0      ; move address of ascii string into R10
    MOV R9,R1       ; keep orignal x-coordinate

draw_intro_font_string_loop:                ; start of loop
    LDRB R0,[R10]                           ; load 1 byte from ascii string into R0
    ADD R10,R10,#1                          ; increase address for ascii string by 1 byte
    CMP R0,#0                               ; check to see if we are at the end of a string
    BEQ draw_intro_font_string_exit         ; if byte is zero exit loop
    CMP R0,#0x0a                            ; check to see if we need to move down to the next line
    BEQ draw_intro_font_string_nextline     ; if byte == 0x0a goto next line section
    BL intro_font_lookup                    ; lookup tile number from ascii character in string
    CMP R0,#0                               ; if tile number == 0
    BLNE draw_intro_font_sprite             ; draw the tile onto screen or display buffer
    ADD R1,R1,#8                            ; move destination up by 8 bytes (width of 1 character)
    CMP R1,#SCANLINE                        ; check to see if we've overflowed a line
    BLT draw_intro_font_string_loop         ; if not go back to start of loop
draw_intro_font_string_nextline:            ; next line section
    MOV R1,R9                               ; go to start of scanline
    ADD R2,R2,#8                            ; increase scanline to draw to by 8 (height of 1 character)
    B draw_intro_font_string_loop           ; go back to start of loop

draw_intro_font_string_exit:                ; exit loop

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

    AND R5,R3,#0b1111   ; get pixel in tile to start from
    AND R6,R4,#0b1111   ; get scanline in tile to start from
    MOV R3,R3,LSR #4    ; divide tilemap x coordinate by 16
    MOV R4,R4,LSR #4    ; divide tilemap y coordinate by 16
    MOV R7,#256         ; move width of tilemap into R5
    MLA R10,R4,R7,R0    ; calculate top left of tilemap to draw from (source = (y * 128) + tilemap_address)
    ADD R10,R10,R3      ; add x tile to start from to tilemap source address

    MOV R4,R2
    MOV R7,#0
    SUB R2,R7,R5
    ADD R2,R2,#16
    SUB R3,R7,R6

draw_tile_map_loop:
    LDRB R0,[R10]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#1]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#2]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#3]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#4]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#5]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#6]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#7]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#8]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#9]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#10]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#11]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#12]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#13]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#14]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#15]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#16]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#17]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#18]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#19]
    BL draw_16x16_tile
    ADD R2,R2,#16
    LDRB R0,[R10,#20]
    BL draw_16x16_tile
    SUB R2,R2,#20 * 16
    ADD R3,R3,#16
    ADD R10,R10,#256
    CMP R3,#CLIP_BOTTOM
    BLT draw_tile_map_loop

draw_tile_map_exit:              ; exit loop

    LDMFD SP!, {R0-R12,R14}     ; restore all registers from the stack, including R14 Link registger
    MOV PC,R14                  ; exit function


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

    LDMFD SP!, {R0-R12,R14}     ; restore all registers from the stack, including R14 Link registger
    MOV PC,R14

clear_edges:
    STMFD SP!, {R0-R12,R14}     ; store all registers onto the stack

    LDR R11,[R12]

    EOR R0,R0,R0
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
    ADD R11,R11,#SCANLINE
    STMIA R11,{R0-R7}

clear_edges_exit:
    LDMFD SP!, {R0-R12,R14}     ; restore all registers from the stack, including R14 Link registger
    MOV PC,R14

;   ****************************************************************
;       main
;   ----------------------------------------------------------------
;       Entry point of applicataion
;   ----------------------------------------------------------------
main:

    ADRL SP,stack           ; load stack pointer with our stack address
    STMFD SP!, {R14}        ; store link register R14 onto the stack

    SWI OS_EnterOS          ; enter supervisor mode

    VDU VDU_SelectScreenMode,15,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_SelectScreenMode,13,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000
    VDU VDU_MultiPurpose,1,0,0,0,0,0,0,0,0,0
    ADRL R0,vdu_variables_screen_start
    ADRL R1,vdu_variables_screen_start_buffer
    SWI OS_ReadVduVariables

    MOV R12,R1

    LDR R1,[R12,#0]
    ADD R1,R1,#SCANLINE
    STR R1,[R12,#0]
    ADD R1,R1,#SCANLINE*233
    STR R1,[R12,#4]

    MOV R1,#45
    BL vidc_set_HDSR
    MOV R1,#221
    BL vidc_set_HDER

    ADRL R0,main_title
    LDR R1,[R12]
    ADD R1,R1,#16
    MOV R2,#256
    BL copy_buffer_to_screen

    SWI OS_ReadC

    MOV R0,#0
    LDR R1,[R12]
    MOV R2,#256
    BL copy_4byte_to_screen
    BL swap_display_buffers    
    BL copy_4byte_to_screen
    BL swap_display_buffers    

    MOV R1,#47
    BL vidc_set_VDSR
    MOV R1,#279
    BL vidc_set_VDER

        B main_draw_tile_map

    ADRL R0,intro_screen
    MOV R2,#1
    MOV R3,#231
    MOV R4,#SCANLINE
    MUL R5,R3,R4
intro_screen_loop:
    LDR R1,[R12]
    MOV R11,R1
    ADD R1,R1,#16
    ADD R1,R1,R5
    BL copy_buffer_to_screen
    STMFD SP!, {R0-R2}
    CMP R2,#231
    BGT intro_text_2_skip
    ADRL R0,intro_text_2
intro_text_2_skip:
    CMP R2,#168
    BGT intro_text_1_skip
    ADRL R0,intro_text_1
intro_text_1_skip:
    MOV R1,#16
    MOV R2,#64
    MOV R3,#0xff00
    BL draw_intro_font_string
    MOV R0,#19
    SWI OS_Byte
    LDMFD SP!, {R0-R2}
    BL swap_display_buffers
    SUB R5,R5,#SCANLINE
    ADD R2,R2,#1
    CMP R2,#232
    BLE intro_screen_loop
    ADRL R0,intro_text_3
    MOV R1,#16
    MOV R2,#64
    MOV R3,#0xff00
    BL draw_intro_font_string

    SWI OS_ReadC

    MOV R0,#0
    LDR R1,[R12]
    MOV R2,#232
    BL copy_4byte_to_screen
    BL swap_display_buffers    
    BL copy_4byte_to_screen

    ; BL fade_screen_to_black

main_draw_tile_map:

    MOV R3,#0
    MOV R4,#0

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

main_draw_tile_map_loop:

    STMFD SP!, {R0,R1}
    MOV R1,#15 << 8
    BL vidc_set_border_colour
    LDMFD SP!, {R0,R1}

    ADRL R0,level_1_map_tilemap
    ADRL R1,level_1_tiles
    LDR R2,[R12]

    BL draw_tile_map

    STMFD SP!,{R0-R2}
    MOV R0,#129
    MOV R1,#-98
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_Z_Key
    SUB R3,R3,#1
    CMP R3,#0
    ADDLT R3,R3,#128*16
No_Z_Key:
    MOV R0,#129
    MOV R1,#-67
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_X_Key
    ADD R3,R3,#1
    CMP R3,#256*16
    MOVEQ R3,#0
No_X_Key:
    MOV R0,#129
    MOV R1,#-87
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_L_Key
    ADD R4,R4,#1
    CMP R4,#48*16
    MOVEQ R4,#0
No_L_Key:
    MOV R0,#129
    MOV R1,#-56
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_P_Key
    SUB R4,R4,#1
    CMP R4,#0
    ADDLT R4,R4,#64*16
No_P_Key:
    MOV R0,#129
    MOV R1,#-58
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_CursorUp_Key
    LDR R0,batman_y
    SUB R0,R0,#1
    STR R0,batman_y
No_CursorUp_Key:
    MOV R0,#129
    MOV R1,#-42
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_CursorDown_Key
    LDR R0,batman_y
    ADD R0,R0,#1
    STR R0,batman_y
No_CursorDown_Key:
    MOV R0,#129
    MOV R1,#-26
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_CursorLeft_Key
    LDR R0,batman_x
    SUB R0,R0,#1
    STR R0,batman_x
No_CursorLeft_Key:
    MOV R0,#129
    MOV R1,#-122
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BNE No_CursorRight_Key
    LDR R0,batman_x
    ADD R0,R0,#1
    STR R0,batman_x
    LDR R0,batman_frame
    ADD R0,R0,#1
    CMP R0,#28
    MOVEQ R0,#0
    STR R0,batman_frame
No_CursorRight_Key:
    MOV R0,#129
    MOV R1,#-113
    MOV R2,#255
    SWI OS_Byte
    CMP R2,#255
    BEQ exit

    LDMFD SP!,{R0-R2}

    STMFD SP!, {R0-R8}
    
    SWI OS_Mouse

    MOV R2,R0,LSR #2
    MOV R3,R1,LSR #2
    EOR R3,R3,#0b11111111
    STR R2,mouse_x
    STR R3,mouse_y

    STMFD SP!,{R0-R1}
    MOV R1,#0b000011111111
    BL vidc_set_border_colour
    LDMFD SP!,{R0-R1}

    STMFD SP!, {R0,R1,R11}
    LDR R11,[R12]
    LDR R0,batman_frame
    MOV R0,R0,LSR #2
    LDR R1,batman_x
    LDR R2,batman_y


    MOV R3,#0x00ff
    BL draw_batman_sprite
    SUB R1,R1,#12
    SUB R2,R2,#12
    MOV R3,#0xf800
    BL draw_batman_sprite
    SUB R1,R1,#12
    SUB R2,R2,#12
    MOV R3,#0xff00
    BL draw_batman_sprite
    SUB R1,R1,#12
    SUB R2,R2,#12
    MOV R3,#0xff03
    BL draw_batman_sprite
    SUB R1,R1,#12
    SUB R2,R2,#12
    MOV R3,#0xff10              ; 0x10 = pinkish ; 0x20 = greenish ; 0x40 = vivid greenish ; 0x80 = blueish
    BL draw_batman_sprite
    SUB R1,R1,#12
    SUB R2,R2,#12
    MOV R3,#0xff40              ; 0x10 = pinkish ; 0x20 = greenish ; 0x40 = vivid greenish ; 0x80 = blueish
    BL draw_batman_sprite
    SUB R1,R1,#12
    SUB R2,R2,#12
    MOV R3,#0xff80              ; 0x10 = pinkish ; 0x20 = greenish ; 0x40 = vivid greenish ; 0x80 = blueish
    BL draw_batman_sprite
    SUB R1,R1,#12
    SUB R2,R2,#12
    MOV R3,#0xffff              ; 0x10 = pinkish ; 0x20 = greenish ; 0x40 = vivid greenish ; 0x80 = blueish
    BL draw_batman_sprite

    MOV R0,#0
    LDR R1,mouse_x
    LDR R2,mouse_y
    MOV R3,#0xff00
    SUB R2,R2,#24
    BL draw_enemies_sprite
    ADD R0,R0,#1
    ADD R1,R1,#32
    BL draw_enemies_sprite
    ADD R0,R0,#1
    ADD R1,R1,#32
    BL draw_enemies_sprite
    ADD R0,R0,#1
    ADD R1,R1,#32
    BL draw_enemies_sprite

    MOV R0,#0
    ADD R1,R1,#32
    ADD R2,R2,#21
    LDR R4,frame_count
    AND R4,R4,#7
    ADD R1,R1,R4
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite
    ADD R1,R1,#8
    BL draw_bullets_sprite

    MOV R4,#0
    MOV R6,#0
    ADR R7,explosion_frame
    ADR R8,explosion_x
    ADR R9,explosion_y
    ADR R10,explosion_yd
    LDR R11,[R12]

animate_explosion_loop:
    LDR R0,[R7,R6,LSL #2]
    LDR R1,[R8,R6,LSL #2]
    LDR R2,[R9,R6,LSL #2]
    LDR R3,[R10,R6,LSL #2]
    ADD R0,R0,#1
    CMP R0,#80
    MOVEQ R0,#0
    ADD R2,R2,R3,ASR #16
    CMP R2,#CLIP_BOTTOM - 24
    ADDLT R3,R3,#1 << 13
    ADDGE R3,R3,R3,ASR #1
    SUBGE R3,R4,R3,ASR #1
    MOVGE R2,#CLIP_BOTTOM - 24
    STR R0,[R7,R6,LSL #2]
    STR R2,[R9,R6,LSL #2]
    STR R3,[R10,R6,LSL #2]
    MOV R0,R0,LSR #3
    MOV R3,#0xff00
    BL draw_explosion_sprite
    ADD R6,R6,#1
    CMP R6,#11
    BNE animate_explosion_loop

    MOV R1,#0b111100001111
    BL vidc_set_border_colour

    BL clear_edges

    MOV R1,#0b000011110000
    BL vidc_set_border_colour

    LDMFD SP!, {R0,R1,R11}
    LDMFD SP!, {R0-R8}

    LDR R11,[R12]
    LDR R0,frame_count
    ADD R0,R0,#1
    STR R0,frame_count

    MOV R0,#19
    SWI OS_Byte

    BL swap_display_buffers

    B main_draw_tile_map_loop
exit:

    BL fade_screen_to_black
    VDU VDU_SelectScreenMode,13,-1,-1,-1,-1,-1,-1,-1,-1     ; change to mode 13 (320x256 256 colours) for A3000

    TEQP  PC,#0
    MOV   R0,R0

    LDMFD SP!, {PC}

frame_count:
    .4byte  0

mouse_x:
    .4byte  0

mouse_y:
    .4byte  0

batman_x:
    .4byte  140
batman_y:
    .4byte  104

batman_frame:
    .4byte 0

intro_font_angle:
    .4byte 0

explosion_x:
    .4byte  (32 * 0)
    .4byte  (32 * 1)
    .4byte  (32 * 2)
    .4byte  (32 * 3)
    .4byte  (32 * 4)
    .4byte  (32 * 5)
    .4byte  (32 * 6)
    .4byte  (32 * 7)
    .4byte  (32 * 8)
    .4byte  (32 * 9)
    .4byte  (32 * 10)
explosion_y:
    .4byte  -32 - (8 * 0)
    .4byte  -32 - (8 * 1)
    .4byte  -32 - (8 * 2)
    .4byte  -32 - (8 * 3)
    .4byte  -32 - (8 * 4)
    .4byte  -32 - (8 * 5)
    .4byte  -32 - (8 * 6)
    .4byte  -32 - (8 * 7)
    .4byte  -32 - (8 * 8)
    .4byte  -32 - (8 * 9)
    .4byte  -32 - (8 * 10)

explosion_yd:
    .4byte  0
    .4byte  0
    .4byte  0
    .4byte  0
    .4byte  0
    .4byte  0
    .4byte  0
    .4byte  0
    .4byte  0
    .4byte  0
    .4byte  0

explosion_frame:
    .4byte 0 << 2
    .4byte 1 << 2
    .4byte 2 << 2
    .4byte 3 << 2
    .4byte 4 << 2
    .4byte 5 << 2
    .4byte 6 << 2
    .4byte 7 << 2
    .4byte 0 << 2
    .4byte 1 << 2
    .4byte 2 << 2

;   ****************************************************************
;       DATA section
;   ----------------------------------------------------------------
;       All data goes here, start by aligning to a 16 byte boundary
;   ----------------------------------------------------------------
    

;   ****************************************************************
;       intro_font_lookup_table
;   ----------------------------------------------------------------
;       Lookup table to convert from ascii to intro font tile set
;           c = copyright symbol
;           b = blank character symbol
;   ----------------------------------------------------------------
    .align 4
intro_font_lookup_table:
    .byte " 0123456789.!&c,ABCDEFGHIJKLMNOPQRSTUVWXYZ"
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
;       intro_text_2
;   ----------------------------------------------------------------
;       Introduction screen text part 2
;   ----------------------------------------------------------------
intro_text_2:
    .byte "                 BATMAN                ",0x0a
    .byte 0x0a
    .byte "               THE MOVIE.              ",0


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
;       vdu_variables_screen_start_buffer
;   ----------------------------------------------------------------
;       VDU variables lookup table, terminated by -1
;           +00   :   start of display memory address buffer #1
;           +04   :   start of display memory address buffer #2
;   ----------------------------------------------------------------
vdu_variables_screen_start_buffer:
    .4byte 0x00000000
    .4byte 0x00000000

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
;       main_title
;   ----------------------------------------------------------------
;       Bitmap for main title screen
;   ----------------------------------------------------------------
    .align 4
main_title:
    .incbin "build/main_title.bin"


;   ****************************************************************
;       intro_screen
;   ----------------------------------------------------------------
;       Bitmap for introduction screen
;   ----------------------------------------------------------------
    .align 4
intro_screen:
    .incbin "build/intro_screen.bin"


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

    .include "build/batman_sprites.asm"
    .include "build/explosion.asm"
    .include "build/enemies.asm"
    .include "build/bullets.asm"
    .include "build/intro_font.asm"

    .include "build/sincos.asm"

