( Project Euler Problem 1 -- Austin Bittinger 4/21/16 )

" logic.forth " import

." Loading " cr

variable sum

: divisible? ( n1 n2 -- f ) rem not ;

: euler1
        sum 0!

        999 0 ?do
                i 3 divisible? i 5 divisible? ^^ if
                        i . space sum @ . cr
                        i sum +!
                then
        loop

        sum @ .
;
