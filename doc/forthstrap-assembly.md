Forthstrap's Generic Macro Assembly
-----------------------------------

Forthstrap is designed to be incredibly generic. While it may not always be optimal, forthstrap is flexible. One of the many cases of flexibility over beauty is in the case of forthstrap's output.

```
;Example from the outputted forth.asm
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

```

From this mess of an example you get to see most of how forthstrap's output looks: mangled names, no actual operators, and lots of something named SAVE_WS.
