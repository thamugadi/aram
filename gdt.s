.intel_syntax noprefix
.code16
cli
lgdt [gdtptr]
mov eax, cr0
or al, 1
mov cr0, eax
jmp protected
protected:
mov ax, 0x10
mov ds, ax
mov es, ax
mov fs, ax
mov gs, ax
mov ss, ax
mov sp, 0xbeef
jmp 0x8:0x1FFF

gdt:
.byte 0,0,0,0,0,0,0,0
gdt_cs:
.word 0xFFFF
.word 0x0000
.byte 0x00
.byte 0b10011110
.byte 0b11001111
.byte 0x00
gdt_ds:
.word 0xFFFF
.word 0x0000
.byte 0x00
.byte 0b10010110
.byte 0b11001111
.byte 0x00
gdtend:
gdtptr:
.word gdtend - gdt - 1
.int gdt
