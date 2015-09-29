( Forthstrap filesystem interface )
( Relies on readbuff writebuff filesize )
( Conflicts with disk.forth load.forth )
: file.forth ;

: fs? true ;

: file-read ( filename -- buffer )
        dup filesize
        here @ swap allot swap
        2dup readbuff
        drop
;

: file-write ( size buffer filename -- )
        writebuff
;

: file-exists? ( filename -- f )
        filesize if true else false then
;

: load ( filename -- )
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
