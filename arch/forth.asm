regZERO_start:
	SAVE_WS ws_start
	STRING "reg0", 0
regZERO_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label0
	SAVE_WS exit_CFA
label0:
	SAVE_WS 0

regONE_start:
	SAVE_WS regZERO_start
	STRING "reg1", 0
regONE_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label1
	SAVE_WS exit_CFA
label1:
	SAVE_WS 0

regTWO_start:
	SAVE_WS regONE_start
	STRING "reg2", 0
regTWO_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label2
	SAVE_WS exit_CFA
label2:
	SAVE_WS 0

dup_start:
	SAVE_WS regTWO_start
	STRING "dup", 0
dup_CFA:
	SAVE_WS enter_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS EXC_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS AT_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS AT_CFA
	SAVE_WS exit_CFA

swap_start:
	SAVE_WS dup_start
	STRING "swap", 0
swap_CFA:
	SAVE_WS enter_CFA
	SAVE_WS regONE_CFA
	SAVE_WS EXC_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS EXC_CFA
	SAVE_WS regONE_CFA
	SAVE_WS AT_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS AT_CFA
	SAVE_WS exit_CFA

drop_start:
	SAVE_WS swap_start
	STRING "drop", 0
drop_CFA:
	SAVE_WS enter_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

TWOdup_start:
	SAVE_WS drop_start
	STRING "2dup", 0
TWOdup_CFA:
	SAVE_WS enter_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS EXC_CFA
	SAVE_WS regONE_CFA
	SAVE_WS EXC_CFA
	SAVE_WS regONE_CFA
	SAVE_WS AT_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS AT_CFA
	SAVE_WS regONE_CFA
	SAVE_WS AT_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS AT_CFA
	SAVE_WS exit_CFA

TWOover_start:
	SAVE_WS TWOdup_start
	STRING "2over", 0
TWOover_CFA:
	SAVE_WS enter_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS EXC_CFA
	SAVE_WS regONE_CFA
	SAVE_WS EXC_CFA
	SAVE_WS regTWO_CFA
	SAVE_WS EXC_CFA
	SAVE_WS regTWO_CFA
	SAVE_WS AT_CFA
	SAVE_WS regONE_CFA
	SAVE_WS AT_CFA
	SAVE_WS regZERO_CFA
	SAVE_WS AT_CFA
	SAVE_WS regTWO_CFA
	SAVE_WS AT_CFA
	SAVE_WS exit_CFA

ONEPLUSEXC_start:
	SAVE_WS TWOover_start
	STRING "1+!", 0
ONEPLUSEXC_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS AT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS swap_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

TWOPLUSEXC_start:
	SAVE_WS ONEPLUSEXC_start
	STRING "2+!", 0
TWOPLUSEXC_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS AT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 2
	SAVE_WS PLUS_CFA
	SAVE_WS swap_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

wsPLUSEXC_start:
	SAVE_WS TWOPLUSEXC_start
	STRING "ws+!", 0
wsPLUSEXC_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS AT_CFA
	SAVE_WS ws_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS swap_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

ONEDASHEXC_start:
	SAVE_WS wsPLUSEXC_start
	STRING "1-!", 0
ONEDASHEXC_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS AT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS DASH_CFA
	SAVE_WS swap_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

TWODASHEXC_start:
	SAVE_WS ONEDASHEXC_start
	STRING "2-!", 0
TWODASHEXC_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS AT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 2
	SAVE_WS DASH_CFA
	SAVE_WS swap_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

wsDASHEXC_start:
	SAVE_WS TWODASHEXC_start
	STRING "ws-!", 0
wsDASHEXC_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS AT_CFA
	SAVE_WS ws_CFA
	SAVE_WS DASH_CFA
	SAVE_WS swap_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

ZEROEXC_start:
	SAVE_WS wsDASHEXC_start
	STRING "0!", 0
ZEROEXC_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS swap_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

true_start:
	SAVE_WS ZEROEXC_start
	STRING "true", 0
true_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS exit_CFA

false_start:
	SAVE_WS true_start
	STRING "false", 0
false_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS exit_CFA

not_start:
	SAVE_WS false_start
	STRING "not", 0
not_CFA:
	SAVE_WS enter_CFA
	SAVE_WS jz_CFA
	SAVE_WS label3
	SAVE_WS false_CFA
	SAVE_WS jp_CFA
	SAVE_WS label4
label3:
	SAVE_WS true_CFA
