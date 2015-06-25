\ io.forth depends on the following words: key emit


\ ---------------
\ Dot vocabulary
\ ---------------

%: . 
	ws
	~dot-loop
		swap emit
		dup
	%goto-nz dot-loop
	drop
%;

%: .s 
	~dots-loop
		dup c@
		swap 1 +
		swap dup emit
	%goto-nz dots-loop

	drop
%;
