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

( This word requires a few hacks... )
: arguments:
        ( Save position for later )
        position @ >r

        ( Create the words as above )
        dup 0 do
                variable
        loop
        
        ( Quick hack to put us back in execution for the current word )
        object beginning @ !
        ( Restore Position so we can get all the arguments again )
        r> position !
        
        0 do
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
