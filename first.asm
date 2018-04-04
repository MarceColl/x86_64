;
; asmsyntax=fasm
;
; Marce Coll <marce@dziban.net>
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
include 'vector.inc'

section '.data'
hello_world	db	"Hello world", 10, 0
number_read	db	"Number of bytes read: ", 0

section '.bss'
input		rb	100
vectors		rq	10		; space for 5 vectors

;
; Test program just to test several IO routines from the
; io.asm file
;
section '.text'
	public _start
_start:
	mov	rdi, hello_world
	call	print_str
	mov	rdi, hello_world
	call	strlen
	mov	rdi, rax
	call	print_uint
	call	print_nl

	mov	r12, 0
.while:
	cmp	r12, 50
	jz	short .endwhile

	mov 	rdi, r12
	call	print_uint
	call	print_nl

	add	r12, 1
	jmp	short .while
.endwhile:

	mov	rdi, input	
	mov	rsi, 100
	call	read_str
	
	mov	r12, rax
	mov	rdi, number_read
	call	print_str
	mov	rdi, r12
	call	print_uint
	call 	print_nl
	mov	rdi, input
	call	print_str

	call	read_uint
	mov	rdi, rax
	call	print_uint
	call	print_nl

	; Create some vectors to toy with them
	make_vec2i vectors, 13, 10
	make_vec2i vectors+16, 3, 4

	mov	r8, vectors
	push	r8
	mov	rdi, r8
	call	print_vec2i
	pop	r8

	add 	r8, 16
	push	r8
	mov	rdi, r8
	call	print_vec2i
	pop	r8

	push	r8
	mov	rdi, vectors+32
	mov	rsi, vectors
	mov	rdx, vectors+16
	call	add_vec2i
	pop 	r8

	add 	r8, 16
	push	r8
	mov	rdi, r8
	call	print_vec2i
	pop	r8

	xor	rdi, rdi
	mov	rax, 60
	syscall


