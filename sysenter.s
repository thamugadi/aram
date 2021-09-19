.intel_syntax noprefix
.code32
.global SYSENTER_start
SYSENTER_start:
cmp ebx, 0xbeef
je kernel_start
cmp ebx, 0xeeee
je input
cmp ebx, 0xaaaa
je read_keyboard_input
cmp ebx, 0xbbbb
je read_wait_keyboard
sysexit


kernel_start:
jmp 0x8:0xcafe
input:
xchg edx, ecx
in eax, dx
xchg edx, ecx
sysexit
read_keyboard_input:
in eax, 0x64
mov dword ptr [esp], eax
and dword ptr [esp], 1
cmp dword ptr [esp], 0
je read_keyboard_input
in eax, 0x60
sysexit
read_wait_keyboard:
in eax, 0x60
cmp eax, 0
je read_wait_keyboard
sysexit


/* eax : result
ebx : select
ecx : arg
edx : return /* 
