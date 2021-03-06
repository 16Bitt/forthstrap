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

//F icast icast 1 1
int icast(float f){
   return (int) f;
}

//F c_sin sin 1 1
int c_sin(float f){
	return float_to_int(sin(f));
}

//F c_cos cos 1 1
int c_cos(float f){
	return float_to_int(cos(f));
}

//F c_sqrt sqrt 1 1
int c_sqrt(float f){
	return float_to_int(sqrtf(f));
}

//F flt flt 2 1
int flt(float f1, float f2){
	return f1 < f2;
}

//F fgt fgt 2 1
int fgt(float f1, float f2){
	return f1 > f2;
}

//F feq feq 2 1
int feq(float f1, float f2){
	return abs(f1 - f2) < 0.00001;
}

//F farctan invtan 1 1
int farctan(float f){
        return float_to_int(atan(f));
}

//F farcsin invsin 1 1
int farcsin(float f){
        return float_to_int(asin(f));
}

//F farccos invcos 1 1
int farccos(float f){
        return float_to_int(acos(f));
}
