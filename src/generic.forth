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
%: 2dup reg0 ! reg1 ! reg1 @ reg0 @ reg1 @ reg0 @ %;
%: 2over reg0 ! reg1 ! reg2 ! reg2 @ reg1 @ reg0 @ reg2 @ %;

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
%: = - not %;

\
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
	1 -
	~strlen-loop
		1 +
		dup c@ %if str-length 1+! %then
		dup c@
	%goto-nz strlen-loop
	drop
	str-length @
%;

%variable strcmp-count
%: strcmp 2dup strlen swap strlen
	= not %if drop drop false exit %then
	dup strlen strcmp-count !
	~strcmp-loop
		2dup
		c@ swap c@ = not %if drop drop false exit %then
		1 + swap 1 +
		strcmp-count 1-!
		strcmp-count @
	%goto-nz strcmp-loop
	drop drop
	true
%;

%: strmov
	dup
	~strmov-loop
		c@ dup c,
		swap 1 + swap
	%goto-nz strmov-loop
	drop 0 c,
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
		2over strcmp %if swap drop exit %then
		@ dup
	%goto-nz find-loop
	drop drop false
%;

\ CFIND is the same as find, but searches the compile-time vocab
%: cfind
	clast @
	~cfind-loop
		dup ws +
		2over strcmp %if swap drop exit %then
		@ dup
	%goto-nz cfind-loop
	drop drop false
%;

%variable buffer
%variable buffer-length
%variable position

\ Clear the buffer and replace spaces and newlines with 0
%: prepare
	buffer @
	~prepare-loop
		dup @ c@ 10 = %if dup 0 swap @ ! %then
		dup @ c@ 32 = %if dup 0 swap @ ! %then
		1 + dup
		buffer @ buffer-length @ + =
	%goto-z prepare-loop
	drop
	0 position !
%;

\ Get a word from the buffer
%: word
	~word-loop1
		position 1+!
		position @ c@
	%goto-nz word-loop1

	~word-loop2
		position 1+!
		position @ c@
	%goto-z word-loop2

	position @ buffer @ buffer-length @ + > %if false %else position @ %then 
%;

%: create here @ last @ , last ! word strmov %;
%: variable create %lit lit , here @ 0 , %lit exit , here @ ! here ws+! %;
%: : create [ %lit enter , %;
%: ;  %lit exit , ] %;

\ --------------------------
\ Initialize the environment
\ --------------------------

%: init heap-init %;
