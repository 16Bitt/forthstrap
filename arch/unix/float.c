#include "math.h"
#include "stdio.h"
#include "stdlib.h"

//This file provides some very basic floating point routines to interface
//	with forthstrap.

int float_to_int(float f){
	int i;
	*((float*) &i) = f;
	return i;
}

//F fadd fadd 2 1
int fadd(float f1, float f2){
	return float_to_int(f1 + f2);
}

//F fsub fsub 2 1
int fsub(float f1, float f2){
	return float_to_int(f1 - f2);
}

//F fmul fmul 2 1
int fmul(float f1, float f2){
	return float_to_int(f1 * f2);
}

//F fdiv fdiv 2 1
int fdiv(float f1, float f2){
	return float_to_int(f1 / f2);
}

//F fprint fdot 1 0
void fprint(float f1){
	printf("%f", f1);
	fflush(stdout);
}

//F strtofloat tof 1 1
int strtofloat(char* str){
	int ret; 
	*((float*) &ret) = atof(str);
	return ret;
}

//F fcast fcast 1 1
int fcast(int n){
	return float_to_int((float) n);
}
