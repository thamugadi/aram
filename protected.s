.intel_syntax noprefix
.code32
mov esp, 0x8F000
mov ebx, 0xeeee
call sysenter_link
sysenter

mov ebx, 0xaaaa
call sysenter_link
sysenter
mov ebx, 0xbeef
call sysenter_link
sysenter
.ascii "end"

sysenter_link:
xor edx, edx
add edx, dword ptr [esp]
add edx, 2 #2 bytes for sysenter 
ret
