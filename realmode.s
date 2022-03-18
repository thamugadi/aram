.intel_syntax noprefix
.code16
.include "macro.s"

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
.gdt_entry 0xffff 0 0b10011010 0b1100
gdt_ds:
.gdt_entry 0xffff 0 0b10010010 0b1100
gdt_cs3:
.gdt_entry 0xffff 0 0b11111010 0b1100
gdt_ds3:
.gdt_entry 0xffff 0 0b11110010 0b1100
gdtend:
gdtptr:
.word gdtend - gdt - 1
.int offset gdt
