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
mov eax, 0xFFFFFFFF
and eax, (~(1 << 3)) | (\pwt << 3)
and eax, (~(1 << 4)) | (\pcd << 4)
and eax, (~(1 << 12)) | (\page_dir_addr << 12)
mov cr3, eax
.endm

//flags:eax, addr_32_39:ebx, addr_page:ecx, entry:edx
.macro .PDE_32BIT page_dir_addr
shl ebx, 13
shl ecx, 22
or eax, ebx
or eax, ecx
add edx, \page_dir_addr 
mov dword ptr [edx], eax
.endm

.macro .PDE_32BIT_flags rw us pwt pcd a d g pat
mov eax, 0x1FFF
and eax, (~(1 << 1)) | (\rw << 1)
and eax, (~(1 << 2)) | (\us << 2)
and eax, (~(1 << 3)) | (\pwt << 3)
and eax, (~(1 << 4)) | (\pcd << 4)
and eax, (~(1 << 5)) | (\a << 5)
and eax, (~(1 << 6)) | (\d << 6)
and eax, (~(1 << 8)) | (\g << 8)
and eax, (~(1 << 12))| (\pat << 12)
.endm
