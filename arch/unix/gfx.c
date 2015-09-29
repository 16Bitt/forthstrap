#include "X11/Xlib.h"
#include "X11/Xutil.h"
#include "stdlib.h"
#include "string.h"

Display* disp;
Window win;
XEvent evt;
GC context;
int screen;

unsigned long int fg;
unsigned long int bg;

char* title = "Forth GFX Interface";

//F gfx_init gfx 0 0
void gfx_init(){
	//Initialize our environment
	disp = XOpenDisplay(NULL);
	screen = DefaultScreen(disp);
	fg = WhitePixel(disp, screen);
	bg = BlackPixel(disp, screen);

	//Register our window with default properties
	win = XCreateSimpleWindow(disp, DefaultRootWindow(disp), \
		200, 200, 640, 480, 5, fg, bg);
	XSetStandardProperties(disp, win, title, "Placeholder", None, NULL, 0, NULL);
	
	//Initialize the graphics and input
	context = XCreateGC(disp, win, 0, 0);
	XSetBackground(disp, context, bg);
	XSetForeground(disp, context, fg);
        XClearWindow(disp, win);
	//XSelectInput(disp, win, ButtonPressMask|KeyPressMask|ExposureMask);
        XMapWindow(disp, win);
	//XMapRaised(disp, win);
}

//F repaint repaint 0 0 
void repaint(){
        XFlush(disp);
}

//F gfx_end nogfx 0 0
void gfx_end(){
	XFreeGC(disp, context);
	XDestroyWindow(disp, win);
	XCloseDisplay(disp);
}

//F putpixel pix 2 0
void putpixel(int x, int y){
        XDrawPoint(disp, win, context, x, y);
}
