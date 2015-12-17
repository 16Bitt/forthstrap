( Words for creating more compiler functionality )
( Austin Bittinger -- December 2, 2015 )
: compile.forth ;



: metacompile cr ." Must be compiling to meta-compile " does>
        begin
                word
                dup " done " strcmp if
                        drop exit
                then
                
                dup number? if
                        lit lit ,
                        lit lit ,
                        lit , ,
                        lit lit ,
                        number ,
                        lit , ,
                else
                        lit lit ,
                        find cfa ,
                        lit , ,
                then
        again
;
