( Performance monitoring library -- Austin Bittinger 7/10/16 )

: perf.forth ;

" compile.forth " import
" safelist.forth " import

100 cells constant trace-size
variable num-traces
variable cumulation

object trace-size allot constant traces

: traces-full? ( -- f ) num-traces @ cells ws + trace-size > ;

: trace, ( ? -- )
        num-traces @ cells traces + ! 
        num-traces 1+! 
;

( Add a trace to the list )
: add-trace ( addr -- )
        traces-full? if
                ." Out of tracing room " cr
                drop drop exit
        then
        
        last @ ws + trace,
        trace,
;

( Display the number of calls for each trace )
: show-traces
        num-traces @ 0 ?do
                i cells traces +

                i 2 rem 0= if
                        @ .s tab
                else
                        @ @ . cr
                then
        loop
;

( Redefine the colon to add some tracing metadata to the definition )
: :
	create
	metacompile
		enter
                jp
	done
        
        object 0 , ( Jump address )
        object 0 , ( Start time )
        object 0 , ( Cumulation )
        dup add-trace
        
        rot here @ 
        swap !
        
        ( Compile Start time )
        metacompile
                lit
        done
        ,
        
        ( Save Cumulation )
        cumulation !

        metacompile
                usecs swap !
        done

	on state !
;

( Change the semicolon to do tracing )
: ; does>
        metacompile
                usecs
                lit
        done
        cumulation @ ,

        metacompile
                +!
        done

        metacompile
                lit
        done
        cumulation @ ws - ,

        metacompile
                @ lit
        done
        cumulation @ ,

        metacompile
                dup rot swap
                -!
                dup @ 2 / swap !
                exit
        done
        off state !
;

