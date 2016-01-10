( Advanced string handling for forthstrap )
: strlib.forth ;

: s+ ( str1 str2 -- str )
        object >r
        swap strmov here 1-!
        strmov r>
;

: s+c ( str1 char -- str )
        object >r
        swap strmov here 1-!
        c, 0 c, r>
;

: n>>c ( n -- c )
        dup 10 < if
                char 0 +
        else
                10 - char A +
        then
;

: i>>s ( n -- s ) 
        object swap
        ns 0 do
                dup bits 4 - i 4 * - shr
                h F and n>>c c,
        loop drop
        0 c,
;

" ~ " 32 s+c constant evalprelude

: eval evalprelude swap s+ evaluate ;

forget evalprelude
