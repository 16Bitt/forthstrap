( Forthstrap metacompiler -- Austin Bittinger 1/22/16 )
memory.forth syntax.forth strlib.forth

( File buffer size )
8 kilobytes constant fs-buffsize

( Files for IO in the compiler )
variable outfile
variable infile

( Variables for interpreting data )
variable codebuffer
variable databuffer

( Remove a single comment )
: fs-cstrip
        cr 8 spaces ." * Stripping comment... "
        begin
                buffer @ position @ + c@ case
                       13 of drop exit endof
                       10 of drop exit endof
                       drop 
                       0 buffer @ position @ + c!
                endcase

                position 1+!

                position @ buffer-length @ =
                position @ buffer-length @ > or if
                        exit
                then
        again
;

( Remove comments and set parsing variables )
: fs-preprocess
        cr 8 spaces ." * Preprocessing... "

        dup file-exists? not if
                cr ." File " .s space " does not exist. "
                " " infile !
                exit
        then
        
        ( Set our parsing values )
        dup file-read infile !
        filesize buffer-length !
        infile @ buffer !
        started is true
        position 0!
        
        ( Start the processing )
        begin
                buffer @ position @ + c@ char \ = if
                        fs-cstrip
                then
                
                position 1+!

                position @ buffer-length @ >
                position @ buffer-length @ = or if
                        exit
                then
        again
        
        cr 8 spaces ." * Preprocessing finished "
;

: fs-process
        position 0!
        started is true
        
        begin
                word found !
                found @ 0= if exit then

                found @ case
                        " %if "         "of" 
                               
                        endof
                        
                        " %then "       "of" 
                        
                        endof
                        
                        " %else "       "of" 
                        
                        endof
                        
                        " %: "          "of" 
                        
                        endof
                endcase
        again
;

: fs-writeout ;

: fs-start ( file-name ... num-file-names outfile -- )
       cr ." Starting forthstrap processing... "

       outfile !
       " " codebuffer !
       " " databuffer !

       0 do
               cr ." Compiling file " i 1 + . ." ... "

               buffer @ buffer-length @ found @ position @
               >r >r >r >r
               
               fs-preprocess
               fs-process

               r> r> r> r>
               position ! found ! buffer-length ! buffer !

               cr ." Finished file. "
        loop

        fs-writeout
;
