;These are used for binding C functions on hosted systems
;THESE EXPECT CDECL

%macro SAVE_STACK 0
	push ebp
	mov ebp, esp
%endmacro

%macro RESTORE_STACK 0
	mov esp, ebp
	pop ebp
%endmacro

%macro SAVE_REG_STATE 0
	pusha
%endmacro

%macro RESTORE_REG_STATE 0
	popa
%endmacro

%define EXTERNAL_C_DEF extern
%define C_CALL call

%macro PUSH_FORTH_0 0
%endmacro

%define SAVE_FORTH_0

%macro SAVE_FORTH_1 0
	pop eax
	mov dword [c_var_loc], eax
%endmacro


%macro SAVE_FORTH_2 0
	pop eax
	mov dword [c_var_loc], eax
	pop eax
	mov dword [c_var_loc+4], eax
%endmacro

%macro SAVE_FORTH_3 0
	pop eax
	mov dword [c_var_loc], eax
	pop eax
	mov dword [c_var_loc + 4], eax
	pop eax
	mov dword [c_var_loc + 8], eax
%endmacro

%macro PUSH_FORTH_1 0
	mov eax, dword [c_var_loc]
	push eax
%endmacro

%macro PUSH_FORTH_2 0
	PUSH_FORTH_1 
	mov eax, dword [c_var_loc + 4]
	push eax
%endmacro

%macro PUSH_FORTH_3 0
	PUSH_FORTH_1 
	mov eax, dword [c_var_loc + 4]
	push eax
	mov eax, dword [c_var_loc + 8]
	push eax
%endmacro

%define GET_RETURNS_0

%macro GET_RETURNS_1 0
	mov eax, dword [c_var_loc]
	push eax
%endmacro

%macro SAVE_0 0
%endmacro

%macro SAVE_1 0
	mov dword [c_var_loc], eax
%endmacro

%define GO_NEXT jmp next

%macro STORE_VALUE_AT 2
	mov eax, %2
	mov dword [%1], eax
%endmacro

%define RETURN_FROM_FUNCTION ret
