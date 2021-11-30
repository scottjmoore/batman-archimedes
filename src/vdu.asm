
.ifndef __VDU_ASM
    .set    __VDU_ASM,    -1

    .include "swi.asm"

    .set VDU_ClearTextViewport, 12
    .set VDU_DefineTextColour, 17
    .set VDU_DefineGraphicsColour, 18
    .set VDU_DefineLogicalColour, 19
    .set VDU_RestoreDefaultLogicalColours, 20
    .set VDU_SelectScreenMode, 22
    .set VDU_MultiPurpose, 23

    ; VDU macro, can accept upto 10 parameters
    .macro VDU v1, v2, v3, v4, v5, v6, v7, v8, v9, v10
        STMFD SP!, {R0}
        .nolist
        .if \v1<>-1           ; if macro is passed 1 parameter
            MOV R0, #\v1      ; move parameter 1 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v2<>-1           ; if macro is passed 2 parameters
            MOV R0, #\v2      ; move parameter 2 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v3<>-1           ; if macro is passed 3 parameters
            MOV R0, #\v3      ; move parameter 3 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v4<>-1           ; if macro is passed 4 parameters
            MOV R0, #\v4      ; move parameter 4 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v5<>-1           ; if macro is passed 5 parameters
            MOV R0, #\v5      ; move parameter 5 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v6<>-1           ; if macro is passed 6 parameters
            MOV R0, #\v6      ; move parameter 6 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v7<>-1           ; if macro is passed 7 parameters
            MOV R0, #\v7      ; move parameter 7 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v8<>-1           ; if macro is passed 8 parameters
            MOV R0, #\v8      ; move parameter 8 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v9<>-1           ; if macro is passed 9 parameters
            MOV R0, #\v9      ; move parameter 9 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        .if \v10<>-1           ; if macro is passed 9 parameters
            MOV R0, #\v10      ; move parameter 9 into R0
            SWI OS_WriteC   ; write it to the display
        .endif
        LDMFD SP!, {R0}
        .list
    .endm
.endif