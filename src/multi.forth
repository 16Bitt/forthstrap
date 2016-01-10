( Forth multitasking library )
( Austin Bittinger -- December 2, 2015 )
object.forth
: multi.forth ;




( Variables )
variable pid
variable running
variable [processes]
variable process

structure
        .Stack
        .RStack
        .SP
        .RSP
        .PID
named Process

: processes [processes] @ ;

1 kilobytes constant multisize
true constant stackgrowsdown?

( Helper functions )
: mkproc
        Process process !
        process @ processes list+
        pid @ process .PID !
        pid 1+!
        process @
;

: >>proc
        running 1+!
        
        cr ." Checking for proc overflow "
        running @ processes list| =
        running @ processes list| > or if
                running 0!
        then
        
        cr ." Changing proc " running @ .
        running @ processes list@ @ process !
        cr ." Swapping to proc " process .PID @ .
;

( Main Program )
: yield
        cr ." Switching proc "
        >>proc
        cr ." Setting RSP "
        process .RSP @ dup . r!
        cr ." Setting SP "
        process .SP @ dup . sp!
;

: spawn
        ( Create and allot a new process )
        process @
        cr ." Making process... "
        mkproc process !
        cr ." Allotting... "
        object multisize allot process .RStack !
        object multisize allot process .Stack !

        ( Setup the return stack and a call to it )
        cr ." Setting the stacks... "
        process .RStack @ process .RSP !
        ` process .RStack @ !

        ( Setup the default stack )
        stackgrowsdown? if
                process .Stack @ multisize + ws - dup . cr process .SP !
        else
                process .Stack @ process .SP !
        then
        
        process !

        cr ." Spawn done. "
;

: kill ;
: getpid process .PID @ ;

: multi 
        cr ." Making startup list... "
        0 list= [processes] !
        cr ." Spawning process... "
        spawn
        cr ." Resetting processes... "
        1 processes list@ [processes] !
        yield
;

( Cleanup )
forget pid
forget running
forget [processes]
forget process




( Testing )
: mt begin yield cr ." Yielded :) " again ;
