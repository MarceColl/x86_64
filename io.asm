; asmsyntax=fasm
;
; Marce Coll <marce@dziban.net>
;
; IO routines to use with assembly without having to link with glibc
;
format ELF64

include 'common.inc'
include 'asm_io.inc'

section '.data'
putint_buff	rb	100

section '.text'
	public putstr
	public strlen2
	public putint
;
; Calculates the length of a string
; rdi - string pointer
;
strlen2:
	pushaq	

	movzx 	r8, byte [rdi]
	mov	rax, 0			; counter
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
	call 	strlen2
	pop	rdi

	mov	rdx, rax		; length of the string

	mov	rsi, rdi		; string
	mov	rax, 1 			; write is syscall 1
	mov	rdi, 1			; stdout
	syscall

	popaq
	ret

;
; Print a number to stdout
; rdi - number to print
;
putint:
	pushaq

	mov	r8, rdi
	mov	r10, putint_buff

.while_length:
	cmp	r8, 0
	jz	short .endwhile_length
	mov	rax, r8			; divide by 10
	mov	rcx, 10
	xor	rdx, rdx
	div	rcx

	mov	r8, rax 
	add	r10, 1
	
	jmp	short .while_length
.endwhile_length:
	mov 	byte [r10], 0

	mov	r8, rdi

.while:
	cmp	r8, 0
	jz	short .endwhile
	sub	r10, 1

	mov	rax, r8			; divide by 10
	mov	rcx, 10
	xor	rdx, rdx
	div	rcx

	mov	r8, rax 
	add	dl, 48
	mov	byte [r10], dl
	
	jmp	short .while
.endwhile:

	mov	rdi, putint_buff
	call	putstr

	popaq
	ret