label4:
	SAVE_WS exit_CFA

EQUAL_start:
	SAVE_WS not_start
	STRING "=", 0
EQUAL_CFA:
	SAVE_WS enter_CFA
	SAVE_WS DASH_CFA
	SAVE_WS not_CFA
	SAVE_WS exit_CFA

negate_start:
	SAVE_WS EQUAL_start
	STRING "negate", 0
negate_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS swap_CFA
	SAVE_WS DASH_CFA
	SAVE_WS exit_CFA

within?_start:
	SAVE_WS negate_start
	STRING "within?", 0
within?_CFA:
	SAVE_WS enter_CFA
	SAVE_WS TWOover_CFA
	SAVE_WS GT_CFA
	SAVE_WS swap_CFA
	SAVE_WS TWOover_CFA
	SAVE_WS LT_CFA
	SAVE_WS and_CFA
	SAVE_WS swap_CFA
	SAVE_WS drop_CFA
	SAVE_WS exit_CFA

here_start:
	SAVE_WS within?_start
	STRING "here", 0
here_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label5
	SAVE_WS exit_CFA
label5:
	SAVE_WS 0

heapDASHinit_start:
	SAVE_WS here_start
	STRING "heap-init", 0
heapDASHinit_CFA:
	SAVE_WS enter_CFA
	SAVE_WS endDASHofDASHmem_CFA
	SAVE_WS lit_CFA
	SAVE_WS 512
	SAVE_WS PLUS_CFA
	SAVE_WS here_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

COMMA_start:
	SAVE_WS heapDASHinit_start
	STRING ",", 0
COMMA_CFA:
	SAVE_WS enter_CFA
	SAVE_WS here_CFA
	SAVE_WS AT_CFA
	SAVE_WS EXC_CFA
	SAVE_WS here_CFA
	SAVE_WS wsPLUSEXC_CFA
	SAVE_WS exit_CFA

cCOMMA_start:
	SAVE_WS COMMA_start
	STRING "c,", 0
cCOMMA_CFA:
	SAVE_WS enter_CFA
	SAVE_WS here_CFA
	SAVE_WS AT_CFA
	SAVE_WS cEXC_CFA
	SAVE_WS here_CFA
	SAVE_WS ONEPLUSEXC_CFA
	SAVE_WS exit_CFA

allot_start:
	SAVE_WS cCOMMA_start
	STRING "allot", 0
allot_CFA:
	SAVE_WS enter_CFA
	SAVE_WS here_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS here_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

strDASHlength_start:
	SAVE_WS allot_start
	STRING "str-length", 0
strDASHlength_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label6
	SAVE_WS exit_CFA
label6:
	SAVE_WS 0

strlen_start:
	SAVE_WS strDASHlength_start
	STRING "strlen", 0
strlen_CFA:
	SAVE_WS enter_CFA
	SAVE_WS strDASHlength_CFA
	SAVE_WS ZEROEXC_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS DASH_CFA
strlenDASHloop_anon:
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS dup_CFA
	SAVE_WS cAT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label7
	SAVE_WS strDASHlength_CFA
	SAVE_WS ONEPLUSEXC_CFA
label7:
	SAVE_WS dup_CFA
	SAVE_WS cAT_CFA
	SAVE_WS jnz_CFA
	SAVE_WS strlenDASHloop_anon
	SAVE_WS drop_CFA
	SAVE_WS strDASHlength_CFA
	SAVE_WS AT_CFA
	SAVE_WS exit_CFA

strcmpDASHcount_start:
	SAVE_WS strlen_start
	STRING "strcmp-count", 0
strcmpDASHcount_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label8
	SAVE_WS exit_CFA
label8:
	SAVE_WS 0

strcmp_start:
	SAVE_WS strcmpDASHcount_start
	STRING "strcmp", 0
strcmp_CFA:
	SAVE_WS enter_CFA
	SAVE_WS TWOdup_CFA
	SAVE_WS strlen_CFA
	SAVE_WS swap_CFA
	SAVE_WS strlen_CFA
	SAVE_WS EQUAL_CFA
	SAVE_WS not_CFA
	SAVE_WS jz_CFA
	SAVE_WS label9
	SAVE_WS drop_CFA
	SAVE_WS drop_CFA
	SAVE_WS false_CFA
	SAVE_WS exit_CFA
label9:
	SAVE_WS dup_CFA
	SAVE_WS strlen_CFA
	SAVE_WS strcmpDASHcount_CFA
	SAVE_WS EXC_CFA
