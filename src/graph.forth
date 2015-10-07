( Forthstrap graphing vocabulary )
( Needs: gfx.forth float.forth )
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
f 10 negate xmin !
f 10 xmax !
f 10 negate ymin !
f 10 ymax !

: translate-y
        height >>f ymax @ ymin @ - f/ ystep !
        ystep @ f* >>i height swap -
;

: translate-x
        width >>f xmax @ xmin @ - f/ xstep !
        xstep @ f* >>i
;

: plot ( fx fy -- ) 
   ystep @ f/ translate-y >r
   xstep @ f/ translate-x r> pixel
;

: graph ( >>function -- )
        xmin @
        ` fx !
        xmax @ >>i xmin @ >>i do
              dup fx @ exec
              xstep @ f+
        done
;
