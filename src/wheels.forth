( Some training wheels to catch basic errors - Austin Bittinger 2/16/2015 )
(
        This file replaces basic data movement words to prevent reads and writes
        below a certain margin in memory. Yes there's a performance tradeoff,
        but it makes debugging and testing infinitely easier.
)

: wheels.forth ;

variable reference
h F0000000 constant upper
h 00080000 constant lower
8 constant printlen

: old ` reference ! ;
: referred reference @ exec does> reference @ , ;

: previous-dbg
        cr ." Memory access error around: "
        r> r> 2dup >r >r swap drop printlen swap ws 4 * - dis-addr
;

old @
: @
        dup lower < if
                previous-dbg
                cr ." Tried to read from low memory, continuing with bad value= " dup . cr
                exit
        then

        referred
;

old c@
: c@
        dup lower < if
                previous-dbg
                cr ." Tried to read from low memory, continuing with bad value= " dup . cr
                exit
        then

        referred
;

old !
: !
        dup lower < if
                previous-dbg
                cr ." Tried to write to low memory, ignoring write to " . drop cr
                exit
        then

        referred
;

old c!
: c!
        dup lower < if
                previous-dbg
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
forget1 printlen
