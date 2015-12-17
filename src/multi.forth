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




( Helper functions )
: mkproc
        Process process !
        process dup processes list+
        dup pid @ swap .PID !
        pid 1+!
;

: >>proc
        running 1+!
        
        running @ processes list| =
        running @ processes list| > or if
                running 0!
        then
        
        processes running @ list@ @ process !
;

( Main Program )
: yield
        >>proc
        process .RSP @ r!
        process .SP @ sp!
;

: spawn
        ( Create and allot a new process )
        process @
        cr ." Making process... "
        mkproc process !
        cr ." Allotting... "
        object 1 kilobytes allot process .RStack !
        object 1 kilobytes allot process .Stack !
        
        ( Setup the return stack and a call to it )
        cr ." Setting the stacks... "
        process .RStack @ process .RSP !
        ` process .RStack dup . cr @ ws - dup . cr !
        ( Setup the default stack )
        process .Stack @ 1 kilobytes + ws - process .SP !
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
: mt begin yield again ;
