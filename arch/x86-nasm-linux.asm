	[bits 32]
%include "arch/x86-linux.h"
	[global main]
	[extern fflush]
	[extern stdout]
	[extern stdin]
	[extern exit]

segment .text

main:
forth_start:
	mov eax, [esp+4]
	mov [argc_hold], eax
	mov eax, [esp+8]
	mov [argv_hold], eax
	call unix_runtime_init
	mov esi, PROGRAM
	mov ebp, end_of_forth
	jmp next

PROGRAM:
	dd payload_CFA
	dd forth_exit_CFA

forth_exit:
	dd 0
	db "bye", 0
forth_exit_CFA:
	dd forth_exit_BEGIN
forth_exit_BEGIN:
	xor eax, eax
	push eax
forth_HALT:
	call exit

%macro rpush 1
	mov [ebp], dword %0
	add ebp, 4
%endmacro

%macro rpop 1
	sub ebp, 4
	mov esi, dword [ebp]
%endmacro

%define STRING db
%define SAVE_WS dd

next:
	lodsd
	jmp dword [eax]

;@ ( addr -- *addr)
AT_start:
	dd forth_exit
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
	pop ebx
	lodsd
	or ebx, ebx
	jnz next
	mov esi, eax
	jmp next

;jnz ( flag --)
jnz_start:
	dd jz_start
	db "jnz", 0
jnz_CFA:
	dd jnz_BEGIN
jnz_BEGIN:
	pop ebx
	lodsd
	or ebx, ebx
	jz next
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

MULT_start:
	dd DASH_start
	db "*", 0
MULT_CFA:
	dd MULT_BEGIN
MULT_BEGIN:
	clc
	pop ebx
	pop eax
	imul eax, ebx
	push eax
	jmp next

SLASH_start:
	dd MULT_start
	db "/", 0
SLASH_CFA:
	dd SLASH_BEGIN
SLASH_BEGIN:
	pop ebx
	pop eax
        cmp eax, 0
        jl isnegative
        xor edx, edx
SLASH_continue:
	or ebx, ebx
	jz baddiv
	idiv ebx
	push eax
	jmp next

rem_start:
	dd SLASH_start
	db "rem", 0
rem_CFA:
	dd rem_BEGIN
rem_BEGIN:
	pop ebx
	pop eax
	xor edx, edx
	or ebx, ebx
	jz baddiv
	div ebx
	push edx
	jmp next

isnegative:
        mov edx, -1
        jmp SLASH_continue

baddiv:
	push dword 0
	jmp next

exec_start:
	dd rem_start
	db "exec", 0
exec_CFA:
	dd exec_BEGIN
exec_BEGIN:
	pop eax
	jmp [eax]

pick_start:
   dd exec_start
   db "pick", 0
pick_CFA:
   dd pick_BEGIN
pick_BEGIN:
   pop eax
   shl eax, 2
   push dword [esp + eax]
   jmp next

endDASHofDASHmem_start:
	dd pick_start
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
	or al, al
	jz emit_null
emit_return:
	mov byte [emit_buffer], al
	pushad
	mov eax, 4
	mov ebx, 1
	mov ecx, emit_buffer
	mov edx, 1
	int 0x80
	popad
	jmp next
emit_null:
	mov al, 32
	jmp emit_return

and_start:
	dd emit_start
	db "and", 0
and_CFA:
	dd and_BEGIN
and_BEGIN:
	pop eax
	pop ebx
	and eax, ebx
	push eax
	jmp next

or_start:
        dd and_start
        db "or", 0
or_CFA:
        dd or_BEGIN
or_BEGIN:
        pop eax
        pop ebx
        or eax, ebx
        push eax
        jmp next

xor_start:
        dd or_start
        db "xor", 0
xor_CFA:
        dd xor_BEGIN
xor_BEGIN:
        pop eax
        pop ebx
        xor eax, ebx
        push eax
        jmp next

GT_start:
	dd xor_start
	db ">", 0
GT_CFA:
	dd GT_BEGIN
GT_BEGIN:
	pop ebx
	pop eax
	cmp eax, ebx
	jg is_true
	jmp is_false

LT_start:
	dd GT_start
	db "<", 0
LT_CFA:
	dd LT_BEGIN
