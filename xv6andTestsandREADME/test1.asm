
_test1:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(stdout, "normal file test ok\n");
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
  16:	e8 27 04 00 00       	call   442 <exit>
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

  printf(stdout, "normal file test\n");
  25:	83 ec 08             	sub    $0x8,%esp
  28:	68 c0 08 00 00       	push   $0x8c0
  2d:	ff 35 d0 0c 00 00    	pushl  0xcd0
  33:	e8 68 05 00 00       	call   5a0 <printf>
  fd = open("normal", O_CREATE|O_RDWR);
  38:	59                   	pop    %ecx
  39:	5b                   	pop    %ebx
  3a:	68 02 02 00 00       	push   $0x202
  3f:	68 d2 08 00 00       	push   $0x8d2
  44:	e8 39 04 00 00       	call   482 <open>
  if(fd >= 0){
  49:	83 c4 10             	add    $0x10,%esp
  4c:	85 c0                	test   %eax,%eax
  4e:	0f 88 8b 01 00 00    	js     1df <writetest+0x1bf>
    printf(stdout, "create normal succeeded; ok\n");
  54:	83 ec 08             	sub    $0x8,%esp
  57:	89 c6                	mov    %eax,%esi
  } else {
    printf(stdout, "error: creat normal failed!\n");
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 100; i++){
  59:	31 db                	xor    %ebx,%ebx
  int i;

  printf(stdout, "normal file test\n");
  fd = open("normal", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "create normal succeeded; ok\n");
  5b:	68 d9 08 00 00       	push   $0x8d9
  60:	ff 35 d0 0c 00 00    	pushl  0xcd0
  66:	e8 35 05 00 00       	call   5a0 <printf>
  6b:	83 c4 10             	add    $0x10,%esp
  6e:	66 90                	xchg   %ax,%ax
    printf(stdout, "error: creat normal failed!\n");
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
  70:	83 ec 04             	sub    $0x4,%esp
  73:	6a 0a                	push   $0xa
  75:	68 13 09 00 00       	push   $0x913
  7a:	56                   	push   %esi
  7b:	e8 e2 03 00 00       	call   462 <write>
  80:	83 c4 10             	add    $0x10,%esp
  83:	83 f8 0a             	cmp    $0xa,%eax
  86:	0f 85 d9 00 00 00    	jne    165 <writetest+0x145>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
  8c:	83 ec 04             	sub    $0x4,%esp
  8f:	6a 0a                	push   $0xa
  91:	68 1e 09 00 00       	push   $0x91e
  96:	56                   	push   %esi
  97:	e8 c6 03 00 00       	call   462 <write>
  9c:	83 c4 10             	add    $0x10,%esp
  9f:	83 f8 0a             	cmp    $0xa,%eax
  a2:	0f 85 d6 00 00 00    	jne    17e <writetest+0x15e>
  } else {
    printf(stdout, "error: creat normal failed!\n");
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 100; i++){
  a8:	83 c3 01             	add    $0x1,%ebx
  ab:	83 fb 64             	cmp    $0x64,%ebx
  ae:	75 c0                	jne    70 <writetest+0x50>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  b0:	83 ec 08             	sub    $0x8,%esp
  b3:	68 29 09 00 00       	push   $0x929
  b8:	ff 35 d0 0c 00 00    	pushl  0xcd0
  be:	e8 dd 04 00 00       	call   5a0 <printf>
  close(fd);
  c3:	89 34 24             	mov    %esi,(%esp)
  c6:	e8 9f 03 00 00       	call   46a <close>
  fd = open("small", O_RDONLY);
  cb:	58                   	pop    %eax
  cc:	5a                   	pop    %edx
  cd:	6a 00                	push   $0x0
  cf:	68 34 09 00 00       	push   $0x934
  d4:	e8 a9 03 00 00       	call   482 <open>
  if(fd >= 0){
  d9:	83 c4 10             	add    $0x10,%esp
  dc:	85 c0                	test   %eax,%eax
      exit();
    }
  }
  printf(stdout, "writes ok\n");
  close(fd);
  fd = open("small", O_RDONLY);
  de:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
  e0:	0f 88 b1 00 00 00    	js     197 <writetest+0x177>
    printf(stdout, "open normal succeeded ok\n");
  e6:	83 ec 08             	sub    $0x8,%esp
  e9:	68 3a 09 00 00       	push   $0x93a
  ee:	ff 35 d0 0c 00 00    	pushl  0xcd0
  f4:	e8 a7 04 00 00       	call   5a0 <printf>
  } else {
    printf(stdout, "error: open normal failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
  f9:	83 c4 0c             	add    $0xc,%esp
  fc:	68 d0 07 00 00       	push   $0x7d0
 101:	68 00 0d 00 00       	push   $0xd00
 106:	53                   	push   %ebx
 107:	e8 4e 03 00 00       	call   45a <read>
  if(i == 2000){
 10c:	83 c4 10             	add    $0x10,%esp
 10f:	3d d0 07 00 00       	cmp    $0x7d0,%eax
 114:	0f 85 95 00 00 00    	jne    1af <writetest+0x18f>
    printf(stdout, "read succeeded ok\n");
 11a:	83 ec 08             	sub    $0x8,%esp
 11d:	68 70 09 00 00       	push   $0x970
 122:	ff 35 d0 0c 00 00    	pushl  0xcd0
 128:	e8 73 04 00 00       	call   5a0 <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
 12d:	89 1c 24             	mov    %ebx,(%esp)
 130:	e8 35 03 00 00       	call   46a <close>

  if(unlink("small") < 0){
 135:	c7 04 24 34 09 00 00 	movl   $0x934,(%esp)
 13c:	e8 51 03 00 00       	call   492 <unlink>
 141:	83 c4 10             	add    $0x10,%esp
 144:	85 c0                	test   %eax,%eax
 146:	78 7f                	js     1c7 <writetest+0x1a7>
    printf(stdout, "unlink normal failed\n");
    exit();
  }
  printf(stdout, "normal file test ok\n");
 148:	83 ec 08             	sub    $0x8,%esp
 14b:	68 a6 09 00 00       	push   $0x9a6
 150:	ff 35 d0 0c 00 00    	pushl  0xcd0
 156:	e8 45 04 00 00       	call   5a0 <printf>
}
 15b:	83 c4 10             	add    $0x10,%esp
 15e:	8d 65 f8             	lea    -0x8(%ebp),%esp
 161:	5b                   	pop    %ebx
 162:	5e                   	pop    %esi
 163:	5d                   	pop    %ebp
 164:	c3                   	ret    
    exit();
  }
	//printf(stdout, "writing\n");
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
 165:	83 ec 04             	sub    $0x4,%esp
 168:	53                   	push   %ebx
 169:	68 bc 09 00 00       	push   $0x9bc
 16e:	ff 35 d0 0c 00 00    	pushl  0xcd0
 174:	e8 27 04 00 00       	call   5a0 <printf>
      exit();
 179:	e8 c4 02 00 00       	call   442 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
 17e:	83 ec 04             	sub    $0x4,%esp
 181:	53                   	push   %ebx
 182:	68 e0 09 00 00       	push   $0x9e0
 187:	ff 35 d0 0c 00 00    	pushl  0xcd0
 18d:	e8 0e 04 00 00       	call   5a0 <printf>
      exit();
 192:	e8 ab 02 00 00       	call   442 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open normal succeeded ok\n");
  } else {
    printf(stdout, "error: open normal failed!\n");
 197:	83 ec 08             	sub    $0x8,%esp
 19a:	68 54 09 00 00       	push   $0x954
 19f:	ff 35 d0 0c 00 00    	pushl  0xcd0
 1a5:	e8 f6 03 00 00       	call   5a0 <printf>
    exit();
 1aa:	e8 93 02 00 00       	call   442 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
 1af:	83 ec 08             	sub    $0x8,%esp
 1b2:	68 83 09 00 00       	push   $0x983
 1b7:	ff 35 d0 0c 00 00    	pushl  0xcd0
 1bd:	e8 de 03 00 00       	call   5a0 <printf>
    exit();
 1c2:	e8 7b 02 00 00       	call   442 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink normal failed\n");
 1c7:	83 ec 08             	sub    $0x8,%esp
 1ca:	68 90 09 00 00       	push   $0x990
 1cf:	ff 35 d0 0c 00 00    	pushl  0xcd0
 1d5:	e8 c6 03 00 00       	call   5a0 <printf>
    exit();
 1da:	e8 63 02 00 00       	call   442 <exit>
  printf(stdout, "normal file test\n");
  fd = open("normal", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "create normal succeeded; ok\n");
  } else {
    printf(stdout, "error: creat normal failed!\n");
 1df:	83 ec 08             	sub    $0x8,%esp
 1e2:	68 f6 08 00 00       	push   $0x8f6
 1e7:	ff 35 d0 0c 00 00    	pushl  0xcd0
 1ed:	e8 ae 03 00 00       	call   5a0 <printf>
    exit();
 1f2:	e8 4b 02 00 00       	call   442 <exit>
 1f7:	66 90                	xchg   %ax,%ax
 1f9:	66 90                	xchg   %ax,%ax
 1fb:	66 90                	xchg   %ax,%ax
 1fd:	66 90                	xchg   %ax,%ax
 1ff:	90                   	nop

00000200 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 45 08             	mov    0x8(%ebp),%eax
 207:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 20a:	89 c2                	mov    %eax,%edx
 20c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 210:	83 c1 01             	add    $0x1,%ecx
 213:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 217:	83 c2 01             	add    $0x1,%edx
 21a:	84 db                	test   %bl,%bl
 21c:	88 5a ff             	mov    %bl,-0x1(%edx)
 21f:	75 ef                	jne    210 <strcpy+0x10>
    ;
  return os;
}
 221:	5b                   	pop    %ebx
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 22a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000230 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	56                   	push   %esi
 234:	53                   	push   %ebx
 235:	8b 55 08             	mov    0x8(%ebp),%edx
 238:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 23b:	0f b6 02             	movzbl (%edx),%eax
 23e:	0f b6 19             	movzbl (%ecx),%ebx
 241:	84 c0                	test   %al,%al
 243:	75 1e                	jne    263 <strcmp+0x33>
 245:	eb 29                	jmp    270 <strcmp+0x40>
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 250:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 253:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 256:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 259:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 25d:	84 c0                	test   %al,%al
 25f:	74 0f                	je     270 <strcmp+0x40>
 261:	89 f1                	mov    %esi,%ecx
 263:	38 d8                	cmp    %bl,%al
 265:	74 e9                	je     250 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 267:	29 d8                	sub    %ebx,%eax
}
 269:	5b                   	pop    %ebx
 26a:	5e                   	pop    %esi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 270:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 272:	29 d8                	sub    %ebx,%eax
}
 274:	5b                   	pop    %ebx
 275:	5e                   	pop    %esi
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <strlen>:

uint
strlen(char *s)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 286:	80 39 00             	cmpb   $0x0,(%ecx)
 289:	74 12                	je     29d <strlen+0x1d>
 28b:	31 d2                	xor    %edx,%edx
 28d:	8d 76 00             	lea    0x0(%esi),%esi
 290:	83 c2 01             	add    $0x1,%edx
 293:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 297:	89 d0                	mov    %edx,%eax
 299:	75 f5                	jne    290 <strlen+0x10>
    ;
  return n;
}
 29b:	5d                   	pop    %ebp
 29c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 29d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 29f:	5d                   	pop    %ebp
 2a0:	c3                   	ret    
 2a1:	eb 0d                	jmp    2b0 <memset>
 2a3:	90                   	nop
 2a4:	90                   	nop
 2a5:	90                   	nop
 2a6:	90                   	nop
 2a7:	90                   	nop
 2a8:	90                   	nop
 2a9:	90                   	nop
 2aa:	90                   	nop
 2ab:	90                   	nop
 2ac:	90                   	nop
 2ad:	90                   	nop
 2ae:	90                   	nop
 2af:	90                   	nop

000002b0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	57                   	push   %edi
 2b4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 2bd:	89 d7                	mov    %edx,%edi
 2bf:	fc                   	cld    
 2c0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2c2:	89 d0                	mov    %edx,%eax
 2c4:	5f                   	pop    %edi
 2c5:	5d                   	pop    %ebp
 2c6:	c3                   	ret    
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <strchr>:

char*
strchr(const char *s, char c)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 45 08             	mov    0x8(%ebp),%eax
 2d7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 2da:	0f b6 10             	movzbl (%eax),%edx
 2dd:	84 d2                	test   %dl,%dl
 2df:	74 1d                	je     2fe <strchr+0x2e>
    if(*s == c)
 2e1:	38 d3                	cmp    %dl,%bl
 2e3:	89 d9                	mov    %ebx,%ecx
 2e5:	75 0d                	jne    2f4 <strchr+0x24>
 2e7:	eb 17                	jmp    300 <strchr+0x30>
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2f0:	38 ca                	cmp    %cl,%dl
 2f2:	74 0c                	je     300 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 2f4:	83 c0 01             	add    $0x1,%eax
 2f7:	0f b6 10             	movzbl (%eax),%edx
 2fa:	84 d2                	test   %dl,%dl
 2fc:	75 f2                	jne    2f0 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 2fe:	31 c0                	xor    %eax,%eax
}
 300:	5b                   	pop    %ebx
 301:	5d                   	pop    %ebp
 302:	c3                   	ret    
 303:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <gets>:

char*
gets(char *buf, int max)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	57                   	push   %edi
 314:	56                   	push   %esi
 315:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 316:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 318:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 31b:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 31e:	eb 29                	jmp    349 <gets+0x39>
    cc = read(0, &c, 1);
 320:	83 ec 04             	sub    $0x4,%esp
 323:	6a 01                	push   $0x1
 325:	57                   	push   %edi
 326:	6a 00                	push   $0x0
 328:	e8 2d 01 00 00       	call   45a <read>
    if(cc < 1)
 32d:	83 c4 10             	add    $0x10,%esp
 330:	85 c0                	test   %eax,%eax
 332:	7e 1d                	jle    351 <gets+0x41>
      break;
    buf[i++] = c;
 334:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 338:	8b 55 08             	mov    0x8(%ebp),%edx
 33b:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 33d:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 33f:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 343:	74 1b                	je     360 <gets+0x50>
 345:	3c 0d                	cmp    $0xd,%al
 347:	74 17                	je     360 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 349:	8d 5e 01             	lea    0x1(%esi),%ebx
 34c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 34f:	7c cf                	jl     320 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 351:	8b 45 08             	mov    0x8(%ebp),%eax
 354:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 358:	8d 65 f4             	lea    -0xc(%ebp),%esp
 35b:	5b                   	pop    %ebx
 35c:	5e                   	pop    %esi
 35d:	5f                   	pop    %edi
 35e:	5d                   	pop    %ebp
 35f:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 360:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 363:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 365:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 369:	8d 65 f4             	lea    -0xc(%ebp),%esp
 36c:	5b                   	pop    %ebx
 36d:	5e                   	pop    %esi
 36e:	5f                   	pop    %edi
 36f:	5d                   	pop    %ebp
 370:	c3                   	ret    
 371:	eb 0d                	jmp    380 <stat>
 373:	90                   	nop
 374:	90                   	nop
 375:	90                   	nop
 376:	90                   	nop
 377:	90                   	nop
 378:	90                   	nop
 379:	90                   	nop
 37a:	90                   	nop
 37b:	90                   	nop
 37c:	90                   	nop
 37d:	90                   	nop
 37e:	90                   	nop
 37f:	90                   	nop

