#include "types.h"
#include "user.h"
#include "syscall.h"
#include "stat.h"
#include "fcntl.h"


#define N 100
char buf[8192];
int stdout = 1;

void
writetest(void)
{
  int rf;
	char* test = "normdir1";
	if(mkdir(test) < 0){
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir(test) < 0){
    printf(stdout, "chdir normdir1 failed\n");
    exit();
  }
  /////////////////////////////////////////////////////////////////////////////
  printf(stdout, "-------------------------\n");
  printf(stdout, "---Creating Small File---\n");
  printf(stdout, "---in normal directory---\n");
  printf(stdout, "-------------------------\n");
  rf = open("small", O_CREATE|O_SFILE|O_RDWR);
  if(rf >= 0){
    printf(stdout, "\tsucceeded\n");
  } else {
    printf(stdout, "error: create normal file failed!\n");
    exit();
  }
  /////////////////////////////////////////////////////////////////////////////
}
int
main(void)
{
		writetest();
    exit();
}
