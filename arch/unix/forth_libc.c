#include "stdio.h"
#include "stdlib.h"

void raw_tty_cr(){
	putchar(13);
	putchar(10);
}

//F dummy c_test 0 0
void dummy(){
	printf("Hello, world! This is UNIX C from FORTH%c%c", 13, 10);
}

//F readbuff readbuff 1 0
void readbuff(char* filename){
	
}

//F writebuff writebuff 3 0
void writebuff(char* filename, unsigned int length, void* addr){

}

//F arg_test arg_test 3 0
void arg_test(int a, int b, int c){
	printf("%i %i %i %c%c", a, b, c, 13, 10);
}