strcmpDASHloop_anon:
	SAVE_WS TWOdup_CFA
	SAVE_WS cAT_CFA
	SAVE_WS swap_CFA
	SAVE_WS cAT_CFA
	SAVE_WS EQUAL_CFA
	SAVE_WS not_CFA
	SAVE_WS jz_CFA
	SAVE_WS label10
	SAVE_WS drop_CFA
	SAVE_WS drop_CFA
	SAVE_WS false_CFA
	SAVE_WS exit_CFA
label10:
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS swap_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS strcmpDASHcount_CFA
	SAVE_WS ONEDASHEXC_CFA
	SAVE_WS strcmpDASHcount_CFA
	SAVE_WS AT_CFA
	SAVE_WS jnz_CFA
	SAVE_WS strcmpDASHloop_anon
	SAVE_WS drop_CFA
	SAVE_WS drop_CFA
	SAVE_WS true_CFA
	SAVE_WS exit_CFA

strmov_start:
	SAVE_WS strcmp_start
	STRING "strmov", 0
strmov_CFA:
	SAVE_WS enter_CFA
strmovDASHloop_anon:
	SAVE_WS dup_CFA
	SAVE_WS cAT_CFA
	SAVE_WS dup_CFA
	SAVE_WS cCOMMA_CFA
	SAVE_WS swap_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS swap_CFA
	SAVE_WS jnz_CFA
	SAVE_WS strmovDASHloop_anon
	SAVE_WS drop_CFA
	SAVE_WS exit_CFA

state_start:
	SAVE_WS strmov_start
	STRING "state", 0
state_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label11
	SAVE_WS exit_CFA
label11:
	SAVE_WS 0

LBRACK_start:
	SAVE_WS state_start
	STRING "[", 0
LBRACK_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS state_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

RBRACK_start:
	SAVE_WS LBRACK_start
	STRING "]", 0
RBRACK_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS state_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

find_start:
	SAVE_WS RBRACK_start
	STRING "find", 0
find_CFA:
	SAVE_WS enter_CFA
	SAVE_WS last_CFA
	SAVE_WS AT_CFA
findDASHloop_anon:
	SAVE_WS dup_CFA
	SAVE_WS ws_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS TWOover_CFA
	SAVE_WS strcmp_CFA
	SAVE_WS jz_CFA
	SAVE_WS label12
	SAVE_WS swap_CFA
	SAVE_WS drop_CFA
	SAVE_WS exit_CFA
label12:
	SAVE_WS AT_CFA
	SAVE_WS dup_CFA
	SAVE_WS jnz_CFA
	SAVE_WS findDASHloop_anon
	SAVE_WS drop_CFA
	SAVE_WS drop_CFA
	SAVE_WS false_CFA
	SAVE_WS exit_CFA

cfind_start:
	SAVE_WS find_start
	STRING "cfind", 0
cfind_CFA:
	SAVE_WS enter_CFA
	SAVE_WS clast_CFA
	SAVE_WS AT_CFA
cfindDASHloop_anon:
	SAVE_WS dup_CFA
	SAVE_WS ws_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS TWOover_CFA
	SAVE_WS strcmp_CFA
	SAVE_WS jz_CFA
	SAVE_WS label13
	SAVE_WS swap_CFA
	SAVE_WS drop_CFA
	SAVE_WS exit_CFA
label13:
	SAVE_WS AT_CFA
	SAVE_WS dup_CFA
	SAVE_WS jnz_CFA
	SAVE_WS cfindDASHloop_anon
	SAVE_WS drop_CFA
	SAVE_WS drop_CFA
	SAVE_WS false_CFA
	SAVE_WS exit_CFA

buffer_start:
	SAVE_WS cfind_start
	STRING "buffer", 0
buffer_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label14
	SAVE_WS exit_CFA
label14:
	SAVE_WS 0

bufferDASHlength_start:
	SAVE_WS buffer_start
	STRING "buffer-length", 0
bufferDASHlength_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label15
	SAVE_WS exit_CFA
label15:
	SAVE_WS 0

position_start:
	SAVE_WS bufferDASHlength_start
	STRING "position", 0
position_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label16
	SAVE_WS exit_CFA
label16:
	SAVE_WS 0

prepare_start:
	SAVE_WS position_start
	STRING "prepare", 0
prepare_CFA:
	SAVE_WS enter_CFA
	SAVE_WS position_CFA
	SAVE_WS ZEROEXC_CFA
