( Forthstrap graphing vocabulary )
: graph.forth ;

( The variables required for a scalable graph )
variable xmin
variable xmax
variable ymin
variable ymax
variable ystep
variable xstep

( Our defaults )
10 negate xmin !
10 xmax !
10 negate ymin !
10 ymax !

: translate-y
;

: translate-x
;

: plot ( fx fy -- ) 
   ystep @ f/ translate-y >r
   xstep @ f/ translate-x r> pixel
;
