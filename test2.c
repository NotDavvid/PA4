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
	char* test = "iputdir";
	if(currentm(test) < 0){
    printf(stdout, "mkSmallFilesdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_SMALLFILE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "create small succeeded; ok\n");
  } else {
    printf(stdout, "error: create small failed!\n");
    exit();
  }

	printf(stdout, "writing\n");
	for(i = 0; i < 1; i++){
    if(write(fd, "a", 1) != 1){
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "b", 1) != 1){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2);
  if(i == 2){
    printf(stdout, "read succeeded ok %d\n", i);
  } else {
    printf(stdout, "read failed %s\n", buf);
    exit();
  }
  close(fd);
	printf(1, "close succeeded");
	if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
    exit();
  }

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
}
int
main(void)
{
		writetest();
    exit();
}
