.intel_syntax noprefix
.code16

mov ah, 0
int 0x13

mov ax, 0
mov es, ax

mov ah, 2
mov al, 4 / load 2 KB (boot1)
mov ch, 0
mov cl, 2
mov dh, 0
mov bx, 0x1000
int 0x13
mov ah, 2
mov al, 2 / load 1 KB (boot2)
mov ch, 0
mov cl, 3
mov dh, 0
mov bx, 0x1FFF
int 0x13
mov ah, 2
mov al, 255 / load up to 128 KB (kernel)
mov ch, 0
mov cl, 4
mov dh, 0
mov bx, 0xCAFE
int 0x13 
jmp 0:0x1000
