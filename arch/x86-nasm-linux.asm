	[bits 32]
	[global main]
	[extern fflush]
	[extern stdout]
	[extern stdin]
	[extern exit]

segment .text

main:
forth_start:
	mov esi, PROGRAM
	mov ebp, end_of_forth
	jmp next

PROGRAM:
	dd loopy_CFA
	dd forth_exit

forth_exit:
	dd forth_exit_BEGIN
forth_exit_BEGIN:
	push dword 0
	call exit

%macro rpush 1
	mov [ebp], dword %0
	add ebp, 4
%endmacro

%macro rpop 1
	sub ebp, 4
	mov esi, dword [ebp]
%endmacro

%macro STRING 1
	db %0, 0
%endmacro

%define SAVE_WS dd

next:
	lodsd
	jmp dword [eax]

;@ ( addr -- *addr)
AT_start:
	dd 0
	db "@", 0
AT_CFA:
	dd AT_BEGIN
AT_BEGIN:
	pop eax
	push dword [eax]
	jmp next

;enter ( --)
enter_start:
	dd AT_start
	db "enter", 0
enter_CFA:
	;dd enter_BEGIN
enter_BEGIN:
	mov [ebp], esi
	add ebp, 4
	mov esi, eax
	add esi, 4
	jmp next

;exit ( --)
exit_start:
	dd enter_start
	db "exit", 0
exit_CFA:
	dd exit_BEGIN
exit_BEGIN:
	sub ebp, 4
	mov esi, [ebp]
	jmp next

;! ( addr --)
EXC_start:
	dd exit_start
	db "!", 0
EXC_CFA:
	dd EXC_BEGIN
EXC_BEGIN:
	pop eax
	pop ebx
	mov dword [eax], ebx
	jmp next

;jp ( --)
jp_start:
	dd EXC_start
	db "jp", 0
jp_CFA:
	dd jp_BEGIN
jp_BEGIN:
	lodsd
	mov esi, eax
	jmp next

;jz ( flag --)
jz_start:
	dd jp_start
	db "jz", 0
jz_CFA:
	dd jz_BEGIN
jz_BEGIN:
	pop eax
	or eax, eax
	jnz next
	lodsd
	mov esi, eax
	jmp next

;jnz ( flag --)
jnz_start:
	dd jz_start
	db "jnz", 0
jnz_CFA:
	dd jnz_BEGIN
jnz_BEGIN:
	pop eax
	or eax, eax
	jz next
	lodsd
	mov esi, eax
	jmp next

;lit ( -- literal)
lit_start:
	dd jnz_start
	db "lit", 0
lit_CFA:
	dd lit_BEGIN
lit_BEGIN:
	lodsd
	push eax
	jmp next

;+ ( n1 n2 -- sum)
PLUS_start:
	dd lit_start
	db "+", 0
PLUS_CFA:
	dd PLUS_BEGIN
PLUS_BEGIN:
	pop eax
	pop ebx
	add eax, ebx
	push eax
	jmp next

;- ( n1 n2 -- diff)
DASH_start:
	dd PLUS_start
	db "-", 0
DASH_CFA:
	dd DASH_BEGIN
DASH_BEGIN:
	pop ebx
	pop eax
	sub eax, ebx
	push eax
	jmp next

endDASHofDASHmem_start:
	dd DASH_start
	db "end-of-mem", 0
endDASHofDASHmem_CFA:
	dd endDASHofDASHmem_BEGIN
endDASHofDASHmem_BEGIN:
	push dword end_of_forth
	jmp next

cEXC_start:
	dd endDASHofDASHmem_start
	db "c!", 0
cEXC_CFA:
	dd cEXC_BEGIN
cEXC_BEGIN:
	pop ebx
	pop eax
	mov byte [ebx], al
	jmp next

cAT_start:
	dd cEXC_start
	db "c@", 0
cAT_CFA:
	dd cAT_BEGIN
cAT_BEGIN:
	pop ebx
	xor eax, eax
	mov al, byte [ebx]
	push eax
	jmp next

emit_start:
	dd cAT_start
	db "emit", 0
emit_CFA:
	dd emit_BEGIN
emit_BEGIN:
	pop eax
	mov byte [emit_buffer], al
	pushad
	mov eax, 4
	mov ebx, 1
	mov ecx, emit_buffer
	mov edx, 1
	int 0x80
	popad
	jmp next

;ws ( -- word-size)
ws_start:
	dd emit_start
	db "ws", 0
ws_CFA:
	dd ws_BEGIN
ws_BEGIN:
	push dword 4
	jmp next


section .data

emit_buffer: db 0, 0
emit_zero: dd 0

%include "arch/forth.asm"

end_of_forth:
times 4096 db 0
