\ io.forth depends on the following words: key emit
\ io.forth depends on the following vocabularies: generic

\ ---------------
\ Dot vocabulary
\ ---------------

%: wait key drop %;

%: tohex
	dup 4 shr 15 and dup
	10 < %if 48 + %else 10 - 65 + %then emit
	15 and dup
	10 < %if 48 + %else 10 - 65 + %then emit
%;

%: .64

%;

%: .32 dup 24 shr tohex dup 16 shr tohex dup 8 shr tohex tohex %;

%: .16 dup 8 shr tohex tohex %;

%: .8 tohex %;

%: .
	ws 1 = %if .8 %then
	ws 2 = %if .16 %then
	ws 4 = %if .32 %then
	ws 8 = %if .64 %then
%;

%: .s 
	~dots-loop
		dup c@
		swap 1 +
		swap dup emit
	%goto-nz dots-loop

	drop
%;


\ ---------------
\ Shell Code
\ ---------------

%variable bs-val
%variable keyecho
%: bkspc bs-val @ %;

\ This is the line editor
\ Its state depends on:
\ BUFFER BUFFER-LENGTH POSITION KEYECHO
%: line
	~line-loop
		key dup 
		
                dup 13 = %if
                        drop drop cr 
		        exit
                %then

		bkspc = %if
			drop
			position @ 0 > %if
				0 buffer @ position @ + c!
				position 1-!
				0 buffer @ position @ + c!
				keyecho @ %if
					8 emit space 8 emit
				%then
			%then
		%else
			keyecho @ %if dup emit %then
			buffer @ position @ + c!
			position 1+!
		%then

		buffer @ position @ + buffer @ buffer-length @ + <

			\ ~looplooploop
			\ %goto looplooploop
	%goto-nz line-loop
	cr
	

%;

%: hang ~hangloop %goto hangloop %;

%variable found
%: shell
	here @ buffer !
	dup allot buffer-length !
        ~shell-loop
		clear
		position 0!
		cr cr ok line
		
		interp
		errorlevel @ %if
			error
                        false errorlevel ! 
		%then
	%goto shell-loop
%;

\ ---------------
\ Common IO words
\ ---------------

%: cr
	10 emit
	13 emit
%;

%: space
	32 emit
%;

%: spaces
	~spaces-loop
		space
		1 - dup
	%goto-nz spaces-loop
	drop
%;

%: tab 9 emit %;

%: list
	last @
	~list-loop
		dup ws + .s
		@ dup
	%goto-nz list-loop
	drop
	
	[clast] @
	~list-loop2
		dup ws + .s
		@ dup
	%goto-nz list-loop2
	drop
%;

%: used.
        here @ end-of-mem - .
%;

%: ok
	space 79 emit 75 emit 46 emit space
%;

%: error 33 emit 33 emit 33 emit space errorlevel @ . ] %;
