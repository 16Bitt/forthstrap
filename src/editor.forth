( Forthstrap editor -- Austin Bittinger 10/23/15 )
file.forth
: editor.forth ;





                ( Constants and variables )
( A list of lines )
" " list= value [lines]
: lines [lines] @ ;

( The name of the file that we're editing )
" " value editing

( Make our buffer for loading the file )
variable scratch






                ( Helper functions )
: openToEdit ( filename -- ) 
       dup editing !
       file-read scratch !
       scratch @ >r
       begin
                char . emit
                scratch @ c@ dup
                not     if drop r> lines list+ exit then
                10 =    if 0 scratch @ c! r> lines list+ scratch @ 1+ >r then
                scratch 1+!
       again cr
;

: disp ( start end -- ) 
        cr
        1+ swap do
                i lines list@ dup if @ i .16 space .s cr else drop then
        loop
;

: esize ( -- newfilesize )
        0
        list| 0 do
                i lines list@ @ strlen +
        loop
;






                ( Primary vocabulary )
: edit ( >>word -- ) ` exec openToEdit ;
: change ( lineno -- ) ;
: insert ( lineno -- ) ;
: remove ( lineno -- ) ;
: show ( line len -- )
        2dup + swap drop disp
;

: save ( -- ) ;



                ( Cleanup )
forget editing
forget [lines]
forget lines
forget openToEdit
forget disp
forget esize
forget scratch