00000380 <stat>:

int
stat(char *n, struct stat *st)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	56                   	push   %esi
 384:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 385:	83 ec 08             	sub    $0x8,%esp
 388:	6a 00                	push   $0x0
 38a:	ff 75 08             	pushl  0x8(%ebp)
 38d:	e8 f0 00 00 00       	call   482 <open>
  if(fd < 0)
 392:	83 c4 10             	add    $0x10,%esp
 395:	85 c0                	test   %eax,%eax
 397:	78 27                	js     3c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 399:	83 ec 08             	sub    $0x8,%esp
 39c:	ff 75 0c             	pushl  0xc(%ebp)
 39f:	89 c3                	mov    %eax,%ebx
 3a1:	50                   	push   %eax
 3a2:	e8 f3 00 00 00       	call   49a <fstat>
 3a7:	89 c6                	mov    %eax,%esi
  close(fd);
 3a9:	89 1c 24             	mov    %ebx,(%esp)
 3ac:	e8 b9 00 00 00       	call   46a <close>
  return r;
 3b1:	83 c4 10             	add    $0x10,%esp
 3b4:	89 f0                	mov    %esi,%eax
}
 3b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3b9:	5b                   	pop    %ebx
 3ba:	5e                   	pop    %esi
 3bb:	5d                   	pop    %ebp
 3bc:	c3                   	ret    
 3bd:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 3c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 3c5:	eb ef                	jmp    3b6 <stat+0x36>
 3c7:	89 f6                	mov    %esi,%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	53                   	push   %ebx
 3d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3d7:	0f be 11             	movsbl (%ecx),%edx
 3da:	8d 42 d0             	lea    -0x30(%edx),%eax
 3dd:	3c 09                	cmp    $0x9,%al
 3df:	b8 00 00 00 00       	mov    $0x0,%eax
 3e4:	77 1f                	ja     405 <atoi+0x35>
 3e6:	8d 76 00             	lea    0x0(%esi),%esi
 3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 3f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 3f3:	83 c1 01             	add    $0x1,%ecx
 3f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3fa:	0f be 11             	movsbl (%ecx),%edx
 3fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 400:	80 fb 09             	cmp    $0x9,%bl
 403:	76 eb                	jbe    3f0 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 405:	5b                   	pop    %ebx
 406:	5d                   	pop    %ebp
 407:	c3                   	ret    
 408:	90                   	nop
 409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000410 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
 415:	8b 5d 10             	mov    0x10(%ebp),%ebx
 418:	8b 45 08             	mov    0x8(%ebp),%eax
 41b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 41e:	85 db                	test   %ebx,%ebx
 420:	7e 14                	jle    436 <memmove+0x26>
 422:	31 d2                	xor    %edx,%edx
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 428:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 42c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 42f:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 432:	39 da                	cmp    %ebx,%edx
 434:	75 f2                	jne    428 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 436:	5b                   	pop    %ebx
 437:	5e                   	pop    %esi
 438:	5d                   	pop    %ebp
 439:	c3                   	ret    