LT_BEGIN:
	pop ebx
	pop eax
	cmp eax, ebx
	jl is_true
	jmp is_false

is_true:
	push dword 1
	jmp next

is_false:
	push dword 0
	jmp next

shl_start:
	dd LT_start
	db "shl", 0
shl_CFA:
	dd shl_BEGIN
shl_BEGIN:
	pop eax
	pop ecx
	shl eax, cl
	push eax
	jmp next

shr_start:
	dd shl_start
	db "shr", 0
shr_CFA:
	dd shr_BEGIN
shr_BEGIN:
	pop ecx
	pop eax
	shr eax, cl
	push eax
	jmp next

GTr_start:
	dd shr_start
	db ">r", 0
GTr_CFA:
	dd GTr_BEGIN
GTr_BEGIN:
	pop eax
	mov dword [ebp], eax
	add ebp, 4
	jmp next

key_start:
	dd GTr_start
	db "key", 0
key_CFA:
	dd key_BEGIN
key_BEGIN:
	push ebp
	mov ebp, esp
	pusha
	mov eax, 3		;SYS_READ
	mov ebx, 0		;stdin
	mov ecx, emit_buffer	;Buffer to read to
	mov edx, 1		;one byte
	int 0x80
	popa
	mov esp, ebp
	pop ebp
	xor eax, eax
	mov al, byte [emit_buffer]
	push eax
	jmp next

rGT_start:
	dd key_start
	db "r>", 0
rGT_CFA:
	dd rGT_BEGIN
rGT_BEGIN:
	sub ebp, 4
	mov eax, dword [ebp]
	push eax
	jmp next

ROM_ADDR_start:
	dd rGT_start
	db "ROM_ADDR", 0
ROM_ADDR_CFA:
	dd ROM_ADDR_BEGIN
ROM_ADDR_BEGIN:
	push dword code_start
	jmp next




;Extensions needed for multitasking

rAT_start:
        dd ROM_ADDR_start
        db "r@", 0
rAT_CFA:
        dd rAT_BEGIN
rAT_BEGIN:
        push ebp
        jmp next

rEXC_start:
        dd rAT_start
        db "r!", 0
rEXC_CFA:
        dd rEXC_BEGIN
rEXC_BEGIN:
        pop ebp
        jmp next

spAT_start:
        dd rEXC_start
        db "sp@", 0
spAT_CFA:
        dd spAT_BEGIN
spAT_BEGIN:
        push esp
        jmp next

spEXC_start:
        dd spAT_start
        db "sp!", 0
spEXC_CFA:
        dd spEXC_BEGIN
spEXC_BEGIN:
        pop esp
        jmp next

bnot_start:
        dd spEXC_start
        db "bnot", 0
bnot_CFA:
        dd bnot_BEGIN
bnot_BEGIN:
        pop eax
        not eax
        push eax
        jmp next

argv_start:
	dd bnot_start
	db "argv", 0
argv_CFA:
	dd argv_BEGIN
argv_BEGIN:
	push dword [argv_hold]
	jmp next

argc_start:
	dd argv_start
	db "argc", 0
argc_CFA:
	dd argc_BEGIN
argc_BEGIN:
	push dword [argc_hold]
	jmp next

;ws ( -- word-size)
ws_start:
	dd argc_start
	db "ws", 0
ws_CFA:
	dd ws_BEGIN
ws_BEGIN:
	push dword 4
	jmp next


section .data

emit_buffer: db 0, 0
emit_zero: dd 0
hello_str: db "hello, world", 0
argv_hold: dd 0
argc_hold: dd 0

%include "arch/forth.asm"
%include "arch/unix/unix.asm"

code_start:
	db "127 bs-val !"
	db " "
	incbin "src/string.forth"
	db " "
	incbin "src/file.forth"
	db " "
	incbin "src/dis.forth"
	db " "
	incbin "src/strlib.forth"
	db " "
	incbin "src/compile.forth"
	db " "
	incbin "src/syntax.forth"
	db " "
	incbin "src/safelist.forth"
	db " "
	incbin "src/imports.forth"
	db " word init1.forth import "
	db 0

c_var_loc:
	times 8 dd 0

;4 MB heap
end_of_forth:
times 1024 * 1024 * 8 db 0
