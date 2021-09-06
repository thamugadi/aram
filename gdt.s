bits 16
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
db 0,0,0,0,0,0,0,0
gdt_cs:
dw 0xFFFF
dw 0x0000
db 0x00
db 0b10011010
db 0b11001111
db 0x00
gdt_ds:
dw 0xFFFF
dw 0x0000
db 0x00
db 0b10010010
db 0b11001111
db 0x00
gdtend:
gdtptr:
dw gdtend - gdt - 1
dd gdt
