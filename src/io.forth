\ io.forth depends on the following words: key emit
\ io.forth depends on the following vocabularies: generic

\ ---------------
\ Dot vocabulary
\ ---------------

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

%variable keyecho

%: line
	~line-loop
		key keyecho @ %if dup emit %then dup
		13 = %if drop cr exit %then
		buffer @ position @ + c!
		position 1+!
		buffer @ position @ + buffer @ buffer-length @ + <
	%goto-nz line-loop
	cr
%;

%variable found
%: shell
	here @ buffer !
	dup allot buffer-length !
	~shell-loop
		clear
		65 buffer @ c!
		2 position !
		line cr
		
		3 spaces interp
		errorlevel @ %if
			error
			false errorlevel ! 
		%else 
			ok 
		%then cr
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

%: list
	last @
	~list-loop
		dup ws + .s
		@ dup
	%goto-nz list-loop

	drop
%;

%: ok
	space 79 emit 75 emit 46 emit cr
%;

%: error 33 emit 33 emit 33 emit %;
