;   ****************************************************************
;       debug.asm
;   ----------------------------------------------------------------
;       Copyright (c) 2021 Scott Moore, all rights reserved.
;   ****************************************************************

.macro DEBUG_REGISTERS
    .nolist
    .ifne DEBUG
        STMFD SP!,{R0-R15}
        BL debug_update_register_text
        LDMFD SP!,{R0-R12}
        ADD SP,SP,#12
    .endif
    .list
.endm

.macro DEBUG_MEMORY source
    ; .nolist
    .ifne DEBUG
        STMFD SP!,{R12}
        .if \source==0
            MOV R12,R0
        .endif
        .if \source==-1
            MOV R12,R1
        .endif
        .if \source==-2
            MOV R12,R2
        .endif
        .if \source==-3
            MOV R12,R3
        .endif
        .if \source==-4
            MOV R12,R4
        .endif
        .if \source==-5
            MOV R12,R5
        .endif
        .if \source==-6
            MOV R12,R6
        .endif
        .if \source==-7
            MOV R12,R7
        .endif
        .if \source==-8
            MOV R12,R8
        .endif
        .if \source==-9
            MOV R12,R9
        .endif
        .if \source==-10
            MOV R12,R10
        .endif
        .if \source==-11
            MOV R12,R11
        .endif
        .if \source==-12
            MOV R12,R12
        .endif
        .if \source==-13
            MOV R12,R13
        .endif
        .if \source==-14
            MOV R12,R14
        .endif
        .if \source==-15
            MOV R12,R15
        .endif
        .if \source>0
            ADRL R12,\source
        .endif
        BL debug_update_memory_text
        LDMFD SP!,{R12}
    .endif
    .list
.endm

.macro  DRAW_DEBUG
    .nolist
    .ifne DEBUG
        STMFD SP!,{R0-R3,R9,R11,R12}
        MOV R9,#draw_system_font_sprite & 0xffff0000
        MOV R0,#draw_system_font_sprite & 0x0000ffff
        ORR R9,R9,R0
        ADRL R0,debug_registers_text
        MOV R1,#24
        MOV R2,#8
        ADRL R10,system_font_lookup_table
        LDR R11,[R12]
        MOV R12,R9
        MOV R3,#0
        BL draw_font_string
        SUB R1,R1,#1
        SUB R2,R2,#1
        MOV R3,#119 << 8
        BL draw_font_string
        ADRL R0,debug_memory_text
        MOV R1,#24
        MOV R2,#88
        MOV R3,#0
        BL draw_font_string
        SUB R1,R1,#1
        SUB R2,R2,#1
        MOV R3,#119 << 8
        BL draw_font_string
        LDMFD SP!,{R0-R3,R9,R11,R12}
    .endif
    .list
