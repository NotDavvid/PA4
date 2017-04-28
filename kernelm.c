#include "types.h"
#include "user.h"
#include "syscall.h"


int
main(int argc, char *argv[])
{
	int n = 2;
	const uint PGSIZE = 4096;
	int pages[n];
	int finals=0;	
	pages[1]=3;
	currentm(pages, finals);
	printf(1, "Kernel: %d\n", pages[1]/PGSIZE);
	exit();
	
}
