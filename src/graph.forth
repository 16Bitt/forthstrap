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
   translate-y swap translate-x swap pixel
;

( Functions to graph on X and Y axis accordingly )
: y= ( >>function -- )
        xmin @
        ` fx !
        xmax @ translate-x xmin @ translate-x do
              dup dup
              fx @ exec plot
              xstep @ f+
        loop
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
