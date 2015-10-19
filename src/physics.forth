( Honors Physics Research Project )

( These are what we expect to have already been loaded: )
list.forth gfx.forth float.forth arg.forth

( This library provides a simple way to log numbers and strings )
" src/logger.forth " load
" src/graph.forth " load

( Here we are creating our two objects that will be colliding, object1 and object2 )
variable object1
variable object2
( Our time, t )
variable t

f 9.8   constant gravity
f 20.0  constant cord-length ( The length of the cord on our pendulum )

( Here we fill the objects with data )
object
( Mass )                f 1.2 ,
( X coordinate )        f 10 ,
( Y coordinate )        f 10 ,
( X Velocity )          f 0 ,
( Y Velocity )          f 0 ,
( Length )              f 2 ,
object1 !

object
( Mass )                f 1.2 ,
( X coordinate )        f -10 ,
( Y coordinate )        f 10 ,
( X Velocity )          f 0 ,
( Y Velocity )          f 0 ,
( Length )              f 2 ,
object2 !

( For readability, we use these functions to read the object's attributes )
: ->Mass @ ;
: ->X @ 1 cells + ;
: ->Y @ 2 cells + ;
: ->Vx @ 3 cells + ;
: ->Vy @ 4 cells + ;
: ->Length @ 5 cells + ;

( Some physics calculations )
: ->Px  dup ->Mass @ swap ->Vx @ f* ;
: ->Py  dup ->Mass @ swap ->Vy @ f* ;
: ->Kx  dup ->Mass @ swap ->Vx @ f^2 f* f 0.5 f* ;
: ->Ky  dup ->Mass @ swap ->Vy @ f^2 f* f 0.5 f* ;

: collision? ( o1 o2 -- f )     ;
: step ( -- )                   ;
: sim ( -- )                    ;
