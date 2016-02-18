( Safe lists for forthstrap -- Austin Bittinger 2/17/16 )
: safelist.forth ;

( List structure: pointer next )
( List cell structure: string name, cell value, pointer next )

" " constant emptystring

: Safelist 0 value ;

: Item.name ;
: Item.value 1 cells + ;
: Item.next 2 cells + ;

: SafelistItem ( value -- Item )
        object
        3 cells allot
        dup Item.name emptystring swap !
        dup Item.value 2over swap !
        dup Item.next 0 swap !
        swap drop
;

: len ( Listvar -- len )
        0 swap @
        begin
               dup 0 = if drop exit then
               swap 1+ swap
               Item.next @
        again
;

: Item[] ( index Listvar -- Item )
        @
        swap 0 ?do
                dup 0 = if
                        drop 0 
                        cr ." Index out of bounds " cr
                        exit
                then
                Item.next @
        loop
;

: &[] ( index Listvar -- valueptr )     Item[] Item.value ;
: [] ( index Listvar -- value )         &[] @ ;

: append ( value Listvar -- )
        dup @ 0 = if 
                swap SafelistItem
                swap !
                exit
        then

        dup len 1- swap Item[]
        swap SafelistItem swap
        Item.next !
;

: remove ( index Listvar -- )
        swap dup 0= if
                drop
                dup @ Item.next @ swap !
                exit
        then swap

        swap dup 1- 2over Item[]
        rot Item[]
        Item.next @ swap Item.next !
;

: pop ( Listvar -- )
        dup len 1- swap 2dup
        [] rot swap remove
;

: push ( val Listvar -- )
        append
;
