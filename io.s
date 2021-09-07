.intel_syntax noprefix
.code32
.global input
input:
mov edx, dword ptr [esp+4]
in al, dx
ret
