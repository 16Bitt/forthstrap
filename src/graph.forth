( Forthstrap graphing vocabulary )
gfx.forth float.forth
: graph.forth ;

( The variables required for a scalable graph )
variable xmin
variable xmax
variable ymin
variable ymax
variable ystep
variable xstep
variable fx
variable lastx
variable lasty

( Our defaults )
f 10 f 0 swap f- xmin !
f 10 xmax !
f 10 f 0 swap f- ymin !
f 10 ymax !

( Translate a float to valid ROW-COLUMN coordinate )
: translate-y
        height >>f ymax @ ymin @ f- swap f/ ystep !
        ystep @ f/ >>i ymax @ ystep @ f/ >>i swap -
;
: translate-x
        width >>f xmax @ xmin @ f- swap f/ xstep !
        xstep @ f/ >>i xmin @ f 0 swap f- xstep @ f/ >>i +
;

( Like pixel, but for scientific graphing )
: plot ( fx fy -- ) 
   translate-y swap translate-x swap 2dup pixel lasty ! lastx !
;

( Functions to graph on X and Y axis accordingly )
: y= ( >>function -- )
        { 2 locals: lxclone lyclone }
        xmin @
        ` fx !
        xmax @ translate-x xmin @ translate-x dup lastx ! do
              dup dup
              lastx @ lxclone ! lasty @ lyclone !
              fx @ exec 2dup plot
              2dup drop xmin @ f= not if
                        translate-y swap translate-x swap
                        lxclone @ lyclone @ drawline
              else
                        drop drop
              then
              xstep @ f+
        loop
        { 2 finished: lxclone lyclone }
;

: x= ( >>function -- )
   ymin @
   ` fx !
   ymin @ translate-y ymax @ translate-y do
      dup dup
      fx @ exec swap plot
      ystep @ f+
   loop
;

( Some basic functions to graph )
: axis drop f 0.0 ;
: quadratic dup f* ;
: linear ;

forget xstep forget ystep forget fx forget lastx forget lasty
