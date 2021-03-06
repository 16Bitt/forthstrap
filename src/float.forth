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
: f< flt ;
: f> fgt ;
: f= feq ;

( Some math words )
: f^2 ( f -- f^2 ) dup f* ;
: f** ( f f2 -- f^f2 )
        f 1.0 swap 0 do
                over f*
        loop
        swap drop
;

: >>i icast ;

: tan dup sin swap cos f/ ;
: fnegate f -1 f* ;
: |f| dup f 0 f< if fnegate then ;

( Rough approximation of pi, should mostly work )
f 3.1415926 constant pi
