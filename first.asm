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

include 'common.inc'
include 'io.inc'
;
; initialized data is put in the .data segment
;
section '.data'
hello_world	db	"Hello world", 10, 0
number_read	db	"Number of bytes read: ", 0

section '.bss'
input		rb	100

;
; Code is put in the .text segment
;
section '.text'
	public _start
_start:
	mov	rdi, hello_world
	call	putstr
	mov	rdi, hello_world
	call	strlen
	mov	rdi, rax
	call	putuint
	call	printnl

	mov	r12, 0
.while:
	cmp	r12, 50
	jz	short .endwhile

	mov 	rdi, r12
	call	putuint
	call	printnl

	add	r12, 1
	jmp	short .while
.endwhile:

	mov	rdi, input	
	mov	rsi, 100
	call	readstr
	
	mov	r12, rax
	mov	rdi, number_read
	call	putstr
	mov	rdi, r12
	call	putuint
	call 	printnl
	mov	rdi, input
	call	putstr

	call	readuint
	mov	rdi, rax
	call	putuint
	call	printnl

	xor	rdi, rdi
	mov	rax, 60
	syscall


