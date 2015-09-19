( Forthstrap filesystem interface )
( Relies on buffread buffwrite filesize )
( Conflicts with disk.forth load.forth )

: fs? true ;

: file-read ( filename -- buffer )
        dup filesize
        here @ swap allot swap
        2dup buffread
        drop
;

: file-write ( size buffer filename -- )
        buffwrite
;

: file-exists? ( filename -- f )
        filesize if true else false then
;

: file-run ( filename -- )
        dup file-exists? not if drop exit then
        here @ char A c, 32 c,
        swap file-read drop

        ( Save interpreter state )
        buffer @ buffer-length @ position @ >r >r >r
        dup buffer !
        strlen buffer-length ! 
        position 0!
        @echo is on
        interp 
        @echo is off
        r> r> r> position ! buffer-length ! buffer !
;
