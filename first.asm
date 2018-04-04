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

include 'asm_io.inc'
include 'common.inc'
include 'io.inc'
;
; initialized data is put in the .data segment
;
section '.data'
;
; These labers refer to strings used for output
;
prompt1 	db	"Enter a number: ", 0
prompt2 	db	"Enter another number: ", 0
outmsg1 	db	"You entered ", 0
outmsg2 	db	" and ", 0
outmsg3 	db	", the sum of these is ", 0

hello_world	db	"Hello world", 10, 0

;
; uninitialized data is put in the .bss segment
;
section '.bss'

;
; These labels refer to double words used to store the inputs
;
input1 		rq 	1
input2 		rq 	2
input3		rb	100

;
; Code is put in the .text segment
;
section '.text'
	public _start
_start:
	pushaq

	mov 	rax, prompt1	; print out prompt

	mov	rdi, hello_world
	call	putstr
	mov	rdi, hello_world
	call	strlen2
	call	print_int
	call	print_nl

	mov 	rdi, 1234
	call	putint
	call	print_nl

	popaq
	mov	rdi, 0
	mov	rax, 60
	syscall