0000043a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 43a:	b8 01 00 00 00       	mov    $0x1,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <exit>:
SYSCALL(exit)
 442:	b8 02 00 00 00       	mov    $0x2,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <wait>:
SYSCALL(wait)
 44a:	b8 03 00 00 00       	mov    $0x3,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <pipe>:
SYSCALL(pipe)
 452:	b8 04 00 00 00       	mov    $0x4,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <read>:
SYSCALL(read)
 45a:	b8 05 00 00 00       	mov    $0x5,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <write>:
SYSCALL(write)
 462:	b8 10 00 00 00       	mov    $0x10,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <close>:
SYSCALL(close)
 46a:	b8 15 00 00 00       	mov    $0x15,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <kill>:
SYSCALL(kill)
 472:	b8 06 00 00 00       	mov    $0x6,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    

0000047a <exec>:
SYSCALL(exec)
 47a:	b8 07 00 00 00       	mov    $0x7,%eax
 47f:	cd 40                	int    $0x40
 481:	c3                   	ret    

00000482 <open>:
SYSCALL(open)
 482:	b8 0f 00 00 00       	mov    $0xf,%eax
 487:	cd 40                	int    $0x40
 489:	c3                   	ret    

0000048a <mknod>:
SYSCALL(mknod)
 48a:	b8 11 00 00 00       	mov    $0x11,%eax
 48f:	cd 40                	int    $0x40
 491:	c3                   	ret    

00000492 <unlink>:
SYSCALL(unlink)
 492:	b8 12 00 00 00       	mov    $0x12,%eax
 497:	cd 40                	int    $0x40
 499:	c3                   	ret    

0000049a <fstat>:
SYSCALL(fstat)
 49a:	b8 08 00 00 00       	mov    $0x8,%eax
 49f:	cd 40                	int    $0x40
 4a1:	c3                   	ret    

000004a2 <link>:
SYSCALL(link)
 4a2:	b8 13 00 00 00       	mov    $0x13,%eax
 4a7:	cd 40                	int    $0x40
 4a9:	c3                   	ret    

000004aa <mkdir>:
SYSCALL(mkdir)
 4aa:	b8 14 00 00 00       	mov    $0x14,%eax
 4af:	cd 40                	int    $0x40
 4b1:	c3                   	ret    

000004b2 <chdir>:
SYSCALL(chdir)
 4b2:	b8 09 00 00 00       	mov    $0x9,%eax
 4b7:	cd 40                	int    $0x40
 4b9:	c3                   	ret    

000004ba <dup>:
SYSCALL(dup)
 4ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 4bf:	cd 40                	int    $0x40
 4c1:	c3                   	ret    

000004c2 <getpid>:
SYSCALL(getpid)
 4c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 4c7:	cd 40                	int    $0x40
 4c9:	c3                   	ret    

000004ca <sbrk>:
SYSCALL(sbrk)
 4ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 4cf:	cd 40                	int    $0x40
 4d1:	c3                   	ret    

000004d2 <sleep>:
SYSCALL(sleep)
 4d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 4d7:	cd 40                	int    $0x40
 4d9:	c3                   	ret    

000004da <uptime>:
SYSCALL(uptime)
 4da:	b8 0e 00 00 00       	mov    $0xe,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <getcount>:
SYSCALL(getcount)
 4e2:	b8 16 00 00 00       	mov    $0x16,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <currentm>:
SYSCALL(currentm)
 4ea:	b8 17 00 00 00       	mov    $0x17,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    
 4f2:	66 90                	xchg   %ax,%ax
 4f4:	66 90                	xchg   %ax,%ax
 4f6:	66 90                	xchg   %ax,%ax
 4f8:	66 90                	xchg   %ax,%ax
 4fa:	66 90                	xchg   %ax,%ax
 4fc:	66 90                	xchg   %ax,%ax
 4fe:	66 90                	xchg   %ax,%ax

