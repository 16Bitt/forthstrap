;This is the layout of the stack after a call
;	ARG2
;	ARG1
;	ARG0
;	EIP
;	EBP
; =>

define ARG0 [ebp + 8]
define ARG1 [ebp + 12]
define ARG2 [ebp + 16]
define ARG3 [ebp + 20]
define ARG4 [ebp + 24]
define ARG5 [ebp + 28]
define ARG6 [ebp + 32]
