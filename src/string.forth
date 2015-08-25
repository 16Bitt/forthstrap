: ( begin word c@ 41 = if exit then again 
  does> begin word c@ 41 = if exit then again 
;

( Welcome to runtime forth! Now the real fun begins )
( This will be the first file loaded at runtime )
: NoRuntimeEquivalent 3 ;
: error! errorlevel ! ;
: char word c@ does> lit literal lit , word c@ , ;

variable strp
: string-init here @ swap allot strp ! ;
: str, 
  strp @ swap dup strlen 0 do
   dup i + c@ strp @ c!
   strp 1+!
  loop
  0 strp @ c!
  strp 1+!
  drop
;

512 string-init

( Forthstrap uses strings beginning and ending a space delimited " )
: "
 strp @
 begin 
   word dup c@ char "
   = if strp 1-! 0 strp @ c! strp 1+! drop exit then
   str, drop strp 1-! 32 strp @ c! strp 1+!
 again

 does>

 lit literal jp , here @ 0 ,
 here @
 begin 
   word dup c@ char "
   = if here 1-! 0 c, drop swap here @ swap ! lit literal lit , , exit then
   strmov here 1-! 32 c,
 again
;

( Same as before, but print after the last " )
: ."
  literal " .s
  does> c-literal " 
  lit literal .s ,
;

( Some code to decorate output )
: dash char - emit ;
: dashes 0 do dash loop ;
: decorator 79 dashes cr ;

: is ` exec swap ! does> ` , lit literal swap , lit literal ! , ;

: fromhex ( str -- n )
   0 swap
   dup strlen 0 do
      swap 16 * swap
      dup c@ dup char 0 1 - char 9 1 + within? 
      if char 0 - swap >r + r>
      else char A - 10 + swap >r + r>
      then
      1 +
   loop
   drop
;

: h ( <hex> -- n ) word fromhex does> word fromhex lit lit , , ;