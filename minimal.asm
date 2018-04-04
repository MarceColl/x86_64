; asmsyntax=fasm
;
; file: first.asm
; First assembly program. This program asks for two integers as
; input and prints out their sum.
;
; To create executable:
; nasm -f coff first.asm
; gcc -o first first.o driver.c asm_io.o

format ELF64

;
; Code is put in the .text segment
;
section '.text'
	public _start
_start:
	mov	rdi, 1
	mov	rax, 60
	syscall


