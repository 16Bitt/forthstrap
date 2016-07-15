( ui.forth -- Austin Bittinger 5/28/16 )

(
        This library defines a basic interface
        for basic window creation and management
        within the gfx.forth environment.
)

( Imports )
" arg.forth " import
" gfx.forth " import
" safelist.forth " import
" object.forth " import
" defer.forth " import

( Data structures )
structure
	win-x win-y win-wt win-ht
	paint-callback
	onkey-callback
	onclick-callback
	onclose-callback
named window

( Variables )
safelist windows
variable current-window

( Methods )

( Make a variable with a window inside )
: CreateWindow window dup ;

( Draw all windows in the list )
: drawall
	windows len 0 ?do
		( Get the callback of the current structure )
		i windows [] paint-callback @
		( Execute it if it isn't NULL )
		dup if exec else drop then
	loop
;

: bounded? ( x y -- f )
	current-window @ ht @ > if drop false exit then
	current-window @ wt @ > if false exit then
	true
;

old pixel
: pixel ( x y -- )
	2dup
	( Bounds check )
	bounded? not if drop drop exit then
	( Draw using the old pixel routine )
	current-window @ win-y @ + swap
	current-window @ win-x @ + swap
	old
;

( Cleanup )
3 finished: windows drawall current-window
