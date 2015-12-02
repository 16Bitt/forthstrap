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
true value resize?

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
: ygraph ( >>function -- )
        { 2 locals: lxclone lyclone }
        xmin @
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

: y= 
        ` fx ! ygraph
does>
        lit lit , 
        ` , 
        lit fx , 
        lit ! , 
        lit ygraph , 
;

: xgraph ( >>function -- )
   ymin @
   ymin @ translate-y ymax @ translate-y do
      dup dup
      fx @ exec swap plot
      ystep @ f+
   loop
;

: x= 
        ` fx ! xgraph 
does> 
        lit lit , 
        ` , 
        lit fx , 
        lit ! ,
        lit xgraph ,
;

( Some basic functions to graph )
: axis drop f 0.0 ;
: quadratic dup f* ;
: linear ;

: graph-list
        {
                1 arguments: list
                3 locals: len lastx lasty
        }
        
        ( We iterate 2 at a time... For t and y )
        list @ list| 2 / len !

        resize? @ if
                cr ." resize? is true, resizing... "
                ( Find the X maximum and minimum )
                f 9999 xmin ! f -9999 xmax !
                len @ 0 do
                        i 2 * list @ list@ @
                        dup xmin @ f< if
                                dup xmin !
                        then
                        dup xmax @ f> if
                                dup xmax !
                        then
                        drop
                loop

                ( Find the Y max and min )
                f 9999 ymin ! f -9999 ymax !
                len @ 0 do
                        i 2 * 1+ list @ list@ @
                        dup ymin @ f< if
                                dup ymin !
                        then
                        dup ymax @ f> if
                                dup ymax !
                        then
                        drop
                loop
                
                cr ." Results: "
                cr ." ymax " ymax @ .f
                cr ." ymin " ymin @ .f
                cr ." xmax " xmax @ .f
                cr ." xmin " xmin @ .f
                
                ymin @ |f| ymax @ |f| f< if
                        cr ." Scaling top to bottom "
                        ymax @ fnegate ymin !
                else
                        cr ." Scaling bottom to top "
                        ymin @ fnegate ymax !
                then
        then
        
        f 0 dup lastx ! lasty !
        
        len @ 0 do
                i 2 * list @ list@ @
                i 2 * 1+ list @ list@ @
                2dup
                i 0 = if
                        drop drop
                else
                        
                        translate-y swap translate-x swap
                        lastx @ translate-x lasty @ translate-y
                        drawline
                then

                lasty ! lastx !
        loop

        ( Draw our axis )
        10000 0 do loop ( Wait for X11 )
        0 color
        y= axis x= axis
        
        {
                4 finished: len list lastx lasty
        }
;

forget xstep forget ystep forget fx forget lastx forget lasty
forget xgraph forget ygraph
