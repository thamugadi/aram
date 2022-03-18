.intel_syntax noprefix
.code32
.global SYSENTER_start
SYSENTER_start:

cmp ebx, 0xbeef
je userland_start
cmp ebx, 0xeeee
je input
cmp ebx, 0xaaaa
je read_keyboard_input
cmp ebx, 0xbbbb
je read_wait_keyboard
mov ecx, 0x8F000
sysexit

userland_start:
mov esp, 0x8F000
mov ebp, esp
sub esp, 0xFFFF
jmp 0x8:0xcafe

input:
xchg edx, ecx
in eax, dx
xchg edx, ecx
mov ecx, 0x8F000
sysexit

read_keyboard_input:
in eax, 0x64
mov dword ptr [esp], eax
and dword ptr [esp], 1
cmp dword ptr [esp], 0
je read_keyboard_input
in eax, 0x60
mov ecx, 0x8F000
sysexit

read_wait_keyboard:
in eax, 0x60
cmp eax, 0
je read_wait_keyboard
mov ecx, 0x8F000
sysexit

/* eax : result
ebx : select
ecx : arg
edx : return /* 