prepareDASHloop_anon:
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cAT_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 13
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label17
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cEXC_CFA
label17:
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 10
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label18
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cEXC_CFA
label18:
	SAVE_WS lit_CFA
	SAVE_WS 32
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label19
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cEXC_CFA
label19:
	SAVE_WS position_CFA
	SAVE_WS ONEPLUSEXC_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS bufferDASHlength_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS LT_CFA
	SAVE_WS jnz_CFA
	SAVE_WS prepareDASHloop_anon
	SAVE_WS position_CFA
	SAVE_WS ZEROEXC_CFA
	SAVE_WS exit_CFA

clear_start:
	SAVE_WS prepare_start
	STRING "clear", 0
clear_CFA:
	SAVE_WS enter_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS ZEROEXC_CFA
clearDASHloop_anon:
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cEXC_CFA
	SAVE_WS position_CFA
	SAVE_WS ONEPLUSEXC_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS bufferDASHlength_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS LT_CFA
	SAVE_WS jnz_CFA
	SAVE_WS clearDASHloop_anon
	SAVE_WS position_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

word_start:
	SAVE_WS clear_start
	STRING "word", 0
word_CFA:
	SAVE_WS enter_CFA
wordDASHloopONE_anon:
	SAVE_WS position_CFA
	SAVE_WS ONEPLUSEXC_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cAT_CFA
	SAVE_WS jnz_CFA
	SAVE_WS wordDASHloopONE_anon
wordDASHloopTWO_anon:
	SAVE_WS position_CFA
	SAVE_WS ONEPLUSEXC_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cAT_CFA
	SAVE_WS jz_CFA
	SAVE_WS wordDASHloopTWO_anon
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS bufferDASHlength_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS GT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label20
	SAVE_WS false_CFA
	SAVE_WS jp_CFA
	SAVE_WS label21
label20:
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS bufferDASHlength_CFA
	SAVE_WS AT_CFA
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label22
	SAVE_WS false_CFA
	SAVE_WS jp_CFA
	SAVE_WS label23
label22:
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
label23:
label21:
	SAVE_WS exit_CFA

number?_start:
	SAVE_WS word_start
	STRING "number?", 0
number?_CFA:
	SAVE_WS enter_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cAT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 45
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label24
	SAVE_WS position_CFA
	SAVE_WS ONEPLUSEXC_CFA
label24:
isnumberDASHloop_anon:
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cAT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 47
	SAVE_WS lit_CFA
	SAVE_WS 58
	SAVE_WS within?_CFA
	SAVE_WS not_CFA
	SAVE_WS jz_CFA
	SAVE_WS label25
	SAVE_WS false_CFA
	SAVE_WS swap_CFA
	SAVE_WS position_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA
label25:
	SAVE_WS position_CFA
	SAVE_WS ONEPLUSEXC_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cAT_CFA
	SAVE_WS jnz_CFA
	SAVE_WS isnumberDASHloop_anon
	SAVE_WS true_CFA
	SAVE_WS swap_CFA
	SAVE_WS position_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

result_start:
	SAVE_WS number?_start
	STRING "result", 0
result_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label26
	SAVE_WS exit_CFA
label26:
	SAVE_WS 0

negated_start:
	SAVE_WS result_start
	STRING "negated", 0
negated_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label27
	SAVE_WS exit_CFA
label27:
	SAVE_WS 0

number_start:
	SAVE_WS negated_start
	STRING "number", 0
number_CFA:
	SAVE_WS enter_CFA
	SAVE_WS result_CFA
	SAVE_WS ZEROEXC_CFA
	SAVE_WS dup_CFA
	SAVE_WS cAT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 45
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label28
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS true_CFA
	SAVE_WS jp_CFA
	SAVE_WS label29
label28:
	SAVE_WS false_CFA
label29:
	SAVE_WS negated_CFA
	SAVE_WS EXC_CFA
numberDASHloop_anon:
	SAVE_WS dup_CFA
	SAVE_WS cAT_CFA
	SAVE_WS dup_CFA
	SAVE_WS dup_CFA
	SAVE_WS jz_CFA
	SAVE_WS label30
	SAVE_WS result_CFA
	SAVE_WS AT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 10
	SAVE_WS MULT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS lit_CFA
	SAVE_WS 48
	SAVE_WS DASH_CFA
	SAVE_WS result_CFA
	SAVE_WS EXC_CFA
