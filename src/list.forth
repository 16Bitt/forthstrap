( Forthstrap linked list implementation )

: list.forth ;

( Create a list from an initial value )
: list= ( head -- list ) object >r , 0 , r> ;

( Get the length of the list )
: list| ( list -- len )
        0 swap
        begin
                swap 1+ swap
                ws + @ dup not if
                        drop exit
                then
        again
;

( Get the final cell in a list )
: list. ( list -- cell )
        begin
                dup ws + @ if
                        ws + @
                else
                        exit
                then
        again
;

( Get a cell from an index in a list )
: list@ ( index list -- cell )
       swap dup not if drop exit then
       0 do 
                ws + @
       loop
;

( Add a value to a list )
: list+ ( value list -- )
        list. ws + object swap ! ( Set the last cell to the new object )
        , 0 , ( Create the cell )
;

( Remove a value from a list given an index )
: list- ( index list -- )
        2dup list@ ws + @ not if ( If this is the end of the list )
                swap 1 - swap list@ ws + 0 swap ! ( End the list )
        else ( If this is in the middle of the list )
                2dup swap 1 - swap list@ ws + >r
                swap 1 + swap list@ r> !
        then
;

: list.- ( list -- )
        dup list| 1 - swap list-
;
