\ Requires: generic.forth io.forth
\ Natively requires: ROM_ADDR (points to null terminated string of forth code)

%: payload
	init
	
	on @echo !
        on keyecho !

	position 0!
	ROM_ADDR buffer !
	ROM_ADDR strlen buffer-length !
	interp

	off @echo !

	cr cr cr

	256 shell
%;
