: ( begin word c@ 41 = if exit then again 
  does> begin word c@ 41 = if exit then again 
;

( Welcome to runtime forth! Now the real fun begins )
: NoRuntimeEquivalent 3 ;
: error! errorlevel ! ;
: char word c@ does> lit literal lit , word c@ , ;

( Forthstrap uses strings beginning and ending a space delimited " )
: " 
 NoRuntimeEquivalent error!
 does>
 lit literal jp , here @ 0 ,
 here @
 begin 
   word dup c@ char "
   = if 0 c, drop swap here @ swap ! lit literal lit , , exit then
   strmov here 1-! 32 c,
 again
;

( Same as before, but print after the last " )
: ." NoRuntimeEquivalent error!
  does> c-literal " 
  lit literal .s ,
;

( The first visible payload )
: welcome cr ." Welcome to forthstrap! " cr cr ;
welcome


