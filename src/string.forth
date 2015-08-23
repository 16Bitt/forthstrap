: ( begin word c@ 41 = if exit then again 
  does> begin word c@ 41 = if exit then again 
;

( Welcome to runtime forth! Now the real fun begins )
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

200 string-init

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

off @echo !

( The first visible payload )
cr cr ." Welcome to forthstrap! " counter @ . space ." runtime words compiled. " cr cr
