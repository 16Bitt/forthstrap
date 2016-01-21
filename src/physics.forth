( physics.forth -- Austin Bittinger 10/23/15 )





                ( Honors Physics Research Project )

( These are what we expect to have already been loaded: )
logger.forth list.forth gfx.forth float.forth arg.forth logic.forth

( This library provides a simple way to log numbers and strings )




                ( Variables )

( Here we are creating our two objects that will be colliding, object1 and object2 )
variable object1
variable object2
( Create some lists to hold data points )
variable object1-xlist
variable object2-xlist
variable object1-ylist
variable object2-ylist
variable object1-vlist
variable object2-vlist
( Our time, t )
f 0.0 value t

f 9.8   constant g ( Gravity )
f 30.0  constant l ( The length of the cord on our pendulum )
f 1.0   constant Ml ( The mass of our cords )
f 0.5  constant stepsize




                ( Data structures )

( Here we fill the objects with data )
object
( Mass )                f 0.02 ,
( Theta,0 )             pi f 15 f/ ,
( Radius )              f 0.02 ,
( Direction )           f 1.0 ,
( Amplitude )           f 0.2 ,
( Offset )              f 0.0 ,
object1 !

object
( Mass )                f 0.01 ,
( Theta,0 )             pi f 14 f/ ,
( Radius )              f 0.02 ,
( Direction )           f 1.0 ,
( Amplitude )           f 0.2 fnegate ,
( Offset )              f 0.0 ,
object2 !

