( Forthstrap logging library )
( Requires: list.forth )
list.forth strlib.forth
: logger.forth ;

variable [logroot]
: logroot [logroot] @ ;

" logger.forth " list= [logroot] !

: log ( s -- )       
        logroot list+
;

: ilog ( i -- )
        i>>s logroot list+
;

: .log
        logroot list| 0 do
                cr i logroot list@ @ .s
        loop
;
