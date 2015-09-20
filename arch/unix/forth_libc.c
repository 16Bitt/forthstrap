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
	printf("Reading file %s...\n", filename);
	unsigned int sz = filesize(filename);
	if(sz == NULL)
		return;

	FILE* f = fopen(filename, "rb");
	int i;
	for(i = 0; i < sz; i++){
		char c = fgetc(f);
		((char*) buffer)[i] = c;
		putchar(c);
	}
	
	fclose(f);
}

//F writebuff writebuff 3 0
void writebuff(unsigned int length, void* addr, char* filename){

}

//F arg_test arg_test 3 0
void arg_test(int a, int b, int c){
	printf("%i %i %i %c%c", a, b, c, 13, 10);
}
