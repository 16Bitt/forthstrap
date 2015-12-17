( Forthstrap extended syntax -- Austin Bittinger 12/17/15 )
compile.forth
: syntax.forth ;



( Case-endcase statements )
variable cases

: of does>
        cases 1+!
        metacompile
                over = jz
        done

        here @ >p 0 ,
;

: endof does>
        p>
        metacompile
                jp 
        done

        here @ >p 0 ,

        here @ swap !
;

: case
        cr ." CASE cannot be used at runtime-- compile only "        
does>
        cases 0!
;

: endcase
        cr ." ENDCASE cannot be used at runtime-- compile only "
does>   
        cases @ if
                cases @ 0 do
                        here @ p> !
                loop
        then
;

forget cases



( New DO-LOOP implementations )

( Guarded DO )
: ?do does>
        metacompile
               >r >r
        done
        
        here @ >p
        
        metacompile
                r> r>
                2dup
                >r >r
                > jz
        done

        here @ >p
        0 ,
;

( Cleaner DO )
: do does>
        metacompile
               >r >r
        done
        
        here @ >p
        
        ( Here we nullify the guard )
        metacompile
                r> r>
                2dup
                >r >r
                > drop lit
        done

        here @ >p
        0 ,

        ( Get rid of the extra word on the stack )
        metacompile
                drop
        done
;

( Cleaner LOOP for guarded loops )
: loop does>
        metacompile
                r> r>
                1+
                2dup
                >r >r
                > jnz
        done

        p> p> ,
        here @ swap !
        
        metacompile
                r> r>
                drop drop
        done
;
