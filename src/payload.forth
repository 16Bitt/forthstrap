\ Requires: generic.forth io.forth
\ Natively requires: ROM_ADDR (points to null terminated string of forth code)

%: payload
	init
	
	on @echo !
        
	position 0!
	ROM_ADDR buffer !
	ROM_ADDR strlen buffer-length !
	interp

	off @echo !

	cr cr cr

	off keyecho !
	256 shell
%;
