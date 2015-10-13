( Fake filesystem implementation for filesystem-less systems )
load.forth
: nofs.forth ;

: s>>f
        find dup not if exit then
        cfa
;

` load
: load s>>f ] , [ ;


( Example for an 8086-bare system
: src/strlib.forth h 033D 2 ;
" src/strlib.forth " load
)

: file.forth ;
