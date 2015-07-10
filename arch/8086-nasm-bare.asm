	[bits 16]
	[org 0x8800]

forth_start:
	xor ax, ax
	mov es, ax
	mov ds, ax
	mov ss, ax
	mov gs, ax
	mov ss, ax
	mov es, ax

	mov si, PROGRAM
	mov bp, end_of_forth
	jmp next

PROGRAM:
	dw payload_CFA
	dw forth_exit

forth_exit:
	dw forth_exit_BEGIN
forth_exit_BEGIN:
	pop ax
forth_HALT:
	cli
	hlt

%macro rpush 1
	mov [bp], word %0
	add bp, 2
%endmacro

%macro rpop 1
	sub bp, 2
	mov si, word [bp]
%endmacro

%define STRING db
%define SAVE_WS dw

next:
	lodsw
	mov bx, ax
	mov ax, word [bx]
	jmp word ax

;@ ( dwr -- *dwr)
AT_start:
	dw 0
	db "@", 0
AT_CFA:
	dw AT_BEGIN
AT_BEGIN:
	pop bx
	mov ax, word [bx]
	push ax
	jmp next

;enter ( --)
enter_start:
	dw AT_start
	db "enter", 0
enter_CFA:
	;dw enter_BEGIN
enter_BEGIN:
	mov [bp], si
	add bp, 2
	mov si, bx
	add si, 2
	jmp next

;exit ( --)
exit_start:
	dw enter_start
	db "exit", 0
exit_CFA:
	dw exit_BEGIN
exit_BEGIN:
	sub bp, 2
	mov si, [bp]
	jmp next

;! ( dwr --)
EXC_start:
	dw exit_start
	db "!", 0
EXC_CFA:
	dw EXC_BEGIN
EXC_BEGIN:
	pop bx
	pop ax
	mov word [bx], ax
	jmp next

;jp ( --)
jp_start:
	dw EXC_start
	db "jp", 0
jp_CFA:
	dw jp_BEGIN
jp_BEGIN:
	lodsw
	mov si, ax
	jmp next

;jz ( flag --)
jz_start:
	dw jp_start
	db "jz", 0
jz_CFA:
	dw jz_BEGIN
jz_BEGIN:
	pop bx
	lodsw
	or bx, bx
	jnz next
	mov si, ax
	jmp next

;jnz ( flag --)
jnz_start:
	dw jz_start
	db "jnz", 0
jnz_CFA:
	dw jnz_BEGIN
jnz_BEGIN:
	pop bx
	lodsw
	or bx, bx
	jz next
	mov si, ax
	jmp next

;lit ( -- literal)
lit_start:
	dw jnz_start
	db "lit", 0
lit_CFA:
	dw lit_BEGIN
lit_BEGIN:
	lodsw
	push ax
	jmp next

;+ ( n1 n2 -- sum)
PLUS_start:
	dw lit_start
	db "+", 0
PLUS_CFA:
	dw PLUS_BEGIN
PLUS_BEGIN:
	pop ax
	pop bx
	add ax, bx
	push ax
	jmp next

;- ( n1 n2 -- diff)
DASH_start:
	dw PLUS_start
	db "-", 0
DASH_CFA:
	dw DASH_BEGIN
DASH_BEGIN:
	pop bx
	pop ax
	sub ax, bx
	push ax
	jmp next

endDASHofDASHmem_start:
	dw DASH_start
	db "end-of-mem", 0
endDASHofDASHmem_CFA:
	dw endDASHofDASHmem_BEGIN
endDASHofDASHmem_BEGIN:
	push word end_of_forth
	jmp next

cEXC_start:
	dw endDASHofDASHmem_start
	db "c!", 0
cEXC_CFA:
	dw cEXC_BEGIN
cEXC_BEGIN:
	pop bx
	pop ax
	mov byte [bx], al
	jmp next

cAT_start:
	dw cEXC_start
	db "c@", 0
cAT_CFA:
	dw cAT_BEGIN
cAT_BEGIN:
	pop bx
	xor ax, ax
	mov al, byte [bx]
	push ax
	jmp next

emit_start:
	dw cAT_start
	db "emit", 0
emit_CFA:
	dw emit_BEGIN
emit_BEGIN:
	pop ax
	pusha
	mov ah, 0x0E
	int 0x10
	popa
	jmp next

and_start:
	dw emit_start
	db "and", 0
and_CFA:
	dw and_BEGIN
and_BEGIN:
	pop ax
	pop bx
	and ax, bx
	push ax
	jmp next

GT_start:
	dw and_start
	db ">", 0
GT_CFA:
	dw GT_BEGIN
GT_BEGIN:
	pop bx
	pop ax
	cmp ax, bx
	jg is_true
	jmp is_false

LT_start:
	dw GT_start
	db "<", 0
LT_CFA:
	dw LT_BEGIN
LT_BEGIN:
	pop bx
	pop ax
	cmp ax, bx
	jl is_true
	jmp is_false

is_true:
	push word 1
	jmp next

is_false:
	push word 0
	jmp next

shl_start:
	dw LT_start
	db "shl", 0
shl_CFA:
	dw shl_BEGIN
shl_BEGIN:
	pop cx
	pop ax
	shl ax, cl
	push ax
	jmp next

shr_start:
	dw shl_start
	db "shr", 0
shr_CFA:
	dw shr_BEGIN
shr_BEGIN:
	pop cx
	pop ax
	shr ax, cl
	push ax
	jmp next

GTr_start:
	dw shr_start
	db ">r", 0
GTr_CFA:
	dw GTr_BEGIN
GTr_BEGIN:
	pop ax
	mov word [bp], ax
	add bp, 2
	jmp next

key_start:
	dw GTr_start
	db "key", 0
key_CFA:
	dw key_BEGIN
key_BEGIN:
	mov ah, 0
	pusha
	int 0x16
	xor ah, ah
	mov byte [emit_buffer], al
	popa
	mov al, byte [emit_buffer]
	push ax
	jmp next

exec_start:
	dw key_start
	db "exec", 0
exec_CFA:
	dw exec_BEGIN
exec_BEGIN:
	pop bx
	mov ax, word [bx]
	jmp ax

MULT_start:
	dw exec_start
	db "*", 0
MULT_CFA:
	dw MULT_BEGIN
MULT_BEGIN:
	pop bx
	pop ax
	imul ax, bx
	push ax
	jmp next

rem_start:
	dw MULT_start
	db "rem", 0
rem_CFA:
	dw rem_BEGIN
rem_BEGIN:
	xor dx, dx
	pop bx
	pop ax
	div bx
	push dx
	jmp next

SLASH_start:
	dw rem_start
	db "/", 0
SLASH_CFA:
	dw SLASH_BEGIN
SLASH_BEGIN:
	pop bx
	pop ax
	div bx
	push ax
	jmp next

;ws ( -- word-size)
ws_start:
	dw SLASH_start
	db "ws", 0
ws_CFA:
	dw ws_BEGIN
ws_BEGIN:
	push word 2
	jmp next

emit_buffer: db 0, 0
emit_zero: dw 0
hello_str: db "hello, world", 0

%include "arch/forth.asm"

end_of_forth: