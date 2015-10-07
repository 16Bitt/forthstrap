( Forthstrap floating point interface )
( Requires floating point core words )

: float.forth ;

: f ( word> -- float )
        word tof
        does> word tof lit lit , ,
;

( Make the core words a little shorter )
: f+ fadd ;
: f- fsub ;
: f* fmul ;
: f/ fdiv ;
: .f fdot ;
: >>f fcast ;

( Some math words )
: f^2 ( f -- f^2 ) dup f* ;
: f** ( f f2 -- f^f2 )
        f 1.0 swap 0 do
                over f*
        loop
        swap drop
;
