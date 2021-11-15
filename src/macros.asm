; BFL macro to branch to a fixed 32 bit address with linked return
.macro BFL r,a
    MOV \r,#\a
    ADD R14,PC,#0
    MOV PC,\r
.endm

; BF macro to branch to a fixed 32 bit address
.macro BF r,a
    MOV \r,#\a
    MOV PC,\r
.endm

.macro MVL r,a
    MOV \r,#\a & 0x0000ffff
    ORR \r,\r,#\a & 0xffff0000
.endm