label30:
	SAVE_WS swap_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS swap_CFA
	SAVE_WS jnz_CFA
	SAVE_WS numberDASHloop_anon
	SAVE_WS negated_CFA
	SAVE_WS AT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label31
	SAVE_WS result_CFA
	SAVE_WS AT_CFA
	SAVE_WS negate_CFA
	SAVE_WS result_CFA
	SAVE_WS EXC_CFA
label31:
	SAVE_WS drop_CFA
	SAVE_WS drop_CFA
	SAVE_WS result_CFA
	SAVE_WS AT_CFA
	SAVE_WS exit_CFA

create_start:
	SAVE_WS number_start
	STRING "create", 0
create_CFA:
	SAVE_WS enter_CFA
	SAVE_WS here_CFA
	SAVE_WS AT_CFA
	SAVE_WS last_CFA
	SAVE_WS AT_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS last_CFA
	SAVE_WS EXC_CFA
	SAVE_WS word_CFA
	SAVE_WS strmov_CFA
	SAVE_WS exit_CFA

variable_start:
	SAVE_WS create_start
	STRING "variable", 0
variable_CFA:
	SAVE_WS enter_CFA
	SAVE_WS create_CFA
	SAVE_WS lit_CFA
	SAVE_WS enter_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS lit_CFA
	SAVE_WS lit_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS here_CFA
	SAVE_WS AT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS COMMA_CFA
	SAVE_WS lit_CFA
	SAVE_WS exit_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS here_CFA
	SAVE_WS AT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS COMMA_CFA
	SAVE_WS swap_CFA
	SAVE_WS EXC_CFA
	SAVE_WS exit_CFA

COLON_start:
	SAVE_WS variable_start
	STRING ":", 0
COLON_CFA:
	SAVE_WS enter_CFA
	SAVE_WS create_CFA
	SAVE_WS LBRACK_CFA
	SAVE_WS lit_CFA
	SAVE_WS enter_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS exit_CFA

SCOLON_start:
	SAVE_WS 0
	STRING ";", 0
SCOLON_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS exit_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS RBRACK_CFA
	SAVE_WS exit_CFA

cfa_start:
	SAVE_WS COLON_start
	STRING "cfa", 0
cfa_CFA:
	SAVE_WS enter_CFA
	SAVE_WS ws_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS dup_CFA
	SAVE_WS strlen_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS exit_CFA

TICK_start:
	SAVE_WS cfa_start
	STRING "`", 0
TICK_CFA:
	SAVE_WS enter_CFA
	SAVE_WS word_CFA
	SAVE_WS find_CFA
	SAVE_WS cfa_CFA
	SAVE_WS exit_CFA

errorlevel_start:
	SAVE_WS TICK_start
	STRING "errorlevel", 0
errorlevel_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label32
	SAVE_WS exit_CFA
label32:
	SAVE_WS 0

interp_start:
	SAVE_WS errorlevel_start
	STRING "interp", 0
interp_CFA:
	SAVE_WS enter_CFA
	SAVE_WS prepare_CFA
shellDASHloopDASHinner_anon:
	SAVE_WS word_CFA
	SAVE_WS found_CFA
	SAVE_WS EXC_CFA
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label33
	SAVE_WS state_CFA
	SAVE_WS AT_CFA
	SAVE_WS not_CFA
	SAVE_WS jz_CFA
	SAVE_WS label34
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS find_CFA
	SAVE_WS found_CFA
	SAVE_WS EXC_CFA
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label35
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS cfa_CFA
	SAVE_WS exec_CFA
	SAVE_WS jp_CFA
	SAVE_WS label36
label35:
	SAVE_WS number?_CFA
	SAVE_WS jz_CFA
	SAVE_WS label37
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS number_CFA
	SAVE_WS true_CFA
	SAVE_WS found_CFA
	SAVE_WS EXC_CFA
	SAVE_WS jp_CFA
	SAVE_WS label38
label37:
	SAVE_WS true_CFA
	SAVE_WS errorlevel_CFA
	SAVE_WS EXC_CFA
label38:
label36:
	SAVE_WS jp_CFA
	SAVE_WS label39
label34:
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS cfind_CFA
	SAVE_WS found_CFA
	SAVE_WS EXC_CFA
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label40
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS cfa_CFA
	SAVE_WS exec_CFA
	SAVE_WS jp_CFA
	SAVE_WS label41
