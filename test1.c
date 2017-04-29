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
	char* test = "smalldir1";
  printf(stdout, "Make mkSmallFilesdir\n");
	if(mkSmallFilesdir(test) < 0){
    printf(stdout, "mkSmallFilesdir failed\n");
    exit();
  }
  printf(stdout, "\tsucceeded\n");
  printf(stdout, "Change to mkSmallFilesdir\n");
  if(chdir(test) < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  printf(stdout, "\tsucceeded\n");
  printf(stdout, "Create small file\n");
  fd = open("small", O_CREATE|O_SFILE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "\tsucceeded\n");
  } else {
    printf(stdout, "error: create small failed!\n");
    exit();
  }
	printf(stdout, "Writing to file\n");
	for(i = 0; i < 2; i++){
    if(write(fd, "aa", 2) != 2){
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bb", 2) != 2){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "\tsucceeded\n");
  printf(stdout, "Closing file\n");
  close(fd);
  printf(stdout, "\tsucceeded\n");

  printf(stdout, "Opening file\n");
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "\tsucceeded\n");
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  printf(stdout, "Reading file\n");
  i = read(fd, buf, 8);
  if(i == 8){
    printf(stdout, "\tsucceeded\n");
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  printf(stdout, "Closing file\n");
  close(fd);
	printf(1, "\tsucceeded\n");
  printf(stdout, "small file tests ok\n");
}
int
main(void)
{
		writetest();
    exit();
}
