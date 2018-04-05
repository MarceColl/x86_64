ASM=fasm
LD=ld
LFLAGS=-melf_x86_64 --dynamic-linker=/usr/lib/ld-linux-x86-64.so.2 

.PHONY: all clean

all: first_libc first_pic first_static

prime: prime.asm asm_io.o Makefile
	$(ASM) prime.asm
	$(LD) -o prime prime.o $(LFLAGS)

first_static: first.asm asm_io.o common.inc io.o vector.o Makefile
	$(ASM) first.asm
	$(LD) -o first_static first.o io.o vector.o $(LFLAGS)

first_pic: first.asm asm_io.o common.inc io.o vector.o Makefile
	$(ASM) first.asm
	$(LD) -o first_pic first.o io.o vector.o $(LFLAGS) --pic-executable

first_libc: first.asm asm_io.o common.inc io.o vector.o Makefile
	$(ASM) first.asm
	$(LD) -o first_libc first.o io.o vector.o $(LFLAGS) -lc

minimal: minimal.asm
	$(ASM) minimal.asm
	$(LD) -o min minimal.o $(LDFLAGS)

asm_io.o: asm_io.asm
	$(ASM) asm_io.asm

io.o: io.asm
	$(ASM) io.asm

vector.o: vector.asm
	$(ASM) vector.asm

clean:
	rm *.o prime first

