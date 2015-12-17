( Forth argument library -- Austin Bittinger 10/15/15 )
: arg.forth ;

variable beginning

: { does> 
        state is false 
        lit jp , 
        object beginning ! 
        0 ,
;

: } 
        state is true 
        object beginning @ !
;

: locals:
        0 do
                variable
        loop
;

variable argsize
variable oldpos


( This word requires a few hacks... )
: arguments:
        argsize !

        ( Save position for later )
        position @ oldpos !

        ( Create the words as above )
        argsize @ 0 do
                variable
        loop
        
        ( Quick hack to put us back in execution for the current word )
        object beginning @ !
        
        argsize @ 0 do
                oldpos @ position !
                argsize @ i 1+ = not if
                        argsize @ i 1+ - 0 do
                                word
                        loop
                then

                ` ,
                lit ! ,
        loop

        ( Emulate { from above to resume the hack )
        lit jp ,
        object beginning !
        0 ,
;

: finished:
        0 do
                forget1
        loop
;

( Hide some junk variables )
2 finished: argsize oldpos


