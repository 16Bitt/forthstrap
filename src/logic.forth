( Forth Logic Operators -- Austin Bittinger 10/22/15 )
: logic.forth ;

: >>boolean not not ;
: && >>boolean swap >>boolean and ;
: ^^ >>boolean swap >>boolean xor ;
: || >>boolean swap >>boolean or ;
