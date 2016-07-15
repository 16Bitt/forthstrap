#include "stdio.h"
#include "sys/time.h"

//F usecs usecs 0 1
int usecs(){
	struct timeval t;
	gettimeofday(&t, NULL);
	return (int) (t.tv_usec * 1000.0);
}
