
_test2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(stdout, "small file test ok\n");
}

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
		writetest();
  11:	e8 0a 00 00 00       	call   20 <writetest>
    exit();
  16:	e8 87 04 00 00       	call   4a2 <exit>
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	90                   	nop

00000020 <writetest>:
char buf[8192];
int stdout = 1;

void
writetest(void)
{
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	56                   	push   %esi
  24:	53                   	push   %ebx
  int fd;
  int i;
	char* test = "iputdir";
	if(mkdir(test) < 0){
  25:	83 ec 0c             	sub    $0xc,%esp
  28:	68 20 09 00 00       	push   $0x920
  2d:	e8 d8 04 00 00       	call   50a <mkdir>
  32:	83 c4 10             	add    $0x10,%esp
  35:	85 c0                	test   %eax,%eax
  37:	0f 88 be 01 00 00    	js     1fb <writetest+0x1db>
    printf(stdout, "mkSmallFilesdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
  3d:	83 ec 0c             	sub    $0xc,%esp
  40:	68 20 09 00 00       	push   $0x920
  45:	e8 c8 04 00 00       	call   512 <chdir>
  4a:	83 c4 10             	add    $0x10,%esp
  4d:	85 c0                	test   %eax,%eax
  4f:	0f 88 8e 01 00 00    	js     1e3 <writetest+0x1c3>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  printf(stdout, "small file test\n");
  55:	83 ec 08             	sub    $0x8,%esp
  58:	68 56 09 00 00       	push   $0x956
  5d:	ff 35 58 0d 00 00    	pushl  0xd58
  63:	e8 98 05 00 00       	call   600 <printf>
  fd = open("small", O_CREATE|O_SMALLFILE|O_RDWR);
  68:	59                   	pop    %ecx
  69:	5b                   	pop    %ebx
  6a:	68 02 06 00 00       	push   $0x602
  6f:	68 67 09 00 00       	push   $0x967
  74:	e8 69 04 00 00       	call   4e2 <open>
  if(fd >= 0){
  79:	83 c4 10             	add    $0x10,%esp
  7c:	85 c0                	test   %eax,%eax
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_SMALLFILE|O_RDWR);
  7e:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
  80:	0f 88 45 01 00 00    	js     1cb <writetest+0x1ab>
    printf(stdout, "create small succeeded; ok\n");
  86:	83 ec 08             	sub    $0x8,%esp
  } else {
    printf(stdout, "error: create small failed!\n");
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 100; i++){
  89:	31 db                	xor    %ebx,%ebx
    exit();
  }
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_SMALLFILE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "create small succeeded; ok\n");
  8b:	68 6d 09 00 00       	push   $0x96d
  90:	ff 35 58 0d 00 00    	pushl  0xd58
  96:	e8 65 05 00 00       	call   600 <printf>
  9b:	83 c4 10             	add    $0x10,%esp
  9e:	66 90                	xchg   %ax,%ax
    printf(stdout, "error: create small failed!\n");
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	6a 0a                	push   $0xa
  a5:	68 a6 09 00 00       	push   $0x9a6
  aa:	56                   	push   %esi
  ab:	e8 12 04 00 00       	call   4c2 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	83 f8 0a             	cmp    $0xa,%eax
  b6:	0f 85 dd 00 00 00    	jne    199 <writetest+0x179>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
  bc:	83 ec 04             	sub    $0x4,%esp
  bf:	6a 0a                	push   $0xa
  c1:	68 b1 09 00 00       	push   $0x9b1
  c6:	56                   	push   %esi
  c7:	e8 f6 03 00 00       	call   4c2 <write>
  cc:	83 c4 10             	add    $0x10,%esp
  cf:	83 f8 0a             	cmp    $0xa,%eax
  d2:	0f 85 da 00 00 00    	jne    1b2 <writetest+0x192>
  } else {
    printf(stdout, "error: create small failed!\n");
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 100; i++){
  d8:	83 c3 01             	add    $0x1,%ebx
  db:	83 fb 64             	cmp    $0x64,%ebx
  de:	75 c0                	jne    a0 <writetest+0x80>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  e0:	83 ec 08             	sub    $0x8,%esp
  e3:	68 bc 09 00 00       	push   $0x9bc
  e8:	ff 35 58 0d 00 00    	pushl  0xd58
  ee:	e8 0d 05 00 00       	call   600 <printf>
  close(fd);
  f3:	89 34 24             	mov    %esi,(%esp)
  f6:	e8 cf 03 00 00       	call   4ca <close>
  fd = open("small", O_RDONLY);
  fb:	58                   	pop    %eax
  fc:	5a                   	pop    %edx
  fd:	6a 00                	push   $0x0
  ff:	68 67 09 00 00       	push   $0x967
 104:	e8 d9 03 00 00       	call   4e2 <open>
  if(fd >= 0){
 109:	83 c4 10             	add    $0x10,%esp
 10c:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
 10e:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
 110:	0f 88 2d 01 00 00    	js     243 <writetest+0x223>
    printf(stdout, "open small succeeded ok\n");
 116:	83 ec 08             	sub    $0x8,%esp
 119:	68 c7 09 00 00       	push   $0x9c7
 11e:	ff 35 58 0d 00 00    	pushl  0xd58
 124:	e8 d7 04 00 00       	call   600 <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
 129:	83 c4 0c             	add    $0xc,%esp
 12c:	68 d0 07 00 00       	push   $0x7d0
 131:	68 80 0d 00 00       	push   $0xd80
 136:	53                   	push   %ebx
 137:	e8 7e 03 00 00       	call   4ba <read>
  if(i == 2000){
 13c:	83 c4 10             	add    $0x10,%esp
 13f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
 144:	0f 85 e1 00 00 00    	jne    22b <writetest+0x20b>
    printf(stdout, "read succeeded ok\n");
 14a:	83 ec 08             	sub    $0x8,%esp
 14d:	68 fb 09 00 00       	push   $0x9fb
 152:	ff 35 58 0d 00 00    	pushl  0xd58
 158:	e8 a3 04 00 00       	call   600 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
 15d:	89 1c 24             	mov    %ebx,(%esp)
 160:	e8 65 03 00 00       	call   4ca <close>

  if(unlink("small") < 0){
 165:	c7 04 24 67 09 00 00 	movl   $0x967,(%esp)
 16c:	e8 81 03 00 00       	call   4f2 <unlink>
 171:	83 c4 10             	add    $0x10,%esp
 174:	85 c0                	test   %eax,%eax
 176:	0f 88 97 00 00 00    	js     213 <writetest+0x1f3>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
 17c:	83 ec 08             	sub    $0x8,%esp
 17f:	68 30 0a 00 00       	push   $0xa30
 184:	ff 35 58 0d 00 00    	pushl  0xd58
 18a:	e8 71 04 00 00       	call   600 <printf>
}
 18f:	83 c4 10             	add    $0x10,%esp
 192:	8d 65 f8             	lea    -0x8(%ebp),%esp
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5d                   	pop    %ebp
 198:	c3                   	ret    
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
 199:	83 ec 04             	sub    $0x4,%esp
 19c:	53                   	push   %ebx
 19d:	68 44 0a 00 00       	push   $0xa44
 1a2:	ff 35 58 0d 00 00    	pushl  0xd58
 1a8:	e8 53 04 00 00       	call   600 <printf>
      exit();
 1ad:	e8 f0 02 00 00       	call   4a2 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
 1b2:	83 ec 04             	sub    $0x4,%esp
 1b5:	53                   	push   %ebx
 1b6:	68 68 0a 00 00       	push   $0xa68
 1bb:	ff 35 58 0d 00 00    	pushl  0xd58
 1c1:	e8 3a 04 00 00       	call   600 <printf>
      exit();
 1c6:	e8 d7 02 00 00       	call   4a2 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_SMALLFILE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "create small succeeded; ok\n");
  } else {
    printf(stdout, "error: create small failed!\n");
 1cb:	83 ec 08             	sub    $0x8,%esp
 1ce:	68 89 09 00 00       	push   $0x989
 1d3:	ff 35 58 0d 00 00    	pushl  0xd58
 1d9:	e8 22 04 00 00       	call   600 <printf>
    exit();
 1de:	e8 bf 02 00 00       	call   4a2 <exit>
	if(mkdir(test) < 0){
    printf(stdout, "mkSmallFilesdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
 1e3:	83 ec 08             	sub    $0x8,%esp
 1e6:	68 40 09 00 00       	push   $0x940
 1eb:	ff 35 58 0d 00 00    	pushl  0xd58
 1f1:	e8 0a 04 00 00       	call   600 <printf>
    exit();
 1f6:	e8 a7 02 00 00       	call   4a2 <exit>
{
  int fd;
  int i;
	char* test = "iputdir";
	if(mkdir(test) < 0){
    printf(stdout, "mkSmallFilesdir failed\n");
 1fb:	83 ec 08             	sub    $0x8,%esp
 1fe:	68 28 09 00 00       	push   $0x928
 203:	ff 35 58 0d 00 00    	pushl  0xd58
 209:	e8 f2 03 00 00       	call   600 <printf>
    exit();
 20e:	e8 8f 02 00 00       	call   4a2 <exit>
    exit();
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
 213:	83 ec 08             	sub    $0x8,%esp
 216:	68 1b 0a 00 00       	push   $0xa1b
 21b:	ff 35 58 0d 00 00    	pushl  0xd58
 221:	e8 da 03 00 00       	call   600 <printf>
    exit();
 226:	e8 77 02 00 00       	call   4a2 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
 22b:	83 ec 08             	sub    $0x8,%esp
 22e:	68 0e 0a 00 00       	push   $0xa0e
 233:	ff 35 58 0d 00 00    	pushl  0xd58
 239:	e8 c2 03 00 00       	call   600 <printf>
    exit();
 23e:	e8 5f 02 00 00       	call   4a2 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
 243:	83 ec 08             	sub    $0x8,%esp
 246:	68 e0 09 00 00       	push   $0x9e0
 24b:	ff 35 58 0d 00 00    	pushl  0xd58
 251:	e8 aa 03 00 00       	call   600 <printf>
    exit();
 256:	e8 47 02 00 00       	call   4a2 <exit>
 25b:	66 90                	xchg   %ax,%ax
 25d:	66 90                	xchg   %ax,%ax
 25f:	90                   	nop

00000260 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 260:	55                   	push   %ebp
 261:	89 e5                	mov    %esp,%ebp
 263:	53                   	push   %ebx
 264:	8b 45 08             	mov    0x8(%ebp),%eax
 267:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 26a:	89 c2                	mov    %eax,%edx
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 270:	83 c1 01             	add    $0x1,%ecx
 273:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 277:	83 c2 01             	add    $0x1,%edx
 27a:	84 db                	test   %bl,%bl
 27c:	88 5a ff             	mov    %bl,-0x1(%edx)
 27f:	75 ef                	jne    270 <strcpy+0x10>
    ;
  return os;
}
 281:	5b                   	pop    %ebx
 282:	5d                   	pop    %ebp
 283:	c3                   	ret    
 284:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 28a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000290 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
 295:	8b 55 08             	mov    0x8(%ebp),%edx
 298:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 29b:	0f b6 02             	movzbl (%edx),%eax
 29e:	0f b6 19             	movzbl (%ecx),%ebx
 2a1:	84 c0                	test   %al,%al
 2a3:	75 1e                	jne    2c3 <strcmp+0x33>
 2a5:	eb 29                	jmp    2d0 <strcmp+0x40>
 2a7:	89 f6                	mov    %esi,%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2b0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2b6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2b9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2bd:	84 c0                	test   %al,%al
 2bf:	74 0f                	je     2d0 <strcmp+0x40>
 2c1:	89 f1                	mov    %esi,%ecx
 2c3:	38 d8                	cmp    %bl,%al
 2c5:	74 e9                	je     2b0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2c7:	29 d8                	sub    %ebx,%eax
}
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret    
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2d0:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 2d2:	29 d8                	sub    %ebx,%eax
}
 2d4:	5b                   	pop    %ebx
 2d5:	5e                   	pop    %esi
 2d6:	5d                   	pop    %ebp
 2d7:	c3                   	ret    
 2d8:	90                   	nop
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002e0 <strlen>:

uint
strlen(char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 2e6:	80 39 00             	cmpb   $0x0,(%ecx)
 2e9:	74 12                	je     2fd <strlen+0x1d>
 2eb:	31 d2                	xor    %edx,%edx
 2ed:	8d 76 00             	lea    0x0(%esi),%esi
 2f0:	83 c2 01             	add    $0x1,%edx
 2f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 2f7:	89 d0                	mov    %edx,%eax
 2f9:	75 f5                	jne    2f0 <strlen+0x10>
    ;
  return n;
}
 2fb:	5d                   	pop    %ebp
 2fc:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 2fd:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 2ff:	5d                   	pop    %ebp
 300:	c3                   	ret    
 301:	eb 0d                	jmp    310 <memset>
 303:	90                   	nop
 304:	90                   	nop
 305:	90                   	nop
 306:	90                   	nop
 307:	90                   	nop
 308:	90                   	nop
 309:	90                   	nop
 30a:	90                   	nop
 30b:	90                   	nop
 30c:	90                   	nop
 30d:	90                   	nop
 30e:	90                   	nop
 30f:	90                   	nop

00000310 <memset>:

void*
memset(void *dst, int c, uint n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 317:	8b 4d 10             	mov    0x10(%ebp),%ecx
 31a:	8b 45 0c             	mov    0xc(%ebp),%eax
 31d:	89 d7                	mov    %edx,%edi
 31f:	fc                   	cld    
 320:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 322:	89 d0                	mov    %edx,%eax
 324:	5f                   	pop    %edi
 325:	5d                   	pop    %ebp
 326:	c3                   	ret    
 327:	89 f6                	mov    %esi,%esi
 329:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000330 <strchr>:

char*
strchr(const char *s, char c)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	53                   	push   %ebx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 33a:	0f b6 10             	movzbl (%eax),%edx
 33d:	84 d2                	test   %dl,%dl
 33f:	74 1d                	je     35e <strchr+0x2e>
    if(*s == c)
 341:	38 d3                	cmp    %dl,%bl
 343:	89 d9                	mov    %ebx,%ecx
 345:	75 0d                	jne    354 <strchr+0x24>
 347:	eb 17                	jmp    360 <strchr+0x30>
 349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 350:	38 ca                	cmp    %cl,%dl
 352:	74 0c                	je     360 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 354:	83 c0 01             	add    $0x1,%eax
 357:	0f b6 10             	movzbl (%eax),%edx
 35a:	84 d2                	test   %dl,%dl
 35c:	75 f2                	jne    350 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 35e:	31 c0                	xor    %eax,%eax
}
 360:	5b                   	pop    %ebx
 361:	5d                   	pop    %ebp
 362:	c3                   	ret    
 363:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <gets>:

char*
gets(char *buf, int max)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	57                   	push   %edi
 374:	56                   	push   %esi
 375:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 376:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 378:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 37b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 37e:	eb 29                	jmp    3a9 <gets+0x39>
    cc = read(0, &c, 1);
 380:	83 ec 04             	sub    $0x4,%esp
 383:	6a 01                	push   $0x1
 385:	57                   	push   %edi
 386:	6a 00                	push   $0x0
 388:	e8 2d 01 00 00       	call   4ba <read>
    if(cc < 1)
 38d:	83 c4 10             	add    $0x10,%esp
 390:	85 c0                	test   %eax,%eax
 392:	7e 1d                	jle    3b1 <gets+0x41>
      break;
    buf[i++] = c;
 394:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 398:	8b 55 08             	mov    0x8(%ebp),%edx
 39b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 39d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 39f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3a3:	74 1b                	je     3c0 <gets+0x50>
 3a5:	3c 0d                	cmp    $0xd,%al
 3a7:	74 17                	je     3c0 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3a9:	8d 5e 01             	lea    0x1(%esi),%ebx
 3ac:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3af:	7c cf                	jl     380 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3b1:	8b 45 08             	mov    0x8(%ebp),%eax
 3b4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3bb:	5b                   	pop    %ebx
 3bc:	5e                   	pop    %esi
 3bd:	5f                   	pop    %edi
 3be:	5d                   	pop    %ebp
 3bf:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3c0:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3c3:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3c5:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3cc:	5b                   	pop    %ebx
 3cd:	5e                   	pop    %esi
 3ce:	5f                   	pop    %edi
 3cf:	5d                   	pop    %ebp
 3d0:	c3                   	ret    
 3d1:	eb 0d                	jmp    3e0 <stat>
 3d3:	90                   	nop
 3d4:	90                   	nop
 3d5:	90                   	nop
 3d6:	90                   	nop
 3d7:	90                   	nop
 3d8:	90                   	nop
 3d9:	90                   	nop
 3da:	90                   	nop
 3db:	90                   	nop
 3dc:	90                   	nop
 3dd:	90                   	nop
 3de:	90                   	nop
 3df:	90                   	nop

000003e0 <stat>:

int
stat(char *n, struct stat *st)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	56                   	push   %esi
 3e4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3e5:	83 ec 08             	sub    $0x8,%esp
 3e8:	6a 00                	push   $0x0
 3ea:	ff 75 08             	pushl  0x8(%ebp)
 3ed:	e8 f0 00 00 00       	call   4e2 <open>
  if(fd < 0)
 3f2:	83 c4 10             	add    $0x10,%esp
 3f5:	85 c0                	test   %eax,%eax
 3f7:	78 27                	js     420 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3f9:	83 ec 08             	sub    $0x8,%esp
 3fc:	ff 75 0c             	pushl  0xc(%ebp)
 3ff:	89 c3                	mov    %eax,%ebx
 401:	50                   	push   %eax
 402:	e8 f3 00 00 00       	call   4fa <fstat>
 407:	89 c6                	mov    %eax,%esi
  close(fd);
 409:	89 1c 24             	mov    %ebx,(%esp)
 40c:	e8 b9 00 00 00       	call   4ca <close>
  return r;
 411:	83 c4 10             	add    $0x10,%esp
 414:	89 f0                	mov    %esi,%eax
}
 416:	8d 65 f8             	lea    -0x8(%ebp),%esp
 419:	5b                   	pop    %ebx
 41a:	5e                   	pop    %esi
 41b:	5d                   	pop    %ebp
 41c:	c3                   	ret    
 41d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 425:	eb ef                	jmp    416 <stat+0x36>
 427:	89 f6                	mov    %esi,%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	53                   	push   %ebx
 434:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 437:	0f be 11             	movsbl (%ecx),%edx
 43a:	8d 42 d0             	lea    -0x30(%edx),%eax
 43d:	3c 09                	cmp    $0x9,%al
 43f:	b8 00 00 00 00       	mov    $0x0,%eax
 444:	77 1f                	ja     465 <atoi+0x35>
 446:	8d 76 00             	lea    0x0(%esi),%esi
 449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 450:	8d 04 80             	lea    (%eax,%eax,4),%eax
 453:	83 c1 01             	add    $0x1,%ecx
 456:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 45a:	0f be 11             	movsbl (%ecx),%edx
 45d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 460:	80 fb 09             	cmp    $0x9,%bl
 463:	76 eb                	jbe    450 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 465:	5b                   	pop    %ebx
 466:	5d                   	pop    %ebp
 467:	c3                   	ret    
 468:	90                   	nop
 469:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000470 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
 475:	8b 5d 10             	mov    0x10(%ebp),%ebx
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 47e:	85 db                	test   %ebx,%ebx
 480:	7e 14                	jle    496 <memmove+0x26>
 482:	31 d2                	xor    %edx,%edx
 484:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 488:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 48c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 48f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 492:	39 da                	cmp    %ebx,%edx
 494:	75 f2                	jne    488 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 496:	5b                   	pop    %ebx
 497:	5e                   	pop    %esi
 498:	5d                   	pop    %ebp
 499:	c3                   	ret    

0000049a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 49a:	b8 01 00 00 00       	mov    $0x1,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <exit>:
SYSCALL(exit)
 4a2:	b8 02 00 00 00       	mov    $0x2,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <wait>:
SYSCALL(wait)
 4aa:	b8 03 00 00 00       	mov    $0x3,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <pipe>:
SYSCALL(pipe)
 4b2:	b8 04 00 00 00       	mov    $0x4,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <read>:
SYSCALL(read)
 4ba:	b8 05 00 00 00       	mov    $0x5,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <write>:
SYSCALL(write)
 4c2:	b8 10 00 00 00       	mov    $0x10,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <close>:
SYSCALL(close)
 4ca:	b8 15 00 00 00       	mov    $0x15,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <kill>:
SYSCALL(kill)
 4d2:	b8 06 00 00 00       	mov    $0x6,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <exec>:
SYSCALL(exec)
 4da:	b8 07 00 00 00       	mov    $0x7,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <open>:
SYSCALL(open)
 4e2:	b8 0f 00 00 00       	mov    $0xf,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <mknod>:
SYSCALL(mknod)
 4ea:	b8 11 00 00 00       	mov    $0x11,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <unlink>:
SYSCALL(unlink)
 4f2:	b8 12 00 00 00       	mov    $0x12,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <fstat>:
SYSCALL(fstat)
 4fa:	b8 08 00 00 00       	mov    $0x8,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <link>:
SYSCALL(link)
 502:	b8 13 00 00 00       	mov    $0x13,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <mkdir>:
SYSCALL(mkdir)
 50a:	b8 14 00 00 00       	mov    $0x14,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <chdir>:
SYSCALL(chdir)
 512:	b8 09 00 00 00       	mov    $0x9,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <dup>:
SYSCALL(dup)
 51a:	b8 0a 00 00 00       	mov    $0xa,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <getpid>:
SYSCALL(getpid)
 522:	b8 0b 00 00 00       	mov    $0xb,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <sbrk>:
SYSCALL(sbrk)
 52a:	b8 0c 00 00 00       	mov    $0xc,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <sleep>:
SYSCALL(sleep)
 532:	b8 0d 00 00 00       	mov    $0xd,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <uptime>:
SYSCALL(uptime)
 53a:	b8 0e 00 00 00       	mov    $0xe,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <getcount>:
SYSCALL(getcount)
 542:	b8 16 00 00 00       	mov    $0x16,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <currentm>:
SYSCALL(currentm)
 54a:	b8 17 00 00 00       	mov    $0x17,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    
 552:	66 90                	xchg   %ax,%ax
 554:	66 90                	xchg   %ax,%ax
 556:	66 90                	xchg   %ax,%ax
 558:	66 90                	xchg   %ax,%ax
 55a:	66 90                	xchg   %ax,%ax
 55c:	66 90                	xchg   %ax,%ax
 55e:	66 90                	xchg   %ax,%ax

00000560 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 560:	55                   	push   %ebp
 561:	89 e5                	mov    %esp,%ebp
 563:	57                   	push   %edi
 564:	56                   	push   %esi
 565:	53                   	push   %ebx
 566:	89 c6                	mov    %eax,%esi
 568:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 56b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 56e:	85 db                	test   %ebx,%ebx
 570:	74 7e                	je     5f0 <printint+0x90>
 572:	89 d0                	mov    %edx,%eax
 574:	c1 e8 1f             	shr    $0x1f,%eax
 577:	84 c0                	test   %al,%al
 579:	74 75                	je     5f0 <printint+0x90>
    neg = 1;
    x = -xx;
 57b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 57d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 584:	f7 d8                	neg    %eax
 586:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 589:	31 ff                	xor    %edi,%edi
 58b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 58e:	89 ce                	mov    %ecx,%esi
 590:	eb 08                	jmp    59a <printint+0x3a>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 598:	89 cf                	mov    %ecx,%edi
 59a:	31 d2                	xor    %edx,%edx
 59c:	8d 4f 01             	lea    0x1(%edi),%ecx
 59f:	f7 f6                	div    %esi
 5a1:	0f b6 92 94 0a 00 00 	movzbl 0xa94(%edx),%edx
  }while((x /= base) != 0);
 5a8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5aa:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5ad:	75 e9                	jne    598 <printint+0x38>
  if(neg)
 5af:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5b2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 5b5:	85 c0                	test   %eax,%eax
 5b7:	74 08                	je     5c1 <printint+0x61>
    buf[i++] = '-';
 5b9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 5be:	8d 4f 02             	lea    0x2(%edi),%ecx
 5c1:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 5c5:	8d 76 00             	lea    0x0(%esi),%esi
 5c8:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5cb:	83 ec 04             	sub    $0x4,%esp
 5ce:	83 ef 01             	sub    $0x1,%edi
 5d1:	6a 01                	push   $0x1
 5d3:	53                   	push   %ebx
 5d4:	56                   	push   %esi
 5d5:	88 45 d7             	mov    %al,-0x29(%ebp)
 5d8:	e8 e5 fe ff ff       	call   4c2 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 5dd:	83 c4 10             	add    $0x10,%esp
 5e0:	39 df                	cmp    %ebx,%edi
 5e2:	75 e4                	jne    5c8 <printint+0x68>
    putc(fd, buf[i]);
}
 5e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e7:	5b                   	pop    %ebx
 5e8:	5e                   	pop    %esi
 5e9:	5f                   	pop    %edi
 5ea:	5d                   	pop    %ebp
 5eb:	c3                   	ret    
 5ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 5f0:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 5f2:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 5f9:	eb 8b                	jmp    586 <printint+0x26>
 5fb:	90                   	nop
 5fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000600 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 600:	55                   	push   %ebp
 601:	89 e5                	mov    %esp,%ebp
 603:	57                   	push   %edi
 604:	56                   	push   %esi
 605:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 606:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 609:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 60c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 60f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 612:	89 45 d0             	mov    %eax,-0x30(%ebp)
 615:	0f b6 1e             	movzbl (%esi),%ebx
 618:	83 c6 01             	add    $0x1,%esi
 61b:	84 db                	test   %bl,%bl
 61d:	0f 84 b0 00 00 00    	je     6d3 <printf+0xd3>
 623:	31 d2                	xor    %edx,%edx
 625:	eb 39                	jmp    660 <printf+0x60>
 627:	89 f6                	mov    %esi,%esi
 629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 630:	83 f8 25             	cmp    $0x25,%eax
 633:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 636:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 63b:	74 18                	je     655 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 640:	83 ec 04             	sub    $0x4,%esp
 643:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 646:	6a 01                	push   $0x1
 648:	50                   	push   %eax
 649:	57                   	push   %edi
 64a:	e8 73 fe ff ff       	call   4c2 <write>
 64f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 652:	83 c4 10             	add    $0x10,%esp
 655:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 658:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 65c:	84 db                	test   %bl,%bl
 65e:	74 73                	je     6d3 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 660:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 662:	0f be cb             	movsbl %bl,%ecx
 665:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 668:	74 c6                	je     630 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 66a:	83 fa 25             	cmp    $0x25,%edx
 66d:	75 e6                	jne    655 <printf+0x55>
      if(c == 'd'){
 66f:	83 f8 64             	cmp    $0x64,%eax
 672:	0f 84 f8 00 00 00    	je     770 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 678:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 67e:	83 f9 70             	cmp    $0x70,%ecx
 681:	74 5d                	je     6e0 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 683:	83 f8 73             	cmp    $0x73,%eax
 686:	0f 84 84 00 00 00    	je     710 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 68c:	83 f8 63             	cmp    $0x63,%eax
 68f:	0f 84 ea 00 00 00    	je     77f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 695:	83 f8 25             	cmp    $0x25,%eax
 698:	0f 84 c2 00 00 00    	je     760 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 69e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6a1:	83 ec 04             	sub    $0x4,%esp
 6a4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6a8:	6a 01                	push   $0x1
 6aa:	50                   	push   %eax
 6ab:	57                   	push   %edi
 6ac:	e8 11 fe ff ff       	call   4c2 <write>
 6b1:	83 c4 0c             	add    $0xc,%esp
 6b4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6b7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6ba:	6a 01                	push   $0x1
 6bc:	50                   	push   %eax
 6bd:	57                   	push   %edi
 6be:	83 c6 01             	add    $0x1,%esi
 6c1:	e8 fc fd ff ff       	call   4c2 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6c6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6ca:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6cd:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6cf:	84 db                	test   %bl,%bl
 6d1:	75 8d                	jne    660 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6d6:	5b                   	pop    %ebx
 6d7:	5e                   	pop    %esi
 6d8:	5f                   	pop    %edi
 6d9:	5d                   	pop    %ebp
 6da:	c3                   	ret    
 6db:	90                   	nop
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 6e0:	83 ec 0c             	sub    $0xc,%esp
 6e3:	b9 10 00 00 00       	mov    $0x10,%ecx
 6e8:	6a 00                	push   $0x0
 6ea:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6ed:	89 f8                	mov    %edi,%eax
 6ef:	8b 13                	mov    (%ebx),%edx
 6f1:	e8 6a fe ff ff       	call   560 <printint>
        ap++;
 6f6:	89 d8                	mov    %ebx,%eax
 6f8:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6fb:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 6fd:	83 c0 04             	add    $0x4,%eax
 700:	89 45 d0             	mov    %eax,-0x30(%ebp)
 703:	e9 4d ff ff ff       	jmp    655 <printf+0x55>
 708:	90                   	nop
 709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 710:	8b 45 d0             	mov    -0x30(%ebp),%eax
 713:	8b 18                	mov    (%eax),%ebx
        ap++;
 715:	83 c0 04             	add    $0x4,%eax
 718:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 71b:	b8 8c 0a 00 00       	mov    $0xa8c,%eax
 720:	85 db                	test   %ebx,%ebx
 722:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 725:	0f b6 03             	movzbl (%ebx),%eax
 728:	84 c0                	test   %al,%al
 72a:	74 23                	je     74f <printf+0x14f>
 72c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 730:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 733:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 736:	83 ec 04             	sub    $0x4,%esp
 739:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 73b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 73e:	50                   	push   %eax
 73f:	57                   	push   %edi
 740:	e8 7d fd ff ff       	call   4c2 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 745:	0f b6 03             	movzbl (%ebx),%eax
 748:	83 c4 10             	add    $0x10,%esp
 74b:	84 c0                	test   %al,%al
 74d:	75 e1                	jne    730 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 74f:	31 d2                	xor    %edx,%edx
 751:	e9 ff fe ff ff       	jmp    655 <printf+0x55>
 756:	8d 76 00             	lea    0x0(%esi),%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 760:	83 ec 04             	sub    $0x4,%esp
 763:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 766:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 769:	6a 01                	push   $0x1
 76b:	e9 4c ff ff ff       	jmp    6bc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 770:	83 ec 0c             	sub    $0xc,%esp
 773:	b9 0a 00 00 00       	mov    $0xa,%ecx
 778:	6a 01                	push   $0x1
 77a:	e9 6b ff ff ff       	jmp    6ea <printf+0xea>
 77f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 782:	83 ec 04             	sub    $0x4,%esp
 785:	8b 03                	mov    (%ebx),%eax
 787:	6a 01                	push   $0x1
 789:	88 45 e4             	mov    %al,-0x1c(%ebp)
 78c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 78f:	50                   	push   %eax
 790:	57                   	push   %edi
 791:	e8 2c fd ff ff       	call   4c2 <write>
 796:	e9 5b ff ff ff       	jmp    6f6 <printf+0xf6>
 79b:	66 90                	xchg   %ax,%ax
 79d:	66 90                	xchg   %ax,%ax
 79f:	90                   	nop

000007a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a1:	a1 60 0d 00 00       	mov    0xd60,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 7a6:	89 e5                	mov    %esp,%ebp
 7a8:	57                   	push   %edi
 7a9:	56                   	push   %esi
 7aa:	53                   	push   %ebx
 7ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ae:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7b0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b3:	39 c8                	cmp    %ecx,%eax
 7b5:	73 19                	jae    7d0 <free+0x30>
 7b7:	89 f6                	mov    %esi,%esi
 7b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 7c0:	39 d1                	cmp    %edx,%ecx
 7c2:	72 1c                	jb     7e0 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c4:	39 d0                	cmp    %edx,%eax
 7c6:	73 18                	jae    7e0 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 7c8:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ca:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7cc:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ce:	72 f0                	jb     7c0 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7d0:	39 d0                	cmp    %edx,%eax
 7d2:	72 f4                	jb     7c8 <free+0x28>
 7d4:	39 d1                	cmp    %edx,%ecx
 7d6:	73 f0                	jae    7c8 <free+0x28>
 7d8:	90                   	nop
 7d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e0:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7e3:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7e6:	39 d7                	cmp    %edx,%edi
 7e8:	74 19                	je     803 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ed:	8b 50 04             	mov    0x4(%eax),%edx
 7f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7f3:	39 f1                	cmp    %esi,%ecx
 7f5:	74 23                	je     81a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7f7:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7f9:	a3 60 0d 00 00       	mov    %eax,0xd60
}
 7fe:	5b                   	pop    %ebx
 7ff:	5e                   	pop    %esi
 800:	5f                   	pop    %edi
 801:	5d                   	pop    %ebp
 802:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 803:	03 72 04             	add    0x4(%edx),%esi
 806:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 809:	8b 10                	mov    (%eax),%edx
 80b:	8b 12                	mov    (%edx),%edx
 80d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 810:	8b 50 04             	mov    0x4(%eax),%edx
 813:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 816:	39 f1                	cmp    %esi,%ecx
 818:	75 dd                	jne    7f7 <free+0x57>
    p->s.size += bp->s.size;
 81a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 81d:	a3 60 0d 00 00       	mov    %eax,0xd60
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 822:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 825:	8b 53 f8             	mov    -0x8(%ebx),%edx
 828:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 82a:	5b                   	pop    %ebx
 82b:	5e                   	pop    %esi
 82c:	5f                   	pop    %edi
 82d:	5d                   	pop    %ebp
 82e:	c3                   	ret    
 82f:	90                   	nop

