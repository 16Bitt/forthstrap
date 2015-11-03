( Forthstrap multitasking library )
( Requires: list.forth r@ r! s@ s! )
list.forth
: multi.forth ;




                ( Variables and constants )

( Our current process )
1 value process
( Our list of processes )
0 list= value [processes]
( Our accessor for the list )
: processes [processes] @ ;
( The size of our stacks )
32 cells constant ds-size
32 cells constant rs-size
4 cells constant proc-size





                ( Internal vocabulary )

( Fire up the scheduler )
: multi-init
        object proc-size allot list= [processes] !
        0 processes list@ !
        0 processes list@ @ dup dup dup dup
        object rs-size allot swap !
        object ds-size allot swap 1 cells + !
        object ws allot swap 2 cells + ! ( sp )
        object ws allot swap 3 cells + ! ( rsp )
;

( Make accessing attributes from our process list easier )
: proc.sp processes list@ @ 2 cells + ;
: proc.rsp processes list@ @ 3 cells + ;


( Jump to this handler on spawn )
: multi-start r> drop ;




                ( Outward vocabulary )

: pid ( -- pid ) process @ ;

( Give control to the next process )
: yield ( -- )
        cr ." Yielding "
        sp@ process @ proc.sp !
        r@ process @ proc.sp !
        process 1+!
        process @ processes list@ dup not if
                1 process !
        then
        process @ proc.sp @ dup . sp!
        process @ proc.rsp @ dup . r! 
        
        cr ." Cross your fingers "
;

: spawn       
        object proc-size allot processes list+
        
        cr ." Added proc to list "

        processes list| 1 - process ! process @ .
        object ds-size allot ds-size + ws - process @ proc.sp !
        object rs-size allot process @ proc.rsp !
        ` process @ proc.rsp @ ws - !
        
        yield
;

: end
        pid process list-
        yield
;

: kill
        process list-
;

safety
: mt yield ;
spawn mt
