( Forth init file )
( Put what you want loaded at runtime here )
: init.forth ;

cr

." Loading init settings... " cr
" src/init0.forth " load

." Loading floating point library... " cr
" src/float.forth " load

." Loading graphics library... " cr
" src/gfx.forth " load

." Loading randomness library... " cr
" src/rand.forth " load

." Loading disassembler library... " cr
" src/dis.forth " load

." Loading UNIX library... " cr
" src/unix.forth " load

." Loading runtime settings... " cr
" src/init1.forth " load
