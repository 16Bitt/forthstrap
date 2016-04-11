#include "stdio.h"
#include "stdlib.h"
#include "termios.h"
#include "unistd.h"

void raw_tty_cr(){
	putchar(13);
	putchar(10);
}

//F dummy c_test 0 0
void dummy(){
	printf("Hello, world! This is UNIX C from FORTH%c%c", 13, 10);
}

//F filesize filesize 1 1
unsigned int filesize(char* filename){
	FILE* file = fopen(filename, "rb");
	if(file == NULL)
		return NULL;
	fseek(file, 0L, SEEK_END);
	unsigned int size = ftell(file);
	fclose(file);
	return size;
}

//F readbuff readbuff 2 0
void readbuff(void* buffer, char* filename){
	unsigned int sz = filesize(filename);
	if(sz == 0)
		return;

	FILE* f = fopen(filename, "rb");
	int i;
	for(i = 0; i < sz; i++){
		char c = fgetc(f);
		((char*) buffer)[i] = c;
	}
	
	fclose(f);
}

//F writebuff writebuff 3 0
void writebuff(unsigned int length, void* addr, char* filename){
	FILE* f = fopen(filename, "wb");
	if(f == NULL)
		return;

	int i;
	for(i = 0; i < length; i++){
		fputc(((char*) addr)[i], f);
	}

	fclose(f);
}

//F arg_test arg_test 3 0
void arg_test(int a, int b, int c){
	printf("%i %i %i %c%c", a, b, c, 13, 10);
}

void error(char* message){
	printf("forth_libc error: %s\n\r", message);
}

static struct termios orig_settings;
static int tty_fd = STDIN_FILENO;

void reset_tty(){
	(void) tcsetattr(tty_fd, TCSAFLUSH, &orig_settings);
}

//F ttymode ttymode 1 0
void ttymode(unsigned int flag){
	if(!flag){
		reset_tty();
		return;
	}

	if(!isatty(tty_fd)){
		error("Failed to set tty mode");
		return;
	}
	
	if(tcgetattr(tty_fd, &orig_settings) < 0){
		error("Failed to save tty settings");
		return;
	}
	
	atexit(reset_tty);

	//Copied from http://www.cs.uleth.ca/~holzmann/C/system/ttyraw.c
	struct termios raw;
	raw = orig_settings;

	/* input modes - clear indicated ones giving: no break, no CR to NL, 
	*        no parity check, no strip char, no start/stop output (sic) control */
	raw.c_iflag &= ~(BRKINT | ICRNL | INPCK | ISTRIP | IXON);
	
	/* output modes - clear giving: no post processing such as NL to CR+NL */
	raw.c_oflag &= ~(OPOST);

	/* control modes - set 8 bit chars */
	raw.c_cflag |= (CS8);

	/* local modes - clear giving: echoing off, canonical off (no erase with 
	*        backspace, ^U,...),  no extended functions, no signal chars (^Z,^C) */
	raw.c_lflag &= ~(ECHO | ICANON | IEXTEN | ISIG);

	/* control chars - set return condition: min number of bytes and timer */
	/*raw.c_cc[VMIN] = 5; raw.c_cc[VTIME] = 8; /* after 5 bytes or .8 seconds
	after first byte seen      */
	/*raw.c_cc[VMIN] = 0; raw.c_cc[VTIME] = 0; /* immediate - anything       */
	raw.c_cc[VMIN] = 1; raw.c_cc[VTIME] = 0; /* after two bytes, no timer  */
	/*raw.c_cc[VMIN] = 0; raw.c_cc[VTIME] = 8; /* after a byte or .8 seconds */

	/* put terminal in raw mode after flushing */
	if(tcsetattr(tty_fd, TCSAFLUSH, &raw) < 0) error("can't set raw mode");
}

