;
; asmsyntax=fasm
;
; Marce Coll <marce@dziban.net>
;

format ELF64

include 'io.inc'
include 'common.inc'

section '.data'
obracket	db	'{ ', 0
comma		db	', ', 0
cbracket	db	' }', 0

section '.text'
	public add_vec2i

	public print_vec2i
	public print_vec3i
;
; Add two vec2i
; rdi - where to put the vec
; rsi - vec a
; rdx - vec b
;
add_vec2i:
	pushaq

	mov	r12, [rsi]
	add	r12, [rdx]
	mov	r13, [rsi+8]
	add	r13, [rdx+8]

	mov	[rdi], r12
	mov	[rdi+8], r13

	popaq
	ret
	

print_vec2i:
	pushaq

	mov	r12, qword [rdi]
	mov	r13, qword [rdi+8]

	mov	rdi, obracket
	call	print_str

	mov	rdi, r12
	call	print_uint

	mov	rdi, comma
	call	print_str

	mov	rdi, r13
	call	print_uint

	mov	rdi, cbracket
	call	print_str

	call	print_nl

	popaq
	ret

print_vec3i:
	pushaq

	mov	r12, qword [rdi]
	mov	r13, qword [rdi+8]
	mov	r14, qword [rdi+16]

	mov	rdi, obracket
	call	print_str

	mov	rdi, r12
	call	print_uint

	mov	rdi, comma
	call	print_str

	mov	rdi, r13
	call	print_uint

	mov	rdi, comma
	call	print_str

	mov	rdi, r14
	call	print_uint

	mov	rdi, cbracket
	call	print_str

	call	print_nl

	popaq
	ret