label40:
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS found_CFA
	SAVE_WS EXC_CFA
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS find_CFA
	SAVE_WS found_CFA
	SAVE_WS EXC_CFA
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label42
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS cfa_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS jp_CFA
	SAVE_WS label43
label42:
	SAVE_WS number?_CFA
	SAVE_WS jz_CFA
	SAVE_WS label44
	SAVE_WS lit_CFA
	SAVE_WS lit_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS number_CFA
	SAVE_WS COMMA_CFA
	SAVE_WS true_CFA
	SAVE_WS found_CFA
	SAVE_WS EXC_CFA
	SAVE_WS false_CFA
	SAVE_WS errorlevel_CFA
	SAVE_WS EXC_CFA
	SAVE_WS jp_CFA
	SAVE_WS label45
label44:
	SAVE_WS true_CFA
	SAVE_WS errorlevel_CFA
	SAVE_WS EXC_CFA
label45:
label43:
label41:
label39:
label33:
	SAVE_WS found_CFA
	SAVE_WS AT_CFA
	SAVE_WS jnz_CFA
	SAVE_WS shellDASHloopDASHinner_anon
	SAVE_WS exit_CFA

if_start:
	SAVE_WS SCOLON_start
	STRING "if", 0
if_CFA:
	SAVE_WS enter_CFA
	SAVE_WS exit_CFA

then_start:
	SAVE_WS if_start
	STRING "then", 0
then_CFA:
	SAVE_WS enter_CFA
	SAVE_WS exit_CFA

else_start:
	SAVE_WS then_start
	STRING "else", 0
else_CFA:
	SAVE_WS enter_CFA
	SAVE_WS exit_CFA

init_start:
	SAVE_WS interp_start
	STRING "init", 0
init_CFA:
	SAVE_WS enter_CFA
	SAVE_WS heapDASHinit_CFA
	SAVE_WS exit_CFA

wait_start:
	SAVE_WS init_start
	STRING "wait", 0
wait_CFA:
	SAVE_WS enter_CFA
	SAVE_WS key_CFA
	SAVE_WS drop_CFA
	SAVE_WS exit_CFA

tohex_start:
	SAVE_WS wait_start
	STRING "tohex", 0
tohex_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 4
	SAVE_WS shr_CFA
	SAVE_WS lit_CFA
	SAVE_WS 15
	SAVE_WS and_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 10
	SAVE_WS LT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label46
	SAVE_WS lit_CFA
	SAVE_WS 48
	SAVE_WS PLUS_CFA
	SAVE_WS jp_CFA
	SAVE_WS label47
label46:
	SAVE_WS lit_CFA
	SAVE_WS 10
	SAVE_WS DASH_CFA
	SAVE_WS lit_CFA
	SAVE_WS 65
	SAVE_WS PLUS_CFA
label47:
	SAVE_WS emit_CFA
	SAVE_WS lit_CFA
	SAVE_WS 15
	SAVE_WS and_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 10
	SAVE_WS LT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label48
	SAVE_WS lit_CFA
	SAVE_WS 48
	SAVE_WS PLUS_CFA
	SAVE_WS jp_CFA
	SAVE_WS label49
label48:
	SAVE_WS lit_CFA
	SAVE_WS 10
	SAVE_WS DASH_CFA
	SAVE_WS lit_CFA
	SAVE_WS 65
	SAVE_WS PLUS_CFA
label49:
	SAVE_WS emit_CFA
	SAVE_WS exit_CFA

DOT64_start:
	SAVE_WS tohex_start
	STRING ".64", 0
DOT64_CFA:
	SAVE_WS enter_CFA
	SAVE_WS exit_CFA

DOT3TWO_start:
	SAVE_WS DOT64_start
	STRING ".32", 0
DOT3TWO_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 24
	SAVE_WS shr_CFA
	SAVE_WS tohex_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 16
	SAVE_WS shr_CFA
	SAVE_WS tohex_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 8
	SAVE_WS shr_CFA
	SAVE_WS tohex_CFA
	SAVE_WS tohex_CFA
	SAVE_WS exit_CFA

DOTONE6_start:
	SAVE_WS DOT3TWO_start
	STRING ".16", 0
DOTONE6_CFA:
	SAVE_WS enter_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 8
	SAVE_WS shr_CFA
	SAVE_WS tohex_CFA
	SAVE_WS tohex_CFA
	SAVE_WS exit_CFA

DOT8_start:
	SAVE_WS DOTONE6_start
	STRING ".8", 0
