#include "types.h"
#include "user.h"
#include "syscall.h"

int
main(int argc, char *argv[])
{
	int n=23;
	int counts[n];
	printf(1, "Davvid_Caballero_#A20307530\n");
	if(argc == 2){
		int arg=atoi(argv[1]);
		getcount(counts, n);
		printf(1, "count: %d\n", counts[arg]);
		exit();
	}
	else{
	printf(1, "Add number of System call:\nSYS_fork    1\nSYS_exit    2\nSYS_wait    3\nSYS_pipe    4\nSYS_read    5\nSYS_kill    6\nSYS_exec    7\nSYS_fstat   8\nSYS_chdir   9\nSYS_dup    10\nSYS_getpid 11\nSYS_sbrk   12\nSYS_sleep  13\nSYS_uptime 14\nSYS_open   15\nSYS_write  16\nSYS_mknod  17\nSYS_unlink 18\nSYS_link   19\nSYS_mkdir  20\nSYS_close  21\nSYS_getcount 22\n");
	exit();
	}
}
