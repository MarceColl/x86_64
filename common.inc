; asmsyntax=fasm
;
; file: common.asm
;
; Common operations for x86_64 asm
;

macro pushaq {
	push rsp
	push rbp 
	push rbx
	push r12
	push r13
	push r14
	push r15
}

macro popaq {
	pop r15
	pop r14
	pop r13
	pop r12
	pop rbx
	pop rbp
	pop rsp
}
