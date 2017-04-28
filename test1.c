#include "types.h"
#include "user.h"
#include "syscall.h"
#include "stat.h"
#include "stdio.h"


int
main(int argc, char *argv[])
{
	FILE *fp = NULL;
	printf(1, "Create a normal file using fopen()\n");
	fp = fopen("test1.txt", "test1");
	fclose(fp);
	exit();

}