( For readability, we use these functions to read the object's attributes )
: ->Mass @ ;
: ->Theta,0 @ 1 cells + ;
: ->Radius @ 2 cells + ;
: ->Direction @ 3 cells + ;
: ->Amplitude @ 4 cells + ;
: ->Offset @ 5 cells + ;




                ( Calculations )
: I f 1 f 3 f/ Ml l f^2 f* f* ;

: ->Period
        { 1 arguments: obj }
        ( This is the actual physics calculation )
        f 2 pi f*               ( 2pi )
        obj @ ->Mass @ l f*     ( * Ml )
        g f*                    ( * g )
        I swap f/ sqrt
        f*

        ( This is the adjustment for the simulation )
        obj @ ->Direction @ f*

        { 1 finished: obj }
;


: ->frequency ->Period f 1 swap f/ ;

: ->w ->frequency f 2 pi f* f*  ;

: ->X
        { 1 arguments: obj }
        obj @ ->Amplitude @
        
        obj @ ->w t @ f*
        obj @ ->Theta,0 @ f+
        
        sin f*

        obj @ ->Offset @ f+
        { 1 finished: obj }
;

: ->Y
        { 1 arguments: obj }
        l f^2
        obj @ ->X f^2 f-
        sqrt
        { 1 finished: obj }
;

: ->Theta
        { 1 arguments: obj }
        obj @ ->X
        obj @ ->Y f/
        invtan
        { 1 finished: obj }
;

: ->Velocity
        { 1 arguments: obj }
        obj @ ->w
        obj @ ->Amplitude @ f*

        obj @ ->w t @ f*
        obj @ ->Theta,0 @ f+
        cos f*

        { 1 finished: obj }
;

: ->Velocity-Y
        { 1 arguments: obj }
        obj @ ->w
        obj @ ->Amplitude @ f*

        obj @ ->w t @ f*
        obj @ ->Theta,0 @ f+
        sin f*

        { 1 finished: obj }
;

: ->Velocity-Component
        { 1 arguments: obj }
        
        obj @ ->Velocity f^2
        obj @ ->Velocity-Y f^2 f+
        sqrt

        { 1 finished: obj }
;

: ->Dump
        ." Mass: "      tab tab dup ->Mass @ .f cr
        ." Theta,0: "   tab dup ->Theta,0 @ .f cr
        ." Radius: "    tab dup ->Radius @ .f cr
        ." Dir: "       tab tab dup ->Direction @ .f cr
        ." Xpos: "      tab tab dup ->X .f cr
        ." Ypos: "      tab tab ->Y .f cr
;

( Use the distance formula and the radii of the objects to see if they are touching )
: collision? ( o1 o2 -- f )
        { 2 arguments: o1 o2 }
        o1 @ ->X o2 @ ->X f- f^2        ( x1-x2 **2 )
        o1 @ ->Y o2 @ ->Y f- f^2        ( y1-y2 **2 )
        f+ sqrt
        o1 @ ->Radius @ o2 @ ->Radius @ f+ f<
        { 2 finished: o1 o2 }
;

( Trim lists for graphing )
: trimmed 1 swap @ list@ ;

( Get a new amplitude )
: conserved-amplitude ( obj1 obj2 -- obj1-adjusted-amplitude )
        { 2 arguments: o1 o2 }
        ( 
                       m2*v2
                --------------------
                m1*w1*cos[w1*t + theta,0,1]
        )
        
        o2 @ ->Mass @ 
        o2 @ ->Velocity f*
        
        o1 @ ->Mass @
        o1 @ ->w f*
        o1 @ ->w
        t @ f*
        o1 @ ->Theta,0 @ f+
        cos f* f/
        
        fnegate
        { 2 finished: o1 o2 }
;

: conserved-theta,0 ( newX obj -- obj1-adjusted-theta )
        { 2 arguments: newX obj }
        
        ( 
                          newX
                arcsin[ -------- ] - w*t
                           A
        )

        newX @
        obj @ ->Amplitude @ f/
        
        dup f 1 f> if
                cr ." GUARD MAX "
                drop f 1
        then

        dup f -1 f< if
                cr ." GUARD MIN "
                drop f -1
        then
        
        invsin

        obj @ ->w
        t @ f*

        f-

        { 2 finished: newX obj }
;





                ( Simulation )

( These can be tweaked according to your simulation needs )
300     constant duration
5      constant adjustment
variable cooldown

: cool cooldown @ if cooldown 1-! then ;

: step t @ stepsize f+ t ! ;

: sim
        cr ." Starting sim with " stepsize .f space ." steps " cr
        0 list= object1-xlist !
        0 list= object2-xlist !
        0 list= object1-ylist !
        0 list= object2-ylist !
        0 list= object1-vlist !
        0 list= object2-vlist !

        duration 0 do
                ( Log object1 X coordinates )
                object1-xlist @ [logroot] !
                t @ log
                object1 ->X log

                ( Log object1 Y coordinates )
                object1-ylist @ [logroot] !
                t @ log
                object1 ->Y log

                ( Log object2 X coordinates )
                object2-xlist @ [logroot] !
                t @ log
                object2 ->X log

                ( Log object2 Y coordinates )
                object2-ylist @ [logroot] !
                t @ log
                object2 ->Y log
                
                ( Log object1 velocity )
                object1-vlist @ [logroot] !
                t @ log
                object1 ->Velocity log

                ( Log object2 velocity )
                object2-vlist @ [logroot] !
                t @ log
                object2 ->Velocity log
                
                object1 object2 collision? if
                       ." Collision on step " i . cr
                       cooldown @ not if
                                ( Save our Xs for adjustment )
                                object1 ->X object2 ->X
                                
                                ( Use the conservation of p to calc A )
                                object1 object2 conserved-amplitude
                                object2 object1 conserved-amplitude
                                object2 ->Amplitude !
                                object1 ->Amplitude !
                                
                                ( Use the old Xs to calc theta,0 )
                                object2 conserved-theta,0
                                object2 ->Theta,0 !
                                object1 conserved-theta,0
                                object1 ->Theta,0 !
                                adjustment cooldown !
                       else
                                ." Collision in cooldown period, ignore " cr
                       then
                then
                
                cool
                step
        loop
        
        gfx repaint
        ( Trim the list )
        resize? is true
        2 color
        object1-xlist trimmed graph-list
        resize? is false
        3 color
        object2-xlist trimmed graph-list

        cr ." Logged " logroot list| 2 / . space ." points "
;
