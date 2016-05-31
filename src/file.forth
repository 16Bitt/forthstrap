( Forthstrap filesystem interface )
( Relies on readbuff writebuff filesize )
( Conflicts with disk.forth load.forth )
: file.forth ;

variable showfileerror

: fileerror showfileerror @ if ." Error in file read/write " then ;

: fs? true ;

: file-read ( filename -- buffer )
        dup filesize
        here @ swap 1+ allot swap
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
        dup file-exists? not if drop fileerror exit then
        file-read
        
        ( Save interpreter state )
        found @ state @ started @ buffer @ buffer-length @ position @ 
        >r >r >r >r >r >r
        dup buffer !
        strlen buffer-length ! 
        position 0!
        interp
        
        errorlevel @ if
                cr ." Unknown word in file: "  current-word-compiling @ .s
                cr ." Make sure the necessary vocabularies are loaded. "
        then

        r> r> r> r> r> r>
        position ! buffer-length ! buffer ! started ! state ! found !
;

( This will be overloaded if import.forth is defined )
: import load ;
