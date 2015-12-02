#include "X11/Xlib.h"
#include "X11/Xutil.h"
#include "stdlib.h"
#include "string.h"
#include "stdio.h"

Display* disp;
Window win;
XEvent evt;
GC context;
int screen;

unsigned long int fg;
unsigned long int bg;
unsigned long int red;
unsigned long int blue;

char* title = "Forth GFX Interface";

Colormap cm;
XColor* colors;

//F gfx_init gfx 0 0
void gfx_init(){
	//Initialize our environment
	disp = XOpenDisplay(NULL);
	screen = DefaultScreen(disp);
	fg = WhitePixel(disp, screen);
	bg = BlackPixel(disp, screen);
	
	cm = DefaultColormap(disp, DefaultScreen(disp));
	colors = (XColor*) malloc(sizeof(XColor) * 8);
	
	int err = 0;
	err = XAllocNamedColor(disp, cm, "white", &colors[0], &colors[0]);
	err += XAllocNamedColor(disp, cm, "black", &colors[1], &colors[1]);
	err += XAllocNamedColor(disp, cm, "red", &colors[2], &colors[2]);
	err += XAllocNamedColor(disp, cm, "blue", &colors[3], &colors[3]);
	err += XAllocNamedColor(disp, cm, "green", &colors[4], &colors[4]);
	
	if(err == 0){
		puts("Failed to allocate color!!!");
		exit(-1);
	}

	//Register our window with default properties
	win = XCreateSimpleWindow(disp, DefaultRootWindow(disp), \
		200, 200, 640, 480, 5, fg, bg);
	XSetStandardProperties(disp, win, title, "Placeholder", None, NULL, 0, NULL);
	
	//Initialize the graphics and input
	context = XCreateGC(disp, win, 0, 0);
	XSetBackground(disp, context, bg);
	XSetForeground(disp, context, fg);
        XClearWindow(disp, win);
        XMapWindow(disp, win);
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

//F clearwindow cleargfx 0 0
void clearwindow(){
        XClearWindow(disp, win);
        repaint();
}

//F width width 0 1
int width(){
   return 640;
}

//F height height 0 1
int height(){
   return 480;
}

//F setcolor color 1 0
void setcolor(int x){
	XSetForeground(disp, context, colors[x].pixel);
	repaint();
}
