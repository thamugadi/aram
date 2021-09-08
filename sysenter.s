.intel_syntax noprefix
.code32
.global SYSENTER_start
SYSENTER_start:
cmp eax, 0xdeadbeef
je kernel_start
xor eax, eax
sysexit
kernel_start:
jmp 0x8:0xcafe
