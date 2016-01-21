( forthstrap lambda environment -- Austin Bittinger 1/20/16 )

( Create some constants for the stack )
20 cells constant lambda-stack-sz
object lambda-stack-sz allot constant lambda-stack
lambda-stack value lambda-stack-ptr

( Check that the stack is OK )
: lambda-ok? 
        lambda-stack-ptr @                      ( value )
        lambda-stack 2 -                        ( lower )
        lambda-stack lambda-stack-sz +          ( upper )
        within? not if
                cr ." Over/underflow in lambda stack "
                false exit
        then
        
        true
;

( Push and pop elements off the lambda stack )
: >lambda 
        lambda-stack-ptr ws+!
        lambda-ok? not if
                cr ." Stack error on push, expect a crash "
                drop exit
        then

        lambda-stack-ptr @ !
;
: lambda>
        lambda-stack-ptr @ @
        lambda-ok? not if
                cr ." Stack error on pop, expect a crash "
        then

        lambda-stack-ptr ws-!
;

( Create the lambda )
: \\ 
        cr ." Lambda is a compile-time function "
        errorlevel is true
does>
        lit jp ,
        here @ >lambda 0 ,
        state @ >lambda
        here @ >lambda

        lit enter ,
;

( Finish the lambda )
: // 
        cr ." Lambda-done requires a runtime "
        errorlevel is true
does>
        lit exit ,
        here @
        lit lit , lambda> ,
        lambda> state !
        lambda> !
;

( Execute the lambda )
: apply
        dup 0= if
                drop
                cr ." NOT applying NULL lambda "
                exit
        then
        exec
;

( Cleanup )
forget lambda-ok?
forget lambda-stack
forget lambda-stack-ptr
forget lambda-stack-sz
( forget lambda>
forget >lambda )