.endm

    .ifne DEBUG
        debug_convert_register_to_hex:
            STMFD SP!,{R0-R3}

            MOV R3,#0x0000000f
            AND R2,R3,R0,LSR #28
            CMP R2,#10
            ADDLT R2,R2,#48 
            ADDGE R2,R2,#65 - 10
            STRB R2,[R1,#0]
            AND R2,R3,R0,LSR #24
            CMP R2,#10
            ADDLT R2,R2,#48 
            ADDGE R2,R2,#65 - 10
            STRB R2,[R1,#1]
            AND R2,R3,R0,LSR #20
            CMP R2,#10
            ADDLT R2,R2,#48 
            ADDGE R2,R2,#65 - 10
            STRB R2,[R1,#2]
            AND R2,R3,R0,LSR #16
            CMP R2,#10
            ADDLT R2,R2,#48 
            ADDGE R2,R2,#65 - 10
            STRB R2,[R1,#3]
            AND R2,R3,R0,LSR #12
            CMP R2,#10
            ADDLT R2,R2,#48 
            ADDGE R2,R2,#65 - 10
            STRB R2,[R1,#4]
            AND R2,R3,R0,LSR #8
            CMP R2,#10
            ADDLT R2,R2,#48 
            ADDGE R2,R2,#65 - 10
            STRB R2,[R1,#5]
            AND R2,R3,R0,LSR #4
            CMP R2,#10
            ADDLT R2,R2,#48 
            ADDGE R2,R2,#65 - 10
            STRB R2,[R1,#6]
            AND R2,R3,R0
            CMP R2,#10
            ADDLT R2,R2,#48 
            ADDGE R2,R2,#65 - 10
            STRB R2,[R1,#7]

        debug_convert_register_to_hex_exit:

            LDMFD SP!,{R0-R3}
            MOV PC,R14


        debug_update_register_text:
            MOV R12,R14

            LDR R0,[SP,#0 * 4]
            ADRL R1,debug_registers_R0_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#1 * 4]
            ADRL R1,debug_registers_R1_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#2 * 4]
            ADRL R1,debug_registers_R2_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#3 * 4]
            ADRL R1,debug_registers_R3_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#4 * 4]
            ADRL R1,debug_registers_R4_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#5 * 4]
            ADRL R1,debug_registers_R5_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#6 * 4]
            ADRL R1,debug_registers_R6_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#7 * 4]
            ADRL R1,debug_registers_R7_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#8 * 4]
            ADRL R1,debug_registers_R8_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#9 * 4]
            ADRL R1,debug_registers_R9_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#10 * 4]
            ADRL R1,debug_registers_R10_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#11 * 4]
            ADRL R1,debug_registers_R11_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#12 * 4]
            ADRL R1,debug_registers_R12_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#13 * 4]
            ADRL R1,debug_registers_R13_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#14 * 4]
            ADRL R1,debug_registers_R14_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#15 * 4]
            SUB R0,R0,#16
            ADRL R1,debug_registers_R15_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#15 * 4]
            AND R0,R0,#0b00000011111111111111111111111100
            SUB R0,R0,#16
            ADRL R1,debug_registers_PC_text
            BL debug_convert_register_to_hex
            LDR R0,[SP,#15 * 4]
            ADRL R1,debug_registers_Status_text

            TST R0,#1 << 31
            MOVNE R2,#78
            MOVEQ R2,#110
            STRB R2,[R1,#0]
            TST R0,#1 << 30
            MOVNE R2,#90
            MOVEQ R2,#122
            STRB R2,[R1,#1]
            TST R0,#1 << 29
            MOVNE R2,#67
            MOVEQ R2,#99
            STRB R2,[R1,#2]
            TST R0,#1 << 28
            MOVNE R2,#86
            MOVEQ R2,#118
            STRB R2,[R1,#3]
            TST R0,#1 << 27
            MOVNE R2,#73
            MOVEQ R2,#105
            STRB R2,[R1,#4]
            TST R0,#1 << 26
            MOVNE R2,#70
            MOVEQ R2,#102
            STRB R2,[R1,#5]

        debug_update_register_text_exit:

            MOV PC,R12

        debug_update_memory_text:
            STMFD SP!,{R0-R3,R11,R14}

            MOV R0,R12
            ADRL R1,debug_memory_address_00_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#0]
            ADRL R1,debug_memory_contents_00_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#4]
            ADRL R1,debug_memory_contents_04_text
            BL debug_convert_register_to_hex

            MOV R1,#0
            ADRL R11,debug_memory_contents_0004_text
        .0000:
            LDRB R0,[R12,R1]
            CMP R0,#32
            MOVLT R0,#46
            CMP R0,#127
            MOVGE R0,#46
            STRB R0,[R11,R1]
            ADD R1,R1,#1
            CMP R1,#8
            BNE .0000

            ADD R12,R12,#8
            MOV R0,R12
            ADRL R1,debug_memory_address_08_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#0]
            ADRL R1,debug_memory_contents_08_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#4]
            ADRL R1,debug_memory_contents_0d_text
            BL debug_convert_register_to_hex
            

            MOV R1,#0
            ADRL R11,debug_memory_contents_080d_text
        .0001:
            LDRB R0,[R12,R1]
            CMP R0,#32
            MOVLT R0,#46
            CMP R0,#127
            MOVGE R0,#46
            STRB R0,[R11,R1]
            ADD R1,R1,#1
            CMP R1,#8
            BNE .0001

            ADD R12,R12,#8
            MOV R0,R12
            ADRL R1,debug_memory_address_10_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#0]
            ADRL R1,debug_memory_contents_10_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#4]
            ADRL R1,debug_memory_contents_14_text
            BL debug_convert_register_to_hex
            
            MOV R1,#0
            ADRL R11,debug_memory_contents_1014_text
        .0002:
            LDRB R0,[R12,R1]
            CMP R0,#32
            MOVLT R0,#46
            CMP R0,#127
            MOVGE R0,#46
            STRB R0,[R11,R1]
            ADD R1,R1,#1
            CMP R1,#8
            BNE .0002

            ADD R12,R12,#8
            MOV R0,R12
            ADRL R1,debug_memory_address_18_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#0]
            ADRL R1,debug_memory_contents_18_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#4]
            ADRL R1,debug_memory_contents_1d_text
            BL debug_convert_register_to_hex
            
            MOV R1,#0
            ADRL R11,debug_memory_contents_181d_text
        .0003:
            LDRB R0,[R12,R1]
            CMP R0,#32
            MOVLT R0,#46
            CMP R0,#127
            MOVGE R0,#46
            STRB R0,[R11,R1]
            ADD R1,R1,#1
            CMP R1,#8
            BNE .0003

            ADD R12,R12,#8
            MOV R0,R12
            ADRL R1,debug_memory_address_20_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#0]
            ADRL R1,debug_memory_contents_20_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#4]
            ADRL R1,debug_memory_contents_24_text
            BL debug_convert_register_to_hex
            
            MOV R1,#0
            ADRL R11,debug_memory_contents_2024_text
        .0004:
            LDRB R0,[R12,R1]
            CMP R0,#32
            MOVLT R0,#46
            CMP R0,#127
            MOVGE R0,#46
            STRB R0,[R11,R1]
            ADD R1,R1,#1
            CMP R1,#8
            BNE .0004

            ADD R12,R12,#8
            MOV R0,R12
            ADRL R1,debug_memory_address_28_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#0]
            ADRL R1,debug_memory_contents_28_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#4]
            ADRL R1,debug_memory_contents_2d_text
            BL debug_convert_register_to_hex
            
            MOV R1,#0
            ADRL R11,debug_memory_contents_282d_text
        .0005:
            LDRB R0,[R12,R1]
            CMP R0,#32
            MOVLT R0,#46
            CMP R0,#127
            MOVGE R0,#46
            STRB R0,[R11,R1]
            ADD R1,R1,#1
            CMP R1,#8
            BNE .0005

            ADD R12,R12,#8
            MOV R0,R12
            ADRL R1,debug_memory_address_30_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#0]
            ADRL R1,debug_memory_contents_30_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#4]
            ADRL R1,debug_memory_contents_34_text
            BL debug_convert_register_to_hex
            

            MOV R1,#0
            ADRL R11,debug_memory_contents_3034_text
        .0006:
            LDRB R0,[R12,R1]
            CMP R0,#32
            MOVLT R0,#46
            CMP R0,#127
            MOVGE R0,#46
            STRB R0,[R11,R1]
            ADD R1,R1,#1
            CMP R1,#8
            BNE .0006

            ADD R12,R12,#8
            MOV R0,R12
            ADRL R1,debug_memory_address_38_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#0]
            ADRL R1,debug_memory_contents_38_text
            BL debug_convert_register_to_hex
            LDR R0,[R12,#4]
            ADRL R1,debug_memory_contents_3d_text
            BL debug_convert_register_to_hex
            
            MOV R1,#0
            ADRL R11,debug_memory_contents_383d_text
        .0007:
            LDRB R0,[R12,R1]
            CMP R0,#32
            MOVLT R0,#46
            CMP R0,#127
            MOVGE R0,#46
            STRB R0,[R11,R1]
            ADD R1,R1,#1
            CMP R1,#8
            BNE .0007

        debug_update_memory_text_exit:
            LDMFD SP!,{R0-R3,R11,R14}
            MOV PC,R14


        ;   ****************************************************************
        ;       debug_registers_text
        ;   ----------------------------------------------------------------
        ;       Debug registers text
        ;   ----------------------------------------------------------------

            .align 4
        debug_registers_text:
            .byte "R0 :"
        debug_registers_R0_text:
            .byte "00000000",0x20
            .byte "R1 :"
        debug_registers_R1_text:
            .byte "00000000",0x0a
            .byte "R2 :"
        debug_registers_R2_text:
            .byte "00000000",0x20
            .byte "R3 :"
        debug_registers_R3_text:
            .byte "00000000",0x0a
            .byte "R4 :"
        debug_registers_R4_text:
            .byte "00000000",0x20
            .byte "R5 :"
        debug_registers_R5_text:
            .byte "00000000",0x0a
            .byte "R6 :"
        debug_registers_R6_text:
            .byte "00000000",0x20
            .byte "R7 :"
        debug_registers_R7_text:
            .byte "00000000",0x0a
            .byte "R8 :"
        debug_registers_R8_text:
            .byte "00000000",0x20
            .byte "R9 :"
        debug_registers_R9_text:
            .byte "00000000",0x0a
            .byte "R10:"
        debug_registers_R10_text:
            .byte "00000000",0x20
            .byte "R11:"
        debug_registers_R11_text:
            .byte "00000000",0x0a
            .byte "R12:"
        debug_registers_R12_text:
            .byte "00000000",0x20
            .byte "R13:"
        debug_registers_R13_text:
            .byte "00000000",0x0a
            .byte "R14:"
        debug_registers_R14_text:
            .byte "00000000",0x20
            .byte "R15:"
        debug_registers_R15_text:
            .byte "00000000",0x0a
            .byte "PC :"
        debug_registers_PC_text:
            .byte "00000000",0x20
            .byte "SR :"
        debug_registers_Status_text:
            .byte "NZCVIF",0x20
            .byte 0
            
        ;   ****************************************************************
        ;       debug_memory_text
        ;   ----------------------------------------------------------------
        ;       Debug memory text
        ;   ----------------------------------------------------------------

            .align 4
        debug_memory_text:
        debug_memory_address_00_text:
            .byte "00000000",0x20
        debug_memory_contents_00_text:
            .byte "00000000:"
        debug_memory_contents_04_text:
            .byte "00000000",0x20
        debug_memory_contents_0004_text:
            .byte "........",0x0a
        debug_memory_address_08_text:
            .byte "00000008",0x20
        debug_memory_contents_08_text:
            .byte "00000000:"
        debug_memory_contents_0d_text:
            .byte "00000000",0x20
        debug_memory_contents_080d_text:
            .byte "........",0x0a
        debug_memory_address_10_text:
            .byte "00000010",0x20
        debug_memory_contents_10_text:
            .byte "00000000:"
        debug_memory_contents_14_text:
            .byte "00000000",0x20
        debug_memory_contents_1014_text:
            .byte "........",0x0a
        debug_memory_address_18_text:
            .byte "00000018",0x20
        debug_memory_contents_18_text:
            .byte "00000000:"
        debug_memory_contents_1d_text:
            .byte "00000000",0x20
        debug_memory_contents_181d_text:
            .byte "........",0x0a
        debug_memory_address_20_text:
            .byte "00000020",0x20
        debug_memory_contents_20_text:
            .byte "00000000:"
        debug_memory_contents_24_text:
            .byte "00000000",0x20
        debug_memory_contents_2024_text:
            .byte "........",0x0a
        debug_memory_address_28_text:
            .byte "00000028",0x20
        debug_memory_contents_28_text:
            .byte "00000000:"
        debug_memory_contents_2d_text:
            .byte "00000000",0x20
        debug_memory_contents_282d_text:
            .byte "........",0x0a
        debug_memory_address_30_text:
            .byte "00000030",0x20
        debug_memory_contents_30_text:
            .byte "00000000:"
        debug_memory_contents_34_text:
            .byte "00000000",0x20
        debug_memory_contents_3034_text:
            .byte "........",0x0a
        debug_memory_address_38_text:
            .byte "00000038",0x20
        debug_memory_contents_38_text:
            .byte "00000000:"
        debug_memory_contents_3d_text:
            .byte "00000000",0x20
        debug_memory_contents_383d_text:
            .byte "........",0x0a
            .byte 0

            .align 4
    .endif