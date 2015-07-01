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
\ Common IO words
\ ---------------

%: cr
	10 emit
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
