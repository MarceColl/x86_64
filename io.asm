; asmsyntax=fasm
;
; Marce Coll <marce@dziban.net>
;
; IO routines to use with assembly without having to link with glibc
;
format ELF64

include 'common.inc'
include 'asm_io.inc'

section '.text'
	public putstr
	public strlen2
;
; Calculates the length of a string
; rdi - string pointer
;
strlen2:
	pushaq	

	movzx 	r8, byte [rdi]
	mov	rax, 0
.while:
	cmp	r8, 0
	jz 	short .endwhile
	add	rax, 1
	add	rdi, 1

	movzx 	r8, byte [rdi]

	jmp	short .while
.endwhile:

	popaq
	ret

;
; Prints a null terminated string to stdout
; rdi - string pointer
;
putstr:
	pushaq

	push	rdi
	call strlen2
	pop	rdi

	mov	rdx, rax		; length of the string

	mov	rsi, rdi		; string
	mov	rax, 1 			; write is syscall 1
	mov	rdi, 1			; stdout
	syscall

	popaq
	ret

