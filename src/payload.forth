\ Requires: generic.forth io.forth
\ Natively requires: ROM_ADDR (points to null terminated string of forth code)

%: payload
	init
   
   on keyecho !

	position 0!
	ROM_ADDR buffer !
	ROM_ADDR strlen buffer-length !
	interp

	cr

	256 shell
%;
