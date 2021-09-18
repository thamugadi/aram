aram: boot0 boot1 boot2 kernel
	dd conv=notrunc if=/dev/zero of=aram bs=1 count=128KiB
	(printf "55AA" | xxd -r -p) | dd conv=notrunc of=aram seek=510 bs=1 count=2
	dd conv=notrunc if=boot0 of=aram seek=0 bs=1 count=510
	dd conv=notrunc if=boot1 of=aram seek=512 bs=1 count=512
	dd conv=notrunc if=boot2 of=aram seek=1024 bs=1 count=512
	dd conv=notrunc if=kernel of=aram seek=1536 bs=1
	echo "if 0x1FE doesn't contain 0x55AA, check if xxd is installed"
kernel : kernel.c io.s
	gcc -c kernel.c -o kernel.o
	as io.s -o io.o
	ld --oformat binary -Ttext 0xCAFE kernel.o io.o -o kernel
boot2 : protected.s
	as protected.s -o boot2_u
	ld --oformat binary -Ttext 0x1FFF boot2_u -o boot2
boot1 : realmode.s sysenter.s
	as realmode.s -o realmode_u
	as sysenter.s -o sysenter_u
	ld --oformat binary -Ttext 0x1000 realmode_u sysenter_u -o boot1
boot0 : boot.s
	as boot.s -o boot0_u
	ld --oformat binary -Ttext 0x7C00 boot0_u -o boot0
clean :
	rm boot0 boot1 boot2 kernel *_u *.o aram
