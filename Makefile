ASM=fasm
LD=ld
LFLAGS=-melf_x86_64 --dynamic-linker /lib/ld-linux-x86-64.so.2 -lc

.PHONY: all clean

all: prime first Makefile

prime: prime.asm asm_io.o
	$(ASM) prime.asm
	$(LD) -o prime prime.o $(LFLAGS)

first: first.asm asm_io.o common.inc io.o
	$(ASM) first.asm
	$(LD) -o first first.o asm_io.o io.o $(LFLAGS)

asm_io.o: asm_io.asm
	$(ASM) asm_io.asm

io.o: io.asm
	$(ASM) io.asm

clean:
	rm *.o prime first

