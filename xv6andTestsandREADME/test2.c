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
	char* test = "smalldir2";
	if(mkSmallFilesdir(test) < 0){
    printf(stdout, "mkSmallFilesdir failed\n");
    exit();
  }
  if(chdir(test) < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  /////////////////////////////////////////////////////////////////////////////
  printf(stdout, "------------------------\n");
  printf(stdout, "--Creating Normal File--\n");
  printf(stdout, "---in small directory---\n");
  printf(stdout, "------------------------\n");
  rf = open("normal", O_CREATE|O_RDWR);
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
