( forthstrap decompiler )

: unfind ( addr -- name ) 
  last @
  begin
    dup 0 = if drop drop 0 exit then
    dup cfa 2over = if swap drop ws + exit then
    @
  again
;

: dis ( len addr )
  cr
  ` dup 0 = if drop drop exit then
  swap 0 do
    dup . char : emit space
    dup @ unfind 
    dup 0 = if ." (???) " drop dup @ . space char ' emit dup c@ emit char ' emit
    else 
       .s
    then
    ws + cr
  loop
  drop 
;

cr cr decorator
." dis.forth loaded! " counter @ . space ." words compiled. " cr
decorator cr cr