00000830 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 839:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 83c:	8b 15 60 0d 00 00    	mov    0xd60,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 842:	8d 78 07             	lea    0x7(%eax),%edi
 845:	c1 ef 03             	shr    $0x3,%edi
 848:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 84b:	85 d2                	test   %edx,%edx
 84d:	0f 84 a3 00 00 00    	je     8f6 <malloc+0xc6>
 853:	8b 02                	mov    (%edx),%eax
 855:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 858:	39 cf                	cmp    %ecx,%edi
 85a:	76 74                	jbe    8d0 <malloc+0xa0>
 85c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 862:	be 00 10 00 00       	mov    $0x1000,%esi
 867:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 86e:	0f 43 f7             	cmovae %edi,%esi
 871:	ba 00 80 00 00       	mov    $0x8000,%edx
 876:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 87c:	0f 46 da             	cmovbe %edx,%ebx
 87f:	eb 10                	jmp    891 <malloc+0x61>
 881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 888:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 88a:	8b 48 04             	mov    0x4(%eax),%ecx
 88d:	39 cf                	cmp    %ecx,%edi
 88f:	76 3f                	jbe    8d0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 891:	39 05 60 0d 00 00    	cmp    %eax,0xd60
 897:	89 c2                	mov    %eax,%edx
 899:	75 ed                	jne    888 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 89b:	83 ec 0c             	sub    $0xc,%esp
 89e:	53                   	push   %ebx
 89f:	e8 86 fc ff ff       	call   52a <sbrk>
  if(p == (char*)-1)
 8a4:	83 c4 10             	add    $0x10,%esp
 8a7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8aa:	74 1c                	je     8c8 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8ac:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8af:	83 ec 0c             	sub    $0xc,%esp
 8b2:	83 c0 08             	add    $0x8,%eax
 8b5:	50                   	push   %eax
 8b6:	e8 e5 fe ff ff       	call   7a0 <free>
  return freep;
 8bb:	8b 15 60 0d 00 00    	mov    0xd60,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 8c1:	83 c4 10             	add    $0x10,%esp
 8c4:	85 d2                	test   %edx,%edx
 8c6:	75 c0                	jne    888 <malloc+0x58>
        return 0;
 8c8:	31 c0                	xor    %eax,%eax
 8ca:	eb 1c                	jmp    8e8 <malloc+0xb8>
 8cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 8d0:	39 cf                	cmp    %ecx,%edi
 8d2:	74 1c                	je     8f0 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 8d4:	29 f9                	sub    %edi,%ecx
 8d6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 8d9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 8dc:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 8df:	89 15 60 0d 00 00    	mov    %edx,0xd60
      return (void*)(p + 1);
 8e5:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 8e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8eb:	5b                   	pop    %ebx
 8ec:	5e                   	pop    %esi
 8ed:	5f                   	pop    %edi
 8ee:	5d                   	pop    %ebp
 8ef:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 8f0:	8b 08                	mov    (%eax),%ecx
 8f2:	89 0a                	mov    %ecx,(%edx)
 8f4:	eb e9                	jmp    8df <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 8f6:	c7 05 60 0d 00 00 64 	movl   $0xd64,0xd60
 8fd:	0d 00 00 
 900:	c7 05 64 0d 00 00 64 	movl   $0xd64,0xd64
 907:	0d 00 00 
    base.s.size = 0;
 90a:	b8 64 0d 00 00       	mov    $0xd64,%eax
 90f:	c7 05 68 0d 00 00 00 	movl   $0x0,0xd68
 916:	00 00 00 
 919:	e9 3e ff ff ff       	jmp    85c <malloc+0x2c>
