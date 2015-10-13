( Forthstrap psuedorandom vocabulary )
: rand.forth ;

variable W variable X variable Y variable Z variable T

: rand32 ( -- n )
        X @ X @ 11 shl xor T !
        Y @ X ! Z @ Y ! W @ Z !
        W @ W @ 19 shr xor T @ xor T @ 8 shr xor W !
        W @
;

: rand16 ( -- n )
        0
;

: rand ( -- n ) bits 32 < if rand16 else rand32 then ;

17 W !
19 X !
h 500 Y !
h FFF Z !
