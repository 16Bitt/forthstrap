( Forthstrap debugging vocab )
" file.forth " import
" dis.forth " import
: dbg.forth ;

variable DBG_TARGET

: rr 
   DBG_TARGET @ if
      @echo is on
      DBG_TARGET @ load
      @echo is off
   else
      ." Please select a target " cr
   then
;

: targetting
   ` exec DBG_TARGET !
;

forget DBG_TARGET
