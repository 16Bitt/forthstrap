( Some training wheels to catch basic errors - Austin Bittinger 2/16/2015 )
(
        Loading this file will make all new functions for basic memory ops
        so that you can safely execute them
)

variable reference
h F0000000 constant upper
h 00080000 constant lower

: old ` reference ! ;
: referred reference @ exec does> reference @ , ;

old @
: @ 
        dup lower < if
                cr ." Tried to read from low memory, continuing with bad value= " dup . cr
                exit
        then

        referred
;

old c@
: c@ 
        dup lower < if
                cr ." Tried to read from low memory, continuing with bad value= " dup . cr
                exit
        then

        referred
;

old !
: !
        dup lower < if
                cr ." Tried to write to low memory, ignoring write to " . drop cr
                exit
        then

        referred
;

old c!
: c!
        dup lower < if
                cr ." Tried to write to low memory, ignoring write to " . drop cr
                exit
        then

        referred
;

forget1 reference
forget1 old
forget1 referred
forget1 upper
forget1 lower
