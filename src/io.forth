\ io.forth depends on the following words: key emit


\ ---------------
\ Dot vocabulary
\ ---------------

%: tohex
	
%;

%: . 
%;

%: .s 
	~dots-loop
		dup c@
		swap 1 +
		swap dup emit
	%goto-nz dots-loop

	drop
%;