DOT8_CFA:
	SAVE_WS enter_CFA
	SAVE_WS tohex_CFA
	SAVE_WS exit_CFA

DOT_start:
	SAVE_WS DOT8_start
	STRING ".", 0
DOT_CFA:
	SAVE_WS enter_CFA
	SAVE_WS ws_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label50
	SAVE_WS DOT8_CFA
label50:
	SAVE_WS ws_CFA
	SAVE_WS lit_CFA
	SAVE_WS 2
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label51
	SAVE_WS DOTONE6_CFA
label51:
	SAVE_WS ws_CFA
	SAVE_WS lit_CFA
	SAVE_WS 4
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label52
	SAVE_WS DOT3TWO_CFA
label52:
	SAVE_WS ws_CFA
	SAVE_WS lit_CFA
	SAVE_WS 8
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label53
	SAVE_WS DOT64_CFA
label53:
	SAVE_WS exit_CFA

DOTs_start:
	SAVE_WS DOT_start
	STRING ".s", 0
DOTs_CFA:
	SAVE_WS enter_CFA
dotsDASHloop_anon:
	SAVE_WS dup_CFA
	SAVE_WS cAT_CFA
	SAVE_WS swap_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS PLUS_CFA
	SAVE_WS swap_CFA
	SAVE_WS dup_CFA
	SAVE_WS emit_CFA
	SAVE_WS jnz_CFA
	SAVE_WS dotsDASHloop_anon
	SAVE_WS drop_CFA
	SAVE_WS exit_CFA

keyecho_start:
	SAVE_WS DOTs_start
	STRING "keyecho", 0
keyecho_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label54
	SAVE_WS exit_CFA
label54:
	SAVE_WS 0

line_start:
	SAVE_WS keyecho_start
	STRING "line", 0
line_CFA:
	SAVE_WS enter_CFA
lineDASHloop_anon:
	SAVE_WS key_CFA
	SAVE_WS dup_CFA
	SAVE_WS dup_CFA
	SAVE_WS lit_CFA
	SAVE_WS 13
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label55
	SAVE_WS drop_CFA
	SAVE_WS drop_CFA
	SAVE_WS cr_CFA
	SAVE_WS exit_CFA
label55:
	SAVE_WS lit_CFA
	SAVE_WS 8
	SAVE_WS EQUAL_CFA
	SAVE_WS jz_CFA
	SAVE_WS label56
	SAVE_WS drop_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS lit_CFA
	SAVE_WS 2
	SAVE_WS GT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label57
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cEXC_CFA
	SAVE_WS position_CFA
	SAVE_WS ONEDASHEXC_CFA
	SAVE_WS lit_CFA
	SAVE_WS 0
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cEXC_CFA
	SAVE_WS keyecho_CFA
	SAVE_WS AT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label58
	SAVE_WS lit_CFA
	SAVE_WS 8
	SAVE_WS emit_CFA
	SAVE_WS space_CFA
	SAVE_WS lit_CFA
	SAVE_WS 8
	SAVE_WS emit_CFA
label58:
label57:
	SAVE_WS jp_CFA
	SAVE_WS label59
label56:
	SAVE_WS keyecho_CFA
	SAVE_WS AT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label60
	SAVE_WS dup_CFA
	SAVE_WS emit_CFA
label60:
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS cEXC_CFA
	SAVE_WS position_CFA
	SAVE_WS ONEPLUSEXC_CFA
label59:
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS position_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS bufferDASHlength_CFA
	SAVE_WS AT_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS LT_CFA
	SAVE_WS jnz_CFA
	SAVE_WS lineDASHloop_anon
	SAVE_WS cr_CFA
	SAVE_WS exit_CFA

found_start:
	SAVE_WS line_start
	STRING "found", 0
found_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label61
	SAVE_WS exit_CFA
label61:
	SAVE_WS 0

shell_start:
	SAVE_WS found_start
	STRING "shell", 0
shell_CFA:
	SAVE_WS enter_CFA
	SAVE_WS here_CFA
	SAVE_WS AT_CFA
	SAVE_WS buffer_CFA
	SAVE_WS EXC_CFA
	SAVE_WS dup_CFA
	SAVE_WS allot_CFA
	SAVE_WS bufferDASHlength_CFA
	SAVE_WS EXC_CFA
