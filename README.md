forthstrap
----------

There a few major problems with FORTH: fragmentation, incompatibility, and duplicated code for every single platform. And the FORTHs that do solve some of these problems ignore the tight coupling between the machine, or add ridiculous amounts of bloat very few people were asking for. When faced with these problems, most FORTHers decide to write their own FORTH, but I decided that would be defeat.  

So I made this collection of scripts to create a proper, yet consistent FORTH across any environment, any architecture, and any word size. No more rewriting the entire FORTH syntax, just pick the pieces you want to include, run them through the script, and write a little bit of assembly glue code.

# Usage

Enough of me on my high horse, let's get to the nitty gritty. You'll need a few things:

* UNIX coreutils-- sh, sed etc.
* GNU make (If you choose to use my test files)
* Ruby 1.9+
* Assembler of your choice

Then, you need to pick what components you want to include in your distribution (Note that each file will list the glue code requirements at the top):

* generic.forth-- Basic words and syntax, enough to start loading words at runtime
* io.forth-- Words like . .s etc
* payload.forth-- The testing suite, has a lot of edge case
* More are coming! Expect a string.forth, disk.forth, and math.forth soon!

Now you're ready to compile to assembler:

```bash
$ cat src/generic.forth src/io.forth | ./forthstrap > forth.asm
```

And then you want to write some glue code:

```assembly
	[bits 32]

;Converts the output to usable assembly
%define SAVE_WS dd
%macro STRING 1
	db %1, 0
%endmacro

;Start defining your glue...
PLUS_start:
	dd 0		;LAST field
	db "+", 0	;NAME field
PLUS_CFA:		
	PLUS_BEGIN	;START field (this will be ENTER in compiled words)
PLUS_BEGIN:
	pop eax		;Start hacking!
	pop ebx
	add eax, ebx
	push eax
	jmp next

;...And keep going, making sure to end on 'ws'
;This is only required for the nucleus layer, and the glue code

;...And then finally
%include "forth.asm"
```

And lastly, assemble your file:

```bash
$ nasm myforth.asm
```

# Adding more FORTH code before runtime
The script uses a percent sign to denote the compiler words, that include %if %then %else %goto %goto-nz %goto-z ~ %variable

```forth
\ A simple example
%variable x
%: test x @ %if 1 %else x 1+! 0 %then %;
```

Feel free to contact me with questions and/or suggestions! Or contributions!
