.intel_syntax noprefix
.code32
.extern inp
inp:
mov edx, dword ptr [esp+4]
in al, dx
ret
