( Block explorer -- Austin Bittinger )

variable current-block
770 current-block !
variable cr-index

: p+ current-block 1+! current-block @ readblock cr-index 0! ;
: p- current-block 1-! current-block @ readblock cr-index 0! ;
0 diskinfo
current-block @ readblock

: .cr
        begin
                dup c@ 10 = if
                        drop cr exit
                then
                dup c@ emit 1+
        again
;

: get-cr ( -- str )
        cr-index @ not if
                disk cr-index 1+! exit
        then

       begin
        10 disk 514 + c!
        disk cr-index @ + c@
        dup 10 = if
                cr-index 1+!
                drop disk cr-index @ +
                disk cr-index @ + disk 510 + > if drop 0 then
                exit
        then
        0 = if
                0 exit
        then
        
        cr-index 1+!
       again
;

: show ( start len -- )
        cr-index 0! cr 
        swap dup 0 = not if
                1 - 0 do
                        get-cr drop
                loop
        else
                drop
        then

        0 do
                dup i + . space get-cr dup if .cr else drop ." EOF " cr then
        loop
;

: numkey? char 0 1- char 9 1+ within? ;
: how-many?
        ." How many blocks would you like to load? "
        begin
                key dup
                numkey? if dup emit char 0 - exit then      
                drop
        again
;

: explore
        begin
                cr decorator
                cr ." At block " current-block @ .
                0 18 show
                decorator
                ." Use L and H to navigate forward and backward, x to exec, q to quit. " cr
                key case
                        char h of drop p- endof
                        char l of drop p+ endof
                        char q of drop exit endof
                        char x of 
                                drop current-block @ how-many? load
                        endof
                        drop
                endcase
        again
;

        ( Clean up )
forget .cr
forget show
forget get-cr
forget p+
forget p-
forget current-block
forget cr-index
