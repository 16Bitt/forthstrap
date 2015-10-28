#include "stdio.h"
#include "stdlib.h"
#include "signal.h"
#include "string.h"

void catch_segfault(int signal, siginfo_t* si, void* args){
	printf("\n\rERROR: memory protection violation at %p\n\r", si->si_addr);
	exit(0);
}

//F init_handler safety 0 0
void init_handler(){
	struct sigaction sa;
	memset(&sa, 0, sizeof(struct sigaction));
	sigemptyset(&sa.sa_mask);
	sa.sa_sigaction = catch_segfault;
	sa.sa_flags = SA_SIGINFO;

	sigaction(SIGSEGV, &sa, NULL);

	printf("\n\rSegfault handler remapped.\n\r");
}
