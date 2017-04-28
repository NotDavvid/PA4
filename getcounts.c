#include "types.h"
#include "user.h"
#include "syscall.h"

const char *sysname(int sysint){
	if(sysint == 1){
		return "SYS_fork";
	}	
	if(sysint == 2){
		return "SYS_exit";
	}
	if(sysint == 3){
		return "SYS_wait";
	}	
	if(sysint == 4){
		return "SYS_pipe";
	}
	if(sysint == 5){
		return "SYS_read";
	}	
	if(sysint == 6){
		return "SYS_kill";
	}
	if(sysint == 7){
		return "SYS_exec";
	}	
	if(sysint == 8){
		return "SYS_fstat";
	}
	if(sysint == 9){
		return "SYS_chdir";
	}	
	if(sysint == 10){
		return "SYS_dup";
	}
	if(sysint == 11){
		return "SYS_getpid";
	}	
	if(sysint == 12){
		return "SYS_sbrk";
	}
	if(sysint == 13){
		return "SYS_sleep";
	}	
	if(sysint == 14){
		return "SYS_uptime";
	}
	if(sysint == 15){
		return "SYS_open";
	}	
	if(sysint == 16){
		return "SYS_write";
	}
	if(sysint == 17){
		return "SYS_mkmod";
	}	
	if(sysint == 18){
		return "SYS_unlink";
	}
	if(sysint == 19){
		return "SYS_link";
	}	
	if(sysint == 20){
		return "SYS_mkdir";
	}
	if(sysint == 21){
		return "SYS_close";
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}

int
main(int argc, char *argv[])
{
	int n=23;
	int counts[n];
	printf(1, "Davvid_Caballero_#A20307530\n");
	int counter = 1;
	getcount(counts, n);
	if(argc == 1){	
	while(counter < n){
		
		printf(1,"%s:%d\n",sysname(counter),counts[counter]);
	counter = counter +1;
			
	}
	}
	else if(argc == 2 && strcmp(argv[1], "-z") ==0){
		while(counter < n){
		if(counts[counter] !=0){
			printf(1,"%s:%d\n",sysname(counter),counts[counter]);
		}
		counter = counter +1;
			
	}


	}
	exit();
}
