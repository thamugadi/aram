aram: boot0 boot1 boot2 kernel
	dd conv=notrunc if=/dev/zero of=aram bs=1 count=64KiB
	(echo "0x55xAA" | xxd -r -p) | dd conv=notrunc of=aram seek=510 bs=1 count=2
	dd conv=notrunc if=boot0 of=aram seek=0 bs=1 count=510
	dd conv=notrunc if=boot1 of=aram seek=512 bs=1 count=512
	dd conv=notrunc if=boot2 of=aram seek=1024 bs=1 count=512
	d conv=notrunc if=kernel of=aram seek=1536 bs=1
kernel : kernel.c
	gcc -c kernel.c -o kernel.o
	ld --oformat binary -Ttext 0x1FFF kernel.o -o kernel
boot2 : protected.s
	nasm -f bin protected.s -o boot2
boot1 : loadcafe.s
	nasm -f bin loadcafe.s -o boot1
boot0 : boot.s
	nasm -f bin boot.s -o boot0
clean : 
	rm boot0 boot1 boot2 kernel.o kernel aram
