( Forth GFX library )
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

