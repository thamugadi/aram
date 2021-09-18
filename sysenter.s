.intel_syntax noprefix
.code32
.global SYSENTER_start
SYSENTER_start:
cmp ebx, 0xbeef
je kernel_start
cmp ebx, 0xeeee
je input
sysexit
kernel_start:
jmp 0x8:0xcafe
input:
mov ecx, edx
in eax, dx
mov edx, ecx
sysexit
