; asmsyntax=fasm
;
; Marce Coll <marce@dziban.net>
;
; IO routines to use with assembly without having to link with glibc
;
format ELF64

include 'common.inc'

section '.data'
newline		db	10
debug_text	db	'DBG', 0

section '.bss'
io_buff		rb	100

section '.text'
	public putstr
	public strlen
	public putuint
	public printnl
	public readstr
	public readuint
;
; Calculates the length of a string
; rdi - string pointer
;
; TODO(Marce): Error management
;
strlen:
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
; TODO(Marce): Error management
;
putstr:
	pushaq

	push	rdi
	call 	strlen
	pop	rdi

	mov	rdx, rax		; length of the string

	mov	rsi, rdi		; string
	mov	rax, 1 			; write is syscall 1
	mov	rdi, 1			; stdout
	syscall

	popaq
	ret

printnl:
	pushaq

	mov	rax, 1
	mov	rdi, 1
	mov	rsi, newline
	mov	rdx, 1
	syscall

	popaq
	ret

dbg:
	pushaq
	mov	rdi, debug_text
	call	putstr
	call	printnl
	popaq
	ret

;
; Print an unsigned number to stdout
; rdi - number to print
;
; TODO(Marce): Improve this procedure, make it more efficient
; TODO(Marce): Error management
;
putuint:
	pushaq

	mov	r9, rdi
	mov	r8, rdi
	mov	r10, io_buff

; Find out how long the number is
.while_length:
	mov	rax, r8			; divide by 10
	mov	rcx, 10
	xor	rdx, rdx
	div	rcx

	mov	r8, rax 
	add	r10, 1

	cmp	r8, 0
	jnz	.while_length
.endwhile_length:
	mov 	byte [r10], 0		; End the string with a null terminator
	mov	r8, r9

; Fill the string buffer with the stringified number, 
; starting from the least significant digit.
.while:
	sub	r10, 1

	mov	rax, r8			; divide by 10
	mov	rcx, 10
	xor	rdx, rdx
	div	rcx

	mov	r8, rax 
	add	dl, 48			; From number to ascii digit
	mov	byte [r10], dl

	cmp	r8, 0
	jnz	short .while
.endwhile:
	mov	rdi, io_buff		; Print the resulting string from the buffer
	call	putstr

	popaq
	ret

;
; Read string from stdin into a buffer that is passed as argument
; rdi - buffer where to put the string
; rsi - max size of buffer
;
; returns number of bytes read
;
; TODO(Marce): Error management
;
readstr:
	pushaq
	
	mov	r8, rdi			; save buffer for null terminating the string later
	mov	rdx, rsi 		; read up to rsi bytes

	mov	rsi, rdi 		; buffer
	mov	rdi, 0			; stdin
	mov	rax, 0			; read syscall
	syscall

	; null terminate the string
	add	r8, rax
	mov	byte [r8], 0

	popaq
	ret

;
; Read an unsigned int from stdin
;
; TODO(Marce): Vectorize the addition
; TODO(Marce): Error management
; 
readuint:
	pushaq
	
	mov	rdi, io_buff	
	mov	rsi, 100
	call	readstr

	mov	r12, rax		; number of bytes read
	sub	r12, 1			; minus the \n
	mov	r13, io_buff
	add	r13, r12		; end of string
	sub	r13, 1			; remove null terminator and \n

	mov	r14, 1			; multiplier (1, 10, 100,...)
	mov 	r11, 0			; counter for the while
	mov	rcx, 0			; resulting number

	; convert string into number
.while:
	cmp	r11, r12
	jz	.endwhile
		
	movzx	rax, byte [r13]
	sub	rax, 48
	imul	r14
	add	rcx, rax

	add	r11, 1
	mov	rax, r14
	mov	r8, 10
	mul	r8
	mov	r14, rax
	sub	r13, 1
	
	jmp 	.while
.endwhile:

	mov	rax, rcx

	popaq
	ret

