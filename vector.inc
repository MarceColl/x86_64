;
; asmsyntax=fasm
;
; Marce Coll <marce@dziban.net>
;
; Macros related to algebraic vectors
;

macro make_vec2i mem,x,y {
	mov	qword [mem], x
	mov	qword [mem+8], y
}

macro make_vec3i mem,x,y,z {
	mov	qword [mem], x
	mov	qword [mem+8], y
	mov	qword [mem+16], z 
}

extrn 	print_vec2i
extrn 	print_vec3i

extrn 	add_vec2i
