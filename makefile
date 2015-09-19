#Builds a forthstrap linux executable, as an example
bootstrap:
	cat src/generic.forth src/io.forth src/payload.forth | ./forthstrap > arch/forth.asm

linux: bootstrap unix_runtime
	nasm -f elf -g arch/x86-nasm-linux.asm
	gcc -m32 arch/x86-nasm-linux.o arch/unix/*.o -o x86

8086: bootstrap
	fasm arch/boot.asm
	mv arch/boot.bin .
	-/sbin/mkdosfs -F 12 -s 2 -C floppy.img 1440
	dd conv=notrunc if=boot.bin of=floppy.img bs=1 seek=64 count=448
	nasm -fbin arch/8086-nasm-bare.asm -o 8086.bin
	mcopy -o -i floppy.img 8086.bin ::/PAYLOAD.SYS
	bin/mkdisk.sh
	dd if=raw_img.bin of=floppy.img conv=notrunc bs=512 seek=770

linux-run: linux
	stty raw -echo isig
	-./x86
	stty cooked echo
	echo

linux-dbg: linux
	stty raw -echo isig
	-gdb x86
	stty cooked echo 
	echo

8086-run: 8086
	qemu-system-i386 -fda floppy.img -monitor stdio

unix_runtime:
	cd arch/unix && make

clean:
	-rm arch/*.o x86 arch/forth.asm *.bin *.img
	cd arch/unix && make clean
