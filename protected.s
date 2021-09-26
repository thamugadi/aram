.intel_syntax noprefix
.code32
.global readInput
.global readKeyboardInput

mov esp, 0x8F000
jmp load
readInput:
mov ebx, 0xeeee
call sysenter_link
sysenter
ret

readKeyboardInput:
mov ebx, 0xaaaa
call sysenter_link
sysenter
ret

load:
mov ebx, 0xbeef
call sysenter_link
sysenter

sysenter_link:
xor edx, edx
add edx, dword ptr [esp]
add edx, 2 #2 bytes for sysenter opcode
ret
