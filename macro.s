.intel_syntax noprefix
.macro .GDT_ENTRY limit base access flags
.word \limit
.word \base
.byte \base >> 16
.byte \access
.byte \limit >> 16 & 0x0F | \flags << 4
.byte \base >> 24
.endm

.macro .IDT_ENTRY offset selector access
.short \offset & 0x0000FFFF
.short \selector
.byte 0
.byte  \access
.short \offset >> 16
.endm

.macro .CR3_32BIT page_dir_addr pcd pwt
mov eax, (0xFFFFFFFF & ((1 << 3) & \pwt)) & ((1 << 4) & \pcd) & (\page_dir_addr << 12)
.endm

//flags:eax, addr_32_39:ebx, addr_page:ecx, directory:edx
.macro .PDE_32BIT page_directory_addr
shl ebx, 13
shl ecx, 22
or eax, ebx
or eax, ecx
add edx, \page_directory_addr 
mov dword ptr [edx], eax
.endm
