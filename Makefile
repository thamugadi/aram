aram: boot0 boot1 boot2 userland 
	dd conv=notrunc if=/dev/zero of=aram bs=1 count=512
	(printf "55AA" | xxd -r -p) | dd conv=notrunc of=aram seek=510 bs=1 count=2
	dd conv=notrunc if=boot0 of=aram seek=0 bs=1 count=510
	dd conv=notrunc if=boot1 of=aram seek=512 bs=1 count=512
	dd conv=notrunc if=boot2 of=aram seek=1024 bs=1 count=512
	dd conv=notrunc if=userland of=aram seek=1536 bs=1
	echo "if 0x1FE doesn't contain 0x55AA, check if xxd is installed"
userland : userland.c 
	gcc -c userland.c -o userland.o
	ld --oformat binary -Ttext 0xCAFE userland.o -o userland
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
	rm boot0 boot1 boot2 userland *_u *.o aram
