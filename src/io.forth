\ io.forth depends on the following words: key emit


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

%: line
	~line-loop
		key dup emit dup
		13 = %if drop cr exit %then
		buffer @ position @ + c!
		position 1+!
		buffer @ position @ + buffer @ buffer-length @ + <
	%goto-nz line-loop
	cr
%;

%: shell
	here @ buffer !
	dup allot buffer-length !
	~shell-loop
		clear
		65 buffer @ c!
		2 position !
		line prepare cr
		~shell-loop-inner
			word dup dup %if position @ . space dup .s find . space number? . cr %else drop %then
		%goto-nz shell-loop-inner
		cr 
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
