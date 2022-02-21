.intel_syntax noprefix
.include "macro.s"
.code16
cli
lgdt [gdtptr]

xor edx, edx

mov eax, offset SYSENTER_start
mov ecx, 0x176
wrmsr

mov eax, 0xd000
mov ecx, 0x175
wrmsr

mov eax, 0x18
mov ecx, 0x174
wrmsr


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
.byte 0b10011010
.byte 0b11001111
.byte 0x00
gdt_ds:
.word 0xFFFF
.word 0x0000
.byte 0x00
.byte 0b10010010
.byte 0b11001111
.byte 0x00
gdt_cs_ring0:
.word 0xFFFF
.word 0x0000
.byte 0x00
.byte 0b10011010
.byte 0b11001001
.byte 0x00

gdtend:
gdtptr:
.word gdtend - gdt - 1
.int offset gdt
