( physics.forth -- Austin Bittinger 10/23/15 )





                ( Honors Physics Research Project )

( These are what we expect to have already been loaded: )
list.forth gfx.forth float.forth arg.forth logic.forth

( This library provides a simple way to log numbers and strings )
" src/logger.forth " load
" src/graph.forth " load





                ( Variables )

( Here we are creating our two objects that will be colliding, object1 and object2 )
variable object1
variable object2
( Our time, t )
variable t

f 9.8   constant gravity
f 20.0  constant cord-length ( The length of the cord on our pendulum )





                ( Data structures )

( Here we fill the objects with data )
object
( Mass )                f 1.2 ,
( X coordinate )        f 10 ,
( Y coordinate )        f 10 ,
( X Velocity )          f 0 ,
( Y Velocity )          f 0 ,
( Radius )              f 0.2 ,
object1 !

object
( Mass )                f 1.2 ,
( X coordinate )        f -10 ,
( Y coordinate )        f 10 ,
( X Velocity )          f 0 ,
( Y Velocity )          f 0 ,
( Radius )              f 0.2 ,
object2 !

( For readability, we use these functions to read the object's attributes )
: ->Mass @ ;
: ->X @ 1 cells + ;
: ->Y @ 2 cells + ;
: ->Vx @ 3 cells + ;
: ->Vy @ 4 cells + ;
: ->Radius @ 5 cells + ;






                ( Calculations )

( Some basic formulas )
: ->Px  dup ->Mass @ swap ->Vx @ f* ;
: ->Py  dup ->Mass @ swap ->Vy @ f* ;
: ->Kx  dup ->Mass @ swap ->Vx @ f^2 f* f 0.5 f* ;
: ->Ky  dup ->Mass @ swap ->Vy @ f^2 f* f 0.5 f* ;

: ->Dump
        ." Mass: "      tab dup ->Mass @ .f cr
        ." X: "         tab dup ->X @ .f cr
        ." Y: "         tab dup ->Y @ .f cr
        ." Vx: "        tab dup ->Vx @ .f cr
        ." Vy: "        tab dup ->Vy @ .f cr
        ." R: "         tab ->Radius @ .f cr
;

( Use the distance formula and the radii of the objects to see if they are touching )
: collision? ( o1 o2 -- f )
        { 2 arguments: o1 o2 }
        o1 ->X @ o2 ->X @ f- f^2        ( x1-x2 **2 )
        o1 ->Y @ o2 ->Y @ f- f^2        ( y1-y2 **2 )
        f+ sqrt
        o1 ->Radius @ o2 ->Radius @ f+ f<
        { 2 finished: o1 o2 }
;






                ( Simulation )

( These can be tweaked according to your simulation needs )
200 constant duration
f 0.1 constant stepsize

: step
        { 1 arguments: obj }
        
        { 1 finished: obj }
;

: sim
        { 2 arguments: o1 o2 }

        duration . space ." steps of " stepsize .f cr

        duration 0 do
                o1 @ step
                o2 @ step
                o1 ->X @ ilog
                o2 ->X @ ilog
        loop

        .log

        { 2 finished: o1 o2 }
;
