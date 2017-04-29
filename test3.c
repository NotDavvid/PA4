#include "types.h"
#include "user.h"
#include "syscall.h"
#include "stat.h"


int
main(int argc, char *argv[])
{
	const uint N = 55748363;
	printf(1, "malloc test\n");
	malloc(N);
	//currentm("test");
    	exit();

}
