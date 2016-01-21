( forthstrap decompiler )

: unfind ( addr -- name ) 
  last @
  begin
    dup 0 = if drop drop 0 exit then
    dup cfa 2over = if swap drop ws + exit then
    @
  again
;

: dis ( len -- )
  cr
  ` dup 0 = if drop drop exit then
  swap 0 do
    dup . char : emit space
    dup @ unfind 
    dup 0 = if drop dup @ . char = emit char ' emit dup c@ emit char ' emit
    else 
       .s
    then
    ws + cr
  loop
  drop 
;

: dis-addr ( len addr )
  cr
  dup 0 = if drop drop exit then
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

: printable? ( char -- flag )
   31 127 within?
;

: ascii-dump ( len addr -- )
  cr
  dup 1 - .
  40 spaces 18 dashes cr
  swap 0 do
    dup . 4 spaces
    16 0 do
      dup c@ tohex
      1 +
    loop
    4 spaces char | emit
    16 -
    16 0 do
      dup c@ dup printable? not if drop char . emit else emit then
      1 +
    loop
    char | emit cr
  loop
  . 40 spaces 18 dashes cr
;

