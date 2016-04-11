( Forth init file )
( Put what you want loaded at runtime here )
file.forth

: init.forth ;

cr

." Loading init settings... " cr
" src/init0.forth " load

." Loading disassembler library... " cr
" src/dis.forth " load

." Loading memory safety library... " cr
" src/wheels.forth " load

." Loading strlib " cr
" src/strlib.forth " load
( 
." Loading logic library... " cr
" src/logic.forth " load

." Loading locals library... " cr
" src/arg.forth " load

." Loading floating point library... " cr
" src/float.forth " load

." Loading graphics library... " cr
" src/gfx.forth " load

." Loading randomness library... " cr
" src/rand.forth " load

." Loading UNIX library... " cr
" src/unix.forth " load

." Loading debugging library... " cr
" src/dbg.forth " load

." Loading list library... " cr
" src/list.forth " load

." Loading advanced string handling library... " cr
" src/strlib.forth " load

." Loading Terminal compatibility library... " cr
" src/term.forth " load

." Loading memory definitions... " cr
" src/memory.forth " load
 )
." Loading compiler library... " cr
" src/compile.forth " load

." Loading syntax extensions... " cr
" src/syntax.forth " load

." Loading object library... " cr
" src/object.forth " load

." Loading safelists... " cr
" src/safelist.forth " load

." Loading runtime settings... " cr
" src/init1.forth " load

