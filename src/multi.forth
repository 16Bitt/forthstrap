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
128 cells constant ds-size
128 cells constant rs-size
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
: first-yield ( -- )
        cr ." Beginning pid " process @ .
        cr ." If this value is not 1, panic! "
        cr ." SP will be " process @ proc.sp @ dup . sp!
        cr ." RP will be " process @ proc.rsp @ dup . r! 
        
        cr ." Cross your fingers "
;




                ( Outward vocabulary )

: pid ( -- pid ) process @ ;

( Give control to the next process )
: yield ( -- )
        cr ." Yielding from pid " pid .
        sp@ process @ proc.sp !
        r@ process @ proc.rsp !
        process 1+!
        process @ processes list@ dup not if
                1 process !
        then
        cr ." SP will be " process @ proc.sp @ dup . sp!
        cr ." RP will be " process @ proc.rsp @ dup . r! 
        
        cr ." Cross your fingers "
;

: spawn       
        object proc-size allot processes list+
        
        cr ." Added proc to list "

        processes list| 1 - process !
        |here| object ds-size allot ds-size + ws - process @ proc.sp !
        |here| object rs-size allot process @ proc.rsp !
        ` process @ proc.rsp @ ws - !
        
        pid 1 = if
            cr ." First task spawn "
            first-yield
        else
            yield
        then
;

: end
        pid process list-
        yield
;

: kill
        process list-
;

( Set up a testing environment )
safety : mt yield ;