shellDASHloop_anon:
	SAVE_WS clear_CFA
	SAVE_WS lit_CFA
	SAVE_WS 65
	SAVE_WS buffer_CFA
	SAVE_WS AT_CFA
	SAVE_WS cEXC_CFA
	SAVE_WS lit_CFA
	SAVE_WS 2
	SAVE_WS position_CFA
	SAVE_WS EXC_CFA
	SAVE_WS ok_CFA
	SAVE_WS line_CFA
	SAVE_WS lit_CFA
	SAVE_WS 3
	SAVE_WS spaces_CFA
	SAVE_WS interp_CFA
	SAVE_WS errorlevel_CFA
	SAVE_WS AT_CFA
	SAVE_WS jz_CFA
	SAVE_WS label62
	SAVE_WS error_CFA
	SAVE_WS false_CFA
	SAVE_WS errorlevel_CFA
	SAVE_WS EXC_CFA
label62:
	SAVE_WS cr_CFA
	SAVE_WS cr_CFA
	SAVE_WS jp_CFA
	SAVE_WS shellDASHloop_anon
	SAVE_WS exit_CFA

cr_start:
	SAVE_WS shell_start
	STRING "cr", 0
cr_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 10
	SAVE_WS emit_CFA
	SAVE_WS lit_CFA
	SAVE_WS 13
	SAVE_WS emit_CFA
	SAVE_WS exit_CFA

space_start:
	SAVE_WS cr_start
	STRING "space", 0
space_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 32
	SAVE_WS emit_CFA
	SAVE_WS exit_CFA

spaces_start:
	SAVE_WS space_start
	STRING "spaces", 0
spaces_CFA:
	SAVE_WS enter_CFA
spacesDASHloop_anon:
	SAVE_WS space_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS DASH_CFA
	SAVE_WS dup_CFA
	SAVE_WS jnz_CFA
	SAVE_WS spacesDASHloop_anon
	SAVE_WS drop_CFA
	SAVE_WS exit_CFA

list_start:
	SAVE_WS spaces_start
	STRING "list", 0
list_CFA:
	SAVE_WS enter_CFA
	SAVE_WS last_CFA
	SAVE_WS AT_CFA
listDASHloop_anon:
	SAVE_WS dup_CFA
	SAVE_WS ws_CFA
	SAVE_WS PLUS_CFA
	SAVE_WS DOTs_CFA
	SAVE_WS AT_CFA
	SAVE_WS dup_CFA
	SAVE_WS jnz_CFA
	SAVE_WS listDASHloop_anon
	SAVE_WS drop_CFA
	SAVE_WS exit_CFA

ok_start:
	SAVE_WS list_start
	STRING "ok", 0
ok_CFA:
	SAVE_WS enter_CFA
	SAVE_WS space_CFA
	SAVE_WS lit_CFA
	SAVE_WS 79
	SAVE_WS emit_CFA
	SAVE_WS lit_CFA
	SAVE_WS 75
	SAVE_WS emit_CFA
	SAVE_WS lit_CFA
	SAVE_WS 46
	SAVE_WS emit_CFA
	SAVE_WS space_CFA
	SAVE_WS exit_CFA

error_start:
	SAVE_WS ok_start
	STRING "error", 0
error_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS 33
	SAVE_WS emit_CFA
	SAVE_WS lit_CFA
	SAVE_WS 33
	SAVE_WS emit_CFA
	SAVE_WS lit_CFA
	SAVE_WS 33
	SAVE_WS emit_CFA
	SAVE_WS exit_CFA

test_start:
	SAVE_WS error_start
	STRING "test", 0
test_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label63
	SAVE_WS exit_CFA
label63:
	SAVE_WS 0

payload_start:
	SAVE_WS test_start
	STRING "payload", 0
payload_CFA:
	SAVE_WS enter_CFA
	SAVE_WS init_CFA
	SAVE_WS lit_CFA
	SAVE_WS 1
	SAVE_WS keyecho_CFA
	SAVE_WS EXC_CFA
	SAVE_WS lit_CFA
	SAVE_WS 256
	SAVE_WS shell_CFA
	SAVE_WS exit_CFA

clast_start:
	SAVE_WS else_start
	STRING "clast", 0
clast_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label64
	SAVE_WS exit_CFA
label64:
	SAVE_WS clast_start

last_start:
	SAVE_WS payload_start
	STRING "last", 0
last_CFA:
	SAVE_WS enter_CFA
	SAVE_WS lit_CFA
	SAVE_WS label65
	SAVE_WS exit_CFA
label65:
	SAVE_WS last_start

