( Forthstrap psuedorandom vocabulary )
( May need some tweaking for <32bit systems )
: rand.forth ;

variable W variable X variable Y variable Z variable T

: rand ( -- n )
        X @ X @ 11 shl xor T !
        Y @ X ! Z @ Y ! W @ Z !
        W @ W @ 19 shr xor T @ xor T @ 8 shr xor W !
        W @
;

17 W !
19 X !
h 500 Y !
h FFF Z !
