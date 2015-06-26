#Builds a forthstrap linux executable, as an example

all: nasm

bootstrap:
	cat src/generic.forth src/io.forth src/payload.forth | ./forthstrap > arch/forth.asm

nasm: bootstrap
	nasm -f elf -g arch/x86-nasm-linux.asm
	gcc -m32 arch/x86-nasm-linux.o -o x86

run: all
	gdb x86

clean:
	-rm arch/*.o x86 arch/forth.asm
