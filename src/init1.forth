( Init )

on ttymode

: init-forth-final
	argc 1 > if
		argv ws + @ load bye
	else
		." This is forthstrap. Type 'list' for a list of vocabulary. See http://github.com/16Bitt/forthstrap for more information. "
	then
;

init-forth-final
