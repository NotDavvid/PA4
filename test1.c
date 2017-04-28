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
  int fd;
  int i;
  char* test = "iputdirN";
  if(mkdir(test) < 0){
    printf(stdout, "mkSmallFilesdir failed\n");
    exit();
  }
  if(chdir("iputdirN") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  printf(stdout, "normal file test\n");
  fd = open("normal", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "create normal succeeded; ok\n");
  } else {
    printf(stdout, "error: creat normal failed!\n");
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 10; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("normal", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open normal succeeded ok\n");
  } else {
    printf(stdout, "error: open normal failed!\n");
    exit();
  }
  i = read(fd, buf, 200);
  if(i == 200){
    printf(stdout, "read succeeded ok%s\n",buf);
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);

  if(unlink("normal") < 0){
    printf(stdout, "unlink normal failed\n");
    exit();
  }
  printf(stdout, "normal file test ok\n");
}

int
main(void)
{
		writetest();
    exit();
}
