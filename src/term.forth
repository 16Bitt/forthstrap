( Terminal compatibility library )
: term.forth ;

( Note that this will most likely expand greatly in the future )

( Traditional tty's use ascii backspace as backspace )
h 08 constant traditional
( Some UNIX terminals prefer to use 0x7F? Not sure why )
h 7F constant unix

: tmode bs-val ! ;
