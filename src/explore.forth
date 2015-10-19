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

: explore
        begin
                cr decorator
                cr ." At block " current-block @ .
                0 18 show
                decorator
                ." Use L and H to navigate forward and backward. q to quit. " cr
                key dup char l = if p+ then
                dup char h = if p- then
                char q = if exit then
        again
;
