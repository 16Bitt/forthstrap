( ui.forth -- Austin Bittinger 5/28/16 )

(
        This library defines a basic interface
        for basic window creation and management
        within the gfx.forth environment.
)

( Imports )
" gfx.forth " import
" safelist.forth " import
" object.forth " import

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

( Methods )

( Make a variable with a window inside )
: CreateWindow window dup ;

( Draw all windows in the list )
: drawall
	windows len 0 ?do
		( Get the callback of the current structure )
		i windows [] paint-callback @
		( Execute it if it isn't NULL )
		dup if exec else drop then ;
	loop
;

( Cleanup )
forget1 windows
forget1 drawall
