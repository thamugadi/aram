bits 16
org 0x7C00
mov ah, 0
int 0x13

mov ah, 2
mov al, 1
mov ch, 0
mov cl, 2
mov dh, 0

mov bx, 0xcafe
int 0x13

mov ah, 2
mov al, 1
mov ch, 0
mov cl, 3
mov dh, 0

mov bx, 0x8000
int 0x13

mov ah, 2
mov al, 4
mov ch, 0
mov cl, 4
mov dh, 0

mov bx, 0x1FFF
int 0x13

jmp 0xcafe
