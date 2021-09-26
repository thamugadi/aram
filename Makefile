aram: boot0.bin boot1.bin boot2.bin userland.bin
	dd conv=notrunc if=/dev/zero of=aram bs=1 count=512
	(printf "55AA" | xxd -r -p) | dd conv=notrunc of=aram seek=510 bs=1 count=2
	dd conv=notrunc if=boot0.bin of=aram seek=0 bs=1 count=510
	dd conv=notrunc if=boot1.bin of=aram seek=512 bs=1 count=512
	dd conv=notrunc if=boot2.bin of=aram seek=1024 bs=1 count=512
	dd conv=notrunc if=userland.bin of=aram seek=1536 bs=1
	echo "if 0x1FE doesn't contain 0x55AA, check if xxd is installed"
userland.bin : userland.c 
	gcc -c -masm=intel userland.c -o userland.o
	ld --oformat binary -Ttext 0xCAFE -e _start userland.o -o userland.bin
boot2.bin : protected.s
	as protected.s -o boot2.elf
	ld --oformat binary -Ttext 0x1FFF boot2.elf -o boot2.bin
boot1.bin : realmode.s sysenter.s
	as realmode.s sysenter.s -o realmode.elf
	ld --oformat binary -Ttext 0x1000 realmode.elf -o boot1.bin
boot0.bin : boot.s
	as boot.s -o boot0.elf
	ld --oformat binary -Ttext 0x7C00 boot0.elf -o boot0.bin
clean :
	rm *.bin *.elf *.o aram
