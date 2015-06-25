\ FORTHSTRAP
\ This file will be processed by the FORTHSTRAP tool to create a custom
\ 	forth distribution. This code cannot be recompiled by the generated
\	interpreter, but is simply intended to bootstrap an interpreter for
\	you. See github.com/16Bitt/forthstrap for more info.

\ Assuming that ! c! @ c@ jp jz and arithmetic operators are present
\ Words starting with % are compiler words

\ %: is a normal word
\ %C: is a compile-time word
\ %B: is a word at both compile and run-time
\ %lit pushes the CFA of the next word
\ %goto jumps to the label specified with ~
\ %gotonz same as goto, but when not zero
\ %gotoz opposite of gotonz

\ -----------------------
\ Some utility words
\ -----------------------

\ Junk variables for creating stack operations
%variable reg0
%variable reg1
%variable reg2

\ Common stack operations
%: dup reg0 ! reg0 @ reg0 @ %;
%: swap reg1 ! reg0 ! reg1 @ reg0 @ %;
%: drop reg0 ! %;
%: dup2 reg0 ! reg1 ! reg1 @ reg0 @ reg1 @ reg0 @ %;
%: over2 reg0 ! reg1 ! reg2 ! reg2 @ reg1 @ reg0 @ reg2 @ %;

\ Common words
%: 1+! dup @ 1 + swap ! %;
%: 2+! dup @ 2 + swap ! %;
%: ws+! dup @ ws + swap ! %;
%: 1-! dup @ 1 - swap ! %;
%: 2-! dup @ 2 - swap ! %;
%: ws-! dup @ ws - swap ! %;
%: 0! 0 swap ! %;
%: true 1 %;
%: false 0 %;
%: not %if false %else true %then %;
\ -----------------------
\ HERE related vocabulary
\ -----------------------

%variable here
\ This will be called at the start of the FORTH
%: heap-init end-of-mem 512 + here ! %;
%: , here @ ! here ws+! %;
%: c, here @ c! here 1+! %;


\ ----------------------
\ String vocabulary
\ ----------------------

\ This is where things get a bit messy-- gotos and variables abound
%variable str-length
%: strlen str-length 0!
	~strlen-loop
		dup c@ %if str-length 1+! 1 + %goto strlen-loop %then
	drop
	str-length @
%;

%variable strcmp-count
%: strcmp dup2 strlen swap strlen
	- %if drop drop false exit %then
	dup strlen strcmp-count !
	~strcmp-loop
		dup2
		@ @ - %if drop drop false exit %then
		1 + swap 1 +
		strcmp-count 1-!
		strcmp-count @
	%goto-nz strcmp-loop
	drop drop
	true
%;


\ -----------------------
\ Compiler vocabulary
\ -----------------------

%variable state
%: [ 1 state ! %;
%: ] 0 state ! %;

\ Finds a word in the runtime vocab list
%: find
	last @
	~find-loop
		dup ws +
		over2 strcmp %if swap drop exit %then
		@ dup
	%goto-nz find-loop
	false
%;

\ CFIND is the same as find, but searches the compile-time vocab
%: cfind
	clast @
	~cfind-loop
		dup ws +
		over2 strcmp %if swap drop exit %then
		@ dup
	%goto-nz cfind-loop
	false
%;
\ %: create here @ last @ , last ! word strmov %;
\ %: variable create %lit lit , here @ 0 , %lit exit , here @ ! here ws+! %;
\ %: : create [ %lit enter , %;
\ %: ;  %lit exit , ] %;

\ --------------------------
\ Initialize the environment
\ --------------------------

\ Add a custom payload here

%: init heap-init %;
