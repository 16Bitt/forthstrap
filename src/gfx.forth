( Forth GFX library )

" arg.forth " import

: gfx.forth ;

( This doesn't really matter depending on the platform )
: pixel ( x y -- ) pix repaint ;

( Line drawing routines )
: horizontal ( length x y -- )
   rot swap dup >r + r> do
      dup i swap pix
   loop drop repaint
;
: vertical ( height x y -- )
   swap rot swap dup >r + r> do
      dup i pix
   loop drop repaint
;

( Shapes )
: rect ( l w x y )
   3dup horizontal
   4dup 3 pick + horizontal drop
   4dup >r >r drop r> r> vertical
   >r + swap 1+ swap r> vertical
;

: abs dup 0 < if negate then ;

( A very bad implementation of Bresenham's line algorithm )
: drawline
        {
                4 arguments:    x1 y1 x2 y2 
                5 locals:       dx dy err derr y
        }
        
        ( Make sure our points are ordered )
        x1 @ x2 @ > if
                x1 @ x2 @ x1 ! x2 !
                y1 @ y2 @ y1 ! y2 !
        then
        
        ( Account for vertical lines )
        x1 @ x2 @ = if
                cr ." VERTICAL "
                ( y1 @ y2 @ - abs
                x1 @ x2 @ vertical )
                exit
        then

        ( Initialize our values for the algorithm )
        x2 @ x1 @ - dx !
        y2 @ y1 @ - dy !
        err 0!
        dy @ dx @ / abs derr !
        y1 @ y !

        derr @ 100 > if
                exit
        then

        ( Our loop to draw... )
        x2 @ x1 @ do
                i y @ pixel
                err @ derr @ + err !
                i err @ 0 do
                        dup y @ pixel
                        dy @ 0 < if
                                y 1-!
                        else
                                y 1+!
                        then
                        err 1-!
                loop
                drop
                err 0!
        loop

        { 9 finished: x1 y1 x2 y2 dx dy err derr y }
;
