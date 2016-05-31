( Data structure library )
( Austin Bittinger -- December 2, 2015 )
 " compile.forth " import

: object.forth ;

variable objname
variable count

( Main Vocabulary )
: mk-accessor ( offs -- )

;

: structure
        count 0!
        begin
                position @
                word " named " strcmp if
                        drop

                        create

                        metacompile
                                enter object lit
                        done

                        count @ ,

                        metacompile
                                cells allot exit
                        done

                        exit
                then
                position !

                create
                metacompile
                        enter @ lit
                done
                count @ ,
                metacompile
                        cells + exit
                done

                count 1+!
        again
;

forget objname
forget count
