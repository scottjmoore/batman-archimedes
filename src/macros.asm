.ifndef __MACROS_ASM
    .set    __MACROS_ASM,    -1

    ; BFL macro to branch to a fixed 32 bit address with linked return
    .macro BFL r, a
        MOV \r, #\a
        ADD R14, PC, #0
        MOV PC, \r
    .endm

    ; BF macro to branch to a fixed 32 bit address
    .macro BF r, a
        MOV \r, #\a
        MOV PC, \r
    .endm

    .macro BRL r
        ADD R14, PC, #0
        MOV PC, \r
    .endm    

    .macro BR r
        MOV PC, \r
    .endm    

    .macro BRLNE r
        ADDNE R14, PC, #0
        MOVNE PC, \r
    .endm    

    .macro BRNE r
        MOVNE PC, \r
    .endm    

    .macro MVL r, a
        MOV \r, #\a & 0x0000ffff
        ORR \r, \r, #\a & 0xffff0000
    .endm
.endif