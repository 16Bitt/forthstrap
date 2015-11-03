( Code to load files from disk )
: load.forth ;

variable codebuffer 2 allot
here @ codebuffer ! 512 allot
variable codesize 512 codesize !

: load ( start n -- )
        dup 512 * codesize @ > if
                2 allot
                here @ codebuffer !
                dup 512 * allot
        then

        0 do
                dup readblock 1+
                disk codebuffer @ 512 i * + 512 memmov
        loop drop

        buffer @ buffer-length @ position @

        @echo is on
        codebuffer @ 2 - buffer !
        codebuffer @ strlen 2 + buffer-length !
        position 0!
        interp
        @echo is off

        position ! buffer-length ! buffer !
;

forget codesize forget codebuffer
