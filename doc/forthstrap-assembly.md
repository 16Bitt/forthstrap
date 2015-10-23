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

_What it Actually Does_

Forthstrap spits out a massive assembly file in the above format. Why? Well, with some simple macros in the assembler of your choice, and a few assembly words (not even these, if you choose to use the C ABI, possibly), and bam! You have a tailored distribution. It's easy to modify the core FORTH engine, add new components, and start developing software.

_Common Outputs_

* SAVE_WS: should be "dd" for nasm x86, simply saves a word that is the word size of your CPU
* Anything ending in an ':': This should be clear to assembly programmers, simply a label constant
* STRING: Saves a string, allowing the appending of a null terminator. Nasm x86 should define this as "db".

