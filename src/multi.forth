( Forthstrap multitasking library )
( Requires: list.forth r@ r! s@ s! )
: multi.forth ;

variable process
variable [processes]
: processes [processes] @ ;

variable rs-size 32 cells rs-size !
variable ds-size 32 cells ds-size !

: multi-init
        ` list= [processes] !
        object 5 cells allot
        0 processes list@ !
        0 processes list@ @ dup dup dup dup
        object rs-size @ allot swap !
        object ds-size @ allot swap 1 cells + !
        object ws allot swap 2 cells + ! ( sp )
        object ws allot swap 3 cells + ! ( rsp )
        object ws allot swap 4 cells + ! ( ip )
;

: proc.sp processes list@ 2 cells + ;
: proc.ip processes list@ 3 cells + ;
: proc.rsp processes list@ 4 cells + ;

: spawn       
;

: yield

;

: end

;

: kill

;

: mt1 begin char A emit yield again ;
: mt2 begin char B emit yield again ;