00000500 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	89 c6                	mov    %eax,%esi
 508:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 50b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 50e:	85 db                	test   %ebx,%ebx
 510:	74 7e                	je     590 <printint+0x90>
 512:	89 d0                	mov    %edx,%eax
 514:	c1 e8 1f             	shr    $0x1f,%eax
 517:	84 c0                	test   %al,%al
 519:	74 75                	je     590 <printint+0x90>
    neg = 1;
    x = -xx;
 51b:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 51d:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 524:	f7 d8                	neg    %eax
 526:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 529:	31 ff                	xor    %edi,%edi
 52b:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 52e:	89 ce                	mov    %ecx,%esi
 530:	eb 08                	jmp    53a <printint+0x3a>
 532:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 538:	89 cf                	mov    %ecx,%edi
 53a:	31 d2                	xor    %edx,%edx
 53c:	8d 4f 01             	lea    0x1(%edi),%ecx
 53f:	f7 f6                	div    %esi
 541:	0f b6 92 0c 0a 00 00 	movzbl 0xa0c(%edx),%edx
  }while((x /= base) != 0);
 548:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 54a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 54d:	75 e9                	jne    538 <printint+0x38>
  if(neg)
 54f:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 552:	8b 75 c0             	mov    -0x40(%ebp),%esi
 555:	85 c0                	test   %eax,%eax
 557:	74 08                	je     561 <printint+0x61>
    buf[i++] = '-';
 559:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 55e:	8d 4f 02             	lea    0x2(%edi),%ecx
 561:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 565:	8d 76 00             	lea    0x0(%esi),%esi
 568:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 56b:	83 ec 04             	sub    $0x4,%esp
 56e:	83 ef 01             	sub    $0x1,%edi
 571:	6a 01                	push   $0x1
 573:	53                   	push   %ebx
 574:	56                   	push   %esi
 575:	88 45 d7             	mov    %al,-0x29(%ebp)
 578:	e8 e5 fe ff ff       	call   462 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 57d:	83 c4 10             	add    $0x10,%esp
 580:	39 df                	cmp    %ebx,%edi
 582:	75 e4                	jne    568 <printint+0x68>
    putc(fd, buf[i]);
}
 584:	8d 65 f4             	lea    -0xc(%ebp),%esp
 587:	5b                   	pop    %ebx
 588:	5e                   	pop    %esi
 589:	5f                   	pop    %edi
 58a:	5d                   	pop    %ebp
 58b:	c3                   	ret    
 58c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 590:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 592:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 599:	eb 8b                	jmp    526 <printint+0x26>
 59b:	90                   	nop
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005a0 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a6:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5a9:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5ac:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5af:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5b2:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5b5:	0f b6 1e             	movzbl (%esi),%ebx
 5b8:	83 c6 01             	add    $0x1,%esi
 5bb:	84 db                	test   %bl,%bl
 5bd:	0f 84 b0 00 00 00    	je     673 <printf+0xd3>
 5c3:	31 d2                	xor    %edx,%edx
 5c5:	eb 39                	jmp    600 <printf+0x60>
 5c7:	89 f6                	mov    %esi,%esi
 5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5d0:	83 f8 25             	cmp    $0x25,%eax
 5d3:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 5d6:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 5db:	74 18                	je     5f5 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 5dd:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 5e6:	6a 01                	push   $0x1
 5e8:	50                   	push   %eax
 5e9:	57                   	push   %edi
 5ea:	e8 73 fe ff ff       	call   462 <write>
 5ef:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5f2:	83 c4 10             	add    $0x10,%esp
 5f5:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5f8:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 5fc:	84 db                	test   %bl,%bl
 5fe:	74 73                	je     673 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 600:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 602:	0f be cb             	movsbl %bl,%ecx
 605:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 608:	74 c6                	je     5d0 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 60a:	83 fa 25             	cmp    $0x25,%edx
 60d:	75 e6                	jne    5f5 <printf+0x55>
      if(c == 'd'){
 60f:	83 f8 64             	cmp    $0x64,%eax
 612:	0f 84 f8 00 00 00    	je     710 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 618:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 61e:	83 f9 70             	cmp    $0x70,%ecx
 621:	74 5d                	je     680 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 623:	83 f8 73             	cmp    $0x73,%eax
 626:	0f 84 84 00 00 00    	je     6b0 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 62c:	83 f8 63             	cmp    $0x63,%eax
 62f:	0f 84 ea 00 00 00    	je     71f <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 635:	83 f8 25             	cmp    $0x25,%eax
 638:	0f 84 c2 00 00 00    	je     700 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 63e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 641:	83 ec 04             	sub    $0x4,%esp
 644:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 648:	6a 01                	push   $0x1
 64a:	50                   	push   %eax
 64b:	57                   	push   %edi
 64c:	e8 11 fe ff ff       	call   462 <write>
 651:	83 c4 0c             	add    $0xc,%esp
 654:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 657:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 65a:	6a 01                	push   $0x1
 65c:	50                   	push   %eax
 65d:	57                   	push   %edi
 65e:	83 c6 01             	add    $0x1,%esi
 661:	e8 fc fd ff ff       	call   462 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 666:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 66a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 66d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 66f:	84 db                	test   %bl,%bl
 671:	75 8d                	jne    600 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 673:	8d 65 f4             	lea    -0xc(%ebp),%esp
 676:	5b                   	pop    %ebx
 677:	5e                   	pop    %esi
 678:	5f                   	pop    %edi
 679:	5d                   	pop    %ebp
 67a:	c3                   	ret    
 67b:	90                   	nop
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 680:	83 ec 0c             	sub    $0xc,%esp
 683:	b9 10 00 00 00       	mov    $0x10,%ecx
 688:	6a 00                	push   $0x0
 68a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 68d:	89 f8                	mov    %edi,%eax
 68f:	8b 13                	mov    (%ebx),%edx
 691:	e8 6a fe ff ff       	call   500 <printint>
        ap++;
 696:	89 d8                	mov    %ebx,%eax
 698:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 69b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 69d:	83 c0 04             	add    $0x4,%eax
 6a0:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6a3:	e9 4d ff ff ff       	jmp    5f5 <printf+0x55>
 6a8:	90                   	nop
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 6b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6b3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6b5:	83 c0 04             	add    $0x4,%eax
 6b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 6bb:	b8 04 0a 00 00       	mov    $0xa04,%eax
 6c0:	85 db                	test   %ebx,%ebx
 6c2:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 6c5:	0f b6 03             	movzbl (%ebx),%eax
 6c8:	84 c0                	test   %al,%al
 6ca:	74 23                	je     6ef <printf+0x14f>
 6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6d0:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6d3:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 6d6:	83 ec 04             	sub    $0x4,%esp
 6d9:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 6db:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6de:	50                   	push   %eax
 6df:	57                   	push   %edi
 6e0:	e8 7d fd ff ff       	call   462 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 6e5:	0f b6 03             	movzbl (%ebx),%eax
 6e8:	83 c4 10             	add    $0x10,%esp
 6eb:	84 c0                	test   %al,%al
 6ed:	75 e1                	jne    6d0 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 6ef:	31 d2                	xor    %edx,%edx
 6f1:	e9 ff fe ff ff       	jmp    5f5 <printf+0x55>
 6f6:	8d 76 00             	lea    0x0(%esi),%esi
 6f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 700:	83 ec 04             	sub    $0x4,%esp
 703:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 706:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 709:	6a 01                	push   $0x1
 70b:	e9 4c ff ff ff       	jmp    65c <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 710:	83 ec 0c             	sub    $0xc,%esp
 713:	b9 0a 00 00 00       	mov    $0xa,%ecx
 718:	6a 01                	push   $0x1
 71a:	e9 6b ff ff ff       	jmp    68a <printf+0xea>
 71f:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 722:	83 ec 04             	sub    $0x4,%esp
 725:	8b 03                	mov    (%ebx),%eax
 727:	6a 01                	push   $0x1
 729:	88 45 e4             	mov    %al,-0x1c(%ebp)
 72c:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 72f:	50                   	push   %eax
 730:	57                   	push   %edi
 731:	e8 2c fd ff ff       	call   462 <write>
 736:	e9 5b ff ff ff       	jmp    696 <printf+0xf6>
 73b:	66 90                	xchg   %ax,%ax
 73d:	66 90                	xchg   %ax,%ax
 73f:	90                   	nop

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	a1 e0 0c 00 00       	mov    0xce0,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 746:	89 e5                	mov    %esp,%ebp
 748:	57                   	push   %edi
 749:	56                   	push   %esi
 74a:	53                   	push   %ebx
 74b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 74e:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 750:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 753:	39 c8                	cmp    %ecx,%eax
 755:	73 19                	jae    770 <free+0x30>
 757:	89 f6                	mov    %esi,%esi
 759:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 760:	39 d1                	cmp    %edx,%ecx
 762:	72 1c                	jb     780 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	39 d0                	cmp    %edx,%eax
 766:	73 18                	jae    780 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 768:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 76c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76e:	72 f0                	jb     760 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 770:	39 d0                	cmp    %edx,%eax
 772:	72 f4                	jb     768 <free+0x28>
 774:	39 d1                	cmp    %edx,%ecx
 776:	73 f0                	jae    768 <free+0x28>
 778:	90                   	nop
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 780:	8b 73 fc             	mov    -0x4(%ebx),%esi
 783:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 786:	39 d7                	cmp    %edx,%edi
 788:	74 19                	je     7a3 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 78a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 78d:	8b 50 04             	mov    0x4(%eax),%edx
 790:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 793:	39 f1                	cmp    %esi,%ecx
 795:	74 23                	je     7ba <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 797:	89 08                	mov    %ecx,(%eax)
  freep = p;
 799:	a3 e0 0c 00 00       	mov    %eax,0xce0
}
 79e:	5b                   	pop    %ebx
 79f:	5e                   	pop    %esi
 7a0:	5f                   	pop    %edi
 7a1:	5d                   	pop    %ebp
 7a2:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 7a3:	03 72 04             	add    0x4(%edx),%esi
 7a6:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a9:	8b 10                	mov    (%eax),%edx
 7ab:	8b 12                	mov    (%edx),%edx
 7ad:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 7b0:	8b 50 04             	mov    0x4(%eax),%edx
 7b3:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7b6:	39 f1                	cmp    %esi,%ecx
 7b8:	75 dd                	jne    797 <free+0x57>
    p->s.size += bp->s.size;
 7ba:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 7bd:	a3 e0 0c 00 00       	mov    %eax,0xce0
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 7c2:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7c5:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7c8:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 7ca:	5b                   	pop    %ebx
 7cb:	5e                   	pop    %esi
 7cc:	5f                   	pop    %edi
 7cd:	5d                   	pop    %ebp
 7ce:	c3                   	ret    
 7cf:	90                   	nop

