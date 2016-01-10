
\ FORTHSTRAP
\ This file will be processed by the FORTHSTRAP tool to create a custom
\ 	forth distribution. This code cannot be recompiled by the generated
\	interpreter, but is simply intended to bootstrap an interpreter for
\	you. See github.com/16Bitt/forthstrap for more info.

\ depends on: io.forth

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
%variable reg3

\ Common stack operations
%: dup reg0 ! reg0 @ reg0 @ %;
%: swap reg1 ! reg0 ! reg1 @ reg0 @ %;
%: drop reg0 ! %;
%: 2dup reg0 ! reg1 ! reg1 @ reg0 @ reg1 @ reg0 @ %;
%: 3dup reg0 ! reg1 ! reg2 ! reg2 @ reg1 @ reg0 @ reg2 @ reg1 @ reg0 @ %;
%: 2over reg0 ! reg1 ! reg2 ! reg2 @ reg1 @ reg0 @ reg2 @ %;
%: over reg0 ! reg1 ! reg1 @ reg0 @ reg1 @ %;
%: rot reg0 ! reg1 ! reg2 ! reg0 @ reg1 @ reg2 @ %;
%: 4dup reg0 ! reg1 ! reg2 ! reg3 ! reg3 @ reg2 @ reg1 @ reg0 @ reg3 @ reg2 @ reg1 @ reg0 @ %;

\ Common words
%: 1+ 1 + %;
%: 1- 1 - %;
%: 1+! dup @ 1 + swap ! %;
%: 2+! dup @ 2 + swap ! %;
%: ws+! dup @ ws + swap ! %;
%: 1-! dup @ 1 - swap ! %;
%: 2-! dup @ 2 - swap ! %;
%: ws-! dup @ ws - swap ! %;
%: 0! 0 swap ! %;
%: 0= 0 = %;
%: true 1 %;
%: false 0 %;
%: not %if false %else true %then %;
%: = - not %;
%: negate 0 swap - %;
\ n lower upper -- flag
%: within? 2over > swap 2over < and swap drop %;
%: cells ws * %;
%: even? 1 and not %;

\ -----------------------
\ HERE related vocabulary
\ -----------------------

%variable here
\ This will be called at the start of the FORTH
%: heap-init end-of-mem 512 + here ! %; %: , here @ ! here ws+! %;
%: c, here @ c! here 1+! %;
%: allot here @ + here ! %;
%: object here @ %;
%: ns ws 2 * %;
%: bits ws 8 * %;

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

%: strcmp
	~strcmp-loop
                2dup
                c@ swap c@ + not %if drop drop true exit %then
		2dup
		c@ swap c@ = not %if drop drop false exit %then
		1 + swap 1 +
	%goto strcmp-loop
%;

%: strmov
	~strmov-loop
		dup
		c@ dup c,
		swap 1 + swap
	%goto-nz strmov-loop
	drop
%;

\ -----------------------
\ Compiler vocabulary
\ -----------------------

%variable state
%: [ 1 state ! %;
%C: ] 0 state ! %;

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

\ Evaluate a string AS THE INTERPRETER EXPECTS, shorthand
%: evaluate 
        position @ buffer @ buffer-length @ found @ >r >r >r >r
        
        dup strlen buffer-length ! buffer !
        position 0!
        position 1-!
        interp

        r> r> r> r> found ! buffer-length ! buffer ! position !
%;

\ Clear the buffer and replace spaces and newlines with 0
%: prepare
	position 0!
	~prepare-loop
		position @ buffer @ + c@ 
		dup 13 = %if 0 buffer @ position @ + c! %then
		dup 10 = %if 0 buffer @ position @ + c! %then
		    32 = %if 0 buffer @ position @ + c! %then
		position 1+!
		buffer @ position @ + buffer @ buffer-length @ + <
	%goto-nz prepare-loop
	position 0!
%;

\ Set the buffer to 0's
%: clear
	position @
	position 0!
	~clear-loop
		0 buffer @ position @ + c!
		position 1+!
		position @ buffer @ + buffer @ buffer-length @ + <
	%goto-nz clear-loop
	position !
%;

\ Get a word from the buffer
%: word
	~word-loop1
		position 1+!
                position @ buffer @ + buffer-length @ buffer @ + 
                > %if 
		        false exit
                %then
		buffer @ position @ + c@
	%goto-nz word-loop1

	~word-loop2
		position 1+!
                position @ buffer @ + buffer-length @ buffer @ + 
                > %if 
		        false exit
                %then
		position @ buffer @ + c@
	%goto-z word-loop2

	position @ buffer @ + buffer-length @ buffer @ + 
	> %if 
		false 
	%else
		position @ buffer-length @ = %if
			false
		%else
			position @ buffer @ +
			@echo @ %if
				dup .s
			%then
		%then
	%then
%;

