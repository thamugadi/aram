.intel_syntax noprefix
.macro .GDT_ENTRY limit base access flags

.word limit
.word base
.byte (base >> 16)
.byte access
.byte (limit >> 16 & 0x0F) | (flags << 4)
.byte (base >> 24)

.endm
