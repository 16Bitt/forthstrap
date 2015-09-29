( Forthstrap floating point interface )
( Requires floating point core words )
( This is simply abstraction, next to no implementation )

: float.forth ;

: f ( word> -- float )
        word tof
        does> word tof lit lit , ,
;

: f+ fadd ;
: f- fsub ;
: f* fmul ;
: f/ fdiv ;
: .f fdot ;