\ Check if the string at the ptr is a valid integer
%: number?
	position @
	
	position @ buffer @ + c@ 45 = %if
		position 1+!
	%then

	~isnumber-loop
		position @ buffer @ + c@
		47 58 within? not %if false swap position !  exit %then
		position 1+!
		position @ buffer @ + c@
	%goto-nz isnumber-loop
	true swap position !
%;

\ Convert the given string to an integer on the stack
%variable result
%variable negated
%: number
	result 0!
	dup c@ 45 = %if 1 + true %else false %then negated !
	~number-loop
		dup c@ dup
		dup %if result @ 10 * + 48 - result ! %then
		swap 1 + swap
	%goto-nz number-loop
	negated @ %if result @ negate result ! %then
	drop drop result @
%;

%: create here @ last @ , last ! word strmov %;
%C: does> ; [
	here @ clast @ , clast ! 
	last @ ws + strmov
	%lit enter ,
%; 

%: variable create %lit enter , %lit lit , here @ 0 , %lit exit , here @ 0 , swap ! %;

%: value 
        create 
        %lit enter , 
        %lit lit , 
        here @ 
        0 , 
        %lit exit , 
        here @
        rot , swap 
        swap ! 
%;

%: constant create %lit enter , %lit lit , , %lit exit , %;
%: : create [ %lit enter , %;
%C: ;  %lit exit , ] %;
%: cfa ws + dup strlen + 1 + %;
%: ` word find cfa %;

%variable errorlevel
%: RuntimeWordNotFound 1 %;
%: CtimeWordNotFound 2 %;
%variable counter
%variable @echo
%: on true %;
%: off false %;

%: interp
	prepare
	~shell-loop-inner
		word found !
		found @ %if
			state @ not %if
				found @ find found !
				found @ %if
					found @ cfa exec
				%else
					number? %if 
						buffer @ position @ + number
						true found !
					%else
						RuntimeWordNotFound errorlevel !
					%then
				%then
			%else
				found @ cfind found !
				found @ %if
					found @ cfa exec
				%else
					position @ buffer @ + found !
					found @ find found !
					found @ %if
						found @ cfa ,
					%else
						number? %if
							%lit lit ,
							buffer @ position @ + number ,
							true found !
							false errorlevel !
						%else
							CtimeWordNotFound errorlevel !
						%then
					%then
				%then
			%then
		%then
	counter 1+!
	found @ %goto-nz shell-loop-inner
%;


\ --------------------------
\ Runtime conditionals
\ --------------------------

\ Control flow stack
%variable ps
%: ps-init here @ ps ! 32 cells allot %;
%: >p ps @ ! ps ws+! %;
%: p> ps ws-! ps @ @ %;

\ Conditionals
%C: if %lit jz , here @ >p 0 , %;
%C: then p> here @ swap ! %;
%C: else %lit jp , p> here @ >p 0 , here @ swap ! %;

\ Uncounted loops
%C: begin here @ >p %;
%C: again %lit jp , p> , %;
%C: while %lit jz , here @ >p 0 , %;
%C: repeat p> %lit jp , p> , here @ swap ! %;

\ Counted loops
%variable depth

%: InvalidDepth 4 %;

%: i 
	depth @ 1 < %if
		\ Error here?
	%then
        r> r> r> 3dup >r >r >r swap drop swap drop 
%;

%C: do %lit depth , %lit 1+! , %lit >r , %lit >r , here @ >p %;
%C: ?do %;
%C: loop
	%lit r> ,
	%lit r> ,
	%lit 1+ ,
	%lit 2dup ,
	%lit >r ,
	%lit >r ,
	%lit > ,
	%lit jnz ,
	p> ,
	%lit r> ,
	%lit drop ,
	%lit r> ,
	%lit drop ,
	%lit depth ,
	%lit 1-! ,
%;

%: unloop r> r> drop r> drop >r %;
%: [clast] clast %;
%C: literal ` , %;
%C: c-literal word cfind cfa , %;

%variable currentword
%variable lastword

%: forget
        last lastword !
        word currentword !
        last @
        ~forget-loop
             dup ws + currentword @ strcmp
             %if
                dup @ lastword @ !
             %else
                dup lastword !
             %then
             @ dup
        %goto-nz forget-loop drop
        
        clast lastword !
        clast @
        ~forget-loop1
             dup ws + currentword @ strcmp
             %if
                dup @ lastword @ !
             %else
                dup lastword !
             %then
             @ dup
        %goto-nz forget-loop1 drop
%;

%variable forgotten?

%: forget1
        false forgotten? !

        last lastword !
        word currentword !
        last @
        ~forget1-loop
             dup ws + currentword @ strcmp
             %if
                forgotten? @ not %if
                        dup @ lastword @ !
                        true forgotten? !
                %then
             %else
                dup lastword !
             %then
             @ dup
        %goto-nz forget1-loop drop
%;

\ --------------------------
\ Initialize the environment
\ --------------------------

%: init heap-init ps-init %;
