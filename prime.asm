; include "asm_io.inc"
format ELF64

include 'common.inc'

section '.data'
Message		db	"Find primes up to: ", 0

section '.bss' writeable
Limit		rd	1	; find primes up to this limit
Guess		rd	1	; the current guess for prime

section '.text' executable
	public _start
_start:
	pushaq
	popaq

	mov	rdi, 1 
	mov	rax, 60
	syscall
