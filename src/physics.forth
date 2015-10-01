( Honors Physics Research Project )

" src/float.forth " load
" src/list.forth " load

( Create a dynamic list for storing data )
variable [results] 
: results [results] @ ;

( Add a result from our data to the list )
: report ( f -- ) results list+ ;

( Our formula )
: flux ( field area -- flux ) f* ;

( Our expirement )
variable area
area is f 1.0

: experiment
        1000 0 do
        loop
;
