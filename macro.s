.intel_syntax noprefix
.macro .GDT_ENTRY limit base access flags

.word \limit
.word \base
.byte \base >> 16
.byte \access
.byte \limit >> 16 & 0x0F | (\flags << 4)
.byte \base >> 24

.endm

.macro .IDT_ENTRY offset selector access

.short \offset & 0x0000FFFF
.short \selector
.byte 0
.byte  \access
.short \offset >> 16

.endm
