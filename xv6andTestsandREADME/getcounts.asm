
_getcounts:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	return "SYS_unknown";
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
	int n=23;
	int counts[n];
	printf(1, "Davvid_Caballero_#A20307530\n");
	int counter = 1;
	getcount(counts, n);
  11:	8d 75 8c             	lea    -0x74(%ebp),%esi
	return "SYS_unknown";
}

int
main(int argc, char *argv[])
{
  14:	83 ec 70             	sub    $0x70,%esp
  17:	8b 19                	mov    (%ecx),%ebx
  19:	8b 79 04             	mov    0x4(%ecx),%edi
	int n=23;
	int counts[n];
	printf(1, "Davvid_Caballero_#A20307530\n");
  1c:	68 42 0a 00 00       	push   $0xa42
  21:	6a 01                	push   $0x1
  23:	e8 18 06 00 00       	call   640 <printf>
	int counter = 1;
	getcount(counts, n);
  28:	5a                   	pop    %edx
  29:	59                   	pop    %ecx
  2a:	6a 17                	push   $0x17
  2c:	56                   	push   %esi
  2d:	e8 50 05 00 00       	call   582 <getcount>
	if(argc == 1){	
  32:	83 c4 10             	add    $0x10,%esp
  35:	83 fb 01             	cmp    $0x1,%ebx
  38:	74 0e                	je     48 <main+0x48>
		printf(1,"%s:%d\n",sysname(counter),counts[counter]);
	counter = counter +1;
			
	}
	}
	else if(argc == 2 && strcmp(argv[1], "-z") ==0){
  3a:	83 fb 02             	cmp    $0x2,%ebx
  3d:	74 32                	je     71 <main+0x71>
			
	}


	}
	exit();
  3f:	e8 9e 04 00 00       	call   4e2 <exit>
  44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	int counter = 1;
	getcount(counts, n);
	if(argc == 1){	
	while(counter < n){
		
		printf(1,"%s:%d\n",sysname(counter),counts[counter]);
  48:	83 ec 0c             	sub    $0xc,%esp
  4b:	53                   	push   %ebx
  4c:	e8 6f 00 00 00       	call   c0 <sysname>
  51:	83 c4 10             	add    $0x10,%esp
  54:	ff 34 9e             	pushl  (%esi,%ebx,4)
	counter = counter +1;
  57:	83 c3 01             	add    $0x1,%ebx
	int counter = 1;
	getcount(counts, n);
	if(argc == 1){	
	while(counter < n){
		
		printf(1,"%s:%d\n",sysname(counter),counts[counter]);
  5a:	50                   	push   %eax
  5b:	68 5f 0a 00 00       	push   $0xa5f
  60:	6a 01                	push   $0x1
  62:	e8 d9 05 00 00       	call   640 <printf>
	int counts[n];
	printf(1, "Davvid_Caballero_#A20307530\n");
	int counter = 1;
	getcount(counts, n);
	if(argc == 1){	
	while(counter < n){
  67:	83 c4 10             	add    $0x10,%esp
  6a:	83 fb 17             	cmp    $0x17,%ebx
  6d:	75 d9                	jne    48 <main+0x48>
  6f:	eb ce                	jmp    3f <main+0x3f>
		printf(1,"%s:%d\n",sysname(counter),counts[counter]);
	counter = counter +1;
			
	}
	}
	else if(argc == 2 && strcmp(argv[1], "-z") ==0){
  71:	50                   	push   %eax
  72:	50                   	push   %eax
  73:	68 66 0a 00 00       	push   $0xa66
  78:	ff 77 04             	pushl  0x4(%edi)
  7b:	e8 50 02 00 00       	call   2d0 <strcmp>
  80:	83 c4 10             	add    $0x10,%esp
  83:	85 c0                	test   %eax,%eax
  85:	75 b8                	jne    3f <main+0x3f>
  87:	bb 01 00 00 00       	mov    $0x1,%ebx
  8c:	eb 0a                	jmp    98 <main+0x98>
  8e:	66 90                	xchg   %ax,%ax
		while(counter < n){
		if(counts[counter] !=0){
			printf(1,"%s:%d\n",sysname(counter),counts[counter]);
		}
		counter = counter +1;
  90:	83 c3 01             	add    $0x1,%ebx
	counter = counter +1;
			
	}
	}
	else if(argc == 2 && strcmp(argv[1], "-z") ==0){
		while(counter < n){
  93:	83 fb 17             	cmp    $0x17,%ebx
  96:	74 a7                	je     3f <main+0x3f>
		if(counts[counter] !=0){
  98:	8b 0c 9e             	mov    (%esi,%ebx,4),%ecx
  9b:	85 c9                	test   %ecx,%ecx
  9d:	74 f1                	je     90 <main+0x90>
			printf(1,"%s:%d\n",sysname(counter),counts[counter]);
  9f:	83 ec 0c             	sub    $0xc,%esp
  a2:	53                   	push   %ebx
  a3:	e8 18 00 00 00       	call   c0 <sysname>
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	51                   	push   %ecx
  ac:	50                   	push   %eax
  ad:	68 5f 0a 00 00       	push   $0xa5f
  b2:	6a 01                	push   $0x1
  b4:	e8 87 05 00 00       	call   640 <printf>
  b9:	83 c4 10             	add    $0x10,%esp
  bc:	eb d2                	jmp    90 <main+0x90>
  be:	66 90                	xchg   %ax,%ax

000000c0 <sysname>:
#include "types.h"
#include "user.h"
#include "syscall.h"

const char *sysname(int sysint){
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	8b 45 08             	mov    0x8(%ebp),%eax
	if(sysint == 1){
  c6:	83 f8 01             	cmp    $0x1,%eax
  c9:	0f 84 d1 00 00 00    	je     1a0 <sysname+0xe0>
		return "SYS_fork";
	}	
	if(sysint == 2){
  cf:	83 f8 02             	cmp    $0x2,%eax
  d2:	0f 84 d8 00 00 00    	je     1b0 <sysname+0xf0>
		return "SYS_exit";
	}
	if(sysint == 3){
  d8:	83 f8 03             	cmp    $0x3,%eax
  db:	0f 84 df 00 00 00    	je     1c0 <sysname+0x100>
		return "SYS_wait";
	}	
	if(sysint == 4){
  e1:	83 f8 04             	cmp    $0x4,%eax
  e4:	0f 84 ae 00 00 00    	je     198 <sysname+0xd8>
		return "SYS_pipe";
	}
	if(sysint == 5){
  ea:	83 f8 05             	cmp    $0x5,%eax
  ed:	0f 84 dd 00 00 00    	je     1d0 <sysname+0x110>
		return "SYS_read";
	}	
	if(sysint == 6){
  f3:	83 f8 06             	cmp    $0x6,%eax
  f6:	0f 84 e4 00 00 00    	je     1e0 <sysname+0x120>
		return "SYS_kill";
	}
	if(sysint == 7){
  fc:	83 f8 07             	cmp    $0x7,%eax
  ff:	0f 84 eb 00 00 00    	je     1f0 <sysname+0x130>
		return "SYS_exec";
	}	
	if(sysint == 8){
 105:	83 f8 08             	cmp    $0x8,%eax
 108:	0f 84 f2 00 00 00    	je     200 <sysname+0x140>
		return "SYS_fstat";
	}
	if(sysint == 9){
 10e:	83 f8 09             	cmp    $0x9,%eax
 111:	0f 84 09 01 00 00    	je     220 <sysname+0x160>
		return "SYS_chdir";
	}	
	if(sysint == 10){
 117:	83 f8 0a             	cmp    $0xa,%eax
 11a:	0f 84 10 01 00 00    	je     230 <sysname+0x170>
		return "SYS_dup";
	}
	if(sysint == 11){
 120:	83 f8 0b             	cmp    $0xb,%eax
 123:	0f 84 17 01 00 00    	je     240 <sysname+0x180>
		return "SYS_getpid";
	}	
	if(sysint == 12){
 129:	83 f8 0c             	cmp    $0xc,%eax
 12c:	0f 84 1e 01 00 00    	je     250 <sysname+0x190>
		return "SYS_sbrk";
	}
	if(sysint == 13){
 132:	83 f8 0d             	cmp    $0xd,%eax
 135:	0f 84 25 01 00 00    	je     260 <sysname+0x1a0>
		return "SYS_sleep";
	}	
	if(sysint == 14){
 13b:	83 f8 0e             	cmp    $0xe,%eax
 13e:	0f 84 cc 00 00 00    	je     210 <sysname+0x150>
		return "SYS_uptime";
	}
	if(sysint == 15){
 144:	83 f8 0f             	cmp    $0xf,%eax
 147:	0f 84 1a 01 00 00    	je     267 <sysname+0x1a7>
		return "SYS_open";
	}	
	if(sysint == 16){
 14d:	83 f8 10             	cmp    $0x10,%eax
 150:	0f 84 18 01 00 00    	je     26e <sysname+0x1ae>
		return "SYS_write";
	}
	if(sysint == 17){
 156:	83 f8 11             	cmp    $0x11,%eax
 159:	0f 84 16 01 00 00    	je     275 <sysname+0x1b5>
		return "SYS_mkmod";
	}	
	if(sysint == 18){
 15f:	83 f8 12             	cmp    $0x12,%eax
 162:	0f 84 14 01 00 00    	je     27c <sysname+0x1bc>
		return "SYS_unlink";
	}
	if(sysint == 19){
 168:	83 f8 13             	cmp    $0x13,%eax
 16b:	0f 84 12 01 00 00    	je     283 <sysname+0x1c3>
		return "SYS_link";
	}	
	if(sysint == 20){
 171:	83 f8 14             	cmp    $0x14,%eax
 174:	0f 84 10 01 00 00    	je     28a <sysname+0x1ca>
		return "SYS_mkdir";
	}
	if(sysint == 21){
 17a:	83 f8 15             	cmp    $0x15,%eax
 17d:	0f 84 0e 01 00 00    	je     291 <sysname+0x1d1>
		return "SYS_close";
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
 183:	83 f8 16             	cmp    $0x16,%eax
 186:	ba 15 0a 00 00       	mov    $0xa15,%edx
 18b:	b8 21 0a 00 00       	mov    $0xa21,%eax
 190:	0f 45 c2             	cmovne %edx,%eax
}
 193:	5d                   	pop    %ebp
 194:	c3                   	ret    
 195:	8d 76 00             	lea    0x0(%esi),%esi
	}
	if(sysint == 3){
		return "SYS_wait";
	}	
	if(sysint == 4){
		return "SYS_pipe";
 198:	b8 7b 09 00 00       	mov    $0x97b,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 19d:	5d                   	pop    %ebp
 19e:	c3                   	ret    
 19f:	90                   	nop
#include "user.h"
#include "syscall.h"

const char *sysname(int sysint){
	if(sysint == 1){
		return "SYS_fork";
 1a0:	b8 60 09 00 00       	mov    $0x960,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 1a5:	5d                   	pop    %ebp
 1a6:	c3                   	ret    
 1a7:	89 f6                	mov    %esi,%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
const char *sysname(int sysint){
	if(sysint == 1){
		return "SYS_fork";
	}	
	if(sysint == 2){
		return "SYS_exit";
 1b0:	b8 69 09 00 00       	mov    $0x969,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}	
	if(sysint == 2){
		return "SYS_exit";
	}
	if(sysint == 3){
		return "SYS_wait";
 1c0:	b8 72 09 00 00       	mov    $0x972,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	89 f6                	mov    %esi,%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}	
	if(sysint == 4){
		return "SYS_pipe";
	}
	if(sysint == 5){
		return "SYS_read";
 1d0:	b8 84 09 00 00       	mov    $0x984,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 1d5:	5d                   	pop    %ebp
 1d6:	c3                   	ret    
 1d7:	89 f6                	mov    %esi,%esi
 1d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}
	if(sysint == 5){
		return "SYS_read";
	}	
	if(sysint == 6){
		return "SYS_kill";
 1e0:	b8 8d 09 00 00       	mov    $0x98d,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	89 f6                	mov    %esi,%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}	
	if(sysint == 6){
		return "SYS_kill";
	}
	if(sysint == 7){
		return "SYS_exec";
 1f0:	b8 96 09 00 00       	mov    $0x996,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}
	if(sysint == 7){
		return "SYS_exec";
	}	
	if(sysint == 8){
		return "SYS_fstat";
 200:	b8 9f 09 00 00       	mov    $0x99f,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}
	if(sysint == 13){
		return "SYS_sleep";
	}	
	if(sysint == 14){
		return "SYS_uptime";
 210:	b8 d9 09 00 00       	mov    $0x9d9,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	89 f6                	mov    %esi,%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}	
	if(sysint == 8){
		return "SYS_fstat";
	}
	if(sysint == 9){
		return "SYS_chdir";
 220:	b8 a9 09 00 00       	mov    $0x9a9,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    
 227:	89 f6                	mov    %esi,%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}
	if(sysint == 9){
		return "SYS_chdir";
	}	
	if(sysint == 10){
		return "SYS_dup";
 230:	b8 b3 09 00 00       	mov    $0x9b3,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 235:	5d                   	pop    %ebp
 236:	c3                   	ret    
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}	
	if(sysint == 10){
		return "SYS_dup";
	}
	if(sysint == 11){
		return "SYS_getpid";
 240:	b8 bb 09 00 00       	mov    $0x9bb,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}
	if(sysint == 11){
		return "SYS_getpid";
	}	
	if(sysint == 12){
		return "SYS_sbrk";
 250:	b8 c6 09 00 00       	mov    $0x9c6,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 255:	5d                   	pop    %ebp
 256:	c3                   	ret    
 257:	89 f6                	mov    %esi,%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	}	
	if(sysint == 12){
		return "SYS_sbrk";
	}
	if(sysint == 13){
		return "SYS_sleep";
 260:	b8 cf 09 00 00       	mov    $0x9cf,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 265:	5d                   	pop    %ebp
 266:	c3                   	ret    
	}	
	if(sysint == 14){
		return "SYS_uptime";
	}
	if(sysint == 15){
		return "SYS_open";
 267:	b8 e4 09 00 00       	mov    $0x9e4,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 26c:	5d                   	pop    %ebp
 26d:	c3                   	ret    
	}
	if(sysint == 15){
		return "SYS_open";
	}	
	if(sysint == 16){
		return "SYS_write";
 26e:	b8 ed 09 00 00       	mov    $0x9ed,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 273:	5d                   	pop    %ebp
 274:	c3                   	ret    
	}	
	if(sysint == 16){
		return "SYS_write";
	}
	if(sysint == 17){
		return "SYS_mkmod";
 275:	b8 f7 09 00 00       	mov    $0x9f7,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 27a:	5d                   	pop    %ebp
 27b:	c3                   	ret    
	}
	if(sysint == 17){
		return "SYS_mkmod";
	}	
	if(sysint == 18){
		return "SYS_unlink";
 27c:	b8 0a 0a 00 00       	mov    $0xa0a,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
	}	
	if(sysint == 18){
		return "SYS_unlink";
	}
	if(sysint == 19){
		return "SYS_link";
 283:	b8 01 0a 00 00       	mov    $0xa01,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 288:	5d                   	pop    %ebp
 289:	c3                   	ret    
	}
	if(sysint == 19){
		return "SYS_link";
	}	
	if(sysint == 20){
		return "SYS_mkdir";
 28a:	b8 38 0a 00 00       	mov    $0xa38,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 28f:	5d                   	pop    %ebp
 290:	c3                   	ret    
	}	
	if(sysint == 20){
		return "SYS_mkdir";
	}
	if(sysint == 21){
		return "SYS_close";
 291:	b8 2e 0a 00 00       	mov    $0xa2e,%eax
	}	
	if(sysint == 22){
		return "SYS_getcount";
	}
	return "SYS_unknown";
}
 296:	5d                   	pop    %ebp
 297:	c3                   	ret    
 298:	66 90                	xchg   %ax,%ax
 29a:	66 90                	xchg   %ax,%ax
 29c:	66 90                	xchg   %ax,%ax
 29e:	66 90                	xchg   %ax,%ax

000002a0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	53                   	push   %ebx
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2aa:	89 c2                	mov    %eax,%edx
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b0:	83 c1 01             	add    $0x1,%ecx
 2b3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 2b7:	83 c2 01             	add    $0x1,%edx
 2ba:	84 db                	test   %bl,%bl
 2bc:	88 5a ff             	mov    %bl,-0x1(%edx)
 2bf:	75 ef                	jne    2b0 <strcpy+0x10>
    ;
  return os;
}
 2c1:	5b                   	pop    %ebx
 2c2:	5d                   	pop    %ebp
 2c3:	c3                   	ret    
 2c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000002d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
 2d5:	8b 55 08             	mov    0x8(%ebp),%edx
 2d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 2db:	0f b6 02             	movzbl (%edx),%eax
 2de:	0f b6 19             	movzbl (%ecx),%ebx
 2e1:	84 c0                	test   %al,%al
 2e3:	75 1e                	jne    303 <strcmp+0x33>
 2e5:	eb 29                	jmp    310 <strcmp+0x40>
 2e7:	89 f6                	mov    %esi,%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 2f0:	83 c2 01             	add    $0x1,%edx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2f3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 2f6:	8d 71 01             	lea    0x1(%ecx),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 2f9:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 2fd:	84 c0                	test   %al,%al
 2ff:	74 0f                	je     310 <strcmp+0x40>
 301:	89 f1                	mov    %esi,%ecx
 303:	38 d8                	cmp    %bl,%al
 305:	74 e9                	je     2f0 <strcmp+0x20>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 307:	29 d8                	sub    %ebx,%eax
}
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 310:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
 312:	29 d8                	sub    %ebx,%eax
}
 314:	5b                   	pop    %ebx
 315:	5e                   	pop    %esi
 316:	5d                   	pop    %ebp
 317:	c3                   	ret    
 318:	90                   	nop
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000320 <strlen>:

uint
strlen(char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 326:	80 39 00             	cmpb   $0x0,(%ecx)
 329:	74 12                	je     33d <strlen+0x1d>
 32b:	31 d2                	xor    %edx,%edx
 32d:	8d 76 00             	lea    0x0(%esi),%esi
 330:	83 c2 01             	add    $0x1,%edx
 333:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 337:	89 d0                	mov    %edx,%eax
 339:	75 f5                	jne    330 <strlen+0x10>
    ;
  return n;
}
 33b:	5d                   	pop    %ebp
 33c:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
 33d:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
 33f:	5d                   	pop    %ebp
 340:	c3                   	ret    
 341:	eb 0d                	jmp    350 <memset>
 343:	90                   	nop
 344:	90                   	nop
 345:	90                   	nop
 346:	90                   	nop
 347:	90                   	nop
 348:	90                   	nop
 349:	90                   	nop
 34a:	90                   	nop
 34b:	90                   	nop
 34c:	90                   	nop
 34d:	90                   	nop
 34e:	90                   	nop
 34f:	90                   	nop

00000350 <memset>:

void*
memset(void *dst, int c, uint n)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 357:	8b 4d 10             	mov    0x10(%ebp),%ecx
 35a:	8b 45 0c             	mov    0xc(%ebp),%eax
 35d:	89 d7                	mov    %edx,%edi
 35f:	fc                   	cld    
 360:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 362:	89 d0                	mov    %edx,%eax
 364:	5f                   	pop    %edi
 365:	5d                   	pop    %ebp
 366:	c3                   	ret    
 367:	89 f6                	mov    %esi,%esi
 369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000370 <strchr>:

char*
strchr(const char *s, char c)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	53                   	push   %ebx
 374:	8b 45 08             	mov    0x8(%ebp),%eax
 377:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 37a:	0f b6 10             	movzbl (%eax),%edx
 37d:	84 d2                	test   %dl,%dl
 37f:	74 1d                	je     39e <strchr+0x2e>
    if(*s == c)
 381:	38 d3                	cmp    %dl,%bl
 383:	89 d9                	mov    %ebx,%ecx
 385:	75 0d                	jne    394 <strchr+0x24>
 387:	eb 17                	jmp    3a0 <strchr+0x30>
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 390:	38 ca                	cmp    %cl,%dl
 392:	74 0c                	je     3a0 <strchr+0x30>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 394:	83 c0 01             	add    $0x1,%eax
 397:	0f b6 10             	movzbl (%eax),%edx
 39a:	84 d2                	test   %dl,%dl
 39c:	75 f2                	jne    390 <strchr+0x20>
    if(*s == c)
      return (char*)s;
  return 0;
 39e:	31 c0                	xor    %eax,%eax
}
 3a0:	5b                   	pop    %ebx
 3a1:	5d                   	pop    %ebp
 3a2:	c3                   	ret    
 3a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003b0 <gets>:

char*
gets(char *buf, int max)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	57                   	push   %edi
 3b4:	56                   	push   %esi
 3b5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3b6:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 3b8:	8d 7d e7             	lea    -0x19(%ebp),%edi
  return 0;
}

char*
gets(char *buf, int max)
{
 3bb:	83 ec 1c             	sub    $0x1c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3be:	eb 29                	jmp    3e9 <gets+0x39>
    cc = read(0, &c, 1);
 3c0:	83 ec 04             	sub    $0x4,%esp
 3c3:	6a 01                	push   $0x1
 3c5:	57                   	push   %edi
 3c6:	6a 00                	push   $0x0
 3c8:	e8 2d 01 00 00       	call   4fa <read>
    if(cc < 1)
 3cd:	83 c4 10             	add    $0x10,%esp
 3d0:	85 c0                	test   %eax,%eax
 3d2:	7e 1d                	jle    3f1 <gets+0x41>
      break;
    buf[i++] = c;
 3d4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3d8:	8b 55 08             	mov    0x8(%ebp),%edx
 3db:	89 de                	mov    %ebx,%esi
    if(c == '\n' || c == '\r')
 3dd:	3c 0a                	cmp    $0xa,%al

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
 3df:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 3e3:	74 1b                	je     400 <gets+0x50>
 3e5:	3c 0d                	cmp    $0xd,%al
 3e7:	74 17                	je     400 <gets+0x50>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 3e9:	8d 5e 01             	lea    0x1(%esi),%ebx
 3ec:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 3ef:	7c cf                	jl     3c0 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 3f1:	8b 45 08             	mov    0x8(%ebp),%eax
 3f4:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 3f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3fb:	5b                   	pop    %ebx
 3fc:	5e                   	pop    %esi
 3fd:	5f                   	pop    %edi
 3fe:	5d                   	pop    %ebp
 3ff:	c3                   	ret    
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 400:	8b 45 08             	mov    0x8(%ebp),%eax
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 403:	89 de                	mov    %ebx,%esi
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 405:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 409:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40c:	5b                   	pop    %ebx
 40d:	5e                   	pop    %esi
 40e:	5f                   	pop    %edi
 40f:	5d                   	pop    %ebp
 410:	c3                   	ret    
 411:	eb 0d                	jmp    420 <stat>
 413:	90                   	nop
 414:	90                   	nop
 415:	90                   	nop
 416:	90                   	nop
 417:	90                   	nop
 418:	90                   	nop
 419:	90                   	nop
 41a:	90                   	nop
 41b:	90                   	nop
 41c:	90                   	nop
 41d:	90                   	nop
 41e:	90                   	nop
 41f:	90                   	nop

00000420 <stat>:

int
stat(char *n, struct stat *st)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	56                   	push   %esi
 424:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 425:	83 ec 08             	sub    $0x8,%esp
 428:	6a 00                	push   $0x0
 42a:	ff 75 08             	pushl  0x8(%ebp)
 42d:	e8 f0 00 00 00       	call   522 <open>
  if(fd < 0)
 432:	83 c4 10             	add    $0x10,%esp
 435:	85 c0                	test   %eax,%eax
 437:	78 27                	js     460 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 439:	83 ec 08             	sub    $0x8,%esp
 43c:	ff 75 0c             	pushl  0xc(%ebp)
 43f:	89 c3                	mov    %eax,%ebx
 441:	50                   	push   %eax
 442:	e8 f3 00 00 00       	call   53a <fstat>
 447:	89 c6                	mov    %eax,%esi
  close(fd);
 449:	89 1c 24             	mov    %ebx,(%esp)
 44c:	e8 b9 00 00 00       	call   50a <close>
  return r;
 451:	83 c4 10             	add    $0x10,%esp
 454:	89 f0                	mov    %esi,%eax
}
 456:	8d 65 f8             	lea    -0x8(%ebp),%esp
 459:	5b                   	pop    %ebx
 45a:	5e                   	pop    %esi
 45b:	5d                   	pop    %ebp
 45c:	c3                   	ret    
 45d:	8d 76 00             	lea    0x0(%esi),%esi
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 465:	eb ef                	jmp    456 <stat+0x36>
 467:	89 f6                	mov    %esi,%esi
 469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000470 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 470:	55                   	push   %ebp
 471:	89 e5                	mov    %esp,%ebp
 473:	53                   	push   %ebx
 474:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 477:	0f be 11             	movsbl (%ecx),%edx
 47a:	8d 42 d0             	lea    -0x30(%edx),%eax
 47d:	3c 09                	cmp    $0x9,%al
 47f:	b8 00 00 00 00       	mov    $0x0,%eax
 484:	77 1f                	ja     4a5 <atoi+0x35>
 486:	8d 76 00             	lea    0x0(%esi),%esi
 489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 490:	8d 04 80             	lea    (%eax,%eax,4),%eax
 493:	83 c1 01             	add    $0x1,%ecx
 496:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 49a:	0f be 11             	movsbl (%ecx),%edx
 49d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 4a0:	80 fb 09             	cmp    $0x9,%bl
 4a3:	76 eb                	jbe    490 <atoi+0x20>
    n = n*10 + *s++ - '0';
  return n;
}
 4a5:	5b                   	pop    %ebx
 4a6:	5d                   	pop    %ebp
 4a7:	c3                   	ret    
 4a8:	90                   	nop
 4a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000004b0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	56                   	push   %esi
 4b4:	53                   	push   %ebx
 4b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4b8:	8b 45 08             	mov    0x8(%ebp),%eax
 4bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4be:	85 db                	test   %ebx,%ebx
 4c0:	7e 14                	jle    4d6 <memmove+0x26>
 4c2:	31 d2                	xor    %edx,%edx
 4c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 4c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 4cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 4cf:	83 c2 01             	add    $0x1,%edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 4d2:	39 da                	cmp    %ebx,%edx
 4d4:	75 f2                	jne    4c8 <memmove+0x18>
    *dst++ = *src++;
  return vdst;
}
 4d6:	5b                   	pop    %ebx
 4d7:	5e                   	pop    %esi
 4d8:	5d                   	pop    %ebp
 4d9:	c3                   	ret    

000004da <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 4da:	b8 01 00 00 00       	mov    $0x1,%eax
 4df:	cd 40                	int    $0x40
 4e1:	c3                   	ret    

000004e2 <exit>:
SYSCALL(exit)
 4e2:	b8 02 00 00 00       	mov    $0x2,%eax
 4e7:	cd 40                	int    $0x40
 4e9:	c3                   	ret    

000004ea <wait>:
SYSCALL(wait)
 4ea:	b8 03 00 00 00       	mov    $0x3,%eax
 4ef:	cd 40                	int    $0x40
 4f1:	c3                   	ret    

000004f2 <pipe>:
SYSCALL(pipe)
 4f2:	b8 04 00 00 00       	mov    $0x4,%eax
 4f7:	cd 40                	int    $0x40
 4f9:	c3                   	ret    

000004fa <read>:
SYSCALL(read)
 4fa:	b8 05 00 00 00       	mov    $0x5,%eax
 4ff:	cd 40                	int    $0x40
 501:	c3                   	ret    

00000502 <write>:
SYSCALL(write)
 502:	b8 10 00 00 00       	mov    $0x10,%eax
 507:	cd 40                	int    $0x40
 509:	c3                   	ret    

0000050a <close>:
SYSCALL(close)
 50a:	b8 15 00 00 00       	mov    $0x15,%eax
 50f:	cd 40                	int    $0x40
 511:	c3                   	ret    

00000512 <kill>:
SYSCALL(kill)
 512:	b8 06 00 00 00       	mov    $0x6,%eax
 517:	cd 40                	int    $0x40
 519:	c3                   	ret    

0000051a <exec>:
SYSCALL(exec)
 51a:	b8 07 00 00 00       	mov    $0x7,%eax
 51f:	cd 40                	int    $0x40
 521:	c3                   	ret    

00000522 <open>:
SYSCALL(open)
 522:	b8 0f 00 00 00       	mov    $0xf,%eax
 527:	cd 40                	int    $0x40
 529:	c3                   	ret    

0000052a <mknod>:
SYSCALL(mknod)
 52a:	b8 11 00 00 00       	mov    $0x11,%eax
 52f:	cd 40                	int    $0x40
 531:	c3                   	ret    

00000532 <unlink>:
SYSCALL(unlink)
 532:	b8 12 00 00 00       	mov    $0x12,%eax
 537:	cd 40                	int    $0x40
 539:	c3                   	ret    

0000053a <fstat>:
SYSCALL(fstat)
 53a:	b8 08 00 00 00       	mov    $0x8,%eax
 53f:	cd 40                	int    $0x40
 541:	c3                   	ret    

00000542 <link>:
SYSCALL(link)
 542:	b8 13 00 00 00       	mov    $0x13,%eax
 547:	cd 40                	int    $0x40
 549:	c3                   	ret    

0000054a <mkdir>:
SYSCALL(mkdir)
 54a:	b8 14 00 00 00       	mov    $0x14,%eax
 54f:	cd 40                	int    $0x40
 551:	c3                   	ret    

00000552 <chdir>:
SYSCALL(chdir)
 552:	b8 09 00 00 00       	mov    $0x9,%eax
 557:	cd 40                	int    $0x40
 559:	c3                   	ret    

0000055a <dup>:
SYSCALL(dup)
 55a:	b8 0a 00 00 00       	mov    $0xa,%eax
 55f:	cd 40                	int    $0x40
 561:	c3                   	ret    

00000562 <getpid>:
SYSCALL(getpid)
 562:	b8 0b 00 00 00       	mov    $0xb,%eax
 567:	cd 40                	int    $0x40
 569:	c3                   	ret    

0000056a <sbrk>:
SYSCALL(sbrk)
 56a:	b8 0c 00 00 00       	mov    $0xc,%eax
 56f:	cd 40                	int    $0x40
 571:	c3                   	ret    

00000572 <sleep>:
SYSCALL(sleep)
 572:	b8 0d 00 00 00       	mov    $0xd,%eax
 577:	cd 40                	int    $0x40
 579:	c3                   	ret    

0000057a <uptime>:
SYSCALL(uptime)
 57a:	b8 0e 00 00 00       	mov    $0xe,%eax
 57f:	cd 40                	int    $0x40
 581:	c3                   	ret    

00000582 <getcount>:
SYSCALL(getcount)
 582:	b8 16 00 00 00       	mov    $0x16,%eax
 587:	cd 40                	int    $0x40
 589:	c3                   	ret    

0000058a <currentm>:
SYSCALL(currentm)
 58a:	b8 17 00 00 00       	mov    $0x17,%eax
 58f:	cd 40                	int    $0x40
 591:	c3                   	ret    
 592:	66 90                	xchg   %ax,%ax
 594:	66 90                	xchg   %ax,%ax
 596:	66 90                	xchg   %ax,%ax
 598:	66 90                	xchg   %ax,%ax
 59a:	66 90                	xchg   %ax,%ax
 59c:	66 90                	xchg   %ax,%ax
 59e:	66 90                	xchg   %ax,%ax

000005a0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	89 c6                	mov    %eax,%esi
 5a8:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 5ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5ae:	85 db                	test   %ebx,%ebx
 5b0:	74 7e                	je     630 <printint+0x90>
 5b2:	89 d0                	mov    %edx,%eax
 5b4:	c1 e8 1f             	shr    $0x1f,%eax
 5b7:	84 c0                	test   %al,%al
 5b9:	74 75                	je     630 <printint+0x90>
    neg = 1;
    x = -xx;
 5bb:	89 d0                	mov    %edx,%eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 5bd:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
    x = -xx;
 5c4:	f7 d8                	neg    %eax
 5c6:	89 75 c0             	mov    %esi,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 5c9:	31 ff                	xor    %edi,%edi
 5cb:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 5ce:	89 ce                	mov    %ecx,%esi
 5d0:	eb 08                	jmp    5da <printint+0x3a>
 5d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 5d8:	89 cf                	mov    %ecx,%edi
 5da:	31 d2                	xor    %edx,%edx
 5dc:	8d 4f 01             	lea    0x1(%edi),%ecx
 5df:	f7 f6                	div    %esi
 5e1:	0f b6 92 70 0a 00 00 	movzbl 0xa70(%edx),%edx
  }while((x /= base) != 0);
 5e8:	85 c0                	test   %eax,%eax
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 5ea:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 5ed:	75 e9                	jne    5d8 <printint+0x38>
  if(neg)
 5ef:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 5f2:	8b 75 c0             	mov    -0x40(%ebp),%esi
 5f5:	85 c0                	test   %eax,%eax
 5f7:	74 08                	je     601 <printint+0x61>
    buf[i++] = '-';
 5f9:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
 5fe:	8d 4f 02             	lea    0x2(%edi),%ecx
 601:	8d 7c 0d d7          	lea    -0x29(%ebp,%ecx,1),%edi
 605:	8d 76 00             	lea    0x0(%esi),%esi
 608:	0f b6 07             	movzbl (%edi),%eax
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 60b:	83 ec 04             	sub    $0x4,%esp
 60e:	83 ef 01             	sub    $0x1,%edi
 611:	6a 01                	push   $0x1
 613:	53                   	push   %ebx
 614:	56                   	push   %esi
 615:	88 45 d7             	mov    %al,-0x29(%ebp)
 618:	e8 e5 fe ff ff       	call   502 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 61d:	83 c4 10             	add    $0x10,%esp
 620:	39 df                	cmp    %ebx,%edi
 622:	75 e4                	jne    608 <printint+0x68>
    putc(fd, buf[i]);
}
 624:	8d 65 f4             	lea    -0xc(%ebp),%esp
 627:	5b                   	pop    %ebx
 628:	5e                   	pop    %esi
 629:	5f                   	pop    %edi
 62a:	5d                   	pop    %ebp
 62b:	c3                   	ret    
 62c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
  } else {
    x = xx;
 630:	89 d0                	mov    %edx,%eax
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 632:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 639:	eb 8b                	jmp    5c6 <printint+0x26>
 63b:	90                   	nop
 63c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000640 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 640:	55                   	push   %ebp
 641:	89 e5                	mov    %esp,%ebp
 643:	57                   	push   %edi
 644:	56                   	push   %esi
 645:	53                   	push   %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 646:	8d 45 10             	lea    0x10(%ebp),%eax
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 649:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 64c:	8b 75 0c             	mov    0xc(%ebp),%esi
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 64f:	8b 7d 08             	mov    0x8(%ebp),%edi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 652:	89 45 d0             	mov    %eax,-0x30(%ebp)
 655:	0f b6 1e             	movzbl (%esi),%ebx
 658:	83 c6 01             	add    $0x1,%esi
 65b:	84 db                	test   %bl,%bl
 65d:	0f 84 b0 00 00 00    	je     713 <printf+0xd3>
 663:	31 d2                	xor    %edx,%edx
 665:	eb 39                	jmp    6a0 <printf+0x60>
 667:	89 f6                	mov    %esi,%esi
 669:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 670:	83 f8 25             	cmp    $0x25,%eax
 673:	89 55 d4             	mov    %edx,-0x2c(%ebp)
        state = '%';
 676:	ba 25 00 00 00       	mov    $0x25,%edx
  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 67b:	74 18                	je     695 <printf+0x55>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 67d:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 680:	83 ec 04             	sub    $0x4,%esp
 683:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 686:	6a 01                	push   $0x1
 688:	50                   	push   %eax
 689:	57                   	push   %edi
 68a:	e8 73 fe ff ff       	call   502 <write>
 68f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 692:	83 c4 10             	add    $0x10,%esp
 695:	83 c6 01             	add    $0x1,%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 698:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 69c:	84 db                	test   %bl,%bl
 69e:	74 73                	je     713 <printf+0xd3>
    c = fmt[i] & 0xff;
    if(state == 0){
 6a0:	85 d2                	test   %edx,%edx
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
 6a2:	0f be cb             	movsbl %bl,%ecx
 6a5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 6a8:	74 c6                	je     670 <printf+0x30>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 6aa:	83 fa 25             	cmp    $0x25,%edx
 6ad:	75 e6                	jne    695 <printf+0x55>
      if(c == 'd'){
 6af:	83 f8 64             	cmp    $0x64,%eax
 6b2:	0f 84 f8 00 00 00    	je     7b0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 6b8:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 6be:	83 f9 70             	cmp    $0x70,%ecx
 6c1:	74 5d                	je     720 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 6c3:	83 f8 73             	cmp    $0x73,%eax
 6c6:	0f 84 84 00 00 00    	je     750 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 6cc:	83 f8 63             	cmp    $0x63,%eax
 6cf:	0f 84 ea 00 00 00    	je     7bf <printf+0x17f>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 6d5:	83 f8 25             	cmp    $0x25,%eax
 6d8:	0f 84 c2 00 00 00    	je     7a0 <printf+0x160>
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 6de:	8d 45 e7             	lea    -0x19(%ebp),%eax
 6e1:	83 ec 04             	sub    $0x4,%esp
 6e4:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 6e8:	6a 01                	push   $0x1
 6ea:	50                   	push   %eax
 6eb:	57                   	push   %edi
 6ec:	e8 11 fe ff ff       	call   502 <write>
 6f1:	83 c4 0c             	add    $0xc,%esp
 6f4:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 6f7:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 6fa:	6a 01                	push   $0x1
 6fc:	50                   	push   %eax
 6fd:	57                   	push   %edi
 6fe:	83 c6 01             	add    $0x1,%esi
 701:	e8 fc fd ff ff       	call   502 <write>
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 706:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 70a:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 70d:	31 d2                	xor    %edx,%edx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 70f:	84 db                	test   %bl,%bl
 711:	75 8d                	jne    6a0 <printf+0x60>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 713:	8d 65 f4             	lea    -0xc(%ebp),%esp
 716:	5b                   	pop    %ebx
 717:	5e                   	pop    %esi
 718:	5f                   	pop    %edi
 719:	5d                   	pop    %ebp
 71a:	c3                   	ret    
 71b:	90                   	nop
 71c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 720:	83 ec 0c             	sub    $0xc,%esp
 723:	b9 10 00 00 00       	mov    $0x10,%ecx
 728:	6a 00                	push   $0x0
 72a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 72d:	89 f8                	mov    %edi,%eax
 72f:	8b 13                	mov    (%ebx),%edx
 731:	e8 6a fe ff ff       	call   5a0 <printint>
        ap++;
 736:	89 d8                	mov    %ebx,%eax
 738:	83 c4 10             	add    $0x10,%esp
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 73b:	31 d2                	xor    %edx,%edx
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 73d:	83 c0 04             	add    $0x4,%eax
 740:	89 45 d0             	mov    %eax,-0x30(%ebp)
 743:	e9 4d ff ff ff       	jmp    695 <printf+0x55>
 748:	90                   	nop
 749:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      } else if(c == 's'){
        s = (char*)*ap;
 750:	8b 45 d0             	mov    -0x30(%ebp),%eax
 753:	8b 18                	mov    (%eax),%ebx
        ap++;
 755:	83 c0 04             	add    $0x4,%eax
 758:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
          s = "(null)";
 75b:	b8 69 0a 00 00       	mov    $0xa69,%eax
 760:	85 db                	test   %ebx,%ebx
 762:	0f 44 d8             	cmove  %eax,%ebx
        while(*s != 0){
 765:	0f b6 03             	movzbl (%ebx),%eax
 768:	84 c0                	test   %al,%al
 76a:	74 23                	je     78f <printf+0x14f>
 76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 770:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 773:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 776:	83 ec 04             	sub    $0x4,%esp
 779:	6a 01                	push   $0x1
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 77b:	83 c3 01             	add    $0x1,%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 77e:	50                   	push   %eax
 77f:	57                   	push   %edi
 780:	e8 7d fd ff ff       	call   502 <write>
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 785:	0f b6 03             	movzbl (%ebx),%eax
 788:	83 c4 10             	add    $0x10,%esp
 78b:	84 c0                	test   %al,%al
 78d:	75 e1                	jne    770 <printf+0x130>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 78f:	31 d2                	xor    %edx,%edx
 791:	e9 ff fe ff ff       	jmp    695 <printf+0x55>
 796:	8d 76 00             	lea    0x0(%esi),%esi
 799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7a0:	83 ec 04             	sub    $0x4,%esp
 7a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 7a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 7a9:	6a 01                	push   $0x1
 7ab:	e9 4c ff ff ff       	jmp    6fc <printf+0xbc>
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 7b0:	83 ec 0c             	sub    $0xc,%esp
 7b3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 7b8:	6a 01                	push   $0x1
 7ba:	e9 6b ff ff ff       	jmp    72a <printf+0xea>
 7bf:	8b 5d d0             	mov    -0x30(%ebp),%ebx
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 7c2:	83 ec 04             	sub    $0x4,%esp
 7c5:	8b 03                	mov    (%ebx),%eax
 7c7:	6a 01                	push   $0x1
 7c9:	88 45 e4             	mov    %al,-0x1c(%ebp)
 7cc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 7cf:	50                   	push   %eax
 7d0:	57                   	push   %edi
 7d1:	e8 2c fd ff ff       	call   502 <write>
 7d6:	e9 5b ff ff ff       	jmp    736 <printf+0xf6>
 7db:	66 90                	xchg   %ax,%ax
 7dd:	66 90                	xchg   %ax,%ax
 7df:	90                   	nop

000007e0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7e1:	a1 dc 0d 00 00       	mov    0xddc,%eax
static Header base;
static Header *freep;

void
free(void *ap)
{
 7e6:	89 e5                	mov    %esp,%ebp
 7e8:	57                   	push   %edi
 7e9:	56                   	push   %esi
 7ea:	53                   	push   %ebx
 7eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ee:	8b 10                	mov    (%eax),%edx
void
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
 7f0:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7f3:	39 c8                	cmp    %ecx,%eax
 7f5:	73 19                	jae    810 <free+0x30>
 7f7:	89 f6                	mov    %esi,%esi
 7f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
 800:	39 d1                	cmp    %edx,%ecx
 802:	72 1c                	jb     820 <free+0x40>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 804:	39 d0                	cmp    %edx,%eax
 806:	73 18                	jae    820 <free+0x40>
static Header base;
static Header *freep;

void
free(void *ap)
{
 808:	89 d0                	mov    %edx,%eax
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80a:	39 c8                	cmp    %ecx,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 80c:	8b 10                	mov    (%eax),%edx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 80e:	72 f0                	jb     800 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 810:	39 d0                	cmp    %edx,%eax
 812:	72 f4                	jb     808 <free+0x28>
 814:	39 d1                	cmp    %edx,%ecx
 816:	73 f0                	jae    808 <free+0x28>
 818:	90                   	nop
 819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
  if(bp + bp->s.size == p->s.ptr){
 820:	8b 73 fc             	mov    -0x4(%ebx),%esi
 823:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 826:	39 d7                	cmp    %edx,%edi
 828:	74 19                	je     843 <free+0x63>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 82a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 82d:	8b 50 04             	mov    0x4(%eax),%edx
 830:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 833:	39 f1                	cmp    %esi,%ecx
 835:	74 23                	je     85a <free+0x7a>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 837:	89 08                	mov    %ecx,(%eax)
  freep = p;
 839:	a3 dc 0d 00 00       	mov    %eax,0xddc
}
 83e:	5b                   	pop    %ebx
 83f:	5e                   	pop    %esi
 840:	5f                   	pop    %edi
 841:	5d                   	pop    %ebp
 842:	c3                   	ret    
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 843:	03 72 04             	add    0x4(%edx),%esi
 846:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 849:	8b 10                	mov    (%eax),%edx
 84b:	8b 12                	mov    (%edx),%edx
 84d:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 850:	8b 50 04             	mov    0x4(%eax),%edx
 853:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 856:	39 f1                	cmp    %esi,%ecx
 858:	75 dd                	jne    837 <free+0x57>
    p->s.size += bp->s.size;
 85a:	03 53 fc             	add    -0x4(%ebx),%edx
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
  freep = p;
 85d:	a3 dc 0d 00 00       	mov    %eax,0xddc
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 862:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 865:	8b 53 f8             	mov    -0x8(%ebx),%edx
 868:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 86a:	5b                   	pop    %ebx
 86b:	5e                   	pop    %esi
 86c:	5f                   	pop    %edi
 86d:	5d                   	pop    %ebp
 86e:	c3                   	ret    
 86f:	90                   	nop

00000870 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 870:	55                   	push   %ebp
 871:	89 e5                	mov    %esp,%ebp
 873:	57                   	push   %edi
 874:	56                   	push   %esi
 875:	53                   	push   %ebx
 876:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 879:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 87c:	8b 15 dc 0d 00 00    	mov    0xddc,%edx
malloc(uint nbytes)
{
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 882:	8d 78 07             	lea    0x7(%eax),%edi
 885:	c1 ef 03             	shr    $0x3,%edi
 888:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 88b:	85 d2                	test   %edx,%edx
 88d:	0f 84 a3 00 00 00    	je     936 <malloc+0xc6>
 893:	8b 02                	mov    (%edx),%eax
 895:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 898:	39 cf                	cmp    %ecx,%edi
 89a:	76 74                	jbe    910 <malloc+0xa0>
 89c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 8a2:	be 00 10 00 00       	mov    $0x1000,%esi
 8a7:	8d 1c fd 00 00 00 00 	lea    0x0(,%edi,8),%ebx
 8ae:	0f 43 f7             	cmovae %edi,%esi
 8b1:	ba 00 80 00 00       	mov    $0x8000,%edx
 8b6:	81 ff ff 0f 00 00    	cmp    $0xfff,%edi
 8bc:	0f 46 da             	cmovbe %edx,%ebx
 8bf:	eb 10                	jmp    8d1 <malloc+0x61>
 8c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8ca:	8b 48 04             	mov    0x4(%eax),%ecx
 8cd:	39 cf                	cmp    %ecx,%edi
 8cf:	76 3f                	jbe    910 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 8d1:	39 05 dc 0d 00 00    	cmp    %eax,0xddc
 8d7:	89 c2                	mov    %eax,%edx
 8d9:	75 ed                	jne    8c8 <malloc+0x58>
  char *p;
  Header *hp;

  if(nu < 4096)
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 8db:	83 ec 0c             	sub    $0xc,%esp
 8de:	53                   	push   %ebx
 8df:	e8 86 fc ff ff       	call   56a <sbrk>
  if(p == (char*)-1)
 8e4:	83 c4 10             	add    $0x10,%esp
 8e7:	83 f8 ff             	cmp    $0xffffffff,%eax
 8ea:	74 1c                	je     908 <malloc+0x98>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 8ec:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 8ef:	83 ec 0c             	sub    $0xc,%esp
 8f2:	83 c0 08             	add    $0x8,%eax
 8f5:	50                   	push   %eax
 8f6:	e8 e5 fe ff ff       	call   7e0 <free>
  return freep;
 8fb:	8b 15 dc 0d 00 00    	mov    0xddc,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 901:	83 c4 10             	add    $0x10,%esp
 904:	85 d2                	test   %edx,%edx
 906:	75 c0                	jne    8c8 <malloc+0x58>
        return 0;
 908:	31 c0                	xor    %eax,%eax
 90a:	eb 1c                	jmp    928 <malloc+0xb8>
 90c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
 910:	39 cf                	cmp    %ecx,%edi
 912:	74 1c                	je     930 <malloc+0xc0>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 914:	29 f9                	sub    %edi,%ecx
 916:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 919:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 91c:	89 78 04             	mov    %edi,0x4(%eax)
      }
      freep = prevp;
 91f:	89 15 dc 0d 00 00    	mov    %edx,0xddc
      return (void*)(p + 1);
 925:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 928:	8d 65 f4             	lea    -0xc(%ebp),%esp
 92b:	5b                   	pop    %ebx
 92c:	5e                   	pop    %esi
 92d:	5f                   	pop    %edi
 92e:	5d                   	pop    %ebp
 92f:	c3                   	ret    
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 930:	8b 08                	mov    (%eax),%ecx
 932:	89 0a                	mov    %ecx,(%edx)
 934:	eb e9                	jmp    91f <malloc+0xaf>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 936:	c7 05 dc 0d 00 00 e0 	movl   $0xde0,0xddc
 93d:	0d 00 00 
 940:	c7 05 e0 0d 00 00 e0 	movl   $0xde0,0xde0
 947:	0d 00 00 
    base.s.size = 0;
 94a:	b8 e0 0d 00 00       	mov    $0xde0,%eax
 94f:	c7 05 e4 0d 00 00 00 	movl   $0x0,0xde4
 956:	00 00 00 
 959:	e9 3e ff ff ff       	jmp    89c <malloc+0x2c>