000007d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	57                   	push   %edi
 7d4:	56                   	push   %esi
 7d5:	53                   	push   %ebx
 7d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7dc:	8b 15 e0 0c 00 00    	mov    0xce0,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e2:	8d 78 07             	lea    0x7(%eax),%edi
 7e5:	c1 ef 03             	shr    $0x3,%edi
 7e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7eb:	85 d2                	test   %edx,%edx
 7ed:	0f 84 a3 00 00 00    	je     896 <malloc+0xc6>
 7f3:	8b 02                	mov    (%edx),%eax
 7f5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 7f8:	39 cf                	cmp    %ecx,%edi
 7fa:	76 74                	jbe    870 <malloc+0xa0>
 7fc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 802:	be 00 10 00 00       	mov    $0x1000,%esi
 807:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 80e:	0f 43 f7             	cmovae %edi,%esi
 811:	ba 00 80 00 00       	mov    $0x8000,%edx
 816:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 81c:	0f 46 da             	cmovbe %edx,%ebx
 81f:	eb 10                	jmp    831 <malloc+0x61>
 821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 828:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 82a:	8b 48 04             	mov    0x4(%eax),%ecx
 82d:	39 cf                	cmp    %ecx,%edi
 82f:	76 3f                	jbe    870 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 831:	39 05 e0 0c 00 00    	cmp    %eax,0xce0
 837:	89 c2                	mov    %eax,%edx
 839:	75 ed                	jne    828 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 83b:	83 ec 0c             	sub    $0xc,%esp
 83e:	53                   	push   %ebx
 83f:	e8 86 fc ff ff       	call   4ca <sbrk>
  if(p == (char*)-1)
 844:	83 c4 10             	add    $0x10,%esp
 847:	83 f8 ff             	cmp    $0xffffffff,%eax
 84a:	74 1c                	je     868 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 84c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 84f:	83 ec 0c             	sub    $0xc,%esp
 852:	83 c0 08             	add    $0x8,%eax
 855:	50                   	push   %eax
 856:	e8 e5 fe ff ff       	call   740 <free>
  return freep;
 85b:	8b 15 e0 0c 00 00    	mov    0xce0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 861:	83 c4 10             	add    $0x10,%esp
 864:	85 d2                	test   %edx,%edx
 866:	75 c0                	jne    828 <malloc+0x58>
        return 0;
 868:	31 c0                	xor    %eax,%eax
 86a:	eb 1c                	jmp    888 <malloc+0xb8>
 86c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 870:	39 cf                	cmp    %ecx,%edi
 872:	74 1c                	je     890 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 874:	29 f9                	sub    %edi,%ecx
 876:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 879:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 87c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 87f:	89 15 e0 0c 00 00    	mov    %edx,0xce0
      return (void*)(p + 1);
 885:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 888:	8d 65 f4             	lea    -0xc(%ebp),%esp
 88b:	5b                   	pop    %ebx
 88c:	5e                   	pop    %esi
 88d:	5f                   	pop    %edi
 88e:	5d                   	pop    %ebp
 88f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 890:	8b 08                	mov    (%eax),%ecx
 892:	89 0a                	mov    %ecx,(%edx)
 894:	eb e9                	jmp    87f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 896:	c7 05 e0 0c 00 00 e4 	movl   $0xce4,0xce0
 89d:	0c 00 00 
 8a0:	c7 05 e4 0c 00 00 e4 	movl   $0xce4,0xce4
 8a7:	0c 00 00 
    base.s.size = 0;
 8aa:	b8 e4 0c 00 00       	mov    $0xce4,%eax
 8af:	c7 05 e8 0c 00 00 00 	movl   $0x0,0xce8
 8b6:	00 00 00 
 8b9:	e9 3e ff ff ff       	jmp    7fc <malloc+0x2c>
