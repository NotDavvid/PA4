
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc d0 b5 10 80       	mov    $0x8010b5d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 60 2f 10 80       	mov    $0x80102f60,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 14 b6 10 80       	mov    $0x8010b614,%ebx
  struct buf head;
} bcache;

void
binit(void)
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010004c:	68 00 73 10 80       	push   $0x80107300
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 75 42 00 00       	call   801042d0 <initlock>

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 2c fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd2c
80100062:	fc 10 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 30 fd 10 80 dc 	movl   $0x8010fcdc,0x8010fd30
8010006c:	fc 10 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba dc fc 10 80       	mov    $0x8010fcdc,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 73 10 80       	push   $0x80107307
80100097:	50                   	push   %eax
80100098:	e8 23 41 00 00       	call   801041c0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 30 fd 10 80       	mov    0x8010fd30,%eax

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
801000b0:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d dc fc 10 80       	cmp    $0x8010fcdc,%eax
801000bb:	75 c3                	jne    80100080 <binit+0x40>
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
static struct buf*
bget(uint dev, uint blockno)
{
  struct buf *b;

  acquire(&bcache.lock);
801000df:	68 e0 b5 10 80       	push   $0x8010b5e0
801000e4:	e8 07 42 00 00       	call   801042f0 <acquire>

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 30 fd 10 80    	mov    0x8010fd30,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }

  // Not cached; recycle some unused buffer and clean buffer
  // "clean" because B_DIRTY and not locked means log.c
  // hasn't yet committed the changes to the buffer.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 2c fd 10 80    	mov    0x8010fd2c,%ebx
80100126:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc fc 10 80    	cmp    $0x8010fcdc,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 b5 10 80       	push   $0x8010b5e0
80100162:	e8 69 43 00 00       	call   801044d0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 40 00 00       	call   80104200 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
bread(uint dev, uint blockno)
{
  struct buf *b;

  b = bget(dev, blockno);
  if(!(b->flags & B_VALID)) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 dd 1f 00 00       	call   80102160 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
      release(&bcache.lock);
      acquiresleep(&b->lock);
      return b;
    }
  }
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 0e 73 10 80       	push   $0x8010730e
80100198:	e8 d3 01 00 00       	call   80100370 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:
}

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 ed 40 00 00       	call   801042a0 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
  b->flags |= B_DIRTY;
  iderw(b);
801001c4:	e9 97 1f 00 00       	jmp    80102160 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 1f 73 10 80       	push   $0x8010731f
801001d1:	e8 9a 01 00 00       	call   80100370 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 ac 40 00 00       	call   801042a0 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 5c 40 00 00       	call   80104260 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 e0 40 00 00       	call   801042f0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
    panic("brelse");

  releasesleep(&b->lock);

  acquire(&bcache.lock);
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 dc fc 10 80 	movl   $0x8010fcdc,0x50(%ebx)
  b->refcnt--;
  if (b->refcnt == 0) {
    // no one is waiting for it.
    b->next->prev = b->prev;
    b->prev->next = b->next;
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
80100241:	a1 30 fd 10 80       	mov    0x8010fd30,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d 30 fd 10 80    	mov    %ebx,0x8010fd30
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 e0 b5 10 80 	movl   $0x8010b5e0,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
    b->prev = &bcache.head;
    bcache.head.next->prev = b;
    bcache.head.next = b;
  }
  
  release(&bcache.lock);
8010025c:	e9 6f 42 00 00       	jmp    801044d0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 26 73 10 80       	push   $0x80107326
80100269:	e8 02 01 00 00       	call   80100370 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 ab 14 00 00       	call   80101730 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010028c:	e8 5f 40 00 00       	call   801042f0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e 9a 00 00 00    	jle    8010033b <consoleread+0xcb>
    while(input.r == input.w){
801002a1:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002a6:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002ac:	74 24                	je     801002d2 <consoleread+0x62>
801002ae:	eb 58                	jmp    80100308 <consoleread+0x98>
      if(proc->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b0:	83 ec 08             	sub    $0x8,%esp
801002b3:	68 20 a5 10 80       	push   $0x8010a520
801002b8:	68 c0 ff 10 80       	push   $0x8010ffc0
801002bd:	e8 ae 3b 00 00       	call   80103e70 <sleep>

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
    while(input.r == input.w){
801002c2:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801002c7:	83 c4 10             	add    $0x10,%esp
801002ca:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
801002d0:	75 36                	jne    80100308 <consoleread+0x98>
      if(proc->killed){
801002d2:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801002d8:	8b 40 24             	mov    0x24(%eax),%eax
801002db:	85 c0                	test   %eax,%eax
801002dd:	74 d1                	je     801002b0 <consoleread+0x40>
        release(&cons.lock);
801002df:	83 ec 0c             	sub    $0xc,%esp
801002e2:	68 20 a5 10 80       	push   $0x8010a520
801002e7:	e8 e4 41 00 00       	call   801044d0 <release>
        ilock(ip);
801002ec:	89 3c 24             	mov    %edi,(%esp)
801002ef:	e8 5c 13 00 00       	call   80101650 <ilock>
        return -1;
801002f4:	83 c4 10             	add    $0x10,%esp
801002f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801002ff:	5b                   	pop    %ebx
80100300:	5e                   	pop    %esi
80100301:	5f                   	pop    %edi
80100302:	5d                   	pop    %ebp
80100303:	c3                   	ret    
80100304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100308:	8d 50 01             	lea    0x1(%eax),%edx
8010030b:	89 15 c0 ff 10 80    	mov    %edx,0x8010ffc0
80100311:	89 c2                	mov    %eax,%edx
80100313:	83 e2 7f             	and    $0x7f,%edx
80100316:	0f be 92 40 ff 10 80 	movsbl -0x7fef00c0(%edx),%edx
    if(c == C('D')){  // EOF
8010031d:	83 fa 04             	cmp    $0x4,%edx
80100320:	74 39                	je     8010035b <consoleread+0xeb>
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
80100322:	83 c6 01             	add    $0x1,%esi
    --n;
80100325:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
80100328:	83 fa 0a             	cmp    $0xa,%edx
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
8010032b:	88 56 ff             	mov    %dl,-0x1(%esi)
    --n;
    if(c == '\n')
8010032e:	74 35                	je     80100365 <consoleread+0xf5>
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);
  while(n > 0){
80100330:	85 db                	test   %ebx,%ebx
80100332:	0f 85 69 ff ff ff    	jne    801002a1 <consoleread+0x31>
80100338:	8b 45 10             	mov    0x10(%ebp),%eax
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  release(&cons.lock);
8010033b:	83 ec 0c             	sub    $0xc,%esp
8010033e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100341:	68 20 a5 10 80       	push   $0x8010a520
80100346:	e8 85 41 00 00       	call   801044d0 <release>
  ilock(ip);
8010034b:	89 3c 24             	mov    %edi,(%esp)
8010034e:	e8 fd 12 00 00       	call   80101650 <ilock>

  return target - n;
80100353:	83 c4 10             	add    $0x10,%esp
80100356:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100359:	eb a1                	jmp    801002fc <consoleread+0x8c>
      }
      sleep(&input.r, &cons.lock);
    }
    c = input.buf[input.r++ % INPUT_BUF];
    if(c == C('D')){  // EOF
      if(n < target){
8010035b:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010035e:	76 05                	jbe    80100365 <consoleread+0xf5>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100360:	a3 c0 ff 10 80       	mov    %eax,0x8010ffc0
80100365:	8b 45 10             	mov    0x10(%ebp),%eax
80100368:	29 d8                	sub    %ebx,%eax
8010036a:	eb cf                	jmp    8010033b <consoleread+0xcb>
8010036c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100370 <panic>:
    release(&cons.lock);
}

void
panic(char *s)
{
80100370:	55                   	push   %ebp
80100371:	89 e5                	mov    %esp,%ebp
80100373:	56                   	push   %esi
80100374:	53                   	push   %ebx
80100375:	83 ec 38             	sub    $0x38,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100378:	fa                   	cli    
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
80100379:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
8010037f:	c7 05 54 a5 10 80 00 	movl   $0x0,0x8010a554
80100386:	00 00 00 
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
80100389:	8d 5d d0             	lea    -0x30(%ebp),%ebx
8010038c:	8d 75 f8             	lea    -0x8(%ebp),%esi
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
8010038f:	0f b6 00             	movzbl (%eax),%eax
80100392:	50                   	push   %eax
80100393:	68 2d 73 10 80       	push   $0x8010732d
80100398:	e8 c3 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039d:	58                   	pop    %eax
8010039e:	ff 75 08             	pushl  0x8(%ebp)
801003a1:	e8 ba 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a6:	c7 04 24 26 78 10 80 	movl   $0x80107826,(%esp)
801003ad:	e8 ae 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b2:	5a                   	pop    %edx
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	59                   	pop    %ecx
801003b7:	53                   	push   %ebx
801003b8:	50                   	push   %eax
801003b9:	e8 02 40 00 00       	call   801043c0 <getcallerpcs>
801003be:	83 c4 10             	add    $0x10,%esp
801003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c8:	83 ec 08             	sub    $0x8,%esp
801003cb:	ff 33                	pushl  (%ebx)
801003cd:	83 c3 04             	add    $0x4,%ebx
801003d0:	68 49 73 10 80       	push   $0x80107349
801003d5:	e8 86 02 00 00       	call   80100660 <cprintf>
  cons.locking = 0;
  cprintf("cpu with apicid %d: panic: ", cpu->apicid);
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
801003da:	83 c4 10             	add    $0x10,%esp
801003dd:	39 f3                	cmp    %esi,%ebx
801003df:	75 e7                	jne    801003c8 <panic+0x58>
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
801003e1:	c7 05 58 a5 10 80 01 	movl   $0x1,0x8010a558
801003e8:	00 00 00 
801003eb:	eb fe                	jmp    801003eb <panic+0x7b>
801003ed:	8d 76 00             	lea    0x0(%esi),%esi

801003f0 <consputc>:
}

void
consputc(int c)
{
  if(panicked){
801003f0:	8b 15 58 a5 10 80    	mov    0x8010a558,%edx
801003f6:	85 d2                	test   %edx,%edx
801003f8:	74 06                	je     80100400 <consputc+0x10>
801003fa:	fa                   	cli    
801003fb:	eb fe                	jmp    801003fb <consputc+0xb>
801003fd:	8d 76 00             	lea    0x0(%esi),%esi
  crt[pos] = ' ' | 0x0700;
}

void
consputc(int c)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 0c             	sub    $0xc,%esp
    cli();
    for(;;)
      ;
  }

  if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 b8 00 00 00    	je     801004ce <consputc+0xde>
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 a1 5a 00 00       	call   80105ec0 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	c1 e0 08             	shl    $0x8,%eax
8010043f:	89 c1                	mov    %eax,%ecx
80100441:	b8 0f 00 00 00       	mov    $0xf,%eax
80100446:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100447:	89 f2                	mov    %esi,%edx
80100449:	ec                   	in     (%dx),%al
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);
8010044a:	0f b6 c0             	movzbl %al,%eax
8010044d:	09 c8                	or     %ecx,%eax

  if(c == '\n')
8010044f:	83 fb 0a             	cmp    $0xa,%ebx
80100452:	0f 84 0b 01 00 00    	je     80100563 <consputc+0x173>
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
80100458:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045e:	0f 84 e6 00 00 00    	je     8010054a <consputc+0x15a>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100464:	0f b6 d3             	movzbl %bl,%edx
80100467:	8d 78 01             	lea    0x1(%eax),%edi
8010046a:	80 ce 07             	or     $0x7,%dh
8010046d:	66 89 94 00 00 80 0b 	mov    %dx,-0x7ff48000(%eax,%eax,1)
80100474:	80 

  if(pos < 0 || pos > 25*80)
80100475:	81 ff d0 07 00 00    	cmp    $0x7d0,%edi
8010047b:	0f 8f bc 00 00 00    	jg     8010053d <consputc+0x14d>
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
80100481:	81 ff 7f 07 00 00    	cmp    $0x77f,%edi
80100487:	7f 6f                	jg     801004f8 <consputc+0x108>
80100489:	89 f8                	mov    %edi,%eax
8010048b:	8d 8c 3f 00 80 0b 80 	lea    -0x7ff48000(%edi,%edi,1),%ecx
80100492:	89 fb                	mov    %edi,%ebx
80100494:	c1 e8 08             	shr    $0x8,%eax
80100497:	89 c6                	mov    %eax,%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100499:	bf d4 03 00 00       	mov    $0x3d4,%edi
8010049e:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a3:	89 fa                	mov    %edi,%edx
801004a5:	ee                   	out    %al,(%dx)
801004a6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004ab:	89 f0                	mov    %esi,%eax
801004ad:	ee                   	out    %al,(%dx)
801004ae:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b3:	89 fa                	mov    %edi,%edx
801004b5:	ee                   	out    %al,(%dx)
801004b6:	ba d5 03 00 00       	mov    $0x3d5,%edx
801004bb:	89 d8                	mov    %ebx,%eax
801004bd:	ee                   	out    %al,(%dx)

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;
801004be:	b8 20 07 00 00       	mov    $0x720,%eax
801004c3:	66 89 01             	mov    %ax,(%ecx)
  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
  } else
    uartputc(c);
  cgaputc(c);
}
801004c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c9:	5b                   	pop    %ebx
801004ca:	5e                   	pop    %esi
801004cb:	5f                   	pop    %edi
801004cc:	5d                   	pop    %ebp
801004cd:	c3                   	ret    
    for(;;)
      ;
  }

  if(c == BACKSPACE){
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004ce:	83 ec 0c             	sub    $0xc,%esp
801004d1:	6a 08                	push   $0x8
801004d3:	e8 e8 59 00 00       	call   80105ec0 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 dc 59 00 00       	call   80105ec0 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 d0 59 00 00       	call   80105ec0 <uartputc>
801004f0:	83 c4 10             	add    $0x10,%esp
801004f3:	e9 2a ff ff ff       	jmp    80100422 <consputc+0x32>

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f8:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004fb:	8d 5f b0             	lea    -0x50(%edi),%ebx

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fe:	68 60 0e 00 00       	push   $0xe60
80100503:	68 a0 80 0b 80       	push   $0x800b80a0
80100508:	68 00 80 0b 80       	push   $0x800b8000
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
8010050d:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100514:	e8 b7 40 00 00       	call   801045d0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 f2 3f 00 00       	call   80104520 <memset>
8010052e:	89 f1                	mov    %esi,%ecx
80100530:	83 c4 10             	add    $0x10,%esp
80100533:	be 07 00 00 00       	mov    $0x7,%esi
80100538:	e9 5c ff ff ff       	jmp    80100499 <consputc+0xa9>
    if(pos > 0) --pos;
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");
8010053d:	83 ec 0c             	sub    $0xc,%esp
80100540:	68 4d 73 10 80       	push   $0x8010734d
80100545:	e8 26 fe ff ff       	call   80100370 <panic>
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
8010054a:	85 c0                	test   %eax,%eax
8010054c:	8d 78 ff             	lea    -0x1(%eax),%edi
8010054f:	0f 85 20 ff ff ff    	jne    80100475 <consputc+0x85>
80100555:	b9 00 80 0b 80       	mov    $0x800b8000,%ecx
8010055a:	31 db                	xor    %ebx,%ebx
8010055c:	31 f6                	xor    %esi,%esi
8010055e:	e9 36 ff ff ff       	jmp    80100499 <consputc+0xa9>
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n')
    pos += 80 - pos%80;
80100563:	ba 67 66 66 66       	mov    $0x66666667,%edx
80100568:	f7 ea                	imul   %edx
8010056a:	89 d0                	mov    %edx,%eax
8010056c:	c1 e8 05             	shr    $0x5,%eax
8010056f:	8d 04 80             	lea    (%eax,%eax,4),%eax
80100572:	c1 e0 04             	shl    $0x4,%eax
80100575:	8d 78 50             	lea    0x50(%eax),%edi
80100578:	e9 f8 fe ff ff       	jmp    80100475 <consputc+0x85>
8010057d:	8d 76 00             	lea    0x0(%esi),%esi

80100580 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d6                	mov    %edx,%esi
80100588:	83 ec 2c             	sub    $0x2c,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
80100590:	74 0c                	je     8010059e <printint+0x1e>
80100592:	89 c7                	mov    %eax,%edi
80100594:	c1 ef 1f             	shr    $0x1f,%edi
80100597:	85 c0                	test   %eax,%eax
80100599:	89 7d d4             	mov    %edi,-0x2c(%ebp)
8010059c:	78 51                	js     801005ef <printint+0x6f>
    x = -xx;
  else
    x = xx;

  i = 0;
8010059e:	31 ff                	xor    %edi,%edi
801005a0:	8d 5d d7             	lea    -0x29(%ebp),%ebx
801005a3:	eb 05                	jmp    801005aa <printint+0x2a>
801005a5:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
801005a8:	89 cf                	mov    %ecx,%edi
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 4f 01             	lea    0x1(%edi),%ecx
801005af:	f7 f6                	div    %esi
801005b1:	0f b6 92 78 73 10 80 	movzbl -0x7fef8c88(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
801005ba:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>

  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 0d d8 2d       	movb   $0x2d,-0x28(%ebp,%ecx,1)
801005cb:	8d 4f 02             	lea    0x2(%edi),%ecx
801005ce:	8d 74 0d d7          	lea    -0x29(%ebp,%ecx,1),%esi
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  while(--i >= 0)
    consputc(buf[i]);
801005d8:	0f be 06             	movsbl (%esi),%eax
801005db:	83 ee 01             	sub    $0x1,%esi
801005de:	e8 0d fe ff ff       	call   801003f0 <consputc>
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
801005e3:	39 de                	cmp    %ebx,%esi
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
    consputc(buf[i]);
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
801005ef:	f7 d8                	neg    %eax
801005f1:	eb ab                	jmp    8010059e <printint+0x1e>
801005f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100600 <consolewrite>:
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100609:	ff 75 08             	pushl  0x8(%ebp)
  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
8010060c:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060f:	e8 1c 11 00 00       	call   80101730 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010061b:	e8 d0 3c 00 00       	call   801042f0 <acquire>
80100620:	8b 7d 0c             	mov    0xc(%ebp),%edi
  for(i = 0; i < n; i++)
80100623:	83 c4 10             	add    $0x10,%esp
80100626:	85 f6                	test   %esi,%esi
80100628:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062b:	7e 12                	jle    8010063f <consolewrite+0x3f>
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 b5 fd ff ff       	call   801003f0 <consputc>
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++)
8010063b:	39 df                	cmp    %ebx,%edi
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
    consputc(buf[i] & 0xff);
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 20 a5 10 80       	push   $0x8010a520
80100647:	e8 84 3e 00 00       	call   801044d0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 fb 0f 00 00       	call   80101650 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100669:	a1 54 a5 10 80       	mov    0x8010a554,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100670:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(locking)
80100673:	0f 85 47 01 00 00    	jne    801007c0 <cprintf+0x160>
    acquire(&cons.lock);

  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c1                	mov    %eax,%ecx
80100680:	0f 84 4f 01 00 00    	je     801007d5 <cprintf+0x175>
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
80100689:	31 db                	xor    %ebx,%ebx
8010068b:	8d 75 0c             	lea    0xc(%ebp),%esi
8010068e:	89 cf                	mov    %ecx,%edi
80100690:	85 c0                	test   %eax,%eax
80100692:	75 55                	jne    801006e9 <cprintf+0x89>
80100694:	eb 68                	jmp    801006fe <cprintf+0x9e>
80100696:	8d 76 00             	lea    0x0(%esi),%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c != '%'){
      consputc(c);
      continue;
    }
    c = fmt[++i] & 0xff;
801006a0:	83 c3 01             	add    $0x1,%ebx
801006a3:	0f b6 14 1f          	movzbl (%edi,%ebx,1),%edx
    if(c == 0)
801006a7:	85 d2                	test   %edx,%edx
801006a9:	74 53                	je     801006fe <cprintf+0x9e>
      break;
    switch(c){
801006ab:	83 fa 70             	cmp    $0x70,%edx
801006ae:	74 7a                	je     8010072a <cprintf+0xca>
801006b0:	7f 6e                	jg     80100720 <cprintf+0xc0>
801006b2:	83 fa 25             	cmp    $0x25,%edx
801006b5:	0f 84 ad 00 00 00    	je     80100768 <cprintf+0x108>
801006bb:	83 fa 64             	cmp    $0x64,%edx
801006be:	0f 85 84 00 00 00    	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
801006c4:	8d 46 04             	lea    0x4(%esi),%eax
801006c7:	b9 01 00 00 00       	mov    $0x1,%ecx
801006cc:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d4:	8b 06                	mov    (%esi),%eax
801006d6:	e8 a5 fe ff ff       	call   80100580 <printint>
801006db:	8b 75 e4             	mov    -0x1c(%ebp),%esi

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006de:	83 c3 01             	add    $0x1,%ebx
801006e1:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006e5:	85 c0                	test   %eax,%eax
801006e7:	74 15                	je     801006fe <cprintf+0x9e>
    if(c != '%'){
801006e9:	83 f8 25             	cmp    $0x25,%eax
801006ec:	74 b2                	je     801006a0 <cprintf+0x40>
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
801006ee:	e8 fd fc ff ff       	call   801003f0 <consputc>

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006f3:	83 c3 01             	add    $0x1,%ebx
801006f6:	0f b6 04 1f          	movzbl (%edi,%ebx,1),%eax
801006fa:	85 c0                	test   %eax,%eax
801006fc:	75 eb                	jne    801006e9 <cprintf+0x89>
      consputc(c);
      break;
    }
  }

  if(locking)
801006fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100701:	85 c0                	test   %eax,%eax
80100703:	74 10                	je     80100715 <cprintf+0xb5>
    release(&cons.lock);
80100705:	83 ec 0c             	sub    $0xc,%esp
80100708:	68 20 a5 10 80       	push   $0x8010a520
8010070d:	e8 be 3d 00 00       	call   801044d0 <release>
80100712:	83 c4 10             	add    $0x10,%esp
}
80100715:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100718:	5b                   	pop    %ebx
80100719:	5e                   	pop    %esi
8010071a:	5f                   	pop    %edi
8010071b:	5d                   	pop    %ebp
8010071c:	c3                   	ret    
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
      continue;
    }
    c = fmt[++i] & 0xff;
    if(c == 0)
      break;
    switch(c){
80100720:	83 fa 73             	cmp    $0x73,%edx
80100723:	74 5b                	je     80100780 <cprintf+0x120>
80100725:	83 fa 78             	cmp    $0x78,%edx
80100728:	75 1e                	jne    80100748 <cprintf+0xe8>
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
8010072a:	8d 46 04             	lea    0x4(%esi),%eax
8010072d:	31 c9                	xor    %ecx,%ecx
8010072f:	ba 10 00 00 00       	mov    $0x10,%edx
80100734:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100737:	8b 06                	mov    (%esi),%eax
80100739:	e8 42 fe ff ff       	call   80100580 <printint>
8010073e:	8b 75 e4             	mov    -0x1c(%ebp),%esi
      break;
80100741:	eb 9b                	jmp    801006de <cprintf+0x7e>
80100743:	90                   	nop
80100744:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100748:	b8 25 00 00 00       	mov    $0x25,%eax
8010074d:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100750:	e8 9b fc ff ff       	call   801003f0 <consputc>
      consputc(c);
80100755:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100758:	89 d0                	mov    %edx,%eax
8010075a:	e8 91 fc ff ff       	call   801003f0 <consputc>
      break;
8010075f:	e9 7a ff ff ff       	jmp    801006de <cprintf+0x7e>
80100764:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
80100768:	b8 25 00 00 00       	mov    $0x25,%eax
8010076d:	e8 7e fc ff ff       	call   801003f0 <consputc>
80100772:	e9 7c ff ff ff       	jmp    801006f3 <cprintf+0x93>
80100777:	89 f6                	mov    %esi,%esi
80100779:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
80100780:	8d 46 04             	lea    0x4(%esi),%eax
80100783:	8b 36                	mov    (%esi),%esi
80100785:	89 45 e4             	mov    %eax,-0x1c(%ebp)
        s = "(null)";
80100788:	b8 60 73 10 80       	mov    $0x80107360,%eax
8010078d:	85 f6                	test   %esi,%esi
8010078f:	0f 44 f0             	cmove  %eax,%esi
      for(; *s; s++)
80100792:	0f be 06             	movsbl (%esi),%eax
80100795:	84 c0                	test   %al,%al
80100797:	74 16                	je     801007af <cprintf+0x14f>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007a0:	83 c6 01             	add    $0x1,%esi
        consputc(*s);
801007a3:	e8 48 fc ff ff       	call   801003f0 <consputc>
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
801007a8:	0f be 06             	movsbl (%esi),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
801007af:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801007b2:	e9 27 ff ff ff       	jmp    801006de <cprintf+0x7e>
801007b7:	89 f6                	mov    %esi,%esi
801007b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 a5 10 80       	push   $0x8010a520
801007c8:	e8 23 3b 00 00       	call   801042f0 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 67 73 10 80       	push   $0x80107367
801007dd:	e8 8e fb ff ff       	call   80100370 <panic>
801007e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801007f0 <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f0:	55                   	push   %ebp
801007f1:	89 e5                	mov    %esp,%ebp
801007f3:	57                   	push   %edi
801007f4:	56                   	push   %esi
801007f5:	53                   	push   %ebx
  int c, doprocdump = 0;
801007f6:	31 f6                	xor    %esi,%esi

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
801007f8:	83 ec 18             	sub    $0x18,%esp
801007fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int c, doprocdump = 0;

  acquire(&cons.lock);
801007fe:	68 20 a5 10 80       	push   $0x8010a520
80100803:	e8 e8 3a 00 00       	call   801042f0 <acquire>
  while((c = getc()) >= 0){
80100808:	83 c4 10             	add    $0x10,%esp
8010080b:	90                   	nop
8010080c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100810:	ff d3                	call   *%ebx
80100812:	85 c0                	test   %eax,%eax
80100814:	89 c7                	mov    %eax,%edi
80100816:	78 48                	js     80100860 <consoleintr+0x70>
    switch(c){
80100818:	83 ff 10             	cmp    $0x10,%edi
8010081b:	0f 84 3f 01 00 00    	je     80100960 <consoleintr+0x170>
80100821:	7e 5d                	jle    80100880 <consoleintr+0x90>
80100823:	83 ff 15             	cmp    $0x15,%edi
80100826:	0f 84 dc 00 00 00    	je     80100908 <consoleintr+0x118>
8010082c:	83 ff 7f             	cmp    $0x7f,%edi
8010082f:	75 54                	jne    80100885 <consoleintr+0x95>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
80100831:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100836:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010083c:	74 d2                	je     80100810 <consoleintr+0x20>
        input.e--;
8010083e:	83 e8 01             	sub    $0x1,%eax
80100841:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100846:	b8 00 01 00 00       	mov    $0x100,%eax
8010084b:	e8 a0 fb ff ff       	call   801003f0 <consputc>
consoleintr(int (*getc)(void))
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
80100850:	ff d3                	call   *%ebx
80100852:	85 c0                	test   %eax,%eax
80100854:	89 c7                	mov    %eax,%edi
80100856:	79 c0                	jns    80100818 <consoleintr+0x28>
80100858:	90                   	nop
80100859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        }
      }
      break;
    }
  }
  release(&cons.lock);
80100860:	83 ec 0c             	sub    $0xc,%esp
80100863:	68 20 a5 10 80       	push   $0x8010a520
80100868:	e8 63 3c 00 00       	call   801044d0 <release>
  if(doprocdump) {
8010086d:	83 c4 10             	add    $0x10,%esp
80100870:	85 f6                	test   %esi,%esi
80100872:	0f 85 f8 00 00 00    	jne    80100970 <consoleintr+0x180>
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100878:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010087b:	5b                   	pop    %ebx
8010087c:	5e                   	pop    %esi
8010087d:	5f                   	pop    %edi
8010087e:	5d                   	pop    %ebp
8010087f:	c3                   	ret    
{
  int c, doprocdump = 0;

  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
80100880:	83 ff 08             	cmp    $0x8,%edi
80100883:	74 ac                	je     80100831 <consoleintr+0x41>
        input.e--;
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100885:	85 ff                	test   %edi,%edi
80100887:	74 87                	je     80100810 <consoleintr+0x20>
80100889:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010088e:	89 c2                	mov    %eax,%edx
80100890:	2b 15 c0 ff 10 80    	sub    0x8010ffc0,%edx
80100896:	83 fa 7f             	cmp    $0x7f,%edx
80100899:	0f 87 71 ff ff ff    	ja     80100810 <consoleintr+0x20>
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010089f:	8d 50 01             	lea    0x1(%eax),%edx
801008a2:	83 e0 7f             	and    $0x7f,%eax
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008a5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008a8:	89 15 c8 ff 10 80    	mov    %edx,0x8010ffc8
        consputc(BACKSPACE);
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
801008ae:	0f 84 c8 00 00 00    	je     8010097c <consoleintr+0x18c>
        input.buf[input.e++ % INPUT_BUF] = c;
801008b4:	89 f9                	mov    %edi,%ecx
801008b6:	88 88 40 ff 10 80    	mov    %cl,-0x7fef00c0(%eax)
        consputc(c);
801008bc:	89 f8                	mov    %edi,%eax
801008be:	e8 2d fb ff ff       	call   801003f0 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008c3:	83 ff 0a             	cmp    $0xa,%edi
801008c6:	0f 84 c1 00 00 00    	je     8010098d <consoleintr+0x19d>
801008cc:	83 ff 04             	cmp    $0x4,%edi
801008cf:	0f 84 b8 00 00 00    	je     8010098d <consoleintr+0x19d>
801008d5:	a1 c0 ff 10 80       	mov    0x8010ffc0,%eax
801008da:	83 e8 80             	sub    $0xffffff80,%eax
801008dd:	39 05 c8 ff 10 80    	cmp    %eax,0x8010ffc8
801008e3:	0f 85 27 ff ff ff    	jne    80100810 <consoleintr+0x20>
          input.w = input.e;
          wakeup(&input.r);
801008e9:	83 ec 0c             	sub    $0xc,%esp
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
        consputc(c);
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
          input.w = input.e;
801008ec:	a3 c4 ff 10 80       	mov    %eax,0x8010ffc4
          wakeup(&input.r);
801008f1:	68 c0 ff 10 80       	push   $0x8010ffc0
801008f6:	e8 15 37 00 00       	call   80104010 <wakeup>
801008fb:	83 c4 10             	add    $0x10,%esp
801008fe:	e9 0d ff ff ff       	jmp    80100810 <consoleintr+0x20>
80100903:	90                   	nop
80100904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100908:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
8010090d:	39 05 c4 ff 10 80    	cmp    %eax,0x8010ffc4
80100913:	75 2b                	jne    80100940 <consoleintr+0x150>
80100915:	e9 f6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010091a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
80100920:	a3 c8 ff 10 80       	mov    %eax,0x8010ffc8
        consputc(BACKSPACE);
80100925:	b8 00 01 00 00       	mov    $0x100,%eax
8010092a:	e8 c1 fa ff ff       	call   801003f0 <consputc>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
8010092f:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100934:	3b 05 c4 ff 10 80    	cmp    0x8010ffc4,%eax
8010093a:	0f 84 d0 fe ff ff    	je     80100810 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100940:	83 e8 01             	sub    $0x1,%eax
80100943:	89 c2                	mov    %eax,%edx
80100945:	83 e2 7f             	and    $0x7f,%edx
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
      break;
    case C('U'):  // Kill line.
      while(input.e != input.w &&
80100948:	80 ba 40 ff 10 80 0a 	cmpb   $0xa,-0x7fef00c0(%edx)
8010094f:	75 cf                	jne    80100920 <consoleintr+0x130>
80100951:	e9 ba fe ff ff       	jmp    80100810 <consoleintr+0x20>
80100956:	8d 76 00             	lea    0x0(%esi),%esi
80100959:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  acquire(&cons.lock);
  while((c = getc()) >= 0){
    switch(c){
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
80100960:	be 01 00 00 00       	mov    $0x1,%esi
80100965:	e9 a6 fe ff ff       	jmp    80100810 <consoleintr+0x20>
8010096a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
  }
}
80100970:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100973:	5b                   	pop    %ebx
80100974:	5e                   	pop    %esi
80100975:	5f                   	pop    %edi
80100976:	5d                   	pop    %ebp
      break;
    }
  }
  release(&cons.lock);
  if(doprocdump) {
    procdump();  // now call procdump() wo. cons.lock held
80100977:	e9 84 37 00 00       	jmp    80104100 <procdump>
      }
      break;
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
        c = (c == '\r') ? '\n' : c;
        input.buf[input.e++ % INPUT_BUF] = c;
8010097c:	c6 80 40 ff 10 80 0a 	movb   $0xa,-0x7fef00c0(%eax)
        consputc(c);
80100983:	b8 0a 00 00 00       	mov    $0xa,%eax
80100988:	e8 63 fa ff ff       	call   801003f0 <consputc>
8010098d:	a1 c8 ff 10 80       	mov    0x8010ffc8,%eax
80100992:	e9 52 ff ff ff       	jmp    801008e9 <consoleintr+0xf9>
80100997:	89 f6                	mov    %esi,%esi
80100999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801009a0 <consoleinit>:
  return n;
}

void
consoleinit(void)
{
801009a0:	55                   	push   %ebp
801009a1:	89 e5                	mov    %esp,%ebp
801009a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009a6:	68 70 73 10 80       	push   $0x80107370
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 1b 39 00 00       	call   801042d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  picenable(IRQ_KBD);
801009b5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
801009bc:	c7 05 8c 09 11 80 00 	movl   $0x80100600,0x8011098c
801009c3:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009c6:	c7 05 88 09 11 80 70 	movl   $0x80100270,0x80110988
801009cd:	02 10 80 
  cons.locking = 1;
801009d0:	c7 05 54 a5 10 80 01 	movl   $0x1,0x8010a554
801009d7:	00 00 00 

  picenable(IRQ_KBD);
801009da:	e8 41 29 00 00       	call   80103320 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009df:	58                   	pop    %eax
801009e0:	5a                   	pop    %edx
801009e1:	6a 00                	push   $0x0
801009e3:	6a 01                	push   $0x1
801009e5:	e8 36 19 00 00       	call   80102320 <ioapicenable>
}
801009ea:	83 c4 10             	add    $0x10,%esp
801009ed:	c9                   	leave  
801009ee:	c3                   	ret    
801009ef:	90                   	nop

801009f0 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
801009f0:	55                   	push   %ebp
801009f1:	89 e5                	mov    %esp,%ebp
801009f3:	57                   	push   %edi
801009f4:	56                   	push   %esi
801009f5:	53                   	push   %ebx
801009f6:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;

  begin_op();
801009fc:	e8 4f 22 00 00       	call   80102c50 <begin_op>

  if((ip = namei(path)) == 0){
80100a01:	83 ec 0c             	sub    $0xc,%esp
80100a04:	ff 75 08             	pushl  0x8(%ebp)
80100a07:	e8 14 15 00 00       	call   80101f20 <namei>
80100a0c:	83 c4 10             	add    $0x10,%esp
80100a0f:	85 c0                	test   %eax,%eax
80100a11:	0f 84 9f 01 00 00    	je     80100bb6 <exec+0x1c6>
    end_op();
    return -1;
  }
  ilock(ip);
80100a17:	83 ec 0c             	sub    $0xc,%esp
80100a1a:	89 c3                	mov    %eax,%ebx
80100a1c:	50                   	push   %eax
80100a1d:	e8 2e 0c 00 00       	call   80101650 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a22:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a28:	6a 34                	push   $0x34
80100a2a:	6a 00                	push   $0x0
80100a2c:	50                   	push   %eax
80100a2d:	53                   	push   %ebx
80100a2e:	e8 dd 0e 00 00       	call   80101910 <readi>
80100a33:	83 c4 20             	add    $0x20,%esp
80100a36:	83 f8 34             	cmp    $0x34,%eax
80100a39:	74 25                	je     80100a60 <exec+0x70>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a3b:	83 ec 0c             	sub    $0xc,%esp
80100a3e:	53                   	push   %ebx
80100a3f:	e8 7c 0e 00 00       	call   801018c0 <iunlockput>
    end_op();
80100a44:	e8 77 22 00 00       	call   80102cc0 <end_op>
80100a49:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a51:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a54:	5b                   	pop    %ebx
80100a55:	5e                   	pop    %esi
80100a56:	5f                   	pop    %edi
80100a57:	5d                   	pop    %ebp
80100a58:	c3                   	ret    
80100a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100a60:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a67:	45 4c 46 
80100a6a:	75 cf                	jne    80100a3b <exec+0x4b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100a6c:	e8 0f 62 00 00       	call   80106c80 <setupkvm>
80100a71:	85 c0                	test   %eax,%eax
80100a73:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100a79:	74 c0                	je     80100a3b <exec+0x4b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100a7b:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100a82:	00 
80100a83:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100a89:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100a90:	00 00 00 
80100a93:	0f 84 c5 00 00 00    	je     80100b5e <exec+0x16e>
80100a99:	31 ff                	xor    %edi,%edi
80100a9b:	eb 18                	jmp    80100ab5 <exec+0xc5>
80100a9d:	8d 76 00             	lea    0x0(%esi),%esi
80100aa0:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100aa7:	83 c7 01             	add    $0x1,%edi
80100aaa:	83 c6 20             	add    $0x20,%esi
80100aad:	39 f8                	cmp    %edi,%eax
80100aaf:	0f 8e a9 00 00 00    	jle    80100b5e <exec+0x16e>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100ab5:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100abb:	6a 20                	push   $0x20
80100abd:	56                   	push   %esi
80100abe:	50                   	push   %eax
80100abf:	53                   	push   %ebx
80100ac0:	e8 4b 0e 00 00       	call   80101910 <readi>
80100ac5:	83 c4 10             	add    $0x10,%esp
80100ac8:	83 f8 20             	cmp    $0x20,%eax
80100acb:	75 7b                	jne    80100b48 <exec+0x158>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100acd:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100ad4:	75 ca                	jne    80100aa0 <exec+0xb0>
      continue;
    if(ph.memsz < ph.filesz)
80100ad6:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100adc:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ae2:	72 64                	jb     80100b48 <exec+0x158>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100ae4:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100aea:	72 5c                	jb     80100b48 <exec+0x158>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aec:	83 ec 04             	sub    $0x4,%esp
80100aef:	50                   	push   %eax
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100afc:	e8 3f 64 00 00       	call   80106f40 <allocuvm>
80100b01:	83 c4 10             	add    $0x10,%esp
80100b04:	85 c0                	test   %eax,%eax
80100b06:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100b0c:	74 3a                	je     80100b48 <exec+0x158>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100b0e:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b14:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b19:	75 2d                	jne    80100b48 <exec+0x158>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b1b:	83 ec 0c             	sub    $0xc,%esp
80100b1e:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b24:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b2a:	53                   	push   %ebx
80100b2b:	50                   	push   %eax
80100b2c:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b32:	e8 49 63 00 00       	call   80106e80 <loaduvm>
80100b37:	83 c4 20             	add    $0x20,%esp
80100b3a:	85 c0                	test   %eax,%eax
80100b3c:	0f 89 5e ff ff ff    	jns    80100aa0 <exec+0xb0>
80100b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b48:	83 ec 0c             	sub    $0xc,%esp
80100b4b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b51:	e8 2a 65 00 00       	call   80107080 <freevm>
80100b56:	83 c4 10             	add    $0x10,%esp
80100b59:	e9 dd fe ff ff       	jmp    80100a3b <exec+0x4b>
    if(ph.vaddr % PGSIZE != 0)
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
      goto bad;
  }
  iunlockput(ip);
80100b5e:	83 ec 0c             	sub    $0xc,%esp
80100b61:	53                   	push   %ebx
80100b62:	e8 59 0d 00 00       	call   801018c0 <iunlockput>
  end_op();
80100b67:	e8 54 21 00 00       	call   80102cc0 <end_op>
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b6c:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b72:	83 c4 0c             	add    $0xc,%esp
  end_op();
  ip = 0;

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100b75:	05 ff 0f 00 00       	add    $0xfff,%eax
80100b7a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b7f:	8d 90 00 20 00 00    	lea    0x2000(%eax),%edx
80100b85:	52                   	push   %edx
80100b86:	50                   	push   %eax
80100b87:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100b8d:	e8 ae 63 00 00       	call   80106f40 <allocuvm>
80100b92:	83 c4 10             	add    $0x10,%esp
80100b95:	85 c0                	test   %eax,%eax
80100b97:	89 c6                	mov    %eax,%esi
80100b99:	75 2a                	jne    80100bc5 <exec+0x1d5>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100b9b:	83 ec 0c             	sub    $0xc,%esp
80100b9e:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100ba4:	e8 d7 64 00 00       	call   80107080 <freevm>
80100ba9:	83 c4 10             	add    $0x10,%esp
  if(ip){
    iunlockput(ip);
    end_op();
  }
  return -1;
80100bac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bb1:	e9 9b fe ff ff       	jmp    80100a51 <exec+0x61>
  pde_t *pgdir, *oldpgdir;

  begin_op();

  if((ip = namei(path)) == 0){
    end_op();
80100bb6:	e8 05 21 00 00       	call   80102cc0 <end_op>
    return -1;
80100bbb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bc0:	e9 8c fe ff ff       	jmp    80100a51 <exec+0x61>
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bc5:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bcb:	83 ec 08             	sub    $0x8,%esp
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bce:	31 ff                	xor    %edi,%edi
80100bd0:	89 f3                	mov    %esi,%ebx
  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bd2:	50                   	push   %eax
80100bd3:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80100bd9:	e8 22 65 00 00       	call   80107100 <clearpteu>
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100bde:	8b 45 0c             	mov    0xc(%ebp),%eax
80100be1:	83 c4 10             	add    $0x10,%esp
80100be4:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100bea:	8b 00                	mov    (%eax),%eax
80100bec:	85 c0                	test   %eax,%eax
80100bee:	74 6d                	je     80100c5d <exec+0x26d>
80100bf0:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80100bf6:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100bfc:	eb 07                	jmp    80100c05 <exec+0x215>
80100bfe:	66 90                	xchg   %ax,%ax
    if(argc >= MAXARG)
80100c00:	83 ff 20             	cmp    $0x20,%edi
80100c03:	74 96                	je     80100b9b <exec+0x1ab>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c05:	83 ec 0c             	sub    $0xc,%esp
80100c08:	50                   	push   %eax
80100c09:	e8 52 3b 00 00       	call   80104760 <strlen>
80100c0e:	f7 d0                	not    %eax
80100c10:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c12:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c15:	5a                   	pop    %edx

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c16:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c19:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c1c:	e8 3f 3b 00 00       	call   80104760 <strlen>
80100c21:	83 c0 01             	add    $0x1,%eax
80100c24:	50                   	push   %eax
80100c25:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c28:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c2b:	53                   	push   %ebx
80100c2c:	56                   	push   %esi
80100c2d:	e8 2e 66 00 00       	call   80107260 <copyout>
80100c32:	83 c4 20             	add    $0x20,%esp
80100c35:	85 c0                	test   %eax,%eax
80100c37:	0f 88 5e ff ff ff    	js     80100b9b <exec+0x1ab>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c40:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c47:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARG)
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
80100c4a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
  sp = sz;

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100c50:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c53:	85 c0                	test   %eax,%eax
80100c55:	75 a9                	jne    80100c00 <exec+0x210>
80100c57:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c5d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c64:	89 d9                	mov    %ebx,%ecx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
      goto bad;
    ustack[3+argc] = sp;
  }
  ustack[3+argc] = 0;
80100c66:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c6d:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100c71:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100c78:	ff ff ff 
  ustack[1] = argc;
80100c7b:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c81:	29 c1                	sub    %eax,%ecx

  sp -= (3+argc+1) * 4;
80100c83:	83 c0 0c             	add    $0xc,%eax
80100c86:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c88:	50                   	push   %eax
80100c89:	52                   	push   %edx
80100c8a:	53                   	push   %ebx
80100c8b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  }
  ustack[3+argc] = 0;

  ustack[0] = 0xffffffff;  // fake return PC
  ustack[1] = argc;
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c91:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)

  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100c97:	e8 c4 65 00 00       	call   80107260 <copyout>
80100c9c:	83 c4 10             	add    $0x10,%esp
80100c9f:	85 c0                	test   %eax,%eax
80100ca1:	0f 88 f4 fe ff ff    	js     80100b9b <exec+0x1ab>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100ca7:	8b 45 08             	mov    0x8(%ebp),%eax
80100caa:	0f b6 10             	movzbl (%eax),%edx
80100cad:	84 d2                	test   %dl,%dl
80100caf:	74 19                	je     80100cca <exec+0x2da>
80100cb1:	8b 4d 08             	mov    0x8(%ebp),%ecx
80100cb4:	83 c0 01             	add    $0x1,%eax
    if(*s == '/')
      last = s+1;
80100cb7:	80 fa 2f             	cmp    $0x2f,%dl
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cba:	0f b6 10             	movzbl (%eax),%edx
    if(*s == '/')
      last = s+1;
80100cbd:	0f 44 c8             	cmove  %eax,%ecx
80100cc0:	83 c0 01             	add    $0x1,%eax
  sp -= (3+argc+1) * 4;
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100cc3:	84 d2                	test   %dl,%dl
80100cc5:	75 f0                	jne    80100cb7 <exec+0x2c7>
80100cc7:	89 4d 08             	mov    %ecx,0x8(%ebp)
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));
80100cca:	50                   	push   %eax
80100ccb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cd1:	6a 10                	push   $0x10
80100cd3:	ff 75 08             	pushl  0x8(%ebp)
80100cd6:	83 c0 6c             	add    $0x6c,%eax
80100cd9:	50                   	push   %eax
80100cda:	e8 41 3a 00 00       	call   80104720 <safestrcpy>

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100cdf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  proc->pgdir = pgdir;
80100ce5:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
    if(*s == '/')
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
80100ceb:	8b 78 04             	mov    0x4(%eax),%edi
  proc->pgdir = pgdir;
  proc->sz = sz;
80100cee:	89 30                	mov    %esi,(%eax)
      last = s+1;
  safestrcpy(proc->name, last, sizeof(proc->name));

  // Commit to the user image.
  oldpgdir = proc->pgdir;
  proc->pgdir = pgdir;
80100cf0:	89 48 04             	mov    %ecx,0x4(%eax)
  proc->sz = sz;
  proc->tf->eip = elf.entry;  // main
80100cf3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80100cf9:	8b 8d 3c ff ff ff    	mov    -0xc4(%ebp),%ecx
80100cff:	8b 50 18             	mov    0x18(%eax),%edx
80100d02:	89 4a 38             	mov    %ecx,0x38(%edx)
  proc->tf->esp = sp;
80100d05:	8b 50 18             	mov    0x18(%eax),%edx
80100d08:	89 5a 44             	mov    %ebx,0x44(%edx)
  switchuvm(proc);
80100d0b:	89 04 24             	mov    %eax,(%esp)
80100d0e:	e8 1d 60 00 00       	call   80106d30 <switchuvm>
  freevm(oldpgdir);
80100d13:	89 3c 24             	mov    %edi,(%esp)
80100d16:	e8 65 63 00 00       	call   80107080 <freevm>
  return 0;
80100d1b:	83 c4 10             	add    $0x10,%esp
80100d1e:	31 c0                	xor    %eax,%eax
80100d20:	e9 2c fd ff ff       	jmp    80100a51 <exec+0x61>
80100d25:	66 90                	xchg   %ax,%ax
80100d27:	66 90                	xchg   %ax,%ax
80100d29:	66 90                	xchg   %ax,%ax
80100d2b:	66 90                	xchg   %ax,%ax
80100d2d:	66 90                	xchg   %ax,%ax
80100d2f:	90                   	nop

80100d30 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d30:	55                   	push   %ebp
80100d31:	89 e5                	mov    %esp,%ebp
80100d33:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d36:	68 89 73 10 80       	push   $0x80107389
80100d3b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d40:	e8 8b 35 00 00       	call   801042d0 <initlock>
}
80100d45:	83 c4 10             	add    $0x10,%esp
80100d48:	c9                   	leave  
80100d49:	c3                   	ret    
80100d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d50 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d50:	55                   	push   %ebp
80100d51:	89 e5                	mov    %esp,%ebp
80100d53:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d54:	bb 14 00 11 80       	mov    $0x80110014,%ebx
}

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d59:	83 ec 10             	sub    $0x10,%esp
  struct file *f;

  acquire(&ftable.lock);
80100d5c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d61:	e8 8a 35 00 00       	call   801042f0 <acquire>
80100d66:	83 c4 10             	add    $0x10,%esp
80100d69:	eb 10                	jmp    80100d7b <filealloc+0x2b>
80100d6b:	90                   	nop
80100d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d70:	83 c3 18             	add    $0x18,%ebx
80100d73:	81 fb 74 09 11 80    	cmp    $0x80110974,%ebx
80100d79:	74 25                	je     80100da0 <filealloc+0x50>
    if(f->ref == 0){
80100d7b:	8b 43 04             	mov    0x4(%ebx),%eax
80100d7e:	85 c0                	test   %eax,%eax
80100d80:	75 ee                	jne    80100d70 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100d82:	83 ec 0c             	sub    $0xc,%esp
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    if(f->ref == 0){
      f->ref = 1;
80100d85:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100d8c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d91:	e8 3a 37 00 00       	call   801044d0 <release>
      return f;
80100d96:	89 d8                	mov    %ebx,%eax
80100d98:	83 c4 10             	add    $0x10,%esp
    }
  }
  release(&ftable.lock);
  return 0;
}
80100d9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100d9e:	c9                   	leave  
80100d9f:	c3                   	ret    
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
80100da0:	83 ec 0c             	sub    $0xc,%esp
80100da3:	68 e0 ff 10 80       	push   $0x8010ffe0
80100da8:	e8 23 37 00 00       	call   801044d0 <release>
  return 0;
80100dad:	83 c4 10             	add    $0x10,%esp
80100db0:	31 c0                	xor    %eax,%eax
}
80100db2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100db5:	c9                   	leave  
80100db6:	c3                   	ret    
80100db7:	89 f6                	mov    %esi,%esi
80100db9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100dc0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100dc0:	55                   	push   %ebp
80100dc1:	89 e5                	mov    %esp,%ebp
80100dc3:	53                   	push   %ebx
80100dc4:	83 ec 10             	sub    $0x10,%esp
80100dc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dca:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dcf:	e8 1c 35 00 00       	call   801042f0 <acquire>
  if(f->ref < 1)
80100dd4:	8b 43 04             	mov    0x4(%ebx),%eax
80100dd7:	83 c4 10             	add    $0x10,%esp
80100dda:	85 c0                	test   %eax,%eax
80100ddc:	7e 1a                	jle    80100df8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100dde:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100de1:	83 ec 0c             	sub    $0xc,%esp
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
  f->ref++;
80100de4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100de7:	68 e0 ff 10 80       	push   $0x8010ffe0
80100dec:	e8 df 36 00 00       	call   801044d0 <release>
  return f;
}
80100df1:	89 d8                	mov    %ebx,%eax
80100df3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100df6:	c9                   	leave  
80100df7:	c3                   	ret    
struct file*
filedup(struct file *f)
{
  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("filedup");
80100df8:	83 ec 0c             	sub    $0xc,%esp
80100dfb:	68 90 73 10 80       	push   $0x80107390
80100e00:	e8 6b f5 ff ff       	call   80100370 <panic>
80100e05:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e10 <fileclose>:
}

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e10:	55                   	push   %ebp
80100e11:	89 e5                	mov    %esp,%ebp
80100e13:	57                   	push   %edi
80100e14:	56                   	push   %esi
80100e15:	53                   	push   %ebx
80100e16:	83 ec 28             	sub    $0x28,%esp
80100e19:	8b 7d 08             	mov    0x8(%ebp),%edi
  struct file ff;

  acquire(&ftable.lock);
80100e1c:	68 e0 ff 10 80       	push   $0x8010ffe0
80100e21:	e8 ca 34 00 00       	call   801042f0 <acquire>
  if(f->ref < 1)
80100e26:	8b 47 04             	mov    0x4(%edi),%eax
80100e29:	83 c4 10             	add    $0x10,%esp
80100e2c:	85 c0                	test   %eax,%eax
80100e2e:	0f 8e 9b 00 00 00    	jle    80100ecf <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e34:	83 e8 01             	sub    $0x1,%eax
80100e37:	85 c0                	test   %eax,%eax
80100e39:	89 47 04             	mov    %eax,0x4(%edi)
80100e3c:	74 1a                	je     80100e58 <fileclose+0x48>
    release(&ftable.lock);
80100e3e:	c7 45 08 e0 ff 10 80 	movl   $0x8010ffe0,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e45:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e48:	5b                   	pop    %ebx
80100e49:	5e                   	pop    %esi
80100e4a:	5f                   	pop    %edi
80100e4b:	5d                   	pop    %ebp

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
80100e4c:	e9 7f 36 00 00       	jmp    801044d0 <release>
80100e51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return;
  }
  ff = *f;
80100e58:	0f b6 47 09          	movzbl 0x9(%edi),%eax
80100e5c:	8b 1f                	mov    (%edi),%ebx
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e5e:	83 ec 0c             	sub    $0xc,%esp
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e61:	8b 77 0c             	mov    0xc(%edi),%esi
  f->ref = 0;
  f->type = FD_NONE;
80100e64:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e6a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e6d:	8b 47 10             	mov    0x10(%edi),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e70:	68 e0 ff 10 80       	push   $0x8010ffe0
    panic("fileclose");
  if(--f->ref > 0){
    release(&ftable.lock);
    return;
  }
  ff = *f;
80100e75:	89 45 e0             	mov    %eax,-0x20(%ebp)
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80100e78:	e8 53 36 00 00       	call   801044d0 <release>

  if(ff.type == FD_PIPE)
80100e7d:	83 c4 10             	add    $0x10,%esp
80100e80:	83 fb 01             	cmp    $0x1,%ebx
80100e83:	74 13                	je     80100e98 <fileclose+0x88>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80100e85:	83 fb 02             	cmp    $0x2,%ebx
80100e88:	74 26                	je     80100eb0 <fileclose+0xa0>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e8d:	5b                   	pop    %ebx
80100e8e:	5e                   	pop    %esi
80100e8f:	5f                   	pop    %edi
80100e90:	5d                   	pop    %ebp
80100e91:	c3                   	ret    
80100e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);

  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
80100e98:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100e9c:	83 ec 08             	sub    $0x8,%esp
80100e9f:	53                   	push   %ebx
80100ea0:	56                   	push   %esi
80100ea1:	e8 4a 26 00 00       	call   801034f0 <pipeclose>
80100ea6:	83 c4 10             	add    $0x10,%esp
80100ea9:	eb df                	jmp    80100e8a <fileclose+0x7a>
80100eab:	90                   	nop
80100eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100eb0:	e8 9b 1d 00 00       	call   80102c50 <begin_op>
    iput(ff.ip);
80100eb5:	83 ec 0c             	sub    $0xc,%esp
80100eb8:	ff 75 e0             	pushl  -0x20(%ebp)
80100ebb:	e8 c0 08 00 00       	call   80101780 <iput>
    end_op();
80100ec0:	83 c4 10             	add    $0x10,%esp
  }
}
80100ec3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ec6:	5b                   	pop    %ebx
80100ec7:	5e                   	pop    %esi
80100ec8:	5f                   	pop    %edi
80100ec9:	5d                   	pop    %ebp
  if(ff.type == FD_PIPE)
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
80100eca:	e9 f1 1d 00 00       	jmp    80102cc0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100ecf:	83 ec 0c             	sub    $0xc,%esp
80100ed2:	68 98 73 10 80       	push   $0x80107398
80100ed7:	e8 94 f4 ff ff       	call   80100370 <panic>
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ee0 <filestat>:
}

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100ee0:	55                   	push   %ebp
80100ee1:	89 e5                	mov    %esp,%ebp
80100ee3:	53                   	push   %ebx
80100ee4:	83 ec 04             	sub    $0x4,%esp
80100ee7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100eea:	83 3b 02             	cmpl   $0x2,(%ebx)
80100eed:	75 31                	jne    80100f20 <filestat+0x40>
    ilock(f->ip);
80100eef:	83 ec 0c             	sub    $0xc,%esp
80100ef2:	ff 73 10             	pushl  0x10(%ebx)
80100ef5:	e8 56 07 00 00       	call   80101650 <ilock>
    stati(f->ip, st);
80100efa:	58                   	pop    %eax
80100efb:	5a                   	pop    %edx
80100efc:	ff 75 0c             	pushl  0xc(%ebp)
80100eff:	ff 73 10             	pushl  0x10(%ebx)
80100f02:	e8 d9 09 00 00       	call   801018e0 <stati>
    iunlock(f->ip);
80100f07:	59                   	pop    %ecx
80100f08:	ff 73 10             	pushl  0x10(%ebx)
80100f0b:	e8 20 08 00 00       	call   80101730 <iunlock>
    return 0;
80100f10:	83 c4 10             	add    $0x10,%esp
80100f13:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f18:	c9                   	leave  
80100f19:	c3                   	ret    
80100f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ilock(f->ip);
    stati(f->ip, st);
    iunlock(f->ip);
    return 0;
  }
  return -1;
80100f20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100f25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f28:	c9                   	leave  
80100f29:	c3                   	ret    
80100f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f30 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f30:	55                   	push   %ebp
80100f31:	89 e5                	mov    %esp,%ebp
80100f33:	57                   	push   %edi
80100f34:	56                   	push   %esi
80100f35:	53                   	push   %ebx
80100f36:	83 ec 0c             	sub    $0xc,%esp
80100f39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f3c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f3f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f42:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f46:	74 60                	je     80100fa8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f48:	8b 03                	mov    (%ebx),%eax
80100f4a:	83 f8 01             	cmp    $0x1,%eax
80100f4d:	74 41                	je     80100f90 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f4f:	83 f8 02             	cmp    $0x2,%eax
80100f52:	75 5b                	jne    80100faf <fileread+0x7f>
    ilock(f->ip);
80100f54:	83 ec 0c             	sub    $0xc,%esp
80100f57:	ff 73 10             	pushl  0x10(%ebx)
80100f5a:	e8 f1 06 00 00       	call   80101650 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f5f:	57                   	push   %edi
80100f60:	ff 73 14             	pushl  0x14(%ebx)
80100f63:	56                   	push   %esi
80100f64:	ff 73 10             	pushl  0x10(%ebx)
80100f67:	e8 a4 09 00 00       	call   80101910 <readi>
80100f6c:	83 c4 20             	add    $0x20,%esp
80100f6f:	85 c0                	test   %eax,%eax
80100f71:	89 c6                	mov    %eax,%esi
80100f73:	7e 03                	jle    80100f78 <fileread+0x48>
      f->off += r;
80100f75:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100f78:	83 ec 0c             	sub    $0xc,%esp
80100f7b:	ff 73 10             	pushl  0x10(%ebx)
80100f7e:	e8 ad 07 00 00       	call   80101730 <iunlock>
    return r;
80100f83:	83 c4 10             	add    $0x10,%esp
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
    ilock(f->ip);
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f86:	89 f0                	mov    %esi,%eax
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f8b:	5b                   	pop    %ebx
80100f8c:	5e                   	pop    %esi
80100f8d:	5f                   	pop    %edi
80100f8e:	5d                   	pop    %ebp
80100f8f:	c3                   	ret    
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f90:	8b 43 0c             	mov    0xc(%ebx),%eax
80100f93:	89 45 08             	mov    %eax,0x8(%ebp)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
}
80100f96:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100f99:	5b                   	pop    %ebx
80100f9a:	5e                   	pop    %esi
80100f9b:	5f                   	pop    %edi
80100f9c:	5d                   	pop    %ebp
  int r;

  if(f->readable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return piperead(f->pipe, addr, n);
80100f9d:	e9 1e 27 00 00       	jmp    801036c0 <piperead>
80100fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
fileread(struct file *f, char *addr, int n)
{
  int r;

  if(f->readable == 0)
    return -1;
80100fa8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fad:	eb d9                	jmp    80100f88 <fileread+0x58>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
      f->off += r;
    iunlock(f->ip);
    return r;
  }
  panic("fileread");
80100faf:	83 ec 0c             	sub    $0xc,%esp
80100fb2:	68 a2 73 10 80       	push   $0x801073a2
80100fb7:	e8 b4 f3 ff ff       	call   80100370 <panic>
80100fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100fc0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fc0:	55                   	push   %ebp
80100fc1:	89 e5                	mov    %esp,%ebp
80100fc3:	57                   	push   %edi
80100fc4:	56                   	push   %esi
80100fc5:	53                   	push   %ebx
80100fc6:	83 ec 1c             	sub    $0x1c,%esp
80100fc9:	8b 75 08             	mov    0x8(%ebp),%esi
80100fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fcf:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100fd3:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100fd6:	8b 45 10             	mov    0x10(%ebp),%eax
80100fd9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int r;

  if(f->writable == 0)
80100fdc:	0f 84 aa 00 00 00    	je     8010108c <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80100fe2:	8b 06                	mov    (%esi),%eax
80100fe4:	83 f8 01             	cmp    $0x1,%eax
80100fe7:	0f 84 c2 00 00 00    	je     801010af <filewrite+0xef>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100fed:	83 f8 02             	cmp    $0x2,%eax
80100ff0:	0f 85 d8 00 00 00    	jne    801010ce <filewrite+0x10e>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80100ff6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ff9:	31 ff                	xor    %edi,%edi
80100ffb:	85 c0                	test   %eax,%eax
80100ffd:	7f 34                	jg     80101033 <filewrite+0x73>
80100fff:	e9 9c 00 00 00       	jmp    801010a0 <filewrite+0xe0>
80101004:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101008:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010100b:	83 ec 0c             	sub    $0xc,%esp
8010100e:	ff 76 10             	pushl  0x10(%esi)
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101011:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101014:	e8 17 07 00 00       	call   80101730 <iunlock>
      end_op();
80101019:	e8 a2 1c 00 00       	call   80102cc0 <end_op>
8010101e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101021:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101024:	39 d8                	cmp    %ebx,%eax
80101026:	0f 85 95 00 00 00    	jne    801010c1 <filewrite+0x101>
        panic("short filewrite");
      i += r;
8010102c:	01 c7                	add    %eax,%edi
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((LOGSIZE-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010102e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101031:	7e 6d                	jle    801010a0 <filewrite+0xe0>
      int n1 = n - i;
80101033:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101036:	b8 00 1a 00 00       	mov    $0x1a00,%eax
8010103b:	29 fb                	sub    %edi,%ebx
8010103d:	81 fb 00 1a 00 00    	cmp    $0x1a00,%ebx
80101043:	0f 4f d8             	cmovg  %eax,%ebx
      if(n1 > max)
        n1 = max;

      begin_op();
80101046:	e8 05 1c 00 00       	call   80102c50 <begin_op>
      ilock(f->ip);
8010104b:	83 ec 0c             	sub    $0xc,%esp
8010104e:	ff 76 10             	pushl  0x10(%esi)
80101051:	e8 fa 05 00 00       	call   80101650 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101056:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101059:	53                   	push   %ebx
8010105a:	ff 76 14             	pushl  0x14(%esi)
8010105d:	01 f8                	add    %edi,%eax
8010105f:	50                   	push   %eax
80101060:	ff 76 10             	pushl  0x10(%esi)
80101063:	e8 d8 09 00 00       	call   80101a40 <writei>
80101068:	83 c4 20             	add    $0x20,%esp
8010106b:	85 c0                	test   %eax,%eax
8010106d:	7f 99                	jg     80101008 <filewrite+0x48>
        f->off += r;
      iunlock(f->ip);
8010106f:	83 ec 0c             	sub    $0xc,%esp
80101072:	ff 76 10             	pushl  0x10(%esi)
80101075:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101078:	e8 b3 06 00 00       	call   80101730 <iunlock>
      end_op();
8010107d:	e8 3e 1c 00 00       	call   80102cc0 <end_op>

      if(r < 0)
80101082:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101085:	83 c4 10             	add    $0x10,%esp
80101088:	85 c0                	test   %eax,%eax
8010108a:	74 98                	je     80101024 <filewrite+0x64>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
8010108c:	8d 65 f4             	lea    -0xc(%ebp),%esp
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
8010108f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101094:	5b                   	pop    %ebx
80101095:	5e                   	pop    %esi
80101096:	5f                   	pop    %edi
80101097:	5d                   	pop    %ebp
80101098:	c3                   	ret    
80101099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        break;
      if(r != n1)
        panic("short filewrite");
      i += r;
    }
    return i == n ? n : -1;
801010a0:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
801010a3:	75 e7                	jne    8010108c <filewrite+0xcc>
  }
  panic("filewrite");
}
801010a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a8:	89 f8                	mov    %edi,%eax
801010aa:	5b                   	pop    %ebx
801010ab:	5e                   	pop    %esi
801010ac:	5f                   	pop    %edi
801010ad:	5d                   	pop    %ebp
801010ae:	c3                   	ret    
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010af:	8b 46 0c             	mov    0xc(%esi),%eax
801010b2:	89 45 08             	mov    %eax,0x8(%ebp)
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010b8:	5b                   	pop    %ebx
801010b9:	5e                   	pop    %esi
801010ba:	5f                   	pop    %edi
801010bb:	5d                   	pop    %ebp
  int r;

  if(f->writable == 0)
    return -1;
  if(f->type == FD_PIPE)
    return pipewrite(f->pipe, addr, n);
801010bc:	e9 cf 24 00 00       	jmp    80103590 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010c1:	83 ec 0c             	sub    $0xc,%esp
801010c4:	68 ab 73 10 80       	push   $0x801073ab
801010c9:	e8 a2 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ce:	83 ec 0c             	sub    $0xc,%esp
801010d1:	68 b1 73 10 80       	push   $0x801073b1
801010d6:	e8 95 f2 ff ff       	call   80100370 <panic>
801010db:	66 90                	xchg   %ax,%ax
801010dd:	66 90                	xchg   %ax,%ax
801010df:	90                   	nop

801010e0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	57                   	push   %edi
801010e4:	56                   	push   %esi
801010e5:	53                   	push   %ebx
801010e6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010e9:	8b 0d e0 09 11 80    	mov    0x801109e0,%ecx
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801010ef:	89 45 d8             	mov    %eax,-0x28(%ebp)
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801010f2:	85 c9                	test   %ecx,%ecx
801010f4:	0f 84 85 00 00 00    	je     8010117f <balloc+0x9f>
801010fa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101101:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101104:	83 ec 08             	sub    $0x8,%esp
80101107:	89 f0                	mov    %esi,%eax
80101109:	c1 f8 0c             	sar    $0xc,%eax
8010110c:	03 05 f8 09 11 80    	add    0x801109f8,%eax
80101112:	50                   	push   %eax
80101113:	ff 75 d8             	pushl  -0x28(%ebp)
80101116:	e8 b5 ef ff ff       	call   801000d0 <bread>
8010111b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010111e:	a1 e0 09 11 80       	mov    0x801109e0,%eax
80101123:	83 c4 10             	add    $0x10,%esp
80101126:	89 45 e0             	mov    %eax,-0x20(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101129:	31 c0                	xor    %eax,%eax
8010112b:	eb 2d                	jmp    8010115a <balloc+0x7a>
8010112d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101130:	89 c1                	mov    %eax,%ecx
80101132:	ba 01 00 00 00       	mov    $0x1,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101137:	8b 5d e4             	mov    -0x1c(%ebp),%ebx

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
8010113a:	83 e1 07             	and    $0x7,%ecx
8010113d:	d3 e2                	shl    %cl,%edx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010113f:	89 c1                	mov    %eax,%ecx
80101141:	c1 f9 03             	sar    $0x3,%ecx
80101144:	0f b6 7c 0b 5c       	movzbl 0x5c(%ebx,%ecx,1),%edi
80101149:	85 d7                	test   %edx,%edi
8010114b:	74 43                	je     80101190 <balloc+0xb0>
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114d:	83 c0 01             	add    $0x1,%eax
80101150:	83 c6 01             	add    $0x1,%esi
80101153:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101158:	74 05                	je     8010115f <balloc+0x7f>
8010115a:	3b 75 e0             	cmp    -0x20(%ebp),%esi
8010115d:	72 d1                	jb     80101130 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
8010115f:	83 ec 0c             	sub    $0xc,%esp
80101162:	ff 75 e4             	pushl  -0x1c(%ebp)
80101165:	e8 76 f0 ff ff       	call   801001e0 <brelse>
{
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
8010116a:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101171:	83 c4 10             	add    $0x10,%esp
80101174:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101177:	39 05 e0 09 11 80    	cmp    %eax,0x801109e0
8010117d:	77 82                	ja     80101101 <balloc+0x21>
        return b + bi;
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
8010117f:	83 ec 0c             	sub    $0xc,%esp
80101182:	68 bb 73 10 80       	push   $0x801073bb
80101187:	e8 e4 f1 ff ff       	call   80100370 <panic>
8010118c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101190:	09 fa                	or     %edi,%edx
80101192:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
80101195:	83 ec 0c             	sub    $0xc,%esp
  for(b = 0; b < sb.size; b += BPB){
    bp = bread(dev, BBLOCK(b, sb));
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
      m = 1 << (bi % 8);
      if((bp->data[bi/8] & m) == 0){  // Is block free?
        bp->data[bi/8] |= m;  // Mark block in use.
80101198:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
8010119c:	57                   	push   %edi
8010119d:	e8 8e 1c 00 00       	call   80102e30 <log_write>
        brelse(bp);
801011a2:	89 3c 24             	mov    %edi,(%esp)
801011a5:	e8 36 f0 ff ff       	call   801001e0 <brelse>
static void
bzero(int dev, int bno)
{
  struct buf *bp;

  bp = bread(dev, bno);
801011aa:	58                   	pop    %eax
801011ab:	5a                   	pop    %edx
801011ac:	56                   	push   %esi
801011ad:	ff 75 d8             	pushl  -0x28(%ebp)
801011b0:	e8 1b ef ff ff       	call   801000d0 <bread>
801011b5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011b7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ba:	83 c4 0c             	add    $0xc,%esp
801011bd:	68 00 02 00 00       	push   $0x200
801011c2:	6a 00                	push   $0x0
801011c4:	50                   	push   %eax
801011c5:	e8 56 33 00 00       	call   80104520 <memset>
  log_write(bp);
801011ca:	89 1c 24             	mov    %ebx,(%esp)
801011cd:	e8 5e 1c 00 00       	call   80102e30 <log_write>
  brelse(bp);
801011d2:	89 1c 24             	mov    %ebx,(%esp)
801011d5:	e8 06 f0 ff ff       	call   801001e0 <brelse>
      }
    }
    brelse(bp);
  }
  panic("balloc: out of blocks");
}
801011da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011dd:	89 f0                	mov    %esi,%eax
801011df:	5b                   	pop    %ebx
801011e0:	5e                   	pop    %esi
801011e1:	5f                   	pop    %edi
801011e2:	5d                   	pop    %ebp
801011e3:	c3                   	ret    
801011e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801011ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801011f0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011f0:	55                   	push   %ebp
801011f1:	89 e5                	mov    %esp,%ebp
801011f3:	57                   	push   %edi
801011f4:	56                   	push   %esi
801011f5:	53                   	push   %ebx
801011f6:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801011f8:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801011fa:	bb 34 0a 11 80       	mov    $0x80110a34,%ebx
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801011ff:	83 ec 28             	sub    $0x28,%esp
80101202:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101205:	68 00 0a 11 80       	push   $0x80110a00
8010120a:	e8 e1 30 00 00       	call   801042f0 <acquire>
8010120f:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101212:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101215:	eb 1b                	jmp    80101232 <iget+0x42>
80101217:	89 f6                	mov    %esi,%esi
80101219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101220:	85 f6                	test   %esi,%esi
80101222:	74 44                	je     80101268 <iget+0x78>

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101224:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010122a:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101230:	74 4e                	je     80101280 <iget+0x90>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101232:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101235:	85 c9                	test   %ecx,%ecx
80101237:	7e e7                	jle    80101220 <iget+0x30>
80101239:	39 3b                	cmp    %edi,(%ebx)
8010123b:	75 e3                	jne    80101220 <iget+0x30>
8010123d:	39 53 04             	cmp    %edx,0x4(%ebx)
80101240:	75 de                	jne    80101220 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
80101242:	83 ec 0c             	sub    $0xc,%esp

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
80101245:	83 c1 01             	add    $0x1,%ecx
      release(&icache.lock);
      return ip;
80101248:	89 de                	mov    %ebx,%esi
  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
8010124a:	68 00 0a 11 80       	push   $0x80110a00

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
8010124f:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
80101252:	e8 79 32 00 00       	call   801044d0 <release>
      return ip;
80101257:	83 c4 10             	add    $0x10,%esp
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);

  return ip;
}
8010125a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010125d:	89 f0                	mov    %esi,%eax
8010125f:	5b                   	pop    %ebx
80101260:	5e                   	pop    %esi
80101261:	5f                   	pop    %edi
80101262:	5d                   	pop    %ebp
80101263:	c3                   	ret    
80101264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101268:	85 c9                	test   %ecx,%ecx
8010126a:	0f 44 f3             	cmove  %ebx,%esi

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010126d:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101273:	81 fb 54 26 11 80    	cmp    $0x80112654,%ebx
80101279:	75 b7                	jne    80101232 <iget+0x42>
8010127b:	90                   	nop
8010127c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101280:	85 f6                	test   %esi,%esi
80101282:	74 2d                	je     801012b1 <iget+0xc1>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->flags = 0;
  release(&icache.lock);
80101284:	83 ec 0c             	sub    $0xc,%esp
  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");

  ip = empty;
  ip->dev = dev;
80101287:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101289:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010128c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->flags = 0;
80101293:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010129a:	68 00 0a 11 80       	push   $0x80110a00
8010129f:	e8 2c 32 00 00       	call   801044d0 <release>

  return ip;
801012a4:	83 c4 10             	add    $0x10,%esp
}
801012a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012aa:	89 f0                	mov    %esi,%eax
801012ac:	5b                   	pop    %ebx
801012ad:	5e                   	pop    %esi
801012ae:	5f                   	pop    %edi
801012af:	5d                   	pop    %ebp
801012b0:	c3                   	ret    
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
    panic("iget: no inodes");
801012b1:	83 ec 0c             	sub    $0xc,%esp
801012b4:	68 d1 73 10 80       	push   $0x801073d1
801012b9:	e8 b2 f0 ff ff       	call   80100370 <panic>
801012be:	66 90                	xchg   %ax,%ax

801012c0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012c0:	55                   	push   %ebp
801012c1:	89 e5                	mov    %esp,%ebp
801012c3:	57                   	push   %edi
801012c4:	56                   	push   %esi
801012c5:	53                   	push   %ebx
801012c6:	89 c6                	mov    %eax,%esi
801012c8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012cb:	83 fa 0b             	cmp    $0xb,%edx
801012ce:	77 18                	ja     801012e8 <bmap+0x28>
801012d0:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
    if((addr = ip->addrs[bn]) == 0)
801012d3:	8b 43 5c             	mov    0x5c(%ebx),%eax
801012d6:	85 c0                	test   %eax,%eax
801012d8:	74 76                	je     80101350 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
801012da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012dd:	5b                   	pop    %ebx
801012de:	5e                   	pop    %esi
801012df:	5f                   	pop    %edi
801012e0:	5d                   	pop    %ebp
801012e1:	c3                   	ret    
801012e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801012e8:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801012eb:	83 fb 7f             	cmp    $0x7f,%ebx
801012ee:	0f 87 83 00 00 00    	ja     80101377 <bmap+0xb7>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801012f4:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801012fa:	85 c0                	test   %eax,%eax
801012fc:	74 6a                	je     80101368 <bmap+0xa8>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801012fe:	83 ec 08             	sub    $0x8,%esp
80101301:	50                   	push   %eax
80101302:	ff 36                	pushl  (%esi)
80101304:	e8 c7 ed ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101309:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010130d:	83 c4 10             	add    $0x10,%esp

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
80101310:	89 c7                	mov    %eax,%edi
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101312:	8b 1a                	mov    (%edx),%ebx
80101314:	85 db                	test   %ebx,%ebx
80101316:	75 1d                	jne    80101335 <bmap+0x75>
      a[bn] = addr = balloc(ip->dev);
80101318:	8b 06                	mov    (%esi),%eax
8010131a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010131d:	e8 be fd ff ff       	call   801010e0 <balloc>
80101322:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101325:	83 ec 0c             	sub    $0xc,%esp
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
80101328:	89 c3                	mov    %eax,%ebx
8010132a:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010132c:	57                   	push   %edi
8010132d:	e8 fe 1a 00 00       	call   80102e30 <log_write>
80101332:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101335:	83 ec 0c             	sub    $0xc,%esp
80101338:	57                   	push   %edi
80101339:	e8 a2 ee ff ff       	call   801001e0 <brelse>
8010133e:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101341:	8d 65 f4             	lea    -0xc(%ebp),%esp
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101344:	89 d8                	mov    %ebx,%eax
    return addr;
  }

  panic("bmap: out of range");
}
80101346:	5b                   	pop    %ebx
80101347:	5e                   	pop    %esi
80101348:	5f                   	pop    %edi
80101349:	5d                   	pop    %ebp
8010134a:	c3                   	ret    
8010134b:	90                   	nop
8010134c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
80101350:	8b 06                	mov    (%esi),%eax
80101352:	e8 89 fd ff ff       	call   801010e0 <balloc>
80101357:	89 43 5c             	mov    %eax,0x5c(%ebx)
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010135a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010135d:	5b                   	pop    %ebx
8010135e:	5e                   	pop    %esi
8010135f:	5f                   	pop    %edi
80101360:	5d                   	pop    %ebp
80101361:	c3                   	ret    
80101362:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  bn -= NDIRECT;

  if(bn < NINDIRECT){
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101368:	8b 06                	mov    (%esi),%eax
8010136a:	e8 71 fd ff ff       	call   801010e0 <balloc>
8010136f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101375:	eb 87                	jmp    801012fe <bmap+0x3e>
    }
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
80101377:	83 ec 0c             	sub    $0xc,%esp
8010137a:	68 e1 73 10 80       	push   $0x801073e1
8010137f:	e8 ec ef ff ff       	call   80100370 <panic>
80101384:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010138a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101390 <readsb>:
struct superblock sb;

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101390:	55                   	push   %ebp
80101391:	89 e5                	mov    %esp,%ebp
80101393:	56                   	push   %esi
80101394:	53                   	push   %ebx
80101395:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct buf *bp;

  bp = bread(dev, 1);
80101398:	83 ec 08             	sub    $0x8,%esp
8010139b:	6a 01                	push   $0x1
8010139d:	ff 75 08             	pushl  0x8(%ebp)
801013a0:	e8 2b ed ff ff       	call   801000d0 <bread>
801013a5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013aa:	83 c4 0c             	add    $0xc,%esp
801013ad:	6a 1c                	push   $0x1c
801013af:	50                   	push   %eax
801013b0:	56                   	push   %esi
801013b1:	e8 1a 32 00 00       	call   801045d0 <memmove>
  brelse(bp);
801013b6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013b9:	83 c4 10             	add    $0x10,%esp
}
801013bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013bf:	5b                   	pop    %ebx
801013c0:	5e                   	pop    %esi
801013c1:	5d                   	pop    %ebp
{
  struct buf *bp;

  bp = bread(dev, 1);
  memmove(sb, bp->data, sizeof(*sb));
  brelse(bp);
801013c2:	e9 19 ee ff ff       	jmp    801001e0 <brelse>
801013c7:	89 f6                	mov    %esi,%esi
801013c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801013d0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	56                   	push   %esi
801013d4:	53                   	push   %ebx
801013d5:	89 d3                	mov    %edx,%ebx
801013d7:	89 c6                	mov    %eax,%esi
  struct buf *bp;
  int bi, m;

  readsb(dev, &sb);
801013d9:	83 ec 08             	sub    $0x8,%esp
801013dc:	68 e0 09 11 80       	push   $0x801109e0
801013e1:	50                   	push   %eax
801013e2:	e8 a9 ff ff ff       	call   80101390 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
801013e7:	58                   	pop    %eax
801013e8:	5a                   	pop    %edx
801013e9:	89 da                	mov    %ebx,%edx
801013eb:	c1 ea 0c             	shr    $0xc,%edx
801013ee:	03 15 f8 09 11 80    	add    0x801109f8,%edx
801013f4:	52                   	push   %edx
801013f5:	56                   	push   %esi
801013f6:	e8 d5 ec ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
801013fb:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801013fd:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101403:	ba 01 00 00 00       	mov    $0x1,%edx
80101408:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010140b:	c1 fb 03             	sar    $0x3,%ebx
8010140e:	83 c4 10             	add    $0x10,%esp
  int bi, m;

  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
80101411:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101413:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101418:	85 d1                	test   %edx,%ecx
8010141a:	74 27                	je     80101443 <bfree+0x73>
8010141c:	89 c6                	mov    %eax,%esi
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
8010141e:	f7 d2                	not    %edx
80101420:	89 c8                	mov    %ecx,%eax
  log_write(bp);
80101422:	83 ec 0c             	sub    $0xc,%esp
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
80101425:	21 d0                	and    %edx,%eax
80101427:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010142b:	56                   	push   %esi
8010142c:	e8 ff 19 00 00       	call   80102e30 <log_write>
  brelse(bp);
80101431:	89 34 24             	mov    %esi,(%esp)
80101434:	e8 a7 ed ff ff       	call   801001e0 <brelse>
}
80101439:	83 c4 10             	add    $0x10,%esp
8010143c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010143f:	5b                   	pop    %ebx
80101440:	5e                   	pop    %esi
80101441:	5d                   	pop    %ebp
80101442:	c3                   	ret    
  readsb(dev, &sb);
  bp = bread(dev, BBLOCK(b, sb));
  bi = b % BPB;
  m = 1 << (bi % 8);
  if((bp->data[bi/8] & m) == 0)
    panic("freeing free block");
80101443:	83 ec 0c             	sub    $0xc,%esp
80101446:	68 f4 73 10 80       	push   $0x801073f4
8010144b:	e8 20 ef ff ff       	call   80100370 <panic>

80101450 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	53                   	push   %ebx
80101454:	bb 40 0a 11 80       	mov    $0x80110a40,%ebx
80101459:	83 ec 0c             	sub    $0xc,%esp
  int i = 0;

  initlock(&icache.lock, "icache");
8010145c:	68 07 74 10 80       	push   $0x80107407
80101461:	68 00 0a 11 80       	push   $0x80110a00
80101466:	e8 65 2e 00 00       	call   801042d0 <initlock>
8010146b:	83 c4 10             	add    $0x10,%esp
8010146e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101470:	83 ec 08             	sub    $0x8,%esp
80101473:	68 0e 74 10 80       	push   $0x8010740e
80101478:	53                   	push   %ebx
80101479:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010147f:	e8 3c 2d 00 00       	call   801041c0 <initsleeplock>
iinit(int dev)
{
  int i = 0;

  initlock(&icache.lock, "icache");
  for(i = 0; i < NINODE; i++) {
80101484:	83 c4 10             	add    $0x10,%esp
80101487:	81 fb 60 26 11 80    	cmp    $0x80112660,%ebx
8010148d:	75 e1                	jne    80101470 <iinit+0x20>
    initsleeplock(&icache.inode[i].lock, "inode");
  }

  readsb(dev, &sb);
8010148f:	83 ec 08             	sub    $0x8,%esp
80101492:	68 e0 09 11 80       	push   $0x801109e0
80101497:	ff 75 08             	pushl  0x8(%ebp)
8010149a:	e8 f1 fe ff ff       	call   80101390 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010149f:	ff 35 f8 09 11 80    	pushl  0x801109f8
801014a5:	ff 35 f4 09 11 80    	pushl  0x801109f4
801014ab:	ff 35 f0 09 11 80    	pushl  0x801109f0
801014b1:	ff 35 ec 09 11 80    	pushl  0x801109ec
801014b7:	ff 35 e8 09 11 80    	pushl  0x801109e8
801014bd:	ff 35 e4 09 11 80    	pushl  0x801109e4
801014c3:	ff 35 e0 09 11 80    	pushl  0x801109e0
801014c9:	68 64 74 10 80       	push   $0x80107464
801014ce:	e8 8d f1 ff ff       	call   80100660 <cprintf>
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
801014d3:	83 c4 30             	add    $0x30,%esp
801014d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014d9:	c9                   	leave  
801014da:	c3                   	ret    
801014db:	90                   	nop
801014dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014e0 <ialloc>:
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801014e0:	55                   	push   %ebp
801014e1:	89 e5                	mov    %esp,%ebp
801014e3:	57                   	push   %edi
801014e4:	56                   	push   %esi
801014e5:	53                   	push   %ebx
801014e6:	83 ec 1c             	sub    $0x1c,%esp
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014e9:	83 3d e8 09 11 80 01 	cmpl   $0x1,0x801109e8
//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode*
ialloc(uint dev, short type)
{
801014f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801014f3:	8b 75 08             	mov    0x8(%ebp),%esi
801014f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
801014f9:	0f 86 91 00 00 00    	jbe    80101590 <ialloc+0xb0>
801014ff:	bb 01 00 00 00       	mov    $0x1,%ebx
80101504:	eb 21                	jmp    80101527 <ialloc+0x47>
80101506:	8d 76 00             	lea    0x0(%esi),%esi
80101509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101510:	83 ec 0c             	sub    $0xc,%esp
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101513:	83 c3 01             	add    $0x1,%ebx
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
    }
    brelse(bp);
80101516:	57                   	push   %edi
80101517:	e8 c4 ec ff ff       	call   801001e0 <brelse>
{
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
8010151c:	83 c4 10             	add    $0x10,%esp
8010151f:	39 1d e8 09 11 80    	cmp    %ebx,0x801109e8
80101525:	76 69                	jbe    80101590 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101527:	89 d8                	mov    %ebx,%eax
80101529:	83 ec 08             	sub    $0x8,%esp
8010152c:	c1 e8 03             	shr    $0x3,%eax
8010152f:	03 05 f4 09 11 80    	add    0x801109f4,%eax
80101535:	50                   	push   %eax
80101536:	56                   	push   %esi
80101537:	e8 94 eb ff ff       	call   801000d0 <bread>
8010153c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010153e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101540:	83 c4 10             	add    $0x10,%esp
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
    bp = bread(dev, IBLOCK(inum, sb));
    dip = (struct dinode*)bp->data + inum%IPB;
80101543:	83 e0 07             	and    $0x7,%eax
80101546:	c1 e0 06             	shl    $0x6,%eax
80101549:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010154d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101551:	75 bd                	jne    80101510 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101553:	83 ec 04             	sub    $0x4,%esp
80101556:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101559:	6a 40                	push   $0x40
8010155b:	6a 00                	push   $0x0
8010155d:	51                   	push   %ecx
8010155e:	e8 bd 2f 00 00       	call   80104520 <memset>
      dip->type = type;
80101563:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101567:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010156a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010156d:	89 3c 24             	mov    %edi,(%esp)
80101570:	e8 bb 18 00 00       	call   80102e30 <log_write>
      brelse(bp);
80101575:	89 3c 24             	mov    %edi,(%esp)
80101578:	e8 63 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
8010157d:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101580:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
80101583:	89 da                	mov    %ebx,%edx
80101585:	89 f0                	mov    %esi,%eax
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
}
80101587:	5b                   	pop    %ebx
80101588:	5e                   	pop    %esi
80101589:	5f                   	pop    %edi
8010158a:	5d                   	pop    %ebp
    if(dip->type == 0){  // a free inode
      memset(dip, 0, sizeof(*dip));
      dip->type = type;
      log_write(bp);   // mark it allocated on the disk
      brelse(bp);
      return iget(dev, inum);
8010158b:	e9 60 fc ff ff       	jmp    801011f0 <iget>
    }
    brelse(bp);
  }
  panic("ialloc: no inodes");
80101590:	83 ec 0c             	sub    $0xc,%esp
80101593:	68 14 74 10 80       	push   $0x80107414
80101598:	e8 d3 ed ff ff       	call   80100370 <panic>
8010159d:	8d 76 00             	lea    0x0(%esi),%esi

801015a0 <iupdate>:
}

// Copy a modified in-memory inode to disk.
void
iupdate(struct inode *ip)
{
801015a0:	55                   	push   %ebp
801015a1:	89 e5                	mov    %esp,%ebp
801015a3:	56                   	push   %esi
801015a4:	53                   	push   %ebx
801015a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015a8:	83 ec 08             	sub    $0x8,%esp
801015ab:	8b 43 04             	mov    0x4(%ebx),%eax
  dip->type = ip->type;
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ae:	83 c3 5c             	add    $0x5c,%ebx
iupdate(struct inode *ip)
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015b1:	c1 e8 03             	shr    $0x3,%eax
801015b4:	03 05 f4 09 11 80    	add    0x801109f4,%eax
801015ba:	50                   	push   %eax
801015bb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015be:	e8 0d eb ff ff       	call   801000d0 <bread>
801015c3:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015c5:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
801015c8:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  dip->major = ip->major;
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015cc:	83 c4 0c             	add    $0xc,%esp
{
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801015cf:	83 e0 07             	and    $0x7,%eax
801015d2:	c1 e0 06             	shl    $0x6,%eax
801015d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801015d9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801015dc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015e0:	83 c0 0c             	add    $0xc,%eax
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
  dip = (struct dinode*)bp->data + ip->inum%IPB;
  dip->type = ip->type;
  dip->major = ip->major;
801015e3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801015e7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801015eb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801015ef:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801015f3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801015f7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801015fa:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015fd:	6a 34                	push   $0x34
801015ff:	53                   	push   %ebx
80101600:	50                   	push   %eax
80101601:	e8 ca 2f 00 00       	call   801045d0 <memmove>
  log_write(bp);
80101606:	89 34 24             	mov    %esi,(%esp)
80101609:	e8 22 18 00 00       	call   80102e30 <log_write>
  brelse(bp);
8010160e:	89 75 08             	mov    %esi,0x8(%ebp)
80101611:	83 c4 10             	add    $0x10,%esp
}
80101614:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101617:	5b                   	pop    %ebx
80101618:	5e                   	pop    %esi
80101619:	5d                   	pop    %ebp
  dip->minor = ip->minor;
  dip->nlink = ip->nlink;
  dip->size = ip->size;
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
  log_write(bp);
  brelse(bp);
8010161a:	e9 c1 eb ff ff       	jmp    801001e0 <brelse>
8010161f:	90                   	nop

80101620 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
80101620:	55                   	push   %ebp
80101621:	89 e5                	mov    %esp,%ebp
80101623:	53                   	push   %ebx
80101624:	83 ec 10             	sub    $0x10,%esp
80101627:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010162a:	68 00 0a 11 80       	push   $0x80110a00
8010162f:	e8 bc 2c 00 00       	call   801042f0 <acquire>
  ip->ref++;
80101634:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101638:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010163f:	e8 8c 2e 00 00       	call   801044d0 <release>
  return ip;
}
80101644:	89 d8                	mov    %ebx,%eax
80101646:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101649:	c9                   	leave  
8010164a:	c3                   	ret    
8010164b:	90                   	nop
8010164c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101650 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	56                   	push   %esi
80101654:	53                   	push   %ebx
80101655:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101658:	85 db                	test   %ebx,%ebx
8010165a:	0f 84 b4 00 00 00    	je     80101714 <ilock+0xc4>
80101660:	8b 43 08             	mov    0x8(%ebx),%eax
80101663:	85 c0                	test   %eax,%eax
80101665:	0f 8e a9 00 00 00    	jle    80101714 <ilock+0xc4>
    panic("ilock");

  acquiresleep(&ip->lock);
8010166b:	8d 43 0c             	lea    0xc(%ebx),%eax
8010166e:	83 ec 0c             	sub    $0xc,%esp
80101671:	50                   	push   %eax
80101672:	e8 89 2b 00 00       	call   80104200 <acquiresleep>

  if(!(ip->flags & I_VALID)){
80101677:	83 c4 10             	add    $0x10,%esp
8010167a:	f6 43 4c 02          	testb  $0x2,0x4c(%ebx)
8010167e:	74 10                	je     80101690 <ilock+0x40>
    brelse(bp);
    ip->flags |= I_VALID;
    if(ip->type == 0)
      panic("ilock: no type");
  }
}
80101680:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101683:	5b                   	pop    %ebx
80101684:	5e                   	pop    %esi
80101685:	5d                   	pop    %ebp
80101686:	c3                   	ret    
80101687:	89 f6                	mov    %esi,%esi
80101689:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    panic("ilock");

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101690:	8b 43 04             	mov    0x4(%ebx),%eax
80101693:	83 ec 08             	sub    $0x8,%esp
80101696:	c1 e8 03             	shr    $0x3,%eax
80101699:	03 05 f4 09 11 80    	add    0x801109f4,%eax
8010169f:	50                   	push   %eax
801016a0:	ff 33                	pushl  (%ebx)
801016a2:	e8 29 ea ff ff       	call   801000d0 <bread>
801016a7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016a9:	8b 43 04             	mov    0x4(%ebx),%eax
    ip->type = dip->type;
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ac:	83 c4 0c             	add    $0xc,%esp

  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016af:	83 e0 07             	and    $0x7,%eax
801016b2:	c1 e0 06             	shl    $0x6,%eax
801016b5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016b9:	0f b7 10             	movzwl (%eax),%edx
    ip->major = dip->major;
    ip->minor = dip->minor;
    ip->nlink = dip->nlink;
    ip->size = dip->size;
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016bc:	83 c0 0c             	add    $0xc,%eax
  acquiresleep(&ip->lock);

  if(!(ip->flags & I_VALID)){
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    dip = (struct dinode*)bp->data + ip->inum%IPB;
    ip->type = dip->type;
801016bf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801016c3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801016c7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801016cb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801016cf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801016d3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801016d7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801016db:	8b 50 fc             	mov    -0x4(%eax),%edx
801016de:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016e1:	6a 34                	push   $0x34
801016e3:	50                   	push   %eax
801016e4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801016e7:	50                   	push   %eax
801016e8:	e8 e3 2e 00 00       	call   801045d0 <memmove>
    brelse(bp);
801016ed:	89 34 24             	mov    %esi,(%esp)
801016f0:	e8 eb ea ff ff       	call   801001e0 <brelse>
    ip->flags |= I_VALID;
801016f5:	83 4b 4c 02          	orl    $0x2,0x4c(%ebx)
    if(ip->type == 0)
801016f9:	83 c4 10             	add    $0x10,%esp
801016fc:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101701:	0f 85 79 ff ff ff    	jne    80101680 <ilock+0x30>
      panic("ilock: no type");
80101707:	83 ec 0c             	sub    $0xc,%esp
8010170a:	68 2c 74 10 80       	push   $0x8010742c
8010170f:	e8 5c ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101714:	83 ec 0c             	sub    $0xc,%esp
80101717:	68 26 74 10 80       	push   $0x80107426
8010171c:	e8 4f ec ff ff       	call   80100370 <panic>
80101721:	eb 0d                	jmp    80101730 <iunlock>
80101723:	90                   	nop
80101724:	90                   	nop
80101725:	90                   	nop
80101726:	90                   	nop
80101727:	90                   	nop
80101728:	90                   	nop
80101729:	90                   	nop
8010172a:	90                   	nop
8010172b:	90                   	nop
8010172c:	90                   	nop
8010172d:	90                   	nop
8010172e:	90                   	nop
8010172f:	90                   	nop

80101730 <iunlock>:
}

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101730:	55                   	push   %ebp
80101731:	89 e5                	mov    %esp,%ebp
80101733:	56                   	push   %esi
80101734:	53                   	push   %ebx
80101735:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101738:	85 db                	test   %ebx,%ebx
8010173a:	74 28                	je     80101764 <iunlock+0x34>
8010173c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010173f:	83 ec 0c             	sub    $0xc,%esp
80101742:	56                   	push   %esi
80101743:	e8 58 2b 00 00       	call   801042a0 <holdingsleep>
80101748:	83 c4 10             	add    $0x10,%esp
8010174b:	85 c0                	test   %eax,%eax
8010174d:	74 15                	je     80101764 <iunlock+0x34>
8010174f:	8b 43 08             	mov    0x8(%ebx),%eax
80101752:	85 c0                	test   %eax,%eax
80101754:	7e 0e                	jle    80101764 <iunlock+0x34>
    panic("iunlock");

  releasesleep(&ip->lock);
80101756:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101759:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010175c:	5b                   	pop    %ebx
8010175d:	5e                   	pop    %esi
8010175e:	5d                   	pop    %ebp
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");

  releasesleep(&ip->lock);
8010175f:	e9 fc 2a 00 00       	jmp    80104260 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101764:	83 ec 0c             	sub    $0xc,%esp
80101767:	68 3b 74 10 80       	push   $0x8010743b
8010176c:	e8 ff eb ff ff       	call   80100370 <panic>
80101771:	eb 0d                	jmp    80101780 <iput>
80101773:	90                   	nop
80101774:	90                   	nop
80101775:	90                   	nop
80101776:	90                   	nop
80101777:	90                   	nop
80101778:	90                   	nop
80101779:	90                   	nop
8010177a:	90                   	nop
8010177b:	90                   	nop
8010177c:	90                   	nop
8010177d:	90                   	nop
8010177e:	90                   	nop
8010177f:	90                   	nop

80101780 <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101780:	55                   	push   %ebp
80101781:	89 e5                	mov    %esp,%ebp
80101783:	57                   	push   %edi
80101784:	56                   	push   %esi
80101785:	53                   	push   %ebx
80101786:	83 ec 28             	sub    $0x28,%esp
80101789:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&icache.lock);
8010178c:	68 00 0a 11 80       	push   $0x80110a00
80101791:	e8 5a 2b 00 00       	call   801042f0 <acquire>
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
80101796:	8b 46 08             	mov    0x8(%esi),%eax
80101799:	83 c4 10             	add    $0x10,%esp
8010179c:	83 f8 01             	cmp    $0x1,%eax
8010179f:	74 1f                	je     801017c0 <iput+0x40>
    ip->type = 0;
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
801017a1:	83 e8 01             	sub    $0x1,%eax
801017a4:	89 46 08             	mov    %eax,0x8(%esi)
  release(&icache.lock);
801017a7:	c7 45 08 00 0a 11 80 	movl   $0x80110a00,0x8(%ebp)
}
801017ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017b1:	5b                   	pop    %ebx
801017b2:	5e                   	pop    %esi
801017b3:	5f                   	pop    %edi
801017b4:	5d                   	pop    %ebp
    iupdate(ip);
    acquire(&icache.lock);
    ip->flags = 0;
  }
  ip->ref--;
  release(&icache.lock);
801017b5:	e9 16 2d 00 00       	jmp    801044d0 <release>
801017ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// case it has to free the inode.
void
iput(struct inode *ip)
{
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
801017c0:	f6 46 4c 02          	testb  $0x2,0x4c(%esi)
801017c4:	74 db                	je     801017a1 <iput+0x21>
801017c6:	66 83 7e 56 00       	cmpw   $0x0,0x56(%esi)
801017cb:	75 d4                	jne    801017a1 <iput+0x21>
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
801017cd:	83 ec 0c             	sub    $0xc,%esp
801017d0:	8d 5e 5c             	lea    0x5c(%esi),%ebx
801017d3:	8d be 8c 00 00 00    	lea    0x8c(%esi),%edi
801017d9:	68 00 0a 11 80       	push   $0x80110a00
801017de:	e8 ed 2c 00 00       	call   801044d0 <release>
801017e3:	83 c4 10             	add    $0x10,%esp
801017e6:	eb 0f                	jmp    801017f7 <iput+0x77>
801017e8:	90                   	nop
801017e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017f0:	83 c3 04             	add    $0x4,%ebx
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
801017f3:	39 fb                	cmp    %edi,%ebx
801017f5:	74 19                	je     80101810 <iput+0x90>
    if(ip->addrs[i]){
801017f7:	8b 13                	mov    (%ebx),%edx
801017f9:	85 d2                	test   %edx,%edx
801017fb:	74 f3                	je     801017f0 <iput+0x70>
      bfree(ip->dev, ip->addrs[i]);
801017fd:	8b 06                	mov    (%esi),%eax
801017ff:	e8 cc fb ff ff       	call   801013d0 <bfree>
      ip->addrs[i] = 0;
80101804:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010180a:	eb e4                	jmp    801017f0 <iput+0x70>
8010180c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101810:	8b 86 8c 00 00 00    	mov    0x8c(%esi),%eax
80101816:	85 c0                	test   %eax,%eax
80101818:	75 46                	jne    80101860 <iput+0xe0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010181a:	83 ec 0c             	sub    $0xc,%esp
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
8010181d:	c7 46 58 00 00 00 00 	movl   $0x0,0x58(%esi)
  iupdate(ip);
80101824:	56                   	push   %esi
80101825:	e8 76 fd ff ff       	call   801015a0 <iupdate>
  acquire(&icache.lock);
  if(ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0){
    // inode has no links and no other references: truncate and free.
    release(&icache.lock);
    itrunc(ip);
    ip->type = 0;
8010182a:	31 c0                	xor    %eax,%eax
8010182c:	66 89 46 50          	mov    %ax,0x50(%esi)
    iupdate(ip);
80101830:	89 34 24             	mov    %esi,(%esp)
80101833:	e8 68 fd ff ff       	call   801015a0 <iupdate>
    acquire(&icache.lock);
80101838:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010183f:	e8 ac 2a 00 00       	call   801042f0 <acquire>
    ip->flags = 0;
80101844:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
8010184b:	8b 46 08             	mov    0x8(%esi),%eax
8010184e:	83 c4 10             	add    $0x10,%esp
80101851:	e9 4b ff ff ff       	jmp    801017a1 <iput+0x21>
80101856:	8d 76 00             	lea    0x0(%esi),%esi
80101859:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[i] = 0;
    }
  }

  if(ip->addrs[NDIRECT]){
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101860:	83 ec 08             	sub    $0x8,%esp
80101863:	50                   	push   %eax
80101864:	ff 36                	pushl  (%esi)
80101866:	e8 65 e8 ff ff       	call   801000d0 <bread>
8010186b:	83 c4 10             	add    $0x10,%esp
8010186e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
80101871:	8d 58 5c             	lea    0x5c(%eax),%ebx
80101874:	8d b8 5c 02 00 00    	lea    0x25c(%eax),%edi
8010187a:	eb 0b                	jmp    80101887 <iput+0x107>
8010187c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101880:	83 c3 04             	add    $0x4,%ebx
    for(j = 0; j < NINDIRECT; j++){
80101883:	39 df                	cmp    %ebx,%edi
80101885:	74 0f                	je     80101896 <iput+0x116>
      if(a[j])
80101887:	8b 13                	mov    (%ebx),%edx
80101889:	85 d2                	test   %edx,%edx
8010188b:	74 f3                	je     80101880 <iput+0x100>
        bfree(ip->dev, a[j]);
8010188d:	8b 06                	mov    (%esi),%eax
8010188f:	e8 3c fb ff ff       	call   801013d0 <bfree>
80101894:	eb ea                	jmp    80101880 <iput+0x100>
    }
    brelse(bp);
80101896:	83 ec 0c             	sub    $0xc,%esp
80101899:	ff 75 e4             	pushl  -0x1c(%ebp)
8010189c:	e8 3f e9 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018a1:	8b 96 8c 00 00 00    	mov    0x8c(%esi),%edx
801018a7:	8b 06                	mov    (%esi),%eax
801018a9:	e8 22 fb ff ff       	call   801013d0 <bfree>
    ip->addrs[NDIRECT] = 0;
801018ae:	c7 86 8c 00 00 00 00 	movl   $0x0,0x8c(%esi)
801018b5:	00 00 00 
801018b8:	83 c4 10             	add    $0x10,%esp
801018bb:	e9 5a ff ff ff       	jmp    8010181a <iput+0x9a>

801018c0 <iunlockput>:
}

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	53                   	push   %ebx
801018c4:	83 ec 10             	sub    $0x10,%esp
801018c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
801018ca:	53                   	push   %ebx
801018cb:	e8 60 fe ff ff       	call   80101730 <iunlock>
  iput(ip);
801018d0:	89 5d 08             	mov    %ebx,0x8(%ebp)
801018d3:	83 c4 10             	add    $0x10,%esp
}
801018d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018d9:	c9                   	leave  
// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
  iput(ip);
801018da:	e9 a1 fe ff ff       	jmp    80101780 <iput>
801018df:	90                   	nop

801018e0 <stati>:
}

// Copy stat information from inode.
void
stati(struct inode *ip, struct stat *st)
{
801018e0:	55                   	push   %ebp
801018e1:	89 e5                	mov    %esp,%ebp
801018e3:	8b 55 08             	mov    0x8(%ebp),%edx
801018e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
801018e9:	8b 0a                	mov    (%edx),%ecx
801018eb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
801018ee:	8b 4a 04             	mov    0x4(%edx),%ecx
801018f1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801018f4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801018f8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801018fb:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801018ff:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101903:	8b 52 58             	mov    0x58(%edx),%edx
80101906:	89 50 10             	mov    %edx,0x10(%eax)
}
80101909:	5d                   	pop    %ebp
8010190a:	c3                   	ret    
8010190b:	90                   	nop
8010190c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101910 <readi>:

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	57                   	push   %edi
80101914:	56                   	push   %esi
80101915:	53                   	push   %ebx
80101916:	83 ec 1c             	sub    $0x1c,%esp
80101919:	8b 45 08             	mov    0x8(%ebp),%eax
8010191c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010191f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101922:	0f b7 50 50          	movzwl 0x50(%eax),%edx

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101926:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101929:	8b 7d 14             	mov    0x14(%ebp),%edi
8010192c:	89 45 d8             	mov    %eax,-0x28(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
8010192f:	66 83 fa 03          	cmp    $0x3,%dx

//PAGEBREAK!
// Read data from inode.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101933:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101936:	0f 84 b4 00 00 00    	je     801019f0 <readi+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
8010193c:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010193f:	8b 40 58             	mov    0x58(%eax),%eax
80101942:	39 f0                	cmp    %esi,%eax
80101944:	0f 82 ee 00 00 00    	jb     80101a38 <readi+0x128>
8010194a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010194d:	89 fb                	mov    %edi,%ebx
8010194f:	01 f3                	add    %esi,%ebx
80101951:	0f 82 e1 00 00 00    	jb     80101a38 <readi+0x128>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101957:	89 c1                	mov    %eax,%ecx
80101959:	29 f1                	sub    %esi,%ecx
8010195b:	39 d8                	cmp    %ebx,%eax
8010195d:	0f 43 cf             	cmovae %edi,%ecx

  if(ip->type == T_SMALLFILE){
80101960:	66 83 fa 05          	cmp    $0x5,%dx
  }

  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101964:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  if(ip->type == T_SMALLFILE){
80101967:	0f 84 ab 00 00 00    	je     80101a18 <readi+0x108>
    memmove(dst, (char *)(ip->addrs) + off, n);
  } else {
    for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010196d:	31 ff                	xor    %edi,%edi
8010196f:	85 c9                	test   %ecx,%ecx
80101971:	74 68                	je     801019db <readi+0xcb>
80101973:	90                   	nop
80101974:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101978:	8b 5d d8             	mov    -0x28(%ebp),%ebx
8010197b:	89 f2                	mov    %esi,%edx
8010197d:	c1 ea 09             	shr    $0x9,%edx
80101980:	89 d8                	mov    %ebx,%eax
80101982:	e8 39 f9 ff ff       	call   801012c0 <bmap>
80101987:	83 ec 08             	sub    $0x8,%esp
8010198a:	50                   	push   %eax
8010198b:	ff 33                	pushl  (%ebx)
      m = min(n - tot, BSIZE - off%BSIZE);
8010198d:	bb 00 02 00 00       	mov    $0x200,%ebx

  if(ip->type == T_SMALLFILE){
    memmove(dst, (char *)(ip->addrs) + off, n);
  } else {
    for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101992:	e8 39 e7 ff ff       	call   801000d0 <bread>
80101997:	89 c2                	mov    %eax,%edx
      m = min(n - tot, BSIZE - off%BSIZE);
80101999:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010199c:	89 f1                	mov    %esi,%ecx
8010199e:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801019a4:	83 c4 0c             	add    $0xc,%esp
      for (int j = 0; j < min(m, 10); j++) {
        cprintf("%x ", bp->data[off%BSIZE+j]);
      }
      cprintf("\n");
      */
      memmove(dst, bp->data + off%BSIZE, m);
801019a7:	89 55 dc             	mov    %edx,-0x24(%ebp)
  if(ip->type == T_SMALLFILE){
    memmove(dst, (char *)(ip->addrs) + off, n);
  } else {
    for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
      m = min(n - tot, BSIZE - off%BSIZE);
801019aa:	29 cb                	sub    %ecx,%ebx
801019ac:	29 f8                	sub    %edi,%eax
801019ae:	39 c3                	cmp    %eax,%ebx
801019b0:	0f 47 d8             	cmova  %eax,%ebx
      for (int j = 0; j < min(m, 10); j++) {
        cprintf("%x ", bp->data[off%BSIZE+j]);
      }
      cprintf("\n");
      */
      memmove(dst, bp->data + off%BSIZE, m);
801019b3:	8d 44 0a 5c          	lea    0x5c(%edx,%ecx,1),%eax
801019b7:	53                   	push   %ebx
    n = ip->size - off;

  if(ip->type == T_SMALLFILE){
    memmove(dst, (char *)(ip->addrs) + off, n);
  } else {
    for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019b8:	01 df                	add    %ebx,%edi
801019ba:	01 de                	add    %ebx,%esi
      for (int j = 0; j < min(m, 10); j++) {
        cprintf("%x ", bp->data[off%BSIZE+j]);
      }
      cprintf("\n");
      */
      memmove(dst, bp->data + off%BSIZE, m);
801019bc:	50                   	push   %eax
801019bd:	ff 75 e0             	pushl  -0x20(%ebp)
801019c0:	e8 0b 2c 00 00       	call   801045d0 <memmove>
      brelse(bp);
801019c5:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019c8:	89 14 24             	mov    %edx,(%esp)
801019cb:	e8 10 e8 ff ff       	call   801001e0 <brelse>
    n = ip->size - off;

  if(ip->type == T_SMALLFILE){
    memmove(dst, (char *)(ip->addrs) + off, n);
  } else {
    for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019d0:	01 5d e0             	add    %ebx,-0x20(%ebp)
801019d3:	83 c4 10             	add    $0x10,%esp
801019d6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801019d9:	77 9d                	ja     80101978 <readi+0x68>
      */
      memmove(dst, bp->data + off%BSIZE, m);
      brelse(bp);
    }
  }
  return n;
801019db:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
801019de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019e1:	5b                   	pop    %ebx
801019e2:	5e                   	pop    %esi
801019e3:	5f                   	pop    %edi
801019e4:	5d                   	pop    %ebp
801019e5:	c3                   	ret    
801019e6:	8d 76 00             	lea    0x0(%esi),%esi
801019e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
801019f0:	0f bf 40 52          	movswl 0x52(%eax),%eax
801019f4:	66 83 f8 09          	cmp    $0x9,%ax
801019f8:	77 3e                	ja     80101a38 <readi+0x128>
801019fa:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101a01:	85 c0                	test   %eax,%eax
80101a03:	74 33                	je     80101a38 <readi+0x128>
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a05:	89 7d 10             	mov    %edi,0x10(%ebp)
      memmove(dst, bp->data + off%BSIZE, m);
      brelse(bp);
    }
  }
  return n;
}
80101a08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a0b:	5b                   	pop    %ebx
80101a0c:	5e                   	pop    %esi
80101a0d:	5f                   	pop    %edi
80101a0e:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
80101a0f:	ff e0                	jmp    *%eax
80101a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;

  if(ip->type == T_SMALLFILE){
    memmove(dst, (char *)(ip->addrs) + off, n);
80101a18:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a1b:	83 ec 04             	sub    $0x4,%esp
80101a1e:	ff 75 e4             	pushl  -0x1c(%ebp)
80101a21:	8d 44 30 5c          	lea    0x5c(%eax,%esi,1),%eax
80101a25:	50                   	push   %eax
80101a26:	ff 75 e0             	pushl  -0x20(%ebp)
80101a29:	e8 a2 2b 00 00       	call   801045d0 <memmove>
80101a2e:	83 c4 10             	add    $0x10,%esp
80101a31:	eb a8                	jmp    801019db <readi+0xcb>
80101a33:	90                   	nop
80101a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a3d:	eb 9f                	jmp    801019de <readi+0xce>
80101a3f:	90                   	nop

80101a40 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a40:	55                   	push   %ebp
80101a41:	89 e5                	mov    %esp,%ebp
80101a43:	57                   	push   %edi
80101a44:	56                   	push   %esi
80101a45:	53                   	push   %ebx
80101a46:	83 ec 2c             	sub    $0x2c,%esp
80101a49:	8b 45 08             	mov    0x8(%ebp),%eax
80101a4c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101a4f:	8b 75 10             	mov    0x10(%ebp),%esi
80101a52:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a55:	0f b7 40 50          	movzwl 0x50(%eax),%eax

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a59:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101a5c:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a5f:	66 83 f8 03          	cmp    $0x3,%ax

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a63:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a66:	0f 84 f4 00 00 00    	je     80101b60 <writei+0x120>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a6c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80101a6f:	39 71 58             	cmp    %esi,0x58(%ecx)
80101a72:	0f 82 58 01 00 00    	jb     80101bd0 <writei+0x190>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a78:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a7b:	89 fa                	mov    %edi,%edx
80101a7d:	01 f2                	add    %esi,%edx
80101a7f:	0f 82 4b 01 00 00    	jb     80101bd0 <writei+0x190>
80101a85:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101a8b:	0f 87 3f 01 00 00    	ja     80101bd0 <writei+0x190>
    return -1;
if(ip->type == T_SMALLFILE){
80101a91:	66 83 f8 05          	cmp    $0x5,%ax
80101a95:	0f 84 0d 01 00 00    	je     80101ba8 <writei+0x168>
  memmove((char *)(ip->addrs) + off, src, n);
}else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101a9b:	89 fa                	mov    %edi,%edx
80101a9d:	8d 41 5c             	lea    0x5c(%ecx),%eax
80101aa0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80101aa7:	85 d2                	test   %edx,%edx
80101aa9:	89 f7                	mov    %esi,%edi
80101aab:	89 45 d0             	mov    %eax,-0x30(%ebp)
80101aae:	0f 84 97 00 00 00    	je     80101b4b <writei+0x10b>
80101ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ab8:	8b 75 d4             	mov    -0x2c(%ebp),%esi
80101abb:	89 fa                	mov    %edi,%edx
      m = min(n - tot, BSIZE - off%BSIZE);
80101abd:	bb 00 02 00 00       	mov    $0x200,%ebx
    return -1;
if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
}else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac2:	c1 ea 09             	shr    $0x9,%edx
80101ac5:	89 f0                	mov    %esi,%eax
80101ac7:	e8 f4 f7 ff ff       	call   801012c0 <bmap>
80101acc:	83 ec 08             	sub    $0x8,%esp
80101acf:	50                   	push   %eax
80101ad0:	ff 36                	pushl  (%esi)
80101ad2:	e8 f9 e5 ff ff       	call   801000d0 <bread>
      m = min(n - tot, BSIZE - off%BSIZE);
80101ad7:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    return -1;
if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
}else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ada:	89 c6                	mov    %eax,%esi
      m = min(n - tot, BSIZE - off%BSIZE);
80101adc:	83 c4 0c             	add    $0xc,%esp
80101adf:	89 fa                	mov    %edi,%edx
80101ae1:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80101ae7:	89 c8                	mov    %ecx,%eax
80101ae9:	2b 45 e0             	sub    -0x20(%ebp),%eax
      memmove((char *)(ip->addrs) + off, src, n);
80101aec:	51                   	push   %ecx
80101aed:	8b 4d d0             	mov    -0x30(%ebp),%ecx
if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
}else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
      m = min(n - tot, BSIZE - off%BSIZE);
80101af0:	29 d3                	sub    %edx,%ebx
      memmove((char *)(ip->addrs) + off, src, n);
80101af2:	ff 75 dc             	pushl  -0x24(%ebp)
if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
}else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
      m = min(n - tot, BSIZE - off%BSIZE);
80101af5:	89 55 d8             	mov    %edx,-0x28(%ebp)
80101af8:	39 c3                	cmp    %eax,%ebx
80101afa:	0f 47 d8             	cmova  %eax,%ebx
      memmove((char *)(ip->addrs) + off, src, n);
80101afd:	8d 04 39             	lea    (%ecx,%edi,1),%eax
  if(off + n > MAXFILE*BSIZE)
    return -1;
if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
}else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b00:	01 df                	add    %ebx,%edi
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
      m = min(n - tot, BSIZE - off%BSIZE);
      memmove((char *)(ip->addrs) + off, src, n);
80101b02:	50                   	push   %eax
80101b03:	e8 c8 2a 00 00       	call   801045d0 <memmove>
      memmove(bp->data + off%BSIZE, src, m);
80101b08:	8b 55 d8             	mov    -0x28(%ebp),%edx
80101b0b:	83 c4 0c             	add    $0xc,%esp
80101b0e:	53                   	push   %ebx
80101b0f:	ff 75 dc             	pushl  -0x24(%ebp)
80101b12:	8d 44 16 5c          	lea    0x5c(%esi,%edx,1),%eax
80101b16:	50                   	push   %eax
80101b17:	e8 b4 2a 00 00       	call   801045d0 <memmove>
      log_write(bp);
80101b1c:	89 34 24             	mov    %esi,(%esp)
80101b1f:	e8 0c 13 00 00       	call   80102e30 <log_write>
      brelse(bp);
80101b24:	89 34 24             	mov    %esi,(%esp)
80101b27:	e8 b4 e6 ff ff       	call   801001e0 <brelse>
  if(off + n > MAXFILE*BSIZE)
    return -1;
if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
}else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b2c:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101b2f:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b32:	83 c4 10             	add    $0x10,%esp
80101b35:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101b38:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80101b3b:	0f 87 77 ff ff ff    	ja     80101ab8 <writei+0x78>
80101b41:	89 fe                	mov    %edi,%esi
      log_write(bp);
      brelse(bp);
  }
}

  if(n > 0 && off > ip->size){
80101b43:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80101b46:	39 70 58             	cmp    %esi,0x58(%eax)
80101b49:	72 45                	jb     80101b90 <writei+0x150>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b4b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101b4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b51:	5b                   	pop    %ebx
80101b52:	5e                   	pop    %esi
80101b53:	5f                   	pop    %edi
80101b54:	5d                   	pop    %ebp
80101b55:	c3                   	ret    
80101b56:	8d 76 00             	lea    0x0(%esi),%esi
80101b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b60:	8b 7d d4             	mov    -0x2c(%ebp),%edi
80101b63:	0f bf 47 52          	movswl 0x52(%edi),%eax
80101b67:	66 83 f8 09          	cmp    $0x9,%ax
80101b6b:	77 63                	ja     80101bd0 <writei+0x190>
80101b6d:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101b74:	85 c0                	test   %eax,%eax
80101b76:	74 58                	je     80101bd0 <writei+0x190>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b78:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101b7b:	89 4d 10             	mov    %ecx,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b81:	5b                   	pop    %ebx
80101b82:	5e                   	pop    %esi
80101b83:	5f                   	pop    %edi
80101b84:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b85:	ff e0                	jmp    *%eax
80101b87:	89 f6                	mov    %esi,%esi
80101b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
80101b90:	83 ec 0c             	sub    $0xc,%esp
      brelse(bp);
  }
}

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b93:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b96:	50                   	push   %eax
80101b97:	e8 04 fa ff ff       	call   801015a0 <iupdate>
80101b9c:	83 c4 10             	add    $0x10,%esp
80101b9f:	eb aa                	jmp    80101b4b <writei+0x10b>
80101ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(off > ip->size || off + n < off)
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;
if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
80101ba8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80101bab:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101bae:	83 ec 04             	sub    $0x4,%esp
80101bb1:	8d 44 30 5c          	lea    0x5c(%eax,%esi,1),%eax
80101bb5:	57                   	push   %edi
80101bb6:	ff 75 dc             	pushl  -0x24(%ebp)
80101bb9:	50                   	push   %eax
80101bba:	e8 11 2a 00 00       	call   801045d0 <memmove>
      log_write(bp);
      brelse(bp);
  }
}

  if(n > 0 && off > ip->size){
80101bbf:	83 c4 10             	add    $0x10,%esp
80101bc2:	85 ff                	test   %edi,%edi
80101bc4:	74 85                	je     80101b4b <writei+0x10b>
80101bc6:	e9 78 ff ff ff       	jmp    80101b43 <writei+0x103>
80101bcb:	90                   	nop
80101bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101bd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bd5:	e9 74 ff ff ff       	jmp    80101b4e <writei+0x10e>
80101bda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101be0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101be0:	55                   	push   %ebp
80101be1:	89 e5                	mov    %esp,%ebp
80101be3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101be6:	6a 0e                	push   $0xe
80101be8:	ff 75 0c             	pushl  0xc(%ebp)
80101beb:	ff 75 08             	pushl  0x8(%ebp)
80101bee:	e8 5d 2a 00 00       	call   80104650 <strncmp>
}
80101bf3:	c9                   	leave  
80101bf4:	c3                   	ret    
80101bf5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101c00 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101c00:	55                   	push   %ebp
80101c01:	89 e5                	mov    %esp,%ebp
80101c03:	57                   	push   %edi
80101c04:	56                   	push   %esi
80101c05:	53                   	push   %ebx
80101c06:	83 ec 1c             	sub    $0x1c,%esp
80101c09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101c0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101c11:	0f 85 80 00 00 00    	jne    80101c97 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101c17:	8b 53 58             	mov    0x58(%ebx),%edx
80101c1a:	31 ff                	xor    %edi,%edi
80101c1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101c1f:	85 d2                	test   %edx,%edx
80101c21:	75 0d                	jne    80101c30 <dirlookup+0x30>
80101c23:	eb 5b                	jmp    80101c80 <dirlookup+0x80>
80101c25:	8d 76 00             	lea    0x0(%esi),%esi
80101c28:	83 c7 10             	add    $0x10,%edi
80101c2b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101c2e:	76 50                	jbe    80101c80 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c30:	6a 10                	push   $0x10
80101c32:	57                   	push   %edi
80101c33:	56                   	push   %esi
80101c34:	53                   	push   %ebx
80101c35:	e8 d6 fc ff ff       	call   80101910 <readi>
80101c3a:	83 c4 10             	add    $0x10,%esp
80101c3d:	83 f8 10             	cmp    $0x10,%eax
80101c40:	75 48                	jne    80101c8a <dirlookup+0x8a>
      panic("dirlink read");
    if(de.inum == 0)
80101c42:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c47:	74 df                	je     80101c28 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101c49:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c4c:	83 ec 04             	sub    $0x4,%esp
80101c4f:	6a 0e                	push   $0xe
80101c51:	50                   	push   %eax
80101c52:	ff 75 0c             	pushl  0xc(%ebp)
80101c55:	e8 f6 29 00 00       	call   80104650 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101c5a:	83 c4 10             	add    $0x10,%esp
80101c5d:	85 c0                	test   %eax,%eax
80101c5f:	75 c7                	jne    80101c28 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c61:	8b 45 10             	mov    0x10(%ebp),%eax
80101c64:	85 c0                	test   %eax,%eax
80101c66:	74 05                	je     80101c6d <dirlookup+0x6d>
        *poff = off;
80101c68:	8b 45 10             	mov    0x10(%ebp),%eax
80101c6b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101c6d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c71:	8b 03                	mov    (%ebx),%eax
80101c73:	e8 78 f5 ff ff       	call   801011f0 <iget>
    }
  }

  return 0;
}
80101c78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c7b:	5b                   	pop    %ebx
80101c7c:	5e                   	pop    %esi
80101c7d:	5f                   	pop    %edi
80101c7e:	5d                   	pop    %ebp
80101c7f:	c3                   	ret    
80101c80:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c83:	31 c0                	xor    %eax,%eax
}
80101c85:	5b                   	pop    %ebx
80101c86:	5e                   	pop    %esi
80101c87:	5f                   	pop    %edi
80101c88:	5d                   	pop    %ebp
80101c89:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101c8a:	83 ec 0c             	sub    $0xc,%esp
80101c8d:	68 55 74 10 80       	push   $0x80107455
80101c92:	e8 d9 e6 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c97:	83 ec 0c             	sub    $0xc,%esp
80101c9a:	68 43 74 10 80       	push   $0x80107443
80101c9f:	e8 cc e6 ff ff       	call   80100370 <panic>
80101ca4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101caa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101cb0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	57                   	push   %edi
80101cb4:	56                   	push   %esi
80101cb5:	53                   	push   %ebx
80101cb6:	89 cf                	mov    %ecx,%edi
80101cb8:	89 c3                	mov    %eax,%ebx
80101cba:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101cbd:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101cc0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101cc3:	0f 84 53 01 00 00    	je     80101e1c <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101cc9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101ccf:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101cd2:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101cd5:	68 00 0a 11 80       	push   $0x80110a00
80101cda:	e8 11 26 00 00       	call   801042f0 <acquire>
  ip->ref++;
80101cdf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ce3:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101cea:	e8 e1 27 00 00       	call   801044d0 <release>
80101cef:	83 c4 10             	add    $0x10,%esp
80101cf2:	eb 07                	jmp    80101cfb <namex+0x4b>
80101cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101cf8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101cfb:	0f b6 03             	movzbl (%ebx),%eax
80101cfe:	3c 2f                	cmp    $0x2f,%al
80101d00:	74 f6                	je     80101cf8 <namex+0x48>
    path++;
  if(*path == 0)
80101d02:	84 c0                	test   %al,%al
80101d04:	0f 84 e3 00 00 00    	je     80101ded <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d0a:	0f b6 03             	movzbl (%ebx),%eax
80101d0d:	89 da                	mov    %ebx,%edx
80101d0f:	84 c0                	test   %al,%al
80101d11:	0f 84 ac 00 00 00    	je     80101dc3 <namex+0x113>
80101d17:	3c 2f                	cmp    $0x2f,%al
80101d19:	75 09                	jne    80101d24 <namex+0x74>
80101d1b:	e9 a3 00 00 00       	jmp    80101dc3 <namex+0x113>
80101d20:	84 c0                	test   %al,%al
80101d22:	74 0a                	je     80101d2e <namex+0x7e>
    path++;
80101d24:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d27:	0f b6 02             	movzbl (%edx),%eax
80101d2a:	3c 2f                	cmp    $0x2f,%al
80101d2c:	75 f2                	jne    80101d20 <namex+0x70>
80101d2e:	89 d1                	mov    %edx,%ecx
80101d30:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101d32:	83 f9 0d             	cmp    $0xd,%ecx
80101d35:	0f 8e 8d 00 00 00    	jle    80101dc8 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d3b:	83 ec 04             	sub    $0x4,%esp
80101d3e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d41:	6a 0e                	push   $0xe
80101d43:	53                   	push   %ebx
80101d44:	57                   	push   %edi
80101d45:	e8 86 28 00 00       	call   801045d0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d4a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101d4d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d50:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d52:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d55:	75 11                	jne    80101d68 <namex+0xb8>
80101d57:	89 f6                	mov    %esi,%esi
80101d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d60:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d63:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d66:	74 f8                	je     80101d60 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d68:	83 ec 0c             	sub    $0xc,%esp
80101d6b:	56                   	push   %esi
80101d6c:	e8 df f8 ff ff       	call   80101650 <ilock>
    if(ip->type != T_DIR){
80101d71:	83 c4 10             	add    $0x10,%esp
80101d74:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d79:	0f 85 7f 00 00 00    	jne    80101dfe <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d7f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d82:	85 d2                	test   %edx,%edx
80101d84:	74 09                	je     80101d8f <namex+0xdf>
80101d86:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d89:	0f 84 a3 00 00 00    	je     80101e32 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d8f:	83 ec 04             	sub    $0x4,%esp
80101d92:	6a 00                	push   $0x0
80101d94:	57                   	push   %edi
80101d95:	56                   	push   %esi
80101d96:	e8 65 fe ff ff       	call   80101c00 <dirlookup>
80101d9b:	83 c4 10             	add    $0x10,%esp
80101d9e:	85 c0                	test   %eax,%eax
80101da0:	74 5c                	je     80101dfe <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101da2:	83 ec 0c             	sub    $0xc,%esp
80101da5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101da8:	56                   	push   %esi
80101da9:	e8 82 f9 ff ff       	call   80101730 <iunlock>
  iput(ip);
80101dae:	89 34 24             	mov    %esi,(%esp)
80101db1:	e8 ca f9 ff ff       	call   80101780 <iput>
80101db6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101db9:	83 c4 10             	add    $0x10,%esp
80101dbc:	89 c6                	mov    %eax,%esi
80101dbe:	e9 38 ff ff ff       	jmp    80101cfb <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101dc3:	31 c9                	xor    %ecx,%ecx
80101dc5:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101dc8:	83 ec 04             	sub    $0x4,%esp
80101dcb:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dce:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101dd1:	51                   	push   %ecx
80101dd2:	53                   	push   %ebx
80101dd3:	57                   	push   %edi
80101dd4:	e8 f7 27 00 00       	call   801045d0 <memmove>
    name[len] = 0;
80101dd9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101ddc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101ddf:	83 c4 10             	add    $0x10,%esp
80101de2:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101de6:	89 d3                	mov    %edx,%ebx
80101de8:	e9 65 ff ff ff       	jmp    80101d52 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101ded:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101df0:	85 c0                	test   %eax,%eax
80101df2:	75 54                	jne    80101e48 <namex+0x198>
80101df4:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101df6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101df9:	5b                   	pop    %ebx
80101dfa:	5e                   	pop    %esi
80101dfb:	5f                   	pop    %edi
80101dfc:	5d                   	pop    %ebp
80101dfd:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101dfe:	83 ec 0c             	sub    $0xc,%esp
80101e01:	56                   	push   %esi
80101e02:	e8 29 f9 ff ff       	call   80101730 <iunlock>
  iput(ip);
80101e07:	89 34 24             	mov    %esi,(%esp)
80101e0a:	e8 71 f9 ff ff       	call   80101780 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101e0f:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e12:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101e15:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e17:	5b                   	pop    %ebx
80101e18:	5e                   	pop    %esi
80101e19:	5f                   	pop    %edi
80101e1a:	5d                   	pop    %ebp
80101e1b:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101e1c:	ba 01 00 00 00       	mov    $0x1,%edx
80101e21:	b8 01 00 00 00       	mov    $0x1,%eax
80101e26:	e8 c5 f3 ff ff       	call   801011f0 <iget>
80101e2b:	89 c6                	mov    %eax,%esi
80101e2d:	e9 c9 fe ff ff       	jmp    80101cfb <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101e32:	83 ec 0c             	sub    $0xc,%esp
80101e35:	56                   	push   %esi
80101e36:	e8 f5 f8 ff ff       	call   80101730 <iunlock>
      return ip;
80101e3b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101e41:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e43:	5b                   	pop    %ebx
80101e44:	5e                   	pop    %esi
80101e45:	5f                   	pop    %edi
80101e46:	5d                   	pop    %ebp
80101e47:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e48:	83 ec 0c             	sub    $0xc,%esp
80101e4b:	56                   	push   %esi
80101e4c:	e8 2f f9 ff ff       	call   80101780 <iput>
    return 0;
80101e51:	83 c4 10             	add    $0x10,%esp
80101e54:	31 c0                	xor    %eax,%eax
80101e56:	eb 9e                	jmp    80101df6 <namex+0x146>
80101e58:	90                   	nop
80101e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e60 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101e60:	55                   	push   %ebp
80101e61:	89 e5                	mov    %esp,%ebp
80101e63:	57                   	push   %edi
80101e64:	56                   	push   %esi
80101e65:	53                   	push   %ebx
80101e66:	83 ec 20             	sub    $0x20,%esp
80101e69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e6c:	6a 00                	push   $0x0
80101e6e:	ff 75 0c             	pushl  0xc(%ebp)
80101e71:	53                   	push   %ebx
80101e72:	e8 89 fd ff ff       	call   80101c00 <dirlookup>
80101e77:	83 c4 10             	add    $0x10,%esp
80101e7a:	85 c0                	test   %eax,%eax
80101e7c:	75 67                	jne    80101ee5 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e7e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e81:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e84:	85 ff                	test   %edi,%edi
80101e86:	74 29                	je     80101eb1 <dirlink+0x51>
80101e88:	31 ff                	xor    %edi,%edi
80101e8a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e8d:	eb 09                	jmp    80101e98 <dirlink+0x38>
80101e8f:	90                   	nop
80101e90:	83 c7 10             	add    $0x10,%edi
80101e93:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e96:	76 19                	jbe    80101eb1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e98:	6a 10                	push   $0x10
80101e9a:	57                   	push   %edi
80101e9b:	56                   	push   %esi
80101e9c:	53                   	push   %ebx
80101e9d:	e8 6e fa ff ff       	call   80101910 <readi>
80101ea2:	83 c4 10             	add    $0x10,%esp
80101ea5:	83 f8 10             	cmp    $0x10,%eax
80101ea8:	75 4e                	jne    80101ef8 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101eaa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101eaf:	75 df                	jne    80101e90 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101eb1:	8d 45 da             	lea    -0x26(%ebp),%eax
80101eb4:	83 ec 04             	sub    $0x4,%esp
80101eb7:	6a 0e                	push   $0xe
80101eb9:	ff 75 0c             	pushl  0xc(%ebp)
80101ebc:	50                   	push   %eax
80101ebd:	e8 fe 27 00 00       	call   801046c0 <strncpy>
  de.inum = inum;
80101ec2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ec5:	6a 10                	push   $0x10
80101ec7:	57                   	push   %edi
80101ec8:	56                   	push   %esi
80101ec9:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101eca:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ece:	e8 6d fb ff ff       	call   80101a40 <writei>
80101ed3:	83 c4 20             	add    $0x20,%esp
80101ed6:	83 f8 10             	cmp    $0x10,%eax
80101ed9:	75 2a                	jne    80101f05 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101edb:	31 c0                	xor    %eax,%eax
}
80101edd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ee0:	5b                   	pop    %ebx
80101ee1:	5e                   	pop    %esi
80101ee2:	5f                   	pop    %edi
80101ee3:	5d                   	pop    %ebp
80101ee4:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	50                   	push   %eax
80101ee9:	e8 92 f8 ff ff       	call   80101780 <iput>
    return -1;
80101eee:	83 c4 10             	add    $0x10,%esp
80101ef1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ef6:	eb e5                	jmp    80101edd <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101ef8:	83 ec 0c             	sub    $0xc,%esp
80101efb:	68 55 74 10 80       	push   $0x80107455
80101f00:	e8 6b e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101f05:	83 ec 0c             	sub    $0xc,%esp
80101f08:	68 2a 7a 10 80       	push   $0x80107a2a
80101f0d:	e8 5e e4 ff ff       	call   80100370 <panic>
80101f12:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101f20:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f21:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101f23:	89 e5                	mov    %esp,%ebp
80101f25:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f28:	8b 45 08             	mov    0x8(%ebp),%eax
80101f2b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f2e:	e8 7d fd ff ff       	call   80101cb0 <namex>
}
80101f33:	c9                   	leave  
80101f34:	c3                   	ret    
80101f35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f40 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f40:	55                   	push   %ebp
  return namex(path, 1, name);
80101f41:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101f46:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f48:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f4e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101f4f:	e9 5c fd ff ff       	jmp    80101cb0 <namex>
80101f54:	66 90                	xchg   %ax,%ax
80101f56:	66 90                	xchg   %ax,%ax
80101f58:	66 90                	xchg   %ax,%ax
80101f5a:	66 90                	xchg   %ax,%ax
80101f5c:	66 90                	xchg   %ax,%ax
80101f5e:	66 90                	xchg   %ax,%ax

80101f60 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f60:	55                   	push   %ebp
  if(b == 0)
80101f61:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f63:	89 e5                	mov    %esp,%ebp
80101f65:	56                   	push   %esi
80101f66:	53                   	push   %ebx
  if(b == 0)
80101f67:	0f 84 ad 00 00 00    	je     8010201a <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f6d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f70:	89 c1                	mov    %eax,%ecx
80101f72:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f78:	0f 87 8f 00 00 00    	ja     8010200d <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f7e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f83:	90                   	nop
80101f84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f88:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f89:	83 e0 c0             	and    $0xffffffc0,%eax
80101f8c:	3c 40                	cmp    $0x40,%al
80101f8e:	75 f8                	jne    80101f88 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f90:	31 f6                	xor    %esi,%esi
80101f92:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f97:	89 f0                	mov    %esi,%eax
80101f99:	ee                   	out    %al,(%dx)
80101f9a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f9f:	b8 01 00 00 00       	mov    $0x1,%eax
80101fa4:	ee                   	out    %al,(%dx)
80101fa5:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101faa:	89 d8                	mov    %ebx,%eax
80101fac:	ee                   	out    %al,(%dx)
80101fad:	89 d8                	mov    %ebx,%eax
80101faf:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101fb4:	c1 f8 08             	sar    $0x8,%eax
80101fb7:	ee                   	out    %al,(%dx)
80101fb8:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fbd:	89 f0                	mov    %esi,%eax
80101fbf:	ee                   	out    %al,(%dx)
80101fc0:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101fc4:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fc9:	83 e0 01             	and    $0x1,%eax
80101fcc:	c1 e0 04             	shl    $0x4,%eax
80101fcf:	83 c8 e0             	or     $0xffffffe0,%eax
80101fd2:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101fd3:	f6 01 04             	testb  $0x4,(%ecx)
80101fd6:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fdb:	75 13                	jne    80101ff0 <idestart+0x90>
80101fdd:	b8 20 00 00 00       	mov    $0x20,%eax
80101fe2:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fe3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fe6:	5b                   	pop    %ebx
80101fe7:	5e                   	pop    %esi
80101fe8:	5d                   	pop    %ebp
80101fe9:	c3                   	ret    
80101fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ff0:	b8 30 00 00 00       	mov    $0x30,%eax
80101ff5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101ff6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101ffb:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101ffe:	b9 80 00 00 00       	mov    $0x80,%ecx
80102003:	fc                   	cld    
80102004:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102006:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102009:	5b                   	pop    %ebx
8010200a:	5e                   	pop    %esi
8010200b:	5d                   	pop    %ebp
8010200c:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
8010200d:	83 ec 0c             	sub    $0xc,%esp
80102010:	68 c0 74 10 80       	push   $0x801074c0
80102015:	e8 56 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
8010201a:	83 ec 0c             	sub    $0xc,%esp
8010201d:	68 b7 74 10 80       	push   $0x801074b7
80102022:	e8 49 e3 ff ff       	call   80100370 <panic>
80102027:	89 f6                	mov    %esi,%esi
80102029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102030 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102030:	55                   	push   %ebp
80102031:	89 e5                	mov    %esp,%ebp
80102033:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102036:	68 d2 74 10 80       	push   $0x801074d2
8010203b:	68 80 a5 10 80       	push   $0x8010a580
80102040:	e8 8b 22 00 00       	call   801042d0 <initlock>
  picenable(IRQ_IDE);
80102045:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
8010204c:	e8 cf 12 00 00       	call   80103320 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102051:	58                   	pop    %eax
80102052:	a1 80 2d 11 80       	mov    0x80112d80,%eax
80102057:	5a                   	pop    %edx
80102058:	83 e8 01             	sub    $0x1,%eax
8010205b:	50                   	push   %eax
8010205c:	6a 0e                	push   $0xe
8010205e:	e8 bd 02 00 00       	call   80102320 <ioapicenable>
80102063:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102066:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010206b:	90                   	nop
8010206c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102070:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102071:	83 e0 c0             	and    $0xffffffc0,%eax
80102074:	3c 40                	cmp    $0x40,%al
80102076:	75 f8                	jne    80102070 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102078:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010207d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102082:	ee                   	out    %al,(%dx)
80102083:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102088:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010208d:	eb 06                	jmp    80102095 <ideinit+0x65>
8010208f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102090:	83 e9 01             	sub    $0x1,%ecx
80102093:	74 0f                	je     801020a4 <ideinit+0x74>
80102095:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102096:	84 c0                	test   %al,%al
80102098:	74 f6                	je     80102090 <ideinit+0x60>
      havedisk1 = 1;
8010209a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
801020a1:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801020a4:	ba f6 01 00 00       	mov    $0x1f6,%edx
801020a9:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801020ae:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
801020af:	c9                   	leave  
801020b0:	c3                   	ret    
801020b1:	eb 0d                	jmp    801020c0 <ideintr>
801020b3:	90                   	nop
801020b4:	90                   	nop
801020b5:	90                   	nop
801020b6:	90                   	nop
801020b7:	90                   	nop
801020b8:	90                   	nop
801020b9:	90                   	nop
801020ba:	90                   	nop
801020bb:	90                   	nop
801020bc:	90                   	nop
801020bd:	90                   	nop
801020be:	90                   	nop
801020bf:	90                   	nop

801020c0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
801020c0:	55                   	push   %ebp
801020c1:	89 e5                	mov    %esp,%ebp
801020c3:	57                   	push   %edi
801020c4:	56                   	push   %esi
801020c5:	53                   	push   %ebx
801020c6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020c9:	68 80 a5 10 80       	push   $0x8010a580
801020ce:	e8 1d 22 00 00       	call   801042f0 <acquire>
  if((b = idequeue) == 0){
801020d3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020d9:	83 c4 10             	add    $0x10,%esp
801020dc:	85 db                	test   %ebx,%ebx
801020de:	74 34                	je     80102114 <ideintr+0x54>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
801020e0:	8b 43 58             	mov    0x58(%ebx),%eax
801020e3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020e8:	8b 33                	mov    (%ebx),%esi
801020ea:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020f0:	74 3e                	je     80102130 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020f2:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801020f5:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020f8:	83 ce 02             	or     $0x2,%esi
801020fb:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020fd:	53                   	push   %ebx
801020fe:	e8 0d 1f 00 00       	call   80104010 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102103:	a1 64 a5 10 80       	mov    0x8010a564,%eax
80102108:	83 c4 10             	add    $0x10,%esp
8010210b:	85 c0                	test   %eax,%eax
8010210d:	74 05                	je     80102114 <ideintr+0x54>
    idestart(idequeue);
8010210f:	e8 4c fe ff ff       	call   80101f60 <idestart>
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
80102114:	83 ec 0c             	sub    $0xc,%esp
80102117:	68 80 a5 10 80       	push   $0x8010a580
8010211c:	e8 af 23 00 00       	call   801044d0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102121:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102124:	5b                   	pop    %ebx
80102125:	5e                   	pop    %esi
80102126:	5f                   	pop    %edi
80102127:	5d                   	pop    %ebp
80102128:	c3                   	ret    
80102129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102130:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102135:	8d 76 00             	lea    0x0(%esi),%esi
80102138:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102139:	89 c1                	mov    %eax,%ecx
8010213b:	83 e1 c0             	and    $0xffffffc0,%ecx
8010213e:	80 f9 40             	cmp    $0x40,%cl
80102141:	75 f5                	jne    80102138 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102143:	a8 21                	test   $0x21,%al
80102145:	75 ab                	jne    801020f2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102147:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010214a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010214f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102154:	fc                   	cld    
80102155:	f3 6d                	rep insl (%dx),%es:(%edi)
80102157:	8b 33                	mov    (%ebx),%esi
80102159:	eb 97                	jmp    801020f2 <ideintr+0x32>
8010215b:	90                   	nop
8010215c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102160 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102160:	55                   	push   %ebp
80102161:	89 e5                	mov    %esp,%ebp
80102163:	53                   	push   %ebx
80102164:	83 ec 10             	sub    $0x10,%esp
80102167:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010216a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010216d:	50                   	push   %eax
8010216e:	e8 2d 21 00 00       	call   801042a0 <holdingsleep>
80102173:	83 c4 10             	add    $0x10,%esp
80102176:	85 c0                	test   %eax,%eax
80102178:	0f 84 ad 00 00 00    	je     8010222b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010217e:	8b 03                	mov    (%ebx),%eax
80102180:	83 e0 06             	and    $0x6,%eax
80102183:	83 f8 02             	cmp    $0x2,%eax
80102186:	0f 84 b9 00 00 00    	je     80102245 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010218c:	8b 53 04             	mov    0x4(%ebx),%edx
8010218f:	85 d2                	test   %edx,%edx
80102191:	74 0d                	je     801021a0 <iderw+0x40>
80102193:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102198:	85 c0                	test   %eax,%eax
8010219a:	0f 84 98 00 00 00    	je     80102238 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801021a0:	83 ec 0c             	sub    $0xc,%esp
801021a3:	68 80 a5 10 80       	push   $0x8010a580
801021a8:	e8 43 21 00 00       	call   801042f0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021ad:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
801021b3:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
801021b6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021bd:	85 d2                	test   %edx,%edx
801021bf:	75 09                	jne    801021ca <iderw+0x6a>
801021c1:	eb 58                	jmp    8010221b <iderw+0xbb>
801021c3:	90                   	nop
801021c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021c8:	89 c2                	mov    %eax,%edx
801021ca:	8b 42 58             	mov    0x58(%edx),%eax
801021cd:	85 c0                	test   %eax,%eax
801021cf:	75 f7                	jne    801021c8 <iderw+0x68>
801021d1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021d4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021d6:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
801021dc:	74 44                	je     80102222 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021de:	8b 03                	mov    (%ebx),%eax
801021e0:	83 e0 06             	and    $0x6,%eax
801021e3:	83 f8 02             	cmp    $0x2,%eax
801021e6:	74 23                	je     8010220b <iderw+0xab>
801021e8:	90                   	nop
801021e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021f0:	83 ec 08             	sub    $0x8,%esp
801021f3:	68 80 a5 10 80       	push   $0x8010a580
801021f8:	53                   	push   %ebx
801021f9:	e8 72 1c 00 00       	call   80103e70 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021fe:	8b 03                	mov    (%ebx),%eax
80102200:	83 c4 10             	add    $0x10,%esp
80102203:	83 e0 06             	and    $0x6,%eax
80102206:	83 f8 02             	cmp    $0x2,%eax
80102209:	75 e5                	jne    801021f0 <iderw+0x90>
    sleep(b, &idelock);
  }

  release(&idelock);
8010220b:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
80102212:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102215:	c9                   	leave  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
80102216:	e9 b5 22 00 00       	jmp    801044d0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010221b:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102220:	eb b2                	jmp    801021d4 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102222:	89 d8                	mov    %ebx,%eax
80102224:	e8 37 fd ff ff       	call   80101f60 <idestart>
80102229:	eb b3                	jmp    801021de <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010222b:	83 ec 0c             	sub    $0xc,%esp
8010222e:	68 d6 74 10 80       	push   $0x801074d6
80102233:	e8 38 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102238:	83 ec 0c             	sub    $0xc,%esp
8010223b:	68 01 75 10 80       	push   $0x80107501
80102240:	e8 2b e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102245:	83 ec 0c             	sub    $0xc,%esp
80102248:	68 ec 74 10 80       	push   $0x801074ec
8010224d:	e8 1e e1 ff ff       	call   80100370 <panic>
80102252:	66 90                	xchg   %ax,%ax
80102254:	66 90                	xchg   %ax,%ax
80102256:	66 90                	xchg   %ax,%ax
80102258:	66 90                	xchg   %ax,%ax
8010225a:	66 90                	xchg   %ax,%ax
8010225c:	66 90                	xchg   %ax,%ax
8010225e:	66 90                	xchg   %ax,%ax

80102260 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
80102260:	a1 84 27 11 80       	mov    0x80112784,%eax
80102265:	85 c0                	test   %eax,%eax
80102267:	0f 84 a8 00 00 00    	je     80102315 <ioapicinit+0xb5>
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010226d:	55                   	push   %ebp
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
8010226e:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
80102275:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102278:	89 e5                	mov    %esp,%ebp
8010227a:	56                   	push   %esi
8010227b:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010227c:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102283:	00 00 00 
  return ioapic->data;
80102286:	8b 15 54 26 11 80    	mov    0x80112654,%edx
8010228c:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010228f:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102295:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010229b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801022a2:	89 f0                	mov    %esi,%eax
801022a4:	c1 e8 10             	shr    $0x10,%eax
801022a7:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
801022aa:	8b 41 10             	mov    0x10(%ecx),%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801022ad:	c1 e8 18             	shr    $0x18,%eax
801022b0:	39 d0                	cmp    %edx,%eax
801022b2:	74 16                	je     801022ca <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801022b4:	83 ec 0c             	sub    $0xc,%esp
801022b7:	68 20 75 10 80       	push   $0x80107520
801022bc:	e8 9f e3 ff ff       	call   80100660 <cprintf>
801022c1:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801022c7:	83 c4 10             	add    $0x10,%esp
801022ca:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022cd:	ba 10 00 00 00       	mov    $0x10,%edx
801022d2:	b8 20 00 00 00       	mov    $0x20,%eax
801022d7:	89 f6                	mov    %esi,%esi
801022d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022e0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022e2:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022e8:	89 c3                	mov    %eax,%ebx
801022ea:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801022f0:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022f3:	89 59 10             	mov    %ebx,0x10(%ecx)
801022f6:	8d 5a 01             	lea    0x1(%edx),%ebx
801022f9:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022fc:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022fe:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
80102300:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
80102306:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
8010230d:	75 d1                	jne    801022e0 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010230f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102312:	5b                   	pop    %ebx
80102313:	5e                   	pop    %esi
80102314:	5d                   	pop    %ebp
80102315:	f3 c3                	repz ret 
80102317:	89 f6                	mov    %esi,%esi
80102319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102320 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102320:	8b 15 84 27 11 80    	mov    0x80112784,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102326:	55                   	push   %ebp
80102327:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102329:	85 d2                	test   %edx,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
8010232b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010232e:	74 2b                	je     8010235b <ioapicenable+0x3b>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102330:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102336:	8d 50 20             	lea    0x20(%eax),%edx
80102339:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010233d:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010233f:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102345:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102348:	89 51 10             	mov    %edx,0x10(%ecx)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010234b:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010234e:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102350:	a1 54 26 11 80       	mov    0x80112654,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102355:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102358:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
8010235b:	5d                   	pop    %ebp
8010235c:	c3                   	ret    
8010235d:	66 90                	xchg   %ax,%ax
8010235f:	90                   	nop

80102360 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102360:	55                   	push   %ebp
80102361:	89 e5                	mov    %esp,%ebp
80102363:	53                   	push   %ebx
80102364:	83 ec 04             	sub    $0x4,%esp
80102367:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010236a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102370:	75 70                	jne    801023e2 <kfree+0x82>
80102372:	81 fb e8 55 11 80    	cmp    $0x801155e8,%ebx
80102378:	72 68                	jb     801023e2 <kfree+0x82>
8010237a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102380:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102385:	77 5b                	ja     801023e2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102387:	83 ec 04             	sub    $0x4,%esp
8010238a:	68 00 10 00 00       	push   $0x1000
8010238f:	6a 01                	push   $0x1
80102391:	53                   	push   %ebx
80102392:	e8 89 21 00 00       	call   80104520 <memset>

  if(kmem.use_lock)
80102397:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010239d:	83 c4 10             	add    $0x10,%esp
801023a0:	85 d2                	test   %edx,%edx
801023a2:	75 2c                	jne    801023d0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801023a4:	a1 98 26 11 80       	mov    0x80112698,%eax
801023a9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801023ab:	a1 94 26 11 80       	mov    0x80112694,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
801023b0:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
801023b6:	85 c0                	test   %eax,%eax
801023b8:	75 06                	jne    801023c0 <kfree+0x60>
    release(&kmem.lock);
}
801023ba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023bd:	c9                   	leave  
801023be:	c3                   	ret    
801023bf:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801023c0:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
801023c7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023ca:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801023cb:	e9 00 21 00 00       	jmp    801044d0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
801023d0:	83 ec 0c             	sub    $0xc,%esp
801023d3:	68 60 26 11 80       	push   $0x80112660
801023d8:	e8 13 1f 00 00       	call   801042f0 <acquire>
801023dd:	83 c4 10             	add    $0x10,%esp
801023e0:	eb c2                	jmp    801023a4 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801023e2:	83 ec 0c             	sub    $0xc,%esp
801023e5:	68 52 75 10 80       	push   $0x80107552
801023ea:	e8 81 df ff ff       	call   80100370 <panic>
801023ef:	90                   	nop

801023f0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023f0:	55                   	push   %ebp
801023f1:	89 e5                	mov    %esp,%ebp
801023f3:	56                   	push   %esi
801023f4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023f5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023fb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102401:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102407:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010240d:	39 de                	cmp    %ebx,%esi
8010240f:	72 23                	jb     80102434 <freerange+0x44>
80102411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102418:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
8010241e:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102421:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102427:	50                   	push   %eax
80102428:	e8 33 ff ff ff       	call   80102360 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010242d:	83 c4 10             	add    $0x10,%esp
80102430:	39 f3                	cmp    %esi,%ebx
80102432:	76 e4                	jbe    80102418 <freerange+0x28>
    kfree(p);
}
80102434:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102437:	5b                   	pop    %ebx
80102438:	5e                   	pop    %esi
80102439:	5d                   	pop    %ebp
8010243a:	c3                   	ret    
8010243b:	90                   	nop
8010243c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102440 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102440:	55                   	push   %ebp
80102441:	89 e5                	mov    %esp,%ebp
80102443:	56                   	push   %esi
80102444:	53                   	push   %ebx
80102445:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102448:	83 ec 08             	sub    $0x8,%esp
8010244b:	68 58 75 10 80       	push   $0x80107558
80102450:	68 60 26 11 80       	push   $0x80112660
80102455:	e8 76 1e 00 00       	call   801042d0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010245a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010245d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102460:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102467:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010246a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102470:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102476:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010247c:	39 de                	cmp    %ebx,%esi
8010247e:	72 1c                	jb     8010249c <kinit1+0x5c>
    kfree(p);
80102480:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102486:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102489:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010248f:	50                   	push   %eax
80102490:	e8 cb fe ff ff       	call   80102360 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102495:	83 c4 10             	add    $0x10,%esp
80102498:	39 de                	cmp    %ebx,%esi
8010249a:	73 e4                	jae    80102480 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010249c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010249f:	5b                   	pop    %ebx
801024a0:	5e                   	pop    %esi
801024a1:	5d                   	pop    %ebp
801024a2:	c3                   	ret    
801024a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801024a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024b0 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	56                   	push   %esi
801024b4:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024b5:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
801024b8:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801024bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024cd:	39 de                	cmp    %ebx,%esi
801024cf:	72 23                	jb     801024f4 <kinit2+0x44>
801024d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024d8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024de:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024e7:	50                   	push   %eax
801024e8:	e8 73 fe ff ff       	call   80102360 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024ed:	83 c4 10             	add    $0x10,%esp
801024f0:	39 de                	cmp    %ebx,%esi
801024f2:	73 e4                	jae    801024d8 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801024f4:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801024fb:	00 00 00 
}
801024fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102501:	5b                   	pop    %ebx
80102502:	5e                   	pop    %esi
80102503:	5d                   	pop    %ebp
80102504:	c3                   	ret    
80102505:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102509:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102510 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102510:	55                   	push   %ebp
80102511:	89 e5                	mov    %esp,%ebp
80102513:	53                   	push   %ebx
80102514:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102517:	a1 94 26 11 80       	mov    0x80112694,%eax
8010251c:	85 c0                	test   %eax,%eax
8010251e:	75 30                	jne    80102550 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102520:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102526:	85 db                	test   %ebx,%ebx
80102528:	74 1c                	je     80102546 <kalloc+0x36>
    kmem.freelist = r->next;
8010252a:	8b 13                	mov    (%ebx),%edx
8010252c:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
80102532:	85 c0                	test   %eax,%eax
80102534:	74 10                	je     80102546 <kalloc+0x36>
    release(&kmem.lock);
80102536:	83 ec 0c             	sub    $0xc,%esp
80102539:	68 60 26 11 80       	push   $0x80112660
8010253e:	e8 8d 1f 00 00       	call   801044d0 <release>
80102543:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102546:	89 d8                	mov    %ebx,%eax
80102548:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010254b:	c9                   	leave  
8010254c:	c3                   	ret    
8010254d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102550:	83 ec 0c             	sub    $0xc,%esp
80102553:	68 60 26 11 80       	push   $0x80112660
80102558:	e8 93 1d 00 00       	call   801042f0 <acquire>
  r = kmem.freelist;
8010255d:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102563:	83 c4 10             	add    $0x10,%esp
80102566:	a1 94 26 11 80       	mov    0x80112694,%eax
8010256b:	85 db                	test   %ebx,%ebx
8010256d:	75 bb                	jne    8010252a <kalloc+0x1a>
8010256f:	eb c1                	jmp    80102532 <kalloc+0x22>
80102571:	66 90                	xchg   %ax,%ax
80102573:	66 90                	xchg   %ax,%ax
80102575:	66 90                	xchg   %ax,%ax
80102577:	66 90                	xchg   %ax,%ax
80102579:	66 90                	xchg   %ax,%ax
8010257b:	66 90                	xchg   %ax,%ax
8010257d:	66 90                	xchg   %ax,%ax
8010257f:	90                   	nop

80102580 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102580:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102581:	ba 64 00 00 00       	mov    $0x64,%edx
80102586:	89 e5                	mov    %esp,%ebp
80102588:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102589:	a8 01                	test   $0x1,%al
8010258b:	0f 84 af 00 00 00    	je     80102640 <kbdgetc+0xc0>
80102591:	ba 60 00 00 00       	mov    $0x60,%edx
80102596:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102597:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010259a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
801025a0:	74 7e                	je     80102620 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801025a2:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801025a4:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
801025aa:	79 24                	jns    801025d0 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801025ac:	f6 c1 40             	test   $0x40,%cl
801025af:	75 05                	jne    801025b6 <kbdgetc+0x36>
801025b1:	89 c2                	mov    %eax,%edx
801025b3:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025b6:	0f b6 82 80 76 10 80 	movzbl -0x7fef8980(%edx),%eax
801025bd:	83 c8 40             	or     $0x40,%eax
801025c0:	0f b6 c0             	movzbl %al,%eax
801025c3:	f7 d0                	not    %eax
801025c5:	21 c8                	and    %ecx,%eax
801025c7:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
801025cc:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025ce:	5d                   	pop    %ebp
801025cf:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801025d0:	f6 c1 40             	test   $0x40,%cl
801025d3:	74 09                	je     801025de <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025d5:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801025d8:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025db:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025de:	0f b6 82 80 76 10 80 	movzbl -0x7fef8980(%edx),%eax
801025e5:	09 c1                	or     %eax,%ecx
801025e7:	0f b6 82 80 75 10 80 	movzbl -0x7fef8a80(%edx),%eax
801025ee:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025f0:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025f2:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025f8:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025fb:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801025fe:	8b 04 85 60 75 10 80 	mov    -0x7fef8aa0(,%eax,4),%eax
80102605:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102609:	74 c3                	je     801025ce <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
8010260b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010260e:	83 fa 19             	cmp    $0x19,%edx
80102611:	77 1d                	ja     80102630 <kbdgetc+0xb0>
      c += 'A' - 'a';
80102613:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102616:	5d                   	pop    %ebp
80102617:	c3                   	ret    
80102618:	90                   	nop
80102619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102620:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102622:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102629:	5d                   	pop    %ebp
8010262a:	c3                   	ret    
8010262b:	90                   	nop
8010262c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102630:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102633:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102636:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102637:	83 f9 19             	cmp    $0x19,%ecx
8010263a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010263d:	c3                   	ret    
8010263e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102640:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102645:	5d                   	pop    %ebp
80102646:	c3                   	ret    
80102647:	89 f6                	mov    %esi,%esi
80102649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102650 <kbdintr>:

void
kbdintr(void)
{
80102650:	55                   	push   %ebp
80102651:	89 e5                	mov    %esp,%ebp
80102653:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102656:	68 80 25 10 80       	push   $0x80102580
8010265b:	e8 90 e1 ff ff       	call   801007f0 <consoleintr>
}
80102660:	83 c4 10             	add    $0x10,%esp
80102663:	c9                   	leave  
80102664:	c3                   	ret    
80102665:	66 90                	xchg   %ax,%ax
80102667:	66 90                	xchg   %ax,%ax
80102669:	66 90                	xchg   %ax,%ax
8010266b:	66 90                	xchg   %ax,%ax
8010266d:	66 90                	xchg   %ax,%ax
8010266f:	90                   	nop

80102670 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102670:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
80102675:	55                   	push   %ebp
80102676:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102678:	85 c0                	test   %eax,%eax
8010267a:	0f 84 c8 00 00 00    	je     80102748 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102680:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102687:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010268a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010268d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102694:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102697:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010269a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801026a1:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801026a4:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026a7:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801026ae:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801026b1:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026b4:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801026bb:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026be:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026c8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026cb:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ce:	8b 50 30             	mov    0x30(%eax),%edx
801026d1:	c1 ea 10             	shr    $0x10,%edx
801026d4:	80 fa 03             	cmp    $0x3,%dl
801026d7:	77 77                	ja     80102750 <lapicinit+0xe0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026d9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026e0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026e3:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026ed:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026f3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026fa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026fd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102700:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102707:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010270a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010270d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102714:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102717:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010271a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102721:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102724:	8b 50 20             	mov    0x20(%eax),%edx
80102727:	89 f6                	mov    %esi,%esi
80102729:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102730:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102736:	80 e6 10             	and    $0x10,%dh
80102739:	75 f5                	jne    80102730 <lapicinit+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010273b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102742:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102745:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102748:	5d                   	pop    %ebp
80102749:	c3                   	ret    
8010274a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102750:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102757:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010275a:	8b 50 20             	mov    0x20(%eax),%edx
8010275d:	e9 77 ff ff ff       	jmp    801026d9 <lapicinit+0x69>
80102762:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102770 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
80102773:	56                   	push   %esi
80102774:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102775:	9c                   	pushf  
80102776:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102777:	f6 c4 02             	test   $0x2,%ah
8010277a:	74 12                	je     8010278e <cpunum+0x1e>
    static int n;
    if(n++ == 0)
8010277c:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80102781:	8d 50 01             	lea    0x1(%eax),%edx
80102784:	85 c0                	test   %eax,%eax
80102786:	89 15 b8 a5 10 80    	mov    %edx,0x8010a5b8
8010278c:	74 4d                	je     801027db <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
8010278e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102793:	85 c0                	test   %eax,%eax
80102795:	74 60                	je     801027f7 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
80102797:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
8010279a:	8b 35 80 2d 11 80    	mov    0x80112d80,%esi
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
801027a0:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
801027a3:	85 f6                	test   %esi,%esi
801027a5:	7e 59                	jle    80102800 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
801027a7:	0f b6 05 a0 27 11 80 	movzbl 0x801127a0,%eax
801027ae:	39 c3                	cmp    %eax,%ebx
801027b0:	74 45                	je     801027f7 <cpunum+0x87>
801027b2:	ba 5c 28 11 80       	mov    $0x8011285c,%edx
801027b7:	31 c0                	xor    %eax,%eax
801027b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
801027c0:	83 c0 01             	add    $0x1,%eax
801027c3:	39 f0                	cmp    %esi,%eax
801027c5:	74 39                	je     80102800 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
801027c7:	0f b6 0a             	movzbl (%edx),%ecx
801027ca:	81 c2 bc 00 00 00    	add    $0xbc,%edx
801027d0:	39 cb                	cmp    %ecx,%ebx
801027d2:	75 ec                	jne    801027c0 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
801027d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027d7:	5b                   	pop    %ebx
801027d8:	5e                   	pop    %esi
801027d9:	5d                   	pop    %ebp
801027da:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
801027db:	83 ec 08             	sub    $0x8,%esp
801027de:	ff 75 04             	pushl  0x4(%ebp)
801027e1:	68 80 77 10 80       	push   $0x80107780
801027e6:	e8 75 de ff ff       	call   80100660 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
801027eb:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
801027f0:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if (!lapic)
801027f3:	85 c0                	test   %eax,%eax
801027f5:	75 a0                	jne    80102797 <cpunum+0x27>
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
801027f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
    return 0;
801027fa:	31 c0                	xor    %eax,%eax
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
801027fc:	5b                   	pop    %ebx
801027fd:	5e                   	pop    %esi
801027fe:	5d                   	pop    %ebp
801027ff:	c3                   	ret    
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
80102800:	83 ec 0c             	sub    $0xc,%esp
80102803:	68 ac 77 10 80       	push   $0x801077ac
80102808:	e8 63 db ff ff       	call   80100370 <panic>
8010280d:	8d 76 00             	lea    0x0(%esi),%esi

80102810 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102810:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102815:	55                   	push   %ebp
80102816:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102818:	85 c0                	test   %eax,%eax
8010281a:	74 0d                	je     80102829 <lapiceoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010281c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102823:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102826:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102829:	5d                   	pop    %ebp
8010282a:	c3                   	ret    
8010282b:	90                   	nop
8010282c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102830 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102830:	55                   	push   %ebp
80102831:	89 e5                	mov    %esp,%ebp
}
80102833:	5d                   	pop    %ebp
80102834:	c3                   	ret    
80102835:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102839:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102840 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102840:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102841:	ba 70 00 00 00       	mov    $0x70,%edx
80102846:	b8 0f 00 00 00       	mov    $0xf,%eax
8010284b:	89 e5                	mov    %esp,%ebp
8010284d:	53                   	push   %ebx
8010284e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102851:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102854:	ee                   	out    %al,(%dx)
80102855:	ba 71 00 00 00       	mov    $0x71,%edx
8010285a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010285f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102860:	31 c0                	xor    %eax,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102862:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102865:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010286b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010286d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102870:	c1 e8 04             	shr    $0x4,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102873:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102875:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102878:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010287e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102883:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102889:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010288c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102893:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102896:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102899:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801028a0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028a3:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028ac:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028b5:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028be:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028c7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801028ca:	5b                   	pop    %ebx
801028cb:	5d                   	pop    %ebp
801028cc:	c3                   	ret    
801028cd:	8d 76 00             	lea    0x0(%esi),%esi

801028d0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801028d0:	55                   	push   %ebp
801028d1:	ba 70 00 00 00       	mov    $0x70,%edx
801028d6:	b8 0b 00 00 00       	mov    $0xb,%eax
801028db:	89 e5                	mov    %esp,%ebp
801028dd:	57                   	push   %edi
801028de:	56                   	push   %esi
801028df:	53                   	push   %ebx
801028e0:	83 ec 4c             	sub    $0x4c,%esp
801028e3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e4:	ba 71 00 00 00       	mov    $0x71,%edx
801028e9:	ec                   	in     (%dx),%al
801028ea:	83 e0 04             	and    $0x4,%eax
801028ed:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f0:	31 db                	xor    %ebx,%ebx
801028f2:	88 45 b7             	mov    %al,-0x49(%ebp)
801028f5:	bf 70 00 00 00       	mov    $0x70,%edi
801028fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102900:	89 d8                	mov    %ebx,%eax
80102902:	89 fa                	mov    %edi,%edx
80102904:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102905:	b9 71 00 00 00       	mov    $0x71,%ecx
8010290a:	89 ca                	mov    %ecx,%edx
8010290c:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010290d:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102910:	89 fa                	mov    %edi,%edx
80102912:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102915:	b8 02 00 00 00       	mov    $0x2,%eax
8010291a:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291b:	89 ca                	mov    %ecx,%edx
8010291d:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
8010291e:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102921:	89 fa                	mov    %edi,%edx
80102923:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102926:	b8 04 00 00 00       	mov    $0x4,%eax
8010292b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292c:	89 ca                	mov    %ecx,%edx
8010292e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010292f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102932:	89 fa                	mov    %edi,%edx
80102934:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102937:	b8 07 00 00 00       	mov    $0x7,%eax
8010293c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293d:	89 ca                	mov    %ecx,%edx
8010293f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102940:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102943:	89 fa                	mov    %edi,%edx
80102945:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102948:	b8 08 00 00 00       	mov    $0x8,%eax
8010294d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010294e:	89 ca                	mov    %ecx,%edx
80102950:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102951:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102954:	89 fa                	mov    %edi,%edx
80102956:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102959:	b8 09 00 00 00       	mov    $0x9,%eax
8010295e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295f:	89 ca                	mov    %ecx,%edx
80102961:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102962:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102965:	89 fa                	mov    %edi,%edx
80102967:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010296a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010296f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102970:	89 ca                	mov    %ecx,%edx
80102972:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102973:	84 c0                	test   %al,%al
80102975:	78 89                	js     80102900 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102977:	89 d8                	mov    %ebx,%eax
80102979:	89 fa                	mov    %edi,%edx
8010297b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297c:	89 ca                	mov    %ecx,%edx
8010297e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010297f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102982:	89 fa                	mov    %edi,%edx
80102984:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102987:	b8 02 00 00 00       	mov    $0x2,%eax
8010298c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298d:	89 ca                	mov    %ecx,%edx
8010298f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102990:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102993:	89 fa                	mov    %edi,%edx
80102995:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102998:	b8 04 00 00 00       	mov    $0x4,%eax
8010299d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010299e:	89 ca                	mov    %ecx,%edx
801029a0:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
801029a1:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a4:	89 fa                	mov    %edi,%edx
801029a6:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029a9:	b8 07 00 00 00       	mov    $0x7,%eax
801029ae:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029af:	89 ca                	mov    %ecx,%edx
801029b1:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
801029b2:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029b5:	89 fa                	mov    %edi,%edx
801029b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
801029ba:	b8 08 00 00 00       	mov    $0x8,%eax
801029bf:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029c0:	89 ca                	mov    %ecx,%edx
801029c2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801029c3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029c6:	89 fa                	mov    %edi,%edx
801029c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029cb:	b8 09 00 00 00       	mov    $0x9,%eax
801029d0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029d1:	89 ca                	mov    %ecx,%edx
801029d3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801029d4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029d7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801029da:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029dd:	8d 45 b8             	lea    -0x48(%ebp),%eax
801029e0:	6a 18                	push   $0x18
801029e2:	56                   	push   %esi
801029e3:	50                   	push   %eax
801029e4:	e8 87 1b 00 00       	call   80104570 <memcmp>
801029e9:	83 c4 10             	add    $0x10,%esp
801029ec:	85 c0                	test   %eax,%eax
801029ee:	0f 85 0c ff ff ff    	jne    80102900 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
801029f4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801029f8:	75 78                	jne    80102a72 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801029fa:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029fd:	89 c2                	mov    %eax,%edx
801029ff:	83 e0 0f             	and    $0xf,%eax
80102a02:	c1 ea 04             	shr    $0x4,%edx
80102a05:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a08:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a0b:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102a0e:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a11:	89 c2                	mov    %eax,%edx
80102a13:	83 e0 0f             	and    $0xf,%eax
80102a16:	c1 ea 04             	shr    $0x4,%edx
80102a19:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a1c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a1f:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a22:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a25:	89 c2                	mov    %eax,%edx
80102a27:	83 e0 0f             	and    $0xf,%eax
80102a2a:	c1 ea 04             	shr    $0x4,%edx
80102a2d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a30:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a33:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a36:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a39:	89 c2                	mov    %eax,%edx
80102a3b:	83 e0 0f             	and    $0xf,%eax
80102a3e:	c1 ea 04             	shr    $0x4,%edx
80102a41:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a44:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a47:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a4a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a4d:	89 c2                	mov    %eax,%edx
80102a4f:	83 e0 0f             	and    $0xf,%eax
80102a52:	c1 ea 04             	shr    $0x4,%edx
80102a55:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a58:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a5b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a5e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a61:	89 c2                	mov    %eax,%edx
80102a63:	83 e0 0f             	and    $0xf,%eax
80102a66:	c1 ea 04             	shr    $0x4,%edx
80102a69:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a6c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a6f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a72:	8b 75 08             	mov    0x8(%ebp),%esi
80102a75:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a78:	89 06                	mov    %eax,(%esi)
80102a7a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a7d:	89 46 04             	mov    %eax,0x4(%esi)
80102a80:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a83:	89 46 08             	mov    %eax,0x8(%esi)
80102a86:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a89:	89 46 0c             	mov    %eax,0xc(%esi)
80102a8c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a8f:	89 46 10             	mov    %eax,0x10(%esi)
80102a92:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a95:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a98:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aa2:	5b                   	pop    %ebx
80102aa3:	5e                   	pop    %esi
80102aa4:	5f                   	pop    %edi
80102aa5:	5d                   	pop    %ebp
80102aa6:	c3                   	ret    
80102aa7:	66 90                	xchg   %ax,%ax
80102aa9:	66 90                	xchg   %ax,%ax
80102aab:	66 90                	xchg   %ax,%ax
80102aad:	66 90                	xchg   %ax,%ax
80102aaf:	90                   	nop

80102ab0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ab0:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102ab6:	85 c9                	test   %ecx,%ecx
80102ab8:	0f 8e 85 00 00 00    	jle    80102b43 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102abe:	55                   	push   %ebp
80102abf:	89 e5                	mov    %esp,%ebp
80102ac1:	57                   	push   %edi
80102ac2:	56                   	push   %esi
80102ac3:	53                   	push   %ebx
80102ac4:	31 db                	xor    %ebx,%ebx
80102ac6:	83 ec 0c             	sub    $0xc,%esp
80102ac9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ad0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102ad5:	83 ec 08             	sub    $0x8,%esp
80102ad8:	01 d8                	add    %ebx,%eax
80102ada:	83 c0 01             	add    $0x1,%eax
80102add:	50                   	push   %eax
80102ade:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102ae4:	e8 e7 d5 ff ff       	call   801000d0 <bread>
80102ae9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102aeb:	58                   	pop    %eax
80102aec:	5a                   	pop    %edx
80102aed:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102af4:	ff 35 e4 26 11 80    	pushl  0x801126e4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102afa:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102afd:	e8 ce d5 ff ff       	call   801000d0 <bread>
80102b02:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102b04:	8d 47 5c             	lea    0x5c(%edi),%eax
80102b07:	83 c4 0c             	add    $0xc,%esp
80102b0a:	68 00 02 00 00       	push   $0x200
80102b0f:	50                   	push   %eax
80102b10:	8d 46 5c             	lea    0x5c(%esi),%eax
80102b13:	50                   	push   %eax
80102b14:	e8 b7 1a 00 00       	call   801045d0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102b19:	89 34 24             	mov    %esi,(%esp)
80102b1c:	e8 7f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b21:	89 3c 24             	mov    %edi,(%esp)
80102b24:	e8 b7 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b29:	89 34 24             	mov    %esi,(%esp)
80102b2c:	e8 af d6 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b31:	83 c4 10             	add    $0x10,%esp
80102b34:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102b3a:	7f 94                	jg     80102ad0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102b3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b3f:	5b                   	pop    %ebx
80102b40:	5e                   	pop    %esi
80102b41:	5f                   	pop    %edi
80102b42:	5d                   	pop    %ebp
80102b43:	f3 c3                	repz ret 
80102b45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b50 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
80102b53:	53                   	push   %ebx
80102b54:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b57:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102b5d:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102b63:	e8 68 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b68:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b6e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b71:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b73:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b75:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b78:	7e 1f                	jle    80102b99 <write_head+0x49>
80102b7a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102b81:	31 d2                	xor    %edx,%edx
80102b83:	90                   	nop
80102b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102b88:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102b8e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102b92:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b95:	39 c2                	cmp    %eax,%edx
80102b97:	75 ef                	jne    80102b88 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102b99:	83 ec 0c             	sub    $0xc,%esp
80102b9c:	53                   	push   %ebx
80102b9d:	e8 fe d5 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102ba2:	89 1c 24             	mov    %ebx,(%esp)
80102ba5:	e8 36 d6 ff ff       	call   801001e0 <brelse>
}
80102baa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bad:	c9                   	leave  
80102bae:	c3                   	ret    
80102baf:	90                   	nop

80102bb0 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	53                   	push   %ebx
80102bb4:	83 ec 2c             	sub    $0x2c,%esp
80102bb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102bba:	68 bc 77 10 80       	push   $0x801077bc
80102bbf:	68 a0 26 11 80       	push   $0x801126a0
80102bc4:	e8 07 17 00 00       	call   801042d0 <initlock>
  readsb(dev, &sb);
80102bc9:	58                   	pop    %eax
80102bca:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bcd:	5a                   	pop    %edx
80102bce:	50                   	push   %eax
80102bcf:	53                   	push   %ebx
80102bd0:	e8 bb e7 ff ff       	call   80101390 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102bd5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102bd8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bdb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102bdc:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102be2:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102be8:	a3 d4 26 11 80       	mov    %eax,0x801126d4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bed:	5a                   	pop    %edx
80102bee:	50                   	push   %eax
80102bef:	53                   	push   %ebx
80102bf0:	e8 db d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bf5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102bf8:	83 c4 10             	add    $0x10,%esp
80102bfb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bfd:	89 0d e8 26 11 80    	mov    %ecx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102c03:	7e 1c                	jle    80102c21 <initlog+0x71>
80102c05:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102c0c:	31 d2                	xor    %edx,%edx
80102c0e:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102c10:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102c14:	83 c2 04             	add    $0x4,%edx
80102c17:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102c1d:	39 da                	cmp    %ebx,%edx
80102c1f:	75 ef                	jne    80102c10 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102c21:	83 ec 0c             	sub    $0xc,%esp
80102c24:	50                   	push   %eax
80102c25:	e8 b6 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c2a:	e8 81 fe ff ff       	call   80102ab0 <install_trans>
  log.lh.n = 0;
80102c2f:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102c36:	00 00 00 
  write_head(); // clear the log
80102c39:	e8 12 ff ff ff       	call   80102b50 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102c3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c41:	c9                   	leave  
80102c42:	c3                   	ret    
80102c43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c50 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c50:	55                   	push   %ebp
80102c51:	89 e5                	mov    %esp,%ebp
80102c53:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c56:	68 a0 26 11 80       	push   $0x801126a0
80102c5b:	e8 90 16 00 00       	call   801042f0 <acquire>
80102c60:	83 c4 10             	add    $0x10,%esp
80102c63:	eb 18                	jmp    80102c7d <begin_op+0x2d>
80102c65:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c68:	83 ec 08             	sub    $0x8,%esp
80102c6b:	68 a0 26 11 80       	push   $0x801126a0
80102c70:	68 a0 26 11 80       	push   $0x801126a0
80102c75:	e8 f6 11 00 00       	call   80103e70 <sleep>
80102c7a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c7d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102c82:	85 c0                	test   %eax,%eax
80102c84:	75 e2                	jne    80102c68 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c86:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102c8b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102c91:	83 c0 01             	add    $0x1,%eax
80102c94:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c97:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c9a:	83 fa 1e             	cmp    $0x1e,%edx
80102c9d:	7f c9                	jg     80102c68 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c9f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102ca2:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102ca7:	68 a0 26 11 80       	push   $0x801126a0
80102cac:	e8 1f 18 00 00       	call   801044d0 <release>
      break;
    }
  }
}
80102cb1:	83 c4 10             	add    $0x10,%esp
80102cb4:	c9                   	leave  
80102cb5:	c3                   	ret    
80102cb6:	8d 76 00             	lea    0x0(%esi),%esi
80102cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102cc0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102cc0:	55                   	push   %ebp
80102cc1:	89 e5                	mov    %esp,%ebp
80102cc3:	57                   	push   %edi
80102cc4:	56                   	push   %esi
80102cc5:	53                   	push   %ebx
80102cc6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102cc9:	68 a0 26 11 80       	push   $0x801126a0
80102cce:	e8 1d 16 00 00       	call   801042f0 <acquire>
  log.outstanding -= 1;
80102cd3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102cd8:	8b 1d e0 26 11 80    	mov    0x801126e0,%ebx
80102cde:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102ce1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102ce4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102ce6:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102ceb:	0f 85 23 01 00 00    	jne    80102e14 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102cf1:	85 c0                	test   %eax,%eax
80102cf3:	0f 85 f7 00 00 00    	jne    80102df0 <end_op+0x130>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102cf9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102cfc:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102d03:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d06:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102d08:	68 a0 26 11 80       	push   $0x801126a0
80102d0d:	e8 be 17 00 00       	call   801044d0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102d12:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102d18:	83 c4 10             	add    $0x10,%esp
80102d1b:	85 c9                	test   %ecx,%ecx
80102d1d:	0f 8e 8a 00 00 00    	jle    80102dad <end_op+0xed>
80102d23:	90                   	nop
80102d24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d28:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102d2d:	83 ec 08             	sub    $0x8,%esp
80102d30:	01 d8                	add    %ebx,%eax
80102d32:	83 c0 01             	add    $0x1,%eax
80102d35:	50                   	push   %eax
80102d36:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102d3c:	e8 8f d3 ff ff       	call   801000d0 <bread>
80102d41:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d43:	58                   	pop    %eax
80102d44:	5a                   	pop    %edx
80102d45:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102d4c:	ff 35 e4 26 11 80    	pushl  0x801126e4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d52:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d55:	e8 76 d3 ff ff       	call   801000d0 <bread>
80102d5a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d5c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d5f:	83 c4 0c             	add    $0xc,%esp
80102d62:	68 00 02 00 00       	push   $0x200
80102d67:	50                   	push   %eax
80102d68:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d6b:	50                   	push   %eax
80102d6c:	e8 5f 18 00 00       	call   801045d0 <memmove>
    bwrite(to);  // write the log
80102d71:	89 34 24             	mov    %esi,(%esp)
80102d74:	e8 27 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d79:	89 3c 24             	mov    %edi,(%esp)
80102d7c:	e8 5f d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d81:	89 34 24             	mov    %esi,(%esp)
80102d84:	e8 57 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d89:	83 c4 10             	add    $0x10,%esp
80102d8c:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102d92:	7c 94                	jl     80102d28 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d94:	e8 b7 fd ff ff       	call   80102b50 <write_head>
    install_trans(); // Now install writes to home locations
80102d99:	e8 12 fd ff ff       	call   80102ab0 <install_trans>
    log.lh.n = 0;
80102d9e:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102da5:	00 00 00 
    write_head();    // Erase the transaction from the log
80102da8:	e8 a3 fd ff ff       	call   80102b50 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102dad:	83 ec 0c             	sub    $0xc,%esp
80102db0:	68 a0 26 11 80       	push   $0x801126a0
80102db5:	e8 36 15 00 00       	call   801042f0 <acquire>
    log.committing = 0;
    wakeup(&log);
80102dba:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102dc1:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102dc8:	00 00 00 
    wakeup(&log);
80102dcb:	e8 40 12 00 00       	call   80104010 <wakeup>
    release(&log.lock);
80102dd0:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102dd7:	e8 f4 16 00 00       	call   801044d0 <release>
80102ddc:	83 c4 10             	add    $0x10,%esp
  }
}
80102ddf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102de2:	5b                   	pop    %ebx
80102de3:	5e                   	pop    %esi
80102de4:	5f                   	pop    %edi
80102de5:	5d                   	pop    %ebp
80102de6:	c3                   	ret    
80102de7:	89 f6                	mov    %esi,%esi
80102de9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80102df0:	83 ec 0c             	sub    $0xc,%esp
80102df3:	68 a0 26 11 80       	push   $0x801126a0
80102df8:	e8 13 12 00 00       	call   80104010 <wakeup>
  }
  release(&log.lock);
80102dfd:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102e04:	e8 c7 16 00 00       	call   801044d0 <release>
80102e09:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102e0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e0f:	5b                   	pop    %ebx
80102e10:	5e                   	pop    %esi
80102e11:	5f                   	pop    %edi
80102e12:	5d                   	pop    %ebp
80102e13:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102e14:	83 ec 0c             	sub    $0xc,%esp
80102e17:	68 c0 77 10 80       	push   $0x801077c0
80102e1c:	e8 4f d5 ff ff       	call   80100370 <panic>
80102e21:	eb 0d                	jmp    80102e30 <log_write>
80102e23:	90                   	nop
80102e24:	90                   	nop
80102e25:	90                   	nop
80102e26:	90                   	nop
80102e27:	90                   	nop
80102e28:	90                   	nop
80102e29:	90                   	nop
80102e2a:	90                   	nop
80102e2b:	90                   	nop
80102e2c:	90                   	nop
80102e2d:	90                   	nop
80102e2e:	90                   	nop
80102e2f:	90                   	nop

80102e30 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e30:	55                   	push   %ebp
80102e31:	89 e5                	mov    %esp,%ebp
80102e33:	53                   	push   %ebx
80102e34:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e37:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e3d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e40:	83 fa 1d             	cmp    $0x1d,%edx
80102e43:	0f 8f 97 00 00 00    	jg     80102ee0 <log_write+0xb0>
80102e49:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102e4e:	83 e8 01             	sub    $0x1,%eax
80102e51:	39 c2                	cmp    %eax,%edx
80102e53:	0f 8d 87 00 00 00    	jge    80102ee0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e59:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102e5e:	85 c0                	test   %eax,%eax
80102e60:	0f 8e 87 00 00 00    	jle    80102eed <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e66:	83 ec 0c             	sub    $0xc,%esp
80102e69:	68 a0 26 11 80       	push   $0x801126a0
80102e6e:	e8 7d 14 00 00       	call   801042f0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e73:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102e79:	83 c4 10             	add    $0x10,%esp
80102e7c:	83 fa 00             	cmp    $0x0,%edx
80102e7f:	7e 50                	jle    80102ed1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e81:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e84:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e86:	3b 0d ec 26 11 80    	cmp    0x801126ec,%ecx
80102e8c:	75 0b                	jne    80102e99 <log_write+0x69>
80102e8e:	eb 38                	jmp    80102ec8 <log_write+0x98>
80102e90:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102e97:	74 2f                	je     80102ec8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e99:	83 c0 01             	add    $0x1,%eax
80102e9c:	39 d0                	cmp    %edx,%eax
80102e9e:	75 f0                	jne    80102e90 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ea0:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102ea7:	83 c2 01             	add    $0x1,%edx
80102eaa:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102eb0:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102eb3:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102eba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102ebd:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102ebe:	e9 0d 16 00 00       	jmp    801044d0 <release>
80102ec3:	90                   	nop
80102ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ec8:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80102ecf:	eb df                	jmp    80102eb0 <log_write+0x80>
80102ed1:	8b 43 08             	mov    0x8(%ebx),%eax
80102ed4:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102ed9:	75 d5                	jne    80102eb0 <log_write+0x80>
80102edb:	eb ca                	jmp    80102ea7 <log_write+0x77>
80102edd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102ee0:	83 ec 0c             	sub    $0xc,%esp
80102ee3:	68 cf 77 10 80       	push   $0x801077cf
80102ee8:	e8 83 d4 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102eed:	83 ec 0c             	sub    $0xc,%esp
80102ef0:	68 e5 77 10 80       	push   $0x801077e5
80102ef5:	e8 76 d4 ff ff       	call   80100370 <panic>
80102efa:	66 90                	xchg   %ax,%ax
80102efc:	66 90                	xchg   %ax,%ax
80102efe:	66 90                	xchg   %ax,%ax

80102f00 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102f00:	55                   	push   %ebp
80102f01:	89 e5                	mov    %esp,%ebp
80102f03:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102f06:	e8 65 f8 ff ff       	call   80102770 <cpunum>
80102f0b:	83 ec 08             	sub    $0x8,%esp
80102f0e:	50                   	push   %eax
80102f0f:	68 00 78 10 80       	push   $0x80107800
80102f14:	e8 47 d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102f19:	e8 e2 2b 00 00       	call   80105b00 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102f1e:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f25:	b8 01 00 00 00       	mov    $0x1,%eax
80102f2a:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102f31:	e8 5a 0c 00 00       	call   80103b90 <scheduler>
80102f36:	8d 76 00             	lea    0x0(%esi),%esi
80102f39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f40 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102f40:	55                   	push   %ebp
80102f41:	89 e5                	mov    %esp,%ebp
80102f43:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f46:	e8 c5 3d 00 00       	call   80106d10 <switchkvm>
  seginit();
80102f4b:	e8 e0 3b 00 00       	call   80106b30 <seginit>
  lapicinit();
80102f50:	e8 1b f7 ff ff       	call   80102670 <lapicinit>
  mpmain();
80102f55:	e8 a6 ff ff ff       	call   80102f00 <mpmain>
80102f5a:	66 90                	xchg   %ax,%ax
80102f5c:	66 90                	xchg   %ax,%ax
80102f5e:	66 90                	xchg   %ax,%ax

80102f60 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f60:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f64:	83 e4 f0             	and    $0xfffffff0,%esp
80102f67:	ff 71 fc             	pushl  -0x4(%ecx)
80102f6a:	55                   	push   %ebp
80102f6b:	89 e5                	mov    %esp,%ebp
80102f6d:	53                   	push   %ebx
80102f6e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f6f:	83 ec 08             	sub    $0x8,%esp
80102f72:	68 00 00 40 80       	push   $0x80400000
80102f77:	68 e8 55 11 80       	push   $0x801155e8
80102f7c:	e8 bf f4 ff ff       	call   80102440 <kinit1>
  kvmalloc();      // kernel page table
80102f81:	e8 6a 3d 00 00       	call   80106cf0 <kvmalloc>
  mpinit();        // detect other processors
80102f86:	e8 b5 01 00 00       	call   80103140 <mpinit>
  lapicinit();     // interrupt controller
80102f8b:	e8 e0 f6 ff ff       	call   80102670 <lapicinit>
  seginit();       // segment descriptors
80102f90:	e8 9b 3b 00 00       	call   80106b30 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f95:	e8 d6 f7 ff ff       	call   80102770 <cpunum>
80102f9a:	5a                   	pop    %edx
80102f9b:	59                   	pop    %ecx
80102f9c:	50                   	push   %eax
80102f9d:	68 11 78 10 80       	push   $0x80107811
80102fa2:	e8 b9 d6 ff ff       	call   80100660 <cprintf>
  picinit();       // another interrupt controller
80102fa7:	e8 a4 03 00 00       	call   80103350 <picinit>
  ioapicinit();    // another interrupt controller
80102fac:	e8 af f2 ff ff       	call   80102260 <ioapicinit>
  consoleinit();   // console hardware
80102fb1:	e8 ea d9 ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102fb6:	e8 45 2e 00 00       	call   80105e00 <uartinit>
  pinit();         // process table
80102fbb:	e8 30 09 00 00       	call   801038f0 <pinit>
  tvinit();        // trap vectors
80102fc0:	e8 9b 2a 00 00       	call   80105a60 <tvinit>
  binit();         // buffer cache
80102fc5:	e8 76 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102fca:	e8 61 dd ff ff       	call   80100d30 <fileinit>
  ideinit();       // disk
80102fcf:	e8 5c f0 ff ff       	call   80102030 <ideinit>
  if(!ismp)
80102fd4:	8b 1d 84 27 11 80    	mov    0x80112784,%ebx
80102fda:	83 c4 10             	add    $0x10,%esp
80102fdd:	85 db                	test   %ebx,%ebx
80102fdf:	0f 84 ca 00 00 00    	je     801030af <main+0x14f>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fe5:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80102fe8:	bb a0 27 11 80       	mov    $0x801127a0,%ebx

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fed:	68 8a 00 00 00       	push   $0x8a
80102ff2:	68 8c a4 10 80       	push   $0x8010a48c
80102ff7:	68 00 70 00 80       	push   $0x80007000
80102ffc:	e8 cf 15 00 00       	call   801045d0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103001:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80103008:	00 00 00 
8010300b:	83 c4 10             	add    $0x10,%esp
8010300e:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103013:	39 d8                	cmp    %ebx,%eax
80103015:	76 7c                	jbe    80103093 <main+0x133>
80103017:	89 f6                	mov    %esi,%esi
80103019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == cpus+cpunum())  // We've started already.
80103020:	e8 4b f7 ff ff       	call   80102770 <cpunum>
80103025:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010302b:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103030:	39 c3                	cmp    %eax,%ebx
80103032:	74 46                	je     8010307a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103034:	e8 d7 f4 ff ff       	call   80102510 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103039:	83 ec 08             	sub    $0x8,%esp

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010303c:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80103041:	c7 05 f8 6f 00 80 40 	movl   $0x80102f40,0x80006ff8
80103048:	2f 10 80 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010304b:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103050:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80103057:	90 10 00 

    lapicstartap(c->apicid, V2P(code));
8010305a:	68 00 70 00 00       	push   $0x7000
8010305f:	0f b6 03             	movzbl (%ebx),%eax
80103062:	50                   	push   %eax
80103063:	e8 d8 f7 ff ff       	call   80102840 <lapicstartap>
80103068:	83 c4 10             	add    $0x10,%esp
8010306b:	90                   	nop
8010306c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103070:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80103076:	85 c0                	test   %eax,%eax
80103078:	74 f6                	je     80103070 <main+0x110>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010307a:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80103081:	00 00 00 
80103084:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
8010308a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010308f:	39 c3                	cmp    %eax,%ebx
80103091:	72 8d                	jb     80103020 <main+0xc0>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103093:	83 ec 08             	sub    $0x8,%esp
80103096:	68 00 00 00 8e       	push   $0x8e000000
8010309b:	68 00 00 40 80       	push   $0x80400000
801030a0:	e8 0b f4 ff ff       	call   801024b0 <kinit2>
  userinit();      // first user process
801030a5:	e8 66 08 00 00       	call   80103910 <userinit>
  mpmain();        // finish this processor's setup
801030aa:	e8 51 fe ff ff       	call   80102f00 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
801030af:	e8 4c 29 00 00       	call   80105a00 <timerinit>
801030b4:	e9 2c ff ff ff       	jmp    80102fe5 <main+0x85>
801030b9:	66 90                	xchg   %ax,%ax
801030bb:	66 90                	xchg   %ax,%ax
801030bd:	66 90                	xchg   %ax,%ax
801030bf:	90                   	nop

801030c0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	57                   	push   %edi
801030c4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030c5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030cb:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
801030cc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030cf:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030d2:	39 de                	cmp    %ebx,%esi
801030d4:	73 48                	jae    8010311e <mpsearch1+0x5e>
801030d6:	8d 76 00             	lea    0x0(%esi),%esi
801030d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030e0:	83 ec 04             	sub    $0x4,%esp
801030e3:	8d 7e 10             	lea    0x10(%esi),%edi
801030e6:	6a 04                	push   $0x4
801030e8:	68 28 78 10 80       	push   $0x80107828
801030ed:	56                   	push   %esi
801030ee:	e8 7d 14 00 00       	call   80104570 <memcmp>
801030f3:	83 c4 10             	add    $0x10,%esp
801030f6:	85 c0                	test   %eax,%eax
801030f8:	75 1e                	jne    80103118 <mpsearch1+0x58>
801030fa:	8d 7e 10             	lea    0x10(%esi),%edi
801030fd:	89 f2                	mov    %esi,%edx
801030ff:	31 c9                	xor    %ecx,%ecx
80103101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
80103108:	0f b6 02             	movzbl (%edx),%eax
8010310b:	83 c2 01             	add    $0x1,%edx
8010310e:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
80103110:	39 fa                	cmp    %edi,%edx
80103112:	75 f4                	jne    80103108 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103114:	84 c9                	test   %cl,%cl
80103116:	74 10                	je     80103128 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
80103118:	39 fb                	cmp    %edi,%ebx
8010311a:	89 fe                	mov    %edi,%esi
8010311c:	77 c2                	ja     801030e0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
8010311e:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103121:	31 c0                	xor    %eax,%eax
}
80103123:	5b                   	pop    %ebx
80103124:	5e                   	pop    %esi
80103125:	5f                   	pop    %edi
80103126:	5d                   	pop    %ebp
80103127:	c3                   	ret    
80103128:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010312b:	89 f0                	mov    %esi,%eax
8010312d:	5b                   	pop    %ebx
8010312e:	5e                   	pop    %esi
8010312f:	5f                   	pop    %edi
80103130:	5d                   	pop    %ebp
80103131:	c3                   	ret    
80103132:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103140 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103140:	55                   	push   %ebp
80103141:	89 e5                	mov    %esp,%ebp
80103143:	57                   	push   %edi
80103144:	56                   	push   %esi
80103145:	53                   	push   %ebx
80103146:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103149:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103150:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103157:	c1 e0 08             	shl    $0x8,%eax
8010315a:	09 d0                	or     %edx,%eax
8010315c:	c1 e0 04             	shl    $0x4,%eax
8010315f:	85 c0                	test   %eax,%eax
80103161:	75 1b                	jne    8010317e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103163:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010316a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103171:	c1 e0 08             	shl    $0x8,%eax
80103174:	09 d0                	or     %edx,%eax
80103176:	c1 e0 0a             	shl    $0xa,%eax
80103179:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010317e:	ba 00 04 00 00       	mov    $0x400,%edx
80103183:	e8 38 ff ff ff       	call   801030c0 <mpsearch1>
80103188:	85 c0                	test   %eax,%eax
8010318a:	89 c6                	mov    %eax,%esi
8010318c:	0f 84 66 01 00 00    	je     801032f8 <mpinit+0x1b8>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103192:	8b 5e 04             	mov    0x4(%esi),%ebx
80103195:	85 db                	test   %ebx,%ebx
80103197:	0f 84 d6 00 00 00    	je     80103273 <mpinit+0x133>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010319d:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
801031a3:	83 ec 04             	sub    $0x4,%esp
801031a6:	6a 04                	push   $0x4
801031a8:	68 2d 78 10 80       	push   $0x8010782d
801031ad:	50                   	push   %eax
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801031ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801031b1:	e8 ba 13 00 00       	call   80104570 <memcmp>
801031b6:	83 c4 10             	add    $0x10,%esp
801031b9:	85 c0                	test   %eax,%eax
801031bb:	0f 85 b2 00 00 00    	jne    80103273 <mpinit+0x133>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801031c1:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031c8:	3c 01                	cmp    $0x1,%al
801031ca:	74 08                	je     801031d4 <mpinit+0x94>
801031cc:	3c 04                	cmp    $0x4,%al
801031ce:	0f 85 9f 00 00 00    	jne    80103273 <mpinit+0x133>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031d4:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031db:	85 ff                	test   %edi,%edi
801031dd:	74 1e                	je     801031fd <mpinit+0xbd>
801031df:	31 d2                	xor    %edx,%edx
801031e1:	31 c0                	xor    %eax,%eax
801031e3:	90                   	nop
801031e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801031e8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801031ef:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031f0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801031f3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031f5:	39 c7                	cmp    %eax,%edi
801031f7:	75 ef                	jne    801031e8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031f9:	84 d2                	test   %dl,%dl
801031fb:	75 76                	jne    80103273 <mpinit+0x133>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031fd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103200:	85 ff                	test   %edi,%edi
80103202:	74 6f                	je     80103273 <mpinit+0x133>
    return;
  ismp = 1;
80103204:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
8010320b:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
8010320e:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103214:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103219:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80103220:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103226:	01 f9                	add    %edi,%ecx
80103228:	39 c8                	cmp    %ecx,%eax
8010322a:	0f 83 a0 00 00 00    	jae    801032d0 <mpinit+0x190>
    switch(*p){
80103230:	80 38 04             	cmpb   $0x4,(%eax)
80103233:	0f 87 87 00 00 00    	ja     801032c0 <mpinit+0x180>
80103239:	0f b6 10             	movzbl (%eax),%edx
8010323c:	ff 24 95 34 78 10 80 	jmp    *-0x7fef87cc(,%edx,4)
80103243:	90                   	nop
80103244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103248:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010324b:	39 c1                	cmp    %eax,%ecx
8010324d:	77 e1                	ja     80103230 <mpinit+0xf0>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010324f:	a1 84 27 11 80       	mov    0x80112784,%eax
80103254:	85 c0                	test   %eax,%eax
80103256:	75 78                	jne    801032d0 <mpinit+0x190>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103258:	c7 05 80 2d 11 80 01 	movl   $0x1,0x80112d80
8010325f:	00 00 00 
    lapic = 0;
80103262:	c7 05 9c 26 11 80 00 	movl   $0x0,0x8011269c
80103269:	00 00 00 
    ioapicid = 0;
8010326c:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103273:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103276:	5b                   	pop    %ebx
80103277:	5e                   	pop    %esi
80103278:	5f                   	pop    %edi
80103279:	5d                   	pop    %ebp
8010327a:	c3                   	ret    
8010327b:	90                   	nop
8010327c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103280:	8b 15 80 2d 11 80    	mov    0x80112d80,%edx
80103286:	83 fa 07             	cmp    $0x7,%edx
80103289:	7f 19                	jg     801032a4 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010328b:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
8010328f:	69 fa bc 00 00 00    	imul   $0xbc,%edx,%edi
        ncpu++;
80103295:	83 c2 01             	add    $0x1,%edx
80103298:	89 15 80 2d 11 80    	mov    %edx,0x80112d80
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010329e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
801032a4:	83 c0 14             	add    $0x14,%eax
      continue;
801032a7:	eb a2                	jmp    8010324b <mpinit+0x10b>
801032a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801032b0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801032b4:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
801032b7:	88 15 80 27 11 80    	mov    %dl,0x80112780
      p += sizeof(struct mpioapic);
      continue;
801032bd:	eb 8c                	jmp    8010324b <mpinit+0x10b>
801032bf:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801032c0:	c7 05 84 27 11 80 00 	movl   $0x0,0x80112784
801032c7:	00 00 00 
      break;
801032ca:	e9 7c ff ff ff       	jmp    8010324b <mpinit+0x10b>
801032cf:	90                   	nop
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
801032d0:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801032d4:	74 9d                	je     80103273 <mpinit+0x133>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032d6:	ba 22 00 00 00       	mov    $0x22,%edx
801032db:	b8 70 00 00 00       	mov    $0x70,%eax
801032e0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032e1:	ba 23 00 00 00       	mov    $0x23,%edx
801032e6:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032e7:	83 c8 01             	or     $0x1,%eax
801032ea:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801032eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032ee:	5b                   	pop    %ebx
801032ef:	5e                   	pop    %esi
801032f0:	5f                   	pop    %edi
801032f1:	5d                   	pop    %ebp
801032f2:	c3                   	ret    
801032f3:	90                   	nop
801032f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032f8:	ba 00 00 01 00       	mov    $0x10000,%edx
801032fd:	b8 00 00 0f 00       	mov    $0xf0000,%eax
80103302:	e8 b9 fd ff ff       	call   801030c0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103307:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
80103309:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
8010330b:	0f 85 81 fe ff ff    	jne    80103192 <mpinit+0x52>
80103311:	e9 5d ff ff ff       	jmp    80103273 <mpinit+0x133>
80103316:	66 90                	xchg   %ax,%ax
80103318:	66 90                	xchg   %ax,%ax
8010331a:	66 90                	xchg   %ax,%ax
8010331c:	66 90                	xchg   %ax,%ax
8010331e:	66 90                	xchg   %ax,%ax

80103320 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103320:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103321:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103326:	ba 21 00 00 00       	mov    $0x21,%edx
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
8010332b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010332d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103330:	d3 c0                	rol    %cl,%eax
80103332:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
80103339:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
8010333f:	ee                   	out    %al,(%dx)
80103340:	ba a1 00 00 00       	mov    $0xa1,%edx
80103345:	66 c1 e8 08          	shr    $0x8,%ax
80103349:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
8010334a:	5d                   	pop    %ebp
8010334b:	c3                   	ret    
8010334c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103350 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103350:	55                   	push   %ebp
80103351:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103356:	89 e5                	mov    %esp,%ebp
80103358:	57                   	push   %edi
80103359:	56                   	push   %esi
8010335a:	53                   	push   %ebx
8010335b:	bb 21 00 00 00       	mov    $0x21,%ebx
80103360:	89 da                	mov    %ebx,%edx
80103362:	ee                   	out    %al,(%dx)
80103363:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80103368:	89 ca                	mov    %ecx,%edx
8010336a:	ee                   	out    %al,(%dx)
8010336b:	bf 11 00 00 00       	mov    $0x11,%edi
80103370:	be 20 00 00 00       	mov    $0x20,%esi
80103375:	89 f8                	mov    %edi,%eax
80103377:	89 f2                	mov    %esi,%edx
80103379:	ee                   	out    %al,(%dx)
8010337a:	b8 20 00 00 00       	mov    $0x20,%eax
8010337f:	89 da                	mov    %ebx,%edx
80103381:	ee                   	out    %al,(%dx)
80103382:	b8 04 00 00 00       	mov    $0x4,%eax
80103387:	ee                   	out    %al,(%dx)
80103388:	b8 03 00 00 00       	mov    $0x3,%eax
8010338d:	ee                   	out    %al,(%dx)
8010338e:	bb a0 00 00 00       	mov    $0xa0,%ebx
80103393:	89 f8                	mov    %edi,%eax
80103395:	89 da                	mov    %ebx,%edx
80103397:	ee                   	out    %al,(%dx)
80103398:	b8 28 00 00 00       	mov    $0x28,%eax
8010339d:	89 ca                	mov    %ecx,%edx
8010339f:	ee                   	out    %al,(%dx)
801033a0:	b8 02 00 00 00       	mov    $0x2,%eax
801033a5:	ee                   	out    %al,(%dx)
801033a6:	b8 03 00 00 00       	mov    $0x3,%eax
801033ab:	ee                   	out    %al,(%dx)
801033ac:	bf 68 00 00 00       	mov    $0x68,%edi
801033b1:	89 f2                	mov    %esi,%edx
801033b3:	89 f8                	mov    %edi,%eax
801033b5:	ee                   	out    %al,(%dx)
801033b6:	b9 0a 00 00 00       	mov    $0xa,%ecx
801033bb:	89 c8                	mov    %ecx,%eax
801033bd:	ee                   	out    %al,(%dx)
801033be:	89 f8                	mov    %edi,%eax
801033c0:	89 da                	mov    %ebx,%edx
801033c2:	ee                   	out    %al,(%dx)
801033c3:	89 c8                	mov    %ecx,%eax
801033c5:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
801033c6:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
801033cd:	66 83 f8 ff          	cmp    $0xffff,%ax
801033d1:	74 10                	je     801033e3 <picinit+0x93>
801033d3:	ba 21 00 00 00       	mov    $0x21,%edx
801033d8:	ee                   	out    %al,(%dx)
801033d9:	ba a1 00 00 00       	mov    $0xa1,%edx
801033de:	66 c1 e8 08          	shr    $0x8,%ax
801033e2:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
801033e3:	5b                   	pop    %ebx
801033e4:	5e                   	pop    %esi
801033e5:	5f                   	pop    %edi
801033e6:	5d                   	pop    %ebp
801033e7:	c3                   	ret    
801033e8:	66 90                	xchg   %ax,%ax
801033ea:	66 90                	xchg   %ax,%ax
801033ec:	66 90                	xchg   %ax,%ax
801033ee:	66 90                	xchg   %ax,%ax

801033f0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033f0:	55                   	push   %ebp
801033f1:	89 e5                	mov    %esp,%ebp
801033f3:	57                   	push   %edi
801033f4:	56                   	push   %esi
801033f5:	53                   	push   %ebx
801033f6:	83 ec 0c             	sub    $0xc,%esp
801033f9:	8b 75 08             	mov    0x8(%ebp),%esi
801033fc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033ff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103405:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010340b:	e8 40 d9 ff ff       	call   80100d50 <filealloc>
80103410:	85 c0                	test   %eax,%eax
80103412:	89 06                	mov    %eax,(%esi)
80103414:	0f 84 a8 00 00 00    	je     801034c2 <pipealloc+0xd2>
8010341a:	e8 31 d9 ff ff       	call   80100d50 <filealloc>
8010341f:	85 c0                	test   %eax,%eax
80103421:	89 03                	mov    %eax,(%ebx)
80103423:	0f 84 87 00 00 00    	je     801034b0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103429:	e8 e2 f0 ff ff       	call   80102510 <kalloc>
8010342e:	85 c0                	test   %eax,%eax
80103430:	89 c7                	mov    %eax,%edi
80103432:	0f 84 b0 00 00 00    	je     801034e8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103438:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010343b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103442:	00 00 00 
  p->writeopen = 1;
80103445:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010344c:	00 00 00 
  p->nwrite = 0;
8010344f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103456:	00 00 00 
  p->nread = 0;
80103459:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103460:	00 00 00 
  initlock(&p->lock, "pipe");
80103463:	68 48 78 10 80       	push   $0x80107848
80103468:	50                   	push   %eax
80103469:	e8 62 0e 00 00       	call   801042d0 <initlock>
  (*f0)->type = FD_PIPE;
8010346e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103470:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103473:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103479:	8b 06                	mov    (%esi),%eax
8010347b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010347f:	8b 06                	mov    (%esi),%eax
80103481:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103485:	8b 06                	mov    (%esi),%eax
80103487:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010348a:	8b 03                	mov    (%ebx),%eax
8010348c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103492:	8b 03                	mov    (%ebx),%eax
80103494:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103498:	8b 03                	mov    (%ebx),%eax
8010349a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010349e:	8b 03                	mov    (%ebx),%eax
801034a0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801034a6:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801034a8:	5b                   	pop    %ebx
801034a9:	5e                   	pop    %esi
801034aa:	5f                   	pop    %edi
801034ab:	5d                   	pop    %ebp
801034ac:	c3                   	ret    
801034ad:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034b0:	8b 06                	mov    (%esi),%eax
801034b2:	85 c0                	test   %eax,%eax
801034b4:	74 1e                	je     801034d4 <pipealloc+0xe4>
    fileclose(*f0);
801034b6:	83 ec 0c             	sub    $0xc,%esp
801034b9:	50                   	push   %eax
801034ba:	e8 51 d9 ff ff       	call   80100e10 <fileclose>
801034bf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034c2:	8b 03                	mov    (%ebx),%eax
801034c4:	85 c0                	test   %eax,%eax
801034c6:	74 0c                	je     801034d4 <pipealloc+0xe4>
    fileclose(*f1);
801034c8:	83 ec 0c             	sub    $0xc,%esp
801034cb:	50                   	push   %eax
801034cc:	e8 3f d9 ff ff       	call   80100e10 <fileclose>
801034d1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801034d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801034d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801034dc:	5b                   	pop    %ebx
801034dd:	5e                   	pop    %esi
801034de:	5f                   	pop    %edi
801034df:	5d                   	pop    %ebp
801034e0:	c3                   	ret    
801034e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034e8:	8b 06                	mov    (%esi),%eax
801034ea:	85 c0                	test   %eax,%eax
801034ec:	75 c8                	jne    801034b6 <pipealloc+0xc6>
801034ee:	eb d2                	jmp    801034c2 <pipealloc+0xd2>

801034f0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801034f0:	55                   	push   %ebp
801034f1:	89 e5                	mov    %esp,%ebp
801034f3:	56                   	push   %esi
801034f4:	53                   	push   %ebx
801034f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034f8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034fb:	83 ec 0c             	sub    $0xc,%esp
801034fe:	53                   	push   %ebx
801034ff:	e8 ec 0d 00 00       	call   801042f0 <acquire>
  if(writable){
80103504:	83 c4 10             	add    $0x10,%esp
80103507:	85 f6                	test   %esi,%esi
80103509:	74 45                	je     80103550 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010350b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103511:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
80103514:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010351b:	00 00 00 
    wakeup(&p->nread);
8010351e:	50                   	push   %eax
8010351f:	e8 ec 0a 00 00       	call   80104010 <wakeup>
80103524:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103527:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010352d:	85 d2                	test   %edx,%edx
8010352f:	75 0a                	jne    8010353b <pipeclose+0x4b>
80103531:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103537:	85 c0                	test   %eax,%eax
80103539:	74 35                	je     80103570 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010353b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010353e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103541:	5b                   	pop    %ebx
80103542:	5e                   	pop    %esi
80103543:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103544:	e9 87 0f 00 00       	jmp    801044d0 <release>
80103549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103550:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103556:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103559:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103560:	00 00 00 
    wakeup(&p->nwrite);
80103563:	50                   	push   %eax
80103564:	e8 a7 0a 00 00       	call   80104010 <wakeup>
80103569:	83 c4 10             	add    $0x10,%esp
8010356c:	eb b9                	jmp    80103527 <pipeclose+0x37>
8010356e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103570:	83 ec 0c             	sub    $0xc,%esp
80103573:	53                   	push   %ebx
80103574:	e8 57 0f 00 00       	call   801044d0 <release>
    kfree((char*)p);
80103579:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010357c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010357f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103582:	5b                   	pop    %ebx
80103583:	5e                   	pop    %esi
80103584:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103585:	e9 d6 ed ff ff       	jmp    80102360 <kfree>
8010358a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103590 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103590:	55                   	push   %ebp
80103591:	89 e5                	mov    %esp,%ebp
80103593:	57                   	push   %edi
80103594:	56                   	push   %esi
80103595:	53                   	push   %ebx
80103596:	83 ec 28             	sub    $0x28,%esp
80103599:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010359c:	57                   	push   %edi
8010359d:	e8 4e 0d 00 00       	call   801042f0 <acquire>
  for(i = 0; i < n; i++){
801035a2:	8b 45 10             	mov    0x10(%ebp),%eax
801035a5:	83 c4 10             	add    $0x10,%esp
801035a8:	85 c0                	test   %eax,%eax
801035aa:	0f 8e c6 00 00 00    	jle    80103676 <pipewrite+0xe6>
801035b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801035b3:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
801035b9:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
801035bf:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
801035c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035c8:	03 45 10             	add    0x10(%ebp),%eax
801035cb:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035ce:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035d4:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801035da:	39 d1                	cmp    %edx,%ecx
801035dc:	0f 85 cf 00 00 00    	jne    801036b1 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
801035e2:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
801035e8:	85 d2                	test   %edx,%edx
801035ea:	0f 84 a8 00 00 00    	je     80103698 <pipewrite+0x108>
801035f0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801035f7:	8b 42 24             	mov    0x24(%edx),%eax
801035fa:	85 c0                	test   %eax,%eax
801035fc:	74 25                	je     80103623 <pipewrite+0x93>
801035fe:	e9 95 00 00 00       	jmp    80103698 <pipewrite+0x108>
80103603:	90                   	nop
80103604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103608:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
8010360e:	85 c0                	test   %eax,%eax
80103610:	0f 84 82 00 00 00    	je     80103698 <pipewrite+0x108>
80103616:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010361c:	8b 40 24             	mov    0x24(%eax),%eax
8010361f:	85 c0                	test   %eax,%eax
80103621:	75 75                	jne    80103698 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103623:	83 ec 0c             	sub    $0xc,%esp
80103626:	56                   	push   %esi
80103627:	e8 e4 09 00 00       	call   80104010 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010362c:	59                   	pop    %ecx
8010362d:	58                   	pop    %eax
8010362e:	57                   	push   %edi
8010362f:	53                   	push   %ebx
80103630:	e8 3b 08 00 00       	call   80103e70 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103635:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010363b:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103641:	83 c4 10             	add    $0x10,%esp
80103644:	05 00 02 00 00       	add    $0x200,%eax
80103649:	39 c2                	cmp    %eax,%edx
8010364b:	74 bb                	je     80103608 <pipewrite+0x78>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010364d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103650:	8d 4a 01             	lea    0x1(%edx),%ecx
80103653:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80103657:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010365d:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103663:	0f b6 00             	movzbl (%eax),%eax
80103666:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
8010366a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010366d:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80103670:	0f 85 58 ff ff ff    	jne    801035ce <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103676:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
8010367c:	83 ec 0c             	sub    $0xc,%esp
8010367f:	52                   	push   %edx
80103680:	e8 8b 09 00 00       	call   80104010 <wakeup>
  release(&p->lock);
80103685:	89 3c 24             	mov    %edi,(%esp)
80103688:	e8 43 0e 00 00       	call   801044d0 <release>
  return n;
8010368d:	83 c4 10             	add    $0x10,%esp
80103690:	8b 45 10             	mov    0x10(%ebp),%eax
80103693:	eb 14                	jmp    801036a9 <pipewrite+0x119>
80103695:	8d 76 00             	lea    0x0(%esi),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
80103698:	83 ec 0c             	sub    $0xc,%esp
8010369b:	57                   	push   %edi
8010369c:	e8 2f 0e 00 00       	call   801044d0 <release>
        return -1;
801036a1:	83 c4 10             	add    $0x10,%esp
801036a4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801036a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ac:	5b                   	pop    %ebx
801036ad:	5e                   	pop    %esi
801036ae:	5f                   	pop    %edi
801036af:	5d                   	pop    %ebp
801036b0:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036b1:	89 ca                	mov    %ecx,%edx
801036b3:	eb 98                	jmp    8010364d <pipewrite+0xbd>
801036b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036c0 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
801036c0:	55                   	push   %ebp
801036c1:	89 e5                	mov    %esp,%ebp
801036c3:	57                   	push   %edi
801036c4:	56                   	push   %esi
801036c5:	53                   	push   %ebx
801036c6:	83 ec 18             	sub    $0x18,%esp
801036c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036cf:	53                   	push   %ebx
801036d0:	e8 1b 0c 00 00       	call   801042f0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036d5:	83 c4 10             	add    $0x10,%esp
801036d8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036de:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801036e4:	75 6a                	jne    80103750 <piperead+0x90>
801036e6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801036ec:	85 f6                	test   %esi,%esi
801036ee:	0f 84 cc 00 00 00    	je     801037c0 <piperead+0x100>
801036f4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801036fa:	eb 2d                	jmp    80103729 <piperead+0x69>
801036fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103700:	83 ec 08             	sub    $0x8,%esp
80103703:	53                   	push   %ebx
80103704:	56                   	push   %esi
80103705:	e8 66 07 00 00       	call   80103e70 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010370a:	83 c4 10             	add    $0x10,%esp
8010370d:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103713:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
80103719:	75 35                	jne    80103750 <piperead+0x90>
8010371b:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103721:	85 d2                	test   %edx,%edx
80103723:	0f 84 97 00 00 00    	je     801037c0 <piperead+0x100>
    if(proc->killed){
80103729:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103730:	8b 4a 24             	mov    0x24(%edx),%ecx
80103733:	85 c9                	test   %ecx,%ecx
80103735:	74 c9                	je     80103700 <piperead+0x40>
      release(&p->lock);
80103737:	83 ec 0c             	sub    $0xc,%esp
8010373a:	53                   	push   %ebx
8010373b:	e8 90 0d 00 00       	call   801044d0 <release>
      return -1;
80103740:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103743:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
      return -1;
80103746:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010374b:	5b                   	pop    %ebx
8010374c:	5e                   	pop    %esi
8010374d:	5f                   	pop    %edi
8010374e:	5d                   	pop    %ebp
8010374f:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103750:	8b 45 10             	mov    0x10(%ebp),%eax
80103753:	85 c0                	test   %eax,%eax
80103755:	7e 69                	jle    801037c0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103757:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010375d:	31 c9                	xor    %ecx,%ecx
8010375f:	eb 15                	jmp    80103776 <piperead+0xb6>
80103761:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103768:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010376e:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
80103774:	74 5a                	je     801037d0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103776:	8d 72 01             	lea    0x1(%edx),%esi
80103779:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010377f:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103785:	0f b6 54 13 34       	movzbl 0x34(%ebx,%edx,1),%edx
8010378a:	88 14 0f             	mov    %dl,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010378d:	83 c1 01             	add    $0x1,%ecx
80103790:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103793:	75 d3                	jne    80103768 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103795:	8d 93 38 02 00 00    	lea    0x238(%ebx),%edx
8010379b:	83 ec 0c             	sub    $0xc,%esp
8010379e:	52                   	push   %edx
8010379f:	e8 6c 08 00 00       	call   80104010 <wakeup>
  release(&p->lock);
801037a4:	89 1c 24             	mov    %ebx,(%esp)
801037a7:	e8 24 0d 00 00       	call   801044d0 <release>
  return i;
801037ac:	8b 45 10             	mov    0x10(%ebp),%eax
801037af:	83 c4 10             	add    $0x10,%esp
}
801037b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801037b5:	5b                   	pop    %ebx
801037b6:	5e                   	pop    %esi
801037b7:	5f                   	pop    %edi
801037b8:	5d                   	pop    %ebp
801037b9:	c3                   	ret    
801037ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037c0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801037c7:	eb cc                	jmp    80103795 <piperead+0xd5>
801037c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037d0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801037d3:	eb c0                	jmp    80103795 <piperead+0xd5>
801037d5:	66 90                	xchg   %ax,%ax
801037d7:	66 90                	xchg   %ax,%ax
801037d9:	66 90                	xchg   %ax,%ax
801037db:	66 90                	xchg   %ax,%ax
801037dd:	66 90                	xchg   %ax,%ax
801037df:	90                   	nop

801037e0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037e0:	55                   	push   %ebp
801037e1:	89 e5                	mov    %esp,%ebp
801037e3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037e4:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037e9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801037ec:	68 a0 2d 11 80       	push   $0x80112da0
801037f1:	e8 fa 0a 00 00       	call   801042f0 <acquire>
801037f6:	83 c4 10             	add    $0x10,%esp
801037f9:	eb 10                	jmp    8010380b <allocproc+0x2b>
801037fb:	90                   	nop
801037fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103800:	83 c3 7c             	add    $0x7c,%ebx
80103803:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103809:	74 75                	je     80103880 <allocproc+0xa0>
    if(p->state == UNUSED)
8010380b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010380e:	85 c0                	test   %eax,%eax
80103810:	75 ee                	jne    80103800 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103812:	a1 08 a0 10 80       	mov    0x8010a008,%eax

  release(&ptable.lock);
80103817:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
8010381a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103821:	68 a0 2d 11 80       	push   $0x80112da0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103826:	8d 50 01             	lea    0x1(%eax),%edx
80103829:	89 43 10             	mov    %eax,0x10(%ebx)
8010382c:	89 15 08 a0 10 80    	mov    %edx,0x8010a008

  release(&ptable.lock);
80103832:	e8 99 0c 00 00       	call   801044d0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103837:	e8 d4 ec ff ff       	call   80102510 <kalloc>
8010383c:	83 c4 10             	add    $0x10,%esp
8010383f:	85 c0                	test   %eax,%eax
80103841:	89 43 08             	mov    %eax,0x8(%ebx)
80103844:	74 51                	je     80103897 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103846:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010384c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010384f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103854:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103857:	c7 40 14 4e 5a 10 80 	movl   $0x80105a4e,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010385e:	6a 14                	push   $0x14
80103860:	6a 00                	push   $0x0
80103862:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103863:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103866:	e8 b5 0c 00 00       	call   80104520 <memset>
  p->context->eip = (uint)forkret;
8010386b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010386e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103871:	c7 40 10 a0 38 10 80 	movl   $0x801038a0,0x10(%eax)

  return p;
80103878:	89 d8                	mov    %ebx,%eax
}
8010387a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010387d:	c9                   	leave  
8010387e:	c3                   	ret    
8010387f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103880:	83 ec 0c             	sub    $0xc,%esp
80103883:	68 a0 2d 11 80       	push   $0x80112da0
80103888:	e8 43 0c 00 00       	call   801044d0 <release>
  return 0;
8010388d:	83 c4 10             	add    $0x10,%esp
80103890:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103892:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103895:	c9                   	leave  
80103896:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103897:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010389e:	eb da                	jmp    8010387a <allocproc+0x9a>

801038a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801038a6:	68 a0 2d 11 80       	push   $0x80112da0
801038ab:	e8 20 0c 00 00       	call   801044d0 <release>

  if (first) {
801038b0:	a1 04 a0 10 80       	mov    0x8010a004,%eax
801038b5:	83 c4 10             	add    $0x10,%esp
801038b8:	85 c0                	test   %eax,%eax
801038ba:	75 04                	jne    801038c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038bc:	c9                   	leave  
801038bd:	c3                   	ret    
801038be:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801038c0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801038c3:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
801038ca:	00 00 00 
    iinit(ROOTDEV);
801038cd:	6a 01                	push   $0x1
801038cf:	e8 7c db ff ff       	call   80101450 <iinit>
    initlog(ROOTDEV);
801038d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038db:	e8 d0 f2 ff ff       	call   80102bb0 <initlog>
801038e0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038e3:	c9                   	leave  
801038e4:	c3                   	ret    
801038e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038f0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038f6:	68 4d 78 10 80       	push   $0x8010784d
801038fb:	68 a0 2d 11 80       	push   $0x80112da0
80103900:	e8 cb 09 00 00       	call   801042d0 <initlock>
}
80103905:	83 c4 10             	add    $0x10,%esp
80103908:	c9                   	leave  
80103909:	c3                   	ret    
8010390a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103910 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
80103910:	55                   	push   %ebp
80103911:	89 e5                	mov    %esp,%ebp
80103913:	53                   	push   %ebx
80103914:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
80103917:	e8 c4 fe ff ff       	call   801037e0 <allocproc>
8010391c:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
8010391e:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
80103923:	e8 58 33 00 00       	call   80106c80 <setupkvm>
80103928:	85 c0                	test   %eax,%eax
8010392a:	89 43 04             	mov    %eax,0x4(%ebx)
8010392d:	0f 84 bd 00 00 00    	je     801039f0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103933:	83 ec 04             	sub    $0x4,%esp
80103936:	68 2c 00 00 00       	push   $0x2c
8010393b:	68 60 a4 10 80       	push   $0x8010a460
80103940:	50                   	push   %eax
80103941:	e8 ba 34 00 00       	call   80106e00 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103946:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103949:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010394f:	6a 4c                	push   $0x4c
80103951:	6a 00                	push   $0x0
80103953:	ff 73 18             	pushl  0x18(%ebx)
80103956:	e8 c5 0b 00 00       	call   80104520 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010395b:	8b 43 18             	mov    0x18(%ebx),%eax
8010395e:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103963:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103968:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010396b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010396f:	8b 43 18             	mov    0x18(%ebx),%eax
80103972:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103976:	8b 43 18             	mov    0x18(%ebx),%eax
80103979:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010397d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103981:	8b 43 18             	mov    0x18(%ebx),%eax
80103984:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103988:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010398c:	8b 43 18             	mov    0x18(%ebx),%eax
8010398f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103996:	8b 43 18             	mov    0x18(%ebx),%eax
80103999:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
801039a0:	8b 43 18             	mov    0x18(%ebx),%eax
801039a3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
801039aa:	8d 43 6c             	lea    0x6c(%ebx),%eax
801039ad:	6a 10                	push   $0x10
801039af:	68 6d 78 10 80       	push   $0x8010786d
801039b4:	50                   	push   %eax
801039b5:	e8 66 0d 00 00       	call   80104720 <safestrcpy>
  p->cwd = namei("/");
801039ba:	c7 04 24 76 78 10 80 	movl   $0x80107876,(%esp)
801039c1:	e8 5a e5 ff ff       	call   80101f20 <namei>
801039c6:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801039c9:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801039d0:	e8 1b 09 00 00       	call   801042f0 <acquire>

  p->state = RUNNABLE;
801039d5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801039dc:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801039e3:	e8 e8 0a 00 00       	call   801044d0 <release>
}
801039e8:	83 c4 10             	add    $0x10,%esp
801039eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ee:	c9                   	leave  
801039ef:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801039f0:	83 ec 0c             	sub    $0xc,%esp
801039f3:	68 54 78 10 80       	push   $0x80107854
801039f8:	e8 73 c9 ff ff       	call   80100370 <panic>
801039fd:	8d 76 00             	lea    0x0(%esi),%esi

80103a00 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	83 ec 08             	sub    $0x8,%esp
  uint sz;

  sz = proc->sz;
80103a06:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
80103a0d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint sz;

  sz = proc->sz;
80103a10:	8b 02                	mov    (%edx),%eax
  if(n > 0){
80103a12:	83 f9 00             	cmp    $0x0,%ecx
80103a15:	7e 39                	jle    80103a50 <growproc+0x50>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
80103a17:	83 ec 04             	sub    $0x4,%esp
80103a1a:	01 c1                	add    %eax,%ecx
80103a1c:	51                   	push   %ecx
80103a1d:	50                   	push   %eax
80103a1e:	ff 72 04             	pushl  0x4(%edx)
80103a21:	e8 1a 35 00 00       	call   80106f40 <allocuvm>
80103a26:	83 c4 10             	add    $0x10,%esp
80103a29:	85 c0                	test   %eax,%eax
80103a2b:	74 3b                	je     80103a68 <growproc+0x68>
80103a2d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
80103a34:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103a36:	83 ec 0c             	sub    $0xc,%esp
80103a39:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103a40:	e8 eb 32 00 00       	call   80106d30 <switchuvm>
  return 0;
80103a45:	83 c4 10             	add    $0x10,%esp
80103a48:	31 c0                	xor    %eax,%eax
}
80103a4a:	c9                   	leave  
80103a4b:	c3                   	ret    
80103a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103a50:	74 e2                	je     80103a34 <growproc+0x34>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103a52:	83 ec 04             	sub    $0x4,%esp
80103a55:	01 c1                	add    %eax,%ecx
80103a57:	51                   	push   %ecx
80103a58:	50                   	push   %eax
80103a59:	ff 72 04             	pushl  0x4(%edx)
80103a5c:	e8 ef 35 00 00       	call   80107050 <deallocuvm>
80103a61:	83 c4 10             	add    $0x10,%esp
80103a64:	85 c0                	test   %eax,%eax
80103a66:	75 c5                	jne    80103a2d <growproc+0x2d>
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
80103a68:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}
80103a6d:	c9                   	leave  
80103a6e:	c3                   	ret    
80103a6f:	90                   	nop

80103a70 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	57                   	push   %edi
80103a74:	56                   	push   %esi
80103a75:	53                   	push   %ebx
80103a76:	83 ec 0c             	sub    $0xc,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
80103a79:	e8 62 fd ff ff       	call   801037e0 <allocproc>
80103a7e:	85 c0                	test   %eax,%eax
80103a80:	0f 84 d6 00 00 00    	je     80103b5c <fork+0xec>
80103a86:	89 c3                	mov    %eax,%ebx
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103a88:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a8e:	83 ec 08             	sub    $0x8,%esp
80103a91:	ff 30                	pushl  (%eax)
80103a93:	ff 70 04             	pushl  0x4(%eax)
80103a96:	e8 95 36 00 00       	call   80107130 <copyuvm>
80103a9b:	83 c4 10             	add    $0x10,%esp
80103a9e:	85 c0                	test   %eax,%eax
80103aa0:	89 43 04             	mov    %eax,0x4(%ebx)
80103aa3:	0f 84 ba 00 00 00    	je     80103b63 <fork+0xf3>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
80103aa9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;
80103aaf:	8b 7b 18             	mov    0x18(%ebx),%edi
80103ab2:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
80103ab7:	8b 00                	mov    (%eax),%eax
80103ab9:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103abb:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ac1:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103ac4:	8b 70 18             	mov    0x18(%eax),%esi
80103ac7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103ac9:	31 f6                	xor    %esi,%esi
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103acb:	8b 43 18             	mov    0x18(%ebx),%eax
80103ace:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103ad5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
80103ae0:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103ae4:	85 c0                	test   %eax,%eax
80103ae6:	74 17                	je     80103aff <fork+0x8f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103ae8:	83 ec 0c             	sub    $0xc,%esp
80103aeb:	50                   	push   %eax
80103aec:	e8 cf d2 ff ff       	call   80100dc0 <filedup>
80103af1:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103af5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103afc:	83 c4 10             	add    $0x10,%esp
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103aff:	83 c6 01             	add    $0x1,%esi
80103b02:	83 fe 10             	cmp    $0x10,%esi
80103b05:	75 d9                	jne    80103ae0 <fork+0x70>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80103b07:	83 ec 0c             	sub    $0xc,%esp
80103b0a:	ff 72 68             	pushl  0x68(%edx)
80103b0d:	e8 0e db ff ff       	call   80101620 <idup>
80103b12:	89 43 68             	mov    %eax,0x68(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103b15:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103b1b:	83 c4 0c             	add    $0xc,%esp
80103b1e:	6a 10                	push   $0x10
80103b20:	83 c0 6c             	add    $0x6c,%eax
80103b23:	50                   	push   %eax
80103b24:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b27:	50                   	push   %eax
80103b28:	e8 f3 0b 00 00       	call   80104720 <safestrcpy>

  pid = np->pid;
80103b2d:	8b 73 10             	mov    0x10(%ebx),%esi

  acquire(&ptable.lock);
80103b30:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b37:	e8 b4 07 00 00       	call   801042f0 <acquire>

  np->state = RUNNABLE;
80103b3c:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103b43:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b4a:	e8 81 09 00 00       	call   801044d0 <release>

  return pid;
80103b4f:	83 c4 10             	add    $0x10,%esp
80103b52:	89 f0                	mov    %esi,%eax
}
80103b54:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b57:	5b                   	pop    %ebx
80103b58:	5e                   	pop    %esi
80103b59:	5f                   	pop    %edi
80103b5a:	5d                   	pop    %ebp
80103b5b:	c3                   	ret    
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103b5c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b61:	eb f1                	jmp    80103b54 <fork+0xe4>
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
80103b63:	83 ec 0c             	sub    $0xc,%esp
80103b66:	ff 73 08             	pushl  0x8(%ebx)
80103b69:	e8 f2 e7 ff ff       	call   80102360 <kfree>
    np->kstack = 0;
80103b6e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103b75:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b7c:	83 c4 10             	add    $0x10,%esp
80103b7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b84:	eb ce                	jmp    80103b54 <fork+0xe4>
80103b86:	8d 76 00             	lea    0x0(%esi),%esi
80103b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b90 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103b90:	55                   	push   %ebp
80103b91:	89 e5                	mov    %esp,%ebp
80103b93:	53                   	push   %ebx
80103b94:	83 ec 04             	sub    $0x4,%esp
80103b97:	89 f6                	mov    %esi,%esi
80103b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103ba0:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103ba1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ba4:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103ba9:	68 a0 2d 11 80       	push   $0x80112da0
80103bae:	e8 3d 07 00 00       	call   801042f0 <acquire>
80103bb3:	83 c4 10             	add    $0x10,%esp
80103bb6:	eb 13                	jmp    80103bcb <scheduler+0x3b>
80103bb8:	90                   	nop
80103bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bc0:	83 c3 7c             	add    $0x7c,%ebx
80103bc3:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103bc9:	74 55                	je     80103c20 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103bcb:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103bcf:	75 ef                	jne    80103bc0 <scheduler+0x30>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103bd1:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80103bd4:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103bdb:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bdc:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103bdf:	e8 4c 31 00 00       	call   80106d30 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, p->context);
80103be4:	58                   	pop    %eax
80103be5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103beb:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)
      swtch(&cpu->scheduler, p->context);
80103bf2:	5a                   	pop    %edx
80103bf3:	ff 73 a0             	pushl  -0x60(%ebx)
80103bf6:	83 c0 04             	add    $0x4,%eax
80103bf9:	50                   	push   %eax
80103bfa:	e8 7c 0b 00 00       	call   8010477b <swtch>
      switchkvm();
80103bff:	e8 0c 31 00 00       	call   80106d10 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103c04:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c07:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
      swtch(&cpu->scheduler, p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103c0d:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103c14:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c18:	75 b1                	jne    80103bcb <scheduler+0x3b>
80103c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80103c20:	83 ec 0c             	sub    $0xc,%esp
80103c23:	68 a0 2d 11 80       	push   $0x80112da0
80103c28:	e8 a3 08 00 00       	call   801044d0 <release>

  }
80103c2d:	83 c4 10             	add    $0x10,%esp
80103c30:	e9 6b ff ff ff       	jmp    80103ba0 <scheduler+0x10>
80103c35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c40 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103c40:	55                   	push   %ebp
80103c41:	89 e5                	mov    %esp,%ebp
80103c43:	53                   	push   %ebx
80103c44:	83 ec 10             	sub    $0x10,%esp
  int intena;

  if(!holding(&ptable.lock))
80103c47:	68 a0 2d 11 80       	push   $0x80112da0
80103c4c:	e8 cf 07 00 00       	call   80104420 <holding>
80103c51:	83 c4 10             	add    $0x10,%esp
80103c54:	85 c0                	test   %eax,%eax
80103c56:	74 4c                	je     80103ca4 <sched+0x64>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
80103c58:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103c5f:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103c66:	75 63                	jne    80103ccb <sched+0x8b>
    panic("sched locks");
  if(proc->state == RUNNING)
80103c68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c6e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103c72:	74 4a                	je     80103cbe <sched+0x7e>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c74:	9c                   	pushf  
80103c75:	59                   	pop    %ecx
    panic("sched running");
  if(readeflags()&FL_IF)
80103c76:	80 e5 02             	and    $0x2,%ch
80103c79:	75 36                	jne    80103cb1 <sched+0x71>
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
80103c7b:	83 ec 08             	sub    $0x8,%esp
80103c7e:	83 c0 1c             	add    $0x1c,%eax
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
80103c81:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103c87:	ff 72 04             	pushl  0x4(%edx)
80103c8a:	50                   	push   %eax
80103c8b:	e8 eb 0a 00 00       	call   8010477b <swtch>
  cpu->intena = intena;
80103c90:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103c96:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
80103c99:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103c9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ca2:	c9                   	leave  
80103ca3:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103ca4:	83 ec 0c             	sub    $0xc,%esp
80103ca7:	68 78 78 10 80       	push   $0x80107878
80103cac:	e8 bf c6 ff ff       	call   80100370 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103cb1:	83 ec 0c             	sub    $0xc,%esp
80103cb4:	68 a4 78 10 80       	push   $0x801078a4
80103cb9:	e8 b2 c6 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
80103cbe:	83 ec 0c             	sub    $0xc,%esp
80103cc1:	68 96 78 10 80       	push   $0x80107896
80103cc6:	e8 a5 c6 ff ff       	call   80100370 <panic>
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
80103ccb:	83 ec 0c             	sub    $0xc,%esp
80103cce:	68 8a 78 10 80       	push   $0x8010788a
80103cd3:	e8 98 c6 ff ff       	call   80100370 <panic>
80103cd8:	90                   	nop
80103cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ce0 <exit>:
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
80103ce0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103ce7:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103ced:	55                   	push   %ebp
80103cee:	89 e5                	mov    %esp,%ebp
80103cf0:	56                   	push   %esi
80103cf1:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
80103cf2:	0f 84 1f 01 00 00    	je     80103e17 <exit+0x137>
80103cf8:	31 db                	xor    %ebx,%ebx
80103cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
80103d00:	8d 73 08             	lea    0x8(%ebx),%esi
80103d03:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103d07:	85 c0                	test   %eax,%eax
80103d09:	74 1b                	je     80103d26 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103d0b:	83 ec 0c             	sub    $0xc,%esp
80103d0e:	50                   	push   %eax
80103d0f:	e8 fc d0 ff ff       	call   80100e10 <fileclose>
      proc->ofile[fd] = 0;
80103d14:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103d1b:	83 c4 10             	add    $0x10,%esp
80103d1e:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103d25:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103d26:	83 c3 01             	add    $0x1,%ebx
80103d29:	83 fb 10             	cmp    $0x10,%ebx
80103d2c:	75 d2                	jne    80103d00 <exit+0x20>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80103d2e:	e8 1d ef ff ff       	call   80102c50 <begin_op>
  iput(proc->cwd);
80103d33:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d39:	83 ec 0c             	sub    $0xc,%esp
80103d3c:	ff 70 68             	pushl  0x68(%eax)
80103d3f:	e8 3c da ff ff       	call   80101780 <iput>
  end_op();
80103d44:	e8 77 ef ff ff       	call   80102cc0 <end_op>
  proc->cwd = 0;
80103d49:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d4f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80103d56:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d5d:	e8 8e 05 00 00       	call   801042f0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103d62:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103d69:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d6c:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103d71:	8b 51 14             	mov    0x14(%ecx),%edx
80103d74:	eb 14                	jmp    80103d8a <exit+0xaa>
80103d76:	8d 76 00             	lea    0x0(%esi),%esi
80103d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d80:	83 c0 7c             	add    $0x7c,%eax
80103d83:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103d88:	74 1c                	je     80103da6 <exit+0xc6>
    if(p->state == SLEEPING && p->chan == chan)
80103d8a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d8e:	75 f0                	jne    80103d80 <exit+0xa0>
80103d90:	3b 50 20             	cmp    0x20(%eax),%edx
80103d93:	75 eb                	jne    80103d80 <exit+0xa0>
      p->state = RUNNABLE;
80103d95:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d9c:	83 c0 7c             	add    $0x7c,%eax
80103d9f:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103da4:	75 e4                	jne    80103d8a <exit+0xaa>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103da6:	8b 1d bc a5 10 80    	mov    0x8010a5bc,%ebx
80103dac:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103db1:	eb 10                	jmp    80103dc3 <exit+0xe3>
80103db3:	90                   	nop
80103db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103db8:	83 c2 7c             	add    $0x7c,%edx
80103dbb:	81 fa d4 4c 11 80    	cmp    $0x80114cd4,%edx
80103dc1:	74 3b                	je     80103dfe <exit+0x11e>
    if(p->parent == proc){
80103dc3:	3b 4a 14             	cmp    0x14(%edx),%ecx
80103dc6:	75 f0                	jne    80103db8 <exit+0xd8>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103dc8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103dcc:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
80103dcf:	75 e7                	jne    80103db8 <exit+0xd8>
80103dd1:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103dd6:	eb 12                	jmp    80103dea <exit+0x10a>
80103dd8:	90                   	nop
80103dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103de0:	83 c0 7c             	add    $0x7c,%eax
80103de3:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103de8:	74 ce                	je     80103db8 <exit+0xd8>
    if(p->state == SLEEPING && p->chan == chan)
80103dea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dee:	75 f0                	jne    80103de0 <exit+0x100>
80103df0:	3b 58 20             	cmp    0x20(%eax),%ebx
80103df3:	75 eb                	jne    80103de0 <exit+0x100>
      p->state = RUNNABLE;
80103df5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103dfc:	eb e2                	jmp    80103de0 <exit+0x100>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80103dfe:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
80103e05:	e8 36 fe ff ff       	call   80103c40 <sched>
  panic("zombie exit");
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 c5 78 10 80       	push   $0x801078c5
80103e12:	e8 59 c5 ff ff       	call   80100370 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103e17:	83 ec 0c             	sub    $0xc,%esp
80103e1a:	68 b8 78 10 80       	push   $0x801078b8
80103e1f:	e8 4c c5 ff ff       	call   80100370 <panic>
80103e24:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e2a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e30 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e36:	68 a0 2d 11 80       	push   $0x80112da0
80103e3b:	e8 b0 04 00 00       	call   801042f0 <acquire>
  proc->state = RUNNABLE;
80103e40:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e46:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103e4d:	e8 ee fd ff ff       	call   80103c40 <sched>
  release(&ptable.lock);
80103e52:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e59:	e8 72 06 00 00       	call   801044d0 <release>
}
80103e5e:	83 c4 10             	add    $0x10,%esp
80103e61:	c9                   	leave  
80103e62:	c3                   	ret    
80103e63:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e70 <sleep>:
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
80103e70:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103e76:	55                   	push   %ebp
80103e77:	89 e5                	mov    %esp,%ebp
80103e79:	56                   	push   %esi
80103e7a:	53                   	push   %ebx
  if(proc == 0)
80103e7b:	85 c0                	test   %eax,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103e7d:	8b 75 08             	mov    0x8(%ebp),%esi
80103e80:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103e83:	0f 84 97 00 00 00    	je     80103f20 <sleep+0xb0>
    panic("sleep");

  if(lk == 0)
80103e89:	85 db                	test   %ebx,%ebx
80103e8b:	0f 84 82 00 00 00    	je     80103f13 <sleep+0xa3>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e91:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103e97:	74 57                	je     80103ef0 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e99:	83 ec 0c             	sub    $0xc,%esp
80103e9c:	68 a0 2d 11 80       	push   $0x80112da0
80103ea1:	e8 4a 04 00 00       	call   801042f0 <acquire>
    release(lk);
80103ea6:	89 1c 24             	mov    %ebx,(%esp)
80103ea9:	e8 22 06 00 00       	call   801044d0 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80103eae:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103eb4:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103eb7:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103ebe:	e8 7d fd ff ff       	call   80103c40 <sched>

  // Tidy up.
  proc->chan = 0;
80103ec3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ec9:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103ed0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103ed7:	e8 f4 05 00 00       	call   801044d0 <release>
    acquire(lk);
80103edc:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103edf:	83 c4 10             	add    $0x10,%esp
  }
}
80103ee2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ee5:	5b                   	pop    %ebx
80103ee6:	5e                   	pop    %esi
80103ee7:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103ee8:	e9 03 04 00 00       	jmp    801042f0 <acquire>
80103eed:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
80103ef0:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103ef3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103efa:	e8 41 fd ff ff       	call   80103c40 <sched>

  // Tidy up.
  proc->chan = 0;
80103eff:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103f05:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103f0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f0f:	5b                   	pop    %ebx
80103f10:	5e                   	pop    %esi
80103f11:	5d                   	pop    %ebp
80103f12:	c3                   	ret    
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103f13:	83 ec 0c             	sub    $0xc,%esp
80103f16:	68 d7 78 10 80       	push   $0x801078d7
80103f1b:	e8 50 c4 ff ff       	call   80100370 <panic>
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
80103f20:	83 ec 0c             	sub    $0xc,%esp
80103f23:	68 d1 78 10 80       	push   $0x801078d1
80103f28:	e8 43 c4 ff ff       	call   80100370 <panic>
80103f2d:	8d 76 00             	lea    0x0(%esi),%esi

80103f30 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	56                   	push   %esi
80103f34:	53                   	push   %ebx
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103f35:	83 ec 0c             	sub    $0xc,%esp
80103f38:	68 a0 2d 11 80       	push   $0x80112da0
80103f3d:	e8 ae 03 00 00       	call   801042f0 <acquire>
80103f42:	83 c4 10             	add    $0x10,%esp
80103f45:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103f4b:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f4d:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103f52:	eb 0f                	jmp    80103f63 <wait+0x33>
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f58:	83 c3 7c             	add    $0x7c,%ebx
80103f5b:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103f61:	74 1d                	je     80103f80 <wait+0x50>
      if(p->parent != proc)
80103f63:	3b 43 14             	cmp    0x14(%ebx),%eax
80103f66:	75 f0                	jne    80103f58 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103f68:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f6c:	74 30                	je     80103f9e <wait+0x6e>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f6e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != proc)
        continue;
      havekids = 1;
80103f71:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f76:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103f7c:	75 e5                	jne    80103f63 <wait+0x33>
80103f7e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103f80:	85 d2                	test   %edx,%edx
80103f82:	74 70                	je     80103ff4 <wait+0xc4>
80103f84:	8b 50 24             	mov    0x24(%eax),%edx
80103f87:	85 d2                	test   %edx,%edx
80103f89:	75 69                	jne    80103ff4 <wait+0xc4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103f8b:	83 ec 08             	sub    $0x8,%esp
80103f8e:	68 a0 2d 11 80       	push   $0x80112da0
80103f93:	50                   	push   %eax
80103f94:	e8 d7 fe ff ff       	call   80103e70 <sleep>
  }
80103f99:	83 c4 10             	add    $0x10,%esp
80103f9c:	eb a7                	jmp    80103f45 <wait+0x15>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103f9e:	83 ec 0c             	sub    $0xc,%esp
80103fa1:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103fa4:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103fa7:	e8 b4 e3 ff ff       	call   80102360 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103fac:	59                   	pop    %ecx
80103fad:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103fb0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103fb7:	e8 c4 30 00 00       	call   80107080 <freevm>
        p->pid = 0;
80103fbc:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fc3:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103fca:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fce:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fd5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fdc:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103fe3:	e8 e8 04 00 00       	call   801044d0 <release>
        return pid;
80103fe8:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103feb:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103fee:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103ff0:	5b                   	pop    %ebx
80103ff1:	5e                   	pop    %esi
80103ff2:	5d                   	pop    %ebp
80103ff3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80103ff4:	83 ec 0c             	sub    $0xc,%esp
80103ff7:	68 a0 2d 11 80       	push   $0x80112da0
80103ffc:	e8 cf 04 00 00       	call   801044d0 <release>
      return -1;
80104001:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80104004:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
80104007:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
8010400c:	5b                   	pop    %ebx
8010400d:	5e                   	pop    %esi
8010400e:	5d                   	pop    %ebp
8010400f:	c3                   	ret    

80104010 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104010:	55                   	push   %ebp
80104011:	89 e5                	mov    %esp,%ebp
80104013:	53                   	push   %ebx
80104014:	83 ec 10             	sub    $0x10,%esp
80104017:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010401a:	68 a0 2d 11 80       	push   $0x80112da0
8010401f:	e8 cc 02 00 00       	call   801042f0 <acquire>
80104024:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104027:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010402c:	eb 0c                	jmp    8010403a <wakeup+0x2a>
8010402e:	66 90                	xchg   %ax,%ax
80104030:	83 c0 7c             	add    $0x7c,%eax
80104033:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80104038:	74 1c                	je     80104056 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010403a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010403e:	75 f0                	jne    80104030 <wakeup+0x20>
80104040:	3b 58 20             	cmp    0x20(%eax),%ebx
80104043:	75 eb                	jne    80104030 <wakeup+0x20>
      p->state = RUNNABLE;
80104045:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010404c:	83 c0 7c             	add    $0x7c,%eax
8010404f:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80104054:	75 e4                	jne    8010403a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104056:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
8010405d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104060:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104061:	e9 6a 04 00 00       	jmp    801044d0 <release>
80104066:	8d 76 00             	lea    0x0(%esi),%esi
80104069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104070 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104070:	55                   	push   %ebp
80104071:	89 e5                	mov    %esp,%ebp
80104073:	53                   	push   %ebx
80104074:	83 ec 10             	sub    $0x10,%esp
80104077:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010407a:	68 a0 2d 11 80       	push   $0x80112da0
8010407f:	e8 6c 02 00 00       	call   801042f0 <acquire>
80104084:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104087:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010408c:	eb 0c                	jmp    8010409a <kill+0x2a>
8010408e:	66 90                	xchg   %ax,%ax
80104090:	83 c0 7c             	add    $0x7c,%eax
80104093:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80104098:	74 3e                	je     801040d8 <kill+0x68>
    if(p->pid == pid){
8010409a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010409d:	75 f1                	jne    80104090 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010409f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
801040a3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801040aa:	74 1c                	je     801040c8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
801040ac:	83 ec 0c             	sub    $0xc,%esp
801040af:	68 a0 2d 11 80       	push   $0x80112da0
801040b4:	e8 17 04 00 00       	call   801044d0 <release>
      return 0;
801040b9:	83 c4 10             	add    $0x10,%esp
801040bc:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
801040be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040c1:	c9                   	leave  
801040c2:	c3                   	ret    
801040c3:	90                   	nop
801040c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
801040c8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040cf:	eb db                	jmp    801040ac <kill+0x3c>
801040d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801040d8:	83 ec 0c             	sub    $0xc,%esp
801040db:	68 a0 2d 11 80       	push   $0x80112da0
801040e0:	e8 eb 03 00 00       	call   801044d0 <release>
  return -1;
801040e5:	83 c4 10             	add    $0x10,%esp
801040e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040f0:	c9                   	leave  
801040f1:	c3                   	ret    
801040f2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104100 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	57                   	push   %edi
80104104:	56                   	push   %esi
80104105:	53                   	push   %ebx
80104106:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104109:	bb 40 2e 11 80       	mov    $0x80112e40,%ebx
8010410e:	83 ec 3c             	sub    $0x3c,%esp
80104111:	eb 24                	jmp    80104137 <procdump+0x37>
80104113:	90                   	nop
80104114:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104118:	83 ec 0c             	sub    $0xc,%esp
8010411b:	68 26 78 10 80       	push   $0x80107826
80104120:	e8 3b c5 ff ff       	call   80100660 <cprintf>
80104125:	83 c4 10             	add    $0x10,%esp
80104128:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010412b:	81 fb 40 4d 11 80    	cmp    $0x80114d40,%ebx
80104131:	0f 84 81 00 00 00    	je     801041b8 <procdump+0xb8>
    if(p->state == UNUSED)
80104137:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010413a:	85 c0                	test   %eax,%eax
8010413c:	74 ea                	je     80104128 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010413e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104141:	ba e8 78 10 80       	mov    $0x801078e8,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104146:	77 11                	ja     80104159 <procdump+0x59>
80104148:	8b 14 85 20 79 10 80 	mov    -0x7fef86e0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010414f:	b8 e8 78 10 80       	mov    $0x801078e8,%eax
80104154:	85 d2                	test   %edx,%edx
80104156:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104159:	53                   	push   %ebx
8010415a:	52                   	push   %edx
8010415b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010415e:	68 ec 78 10 80       	push   $0x801078ec
80104163:	e8 f8 c4 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104168:	83 c4 10             	add    $0x10,%esp
8010416b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010416f:	75 a7                	jne    80104118 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104171:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104174:	83 ec 08             	sub    $0x8,%esp
80104177:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010417a:	50                   	push   %eax
8010417b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010417e:	8b 40 0c             	mov    0xc(%eax),%eax
80104181:	83 c0 08             	add    $0x8,%eax
80104184:	50                   	push   %eax
80104185:	e8 36 02 00 00       	call   801043c0 <getcallerpcs>
8010418a:	83 c4 10             	add    $0x10,%esp
8010418d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104190:	8b 17                	mov    (%edi),%edx
80104192:	85 d2                	test   %edx,%edx
80104194:	74 82                	je     80104118 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104196:	83 ec 08             	sub    $0x8,%esp
80104199:	83 c7 04             	add    $0x4,%edi
8010419c:	52                   	push   %edx
8010419d:	68 49 73 10 80       	push   $0x80107349
801041a2:	e8 b9 c4 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
801041a7:	83 c4 10             	add    $0x10,%esp
801041aa:	39 f7                	cmp    %esi,%edi
801041ac:	75 e2                	jne    80104190 <procdump+0x90>
801041ae:	e9 65 ff ff ff       	jmp    80104118 <procdump+0x18>
801041b3:	90                   	nop
801041b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
801041b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801041bb:	5b                   	pop    %ebx
801041bc:	5e                   	pop    %esi
801041bd:	5f                   	pop    %edi
801041be:	5d                   	pop    %ebp
801041bf:	c3                   	ret    

801041c0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801041c0:	55                   	push   %ebp
801041c1:	89 e5                	mov    %esp,%ebp
801041c3:	53                   	push   %ebx
801041c4:	83 ec 0c             	sub    $0xc,%esp
801041c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801041ca:	68 38 79 10 80       	push   $0x80107938
801041cf:	8d 43 04             	lea    0x4(%ebx),%eax
801041d2:	50                   	push   %eax
801041d3:	e8 f8 00 00 00       	call   801042d0 <initlock>
  lk->name = name;
801041d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801041db:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801041e1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801041e4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801041eb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801041ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041f1:	c9                   	leave  
801041f2:	c3                   	ret    
801041f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104200 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
80104205:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104208:	83 ec 0c             	sub    $0xc,%esp
8010420b:	8d 73 04             	lea    0x4(%ebx),%esi
8010420e:	56                   	push   %esi
8010420f:	e8 dc 00 00 00       	call   801042f0 <acquire>
  while (lk->locked) {
80104214:	8b 13                	mov    (%ebx),%edx
80104216:	83 c4 10             	add    $0x10,%esp
80104219:	85 d2                	test   %edx,%edx
8010421b:	74 16                	je     80104233 <acquiresleep+0x33>
8010421d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104220:	83 ec 08             	sub    $0x8,%esp
80104223:	56                   	push   %esi
80104224:	53                   	push   %ebx
80104225:	e8 46 fc ff ff       	call   80103e70 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010422a:	8b 03                	mov    (%ebx),%eax
8010422c:	83 c4 10             	add    $0x10,%esp
8010422f:	85 c0                	test   %eax,%eax
80104231:	75 ed                	jne    80104220 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104233:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
80104239:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010423f:	8b 40 10             	mov    0x10(%eax),%eax
80104242:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104245:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104248:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010424b:	5b                   	pop    %ebx
8010424c:	5e                   	pop    %esi
8010424d:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = proc->pid;
  release(&lk->lk);
8010424e:	e9 7d 02 00 00       	jmp    801044d0 <release>
80104253:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104260 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104260:	55                   	push   %ebp
80104261:	89 e5                	mov    %esp,%ebp
80104263:	56                   	push   %esi
80104264:	53                   	push   %ebx
80104265:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104268:	83 ec 0c             	sub    $0xc,%esp
8010426b:	8d 73 04             	lea    0x4(%ebx),%esi
8010426e:	56                   	push   %esi
8010426f:	e8 7c 00 00 00       	call   801042f0 <acquire>
  lk->locked = 0;
80104274:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010427a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104281:	89 1c 24             	mov    %ebx,(%esp)
80104284:	e8 87 fd ff ff       	call   80104010 <wakeup>
  release(&lk->lk);
80104289:	89 75 08             	mov    %esi,0x8(%ebp)
8010428c:	83 c4 10             	add    $0x10,%esp
}
8010428f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104292:	5b                   	pop    %ebx
80104293:	5e                   	pop    %esi
80104294:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104295:	e9 36 02 00 00       	jmp    801044d0 <release>
8010429a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042a0 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	56                   	push   %esi
801042a4:	53                   	push   %ebx
801042a5:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
801042a8:	83 ec 0c             	sub    $0xc,%esp
801042ab:	8d 5e 04             	lea    0x4(%esi),%ebx
801042ae:	53                   	push   %ebx
801042af:	e8 3c 00 00 00       	call   801042f0 <acquire>
  r = lk->locked;
801042b4:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
801042b6:	89 1c 24             	mov    %ebx,(%esp)
801042b9:	e8 12 02 00 00       	call   801044d0 <release>
  return r;
}
801042be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042c1:	89 f0                	mov    %esi,%eax
801042c3:	5b                   	pop    %ebx
801042c4:	5e                   	pop    %esi
801042c5:	5d                   	pop    %ebp
801042c6:	c3                   	ret    
801042c7:	66 90                	xchg   %ax,%ax
801042c9:	66 90                	xchg   %ax,%ax
801042cb:	66 90                	xchg   %ax,%ax
801042cd:	66 90                	xchg   %ax,%ax
801042cf:	90                   	nop

801042d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801042d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801042d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801042df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801042e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801042e9:	5d                   	pop    %ebp
801042ea:	c3                   	ret    
801042eb:	90                   	nop
801042ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042f0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801042f0:	55                   	push   %ebp
801042f1:	89 e5                	mov    %esp,%ebp
801042f3:	53                   	push   %ebx
801042f4:	83 ec 04             	sub    $0x4,%esp
801042f7:	9c                   	pushf  
801042f8:	5a                   	pop    %edx
}

static inline void
cli(void)
{
  asm volatile("cli");
801042f9:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801042fa:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
80104301:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
80104307:	85 c0                	test   %eax,%eax
80104309:	75 0c                	jne    80104317 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
8010430b:	81 e2 00 02 00 00    	and    $0x200,%edx
80104311:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
80104317:	8b 55 08             	mov    0x8(%ebp),%edx

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
    cpu->intena = eflags & FL_IF;
  cpu->ncli += 1;
8010431a:	83 c0 01             	add    $0x1,%eax
8010431d:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104323:	8b 02                	mov    (%edx),%eax
80104325:	85 c0                	test   %eax,%eax
80104327:	74 05                	je     8010432e <acquire+0x3e>
80104329:	39 4a 08             	cmp    %ecx,0x8(%edx)
8010432c:	74 7a                	je     801043a8 <acquire+0xb8>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010432e:	b9 01 00 00 00       	mov    $0x1,%ecx
80104333:	90                   	nop
80104334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104338:	89 c8                	mov    %ecx,%eax
8010433a:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
8010433d:	85 c0                	test   %eax,%eax
8010433f:	75 f7                	jne    80104338 <acquire+0x48>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80104341:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104346:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104349:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010434f:	89 ea                	mov    %ebp,%edx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104351:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
80104354:	83 c1 0c             	add    $0xc,%ecx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104357:	31 c0                	xor    %eax,%eax
80104359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104360:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104366:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010436c:	77 1a                	ja     80104388 <acquire+0x98>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010436e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104371:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104374:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104377:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104379:	83 f8 0a             	cmp    $0xa,%eax
8010437c:	75 e2                	jne    80104360 <acquire+0x70>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  getcallerpcs(&lk, lk->pcs);
}
8010437e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104381:	c9                   	leave  
80104382:	c3                   	ret    
80104383:	90                   	nop
80104384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104388:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010438f:	83 c0 01             	add    $0x1,%eax
80104392:	83 f8 0a             	cmp    $0xa,%eax
80104395:	74 e7                	je     8010437e <acquire+0x8e>
    pcs[i] = 0;
80104397:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010439e:	83 c0 01             	add    $0x1,%eax
801043a1:	83 f8 0a             	cmp    $0xa,%eax
801043a4:	75 e2                	jne    80104388 <acquire+0x98>
801043a6:	eb d6                	jmp    8010437e <acquire+0x8e>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
801043a8:	83 ec 0c             	sub    $0xc,%esp
801043ab:	68 43 79 10 80       	push   $0x80107943
801043b0:	e8 bb bf ff ff       	call   80100370 <panic>
801043b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043c0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043c4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043ca:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801043cd:	31 c0                	xor    %eax,%eax
801043cf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043d0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801043d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043dc:	77 1a                	ja     801043f8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043de:	8b 5a 04             	mov    0x4(%edx),%ebx
801043e1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043e4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801043e7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043e9:	83 f8 0a             	cmp    $0xa,%eax
801043ec:	75 e2                	jne    801043d0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043ee:	5b                   	pop    %ebx
801043ef:	5d                   	pop    %ebp
801043f0:	c3                   	ret    
801043f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801043f8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801043ff:	83 c0 01             	add    $0x1,%eax
80104402:	83 f8 0a             	cmp    $0xa,%eax
80104405:	74 e7                	je     801043ee <getcallerpcs+0x2e>
    pcs[i] = 0;
80104407:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010440e:	83 c0 01             	add    $0x1,%eax
80104411:	83 f8 0a             	cmp    $0xa,%eax
80104414:	75 e2                	jne    801043f8 <getcallerpcs+0x38>
80104416:	eb d6                	jmp    801043ee <getcallerpcs+0x2e>
80104418:	90                   	nop
80104419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104420 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104420:	55                   	push   %ebp
80104421:	89 e5                	mov    %esp,%ebp
80104423:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104426:	8b 02                	mov    (%edx),%eax
80104428:	85 c0                	test   %eax,%eax
8010442a:	74 14                	je     80104440 <holding+0x20>
8010442c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104432:	39 42 08             	cmp    %eax,0x8(%edx)
}
80104435:	5d                   	pop    %ebp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104436:	0f 94 c0             	sete   %al
80104439:	0f b6 c0             	movzbl %al,%eax
}
8010443c:	c3                   	ret    
8010443d:	8d 76 00             	lea    0x0(%esi),%esi
80104440:	31 c0                	xor    %eax,%eax
80104442:	5d                   	pop    %ebp
80104443:	c3                   	ret    
80104444:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010444a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104450 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104450:	55                   	push   %ebp
80104451:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104453:	9c                   	pushf  
80104454:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104455:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
80104456:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010445d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104463:	85 c0                	test   %eax,%eax
80104465:	75 0c                	jne    80104473 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
80104467:	81 e1 00 02 00 00    	and    $0x200,%ecx
8010446d:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
80104473:	83 c0 01             	add    $0x1,%eax
80104476:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
8010447c:	5d                   	pop    %ebp
8010447d:	c3                   	ret    
8010447e:	66 90                	xchg   %ax,%ax

80104480 <popcli>:

void
popcli(void)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104486:	9c                   	pushf  
80104487:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104488:	f6 c4 02             	test   $0x2,%ah
8010448b:	75 2c                	jne    801044b9 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
8010448d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104494:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
8010449b:	78 0f                	js     801044ac <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
8010449d:	75 0b                	jne    801044aa <popcli+0x2a>
8010449f:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
801044a5:	85 c0                	test   %eax,%eax
801044a7:	74 01                	je     801044aa <popcli+0x2a>
}

static inline void
sti(void)
{
  asm volatile("sti");
801044a9:	fb                   	sti    
    sti();
}
801044aa:	c9                   	leave  
801044ab:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
801044ac:	83 ec 0c             	sub    $0xc,%esp
801044af:	68 62 79 10 80       	push   $0x80107962
801044b4:	e8 b7 be ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
801044b9:	83 ec 0c             	sub    $0xc,%esp
801044bc:	68 4b 79 10 80       	push   $0x8010794b
801044c1:	e8 aa be ff ff       	call   80100370 <panic>
801044c6:	8d 76 00             	lea    0x0(%esi),%esi
801044c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044d0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	83 ec 08             	sub    $0x8,%esp
801044d6:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801044d9:	8b 10                	mov    (%eax),%edx
801044db:	85 d2                	test   %edx,%edx
801044dd:	74 0c                	je     801044eb <release+0x1b>
801044df:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801044e6:	39 50 08             	cmp    %edx,0x8(%eax)
801044e9:	74 15                	je     80104500 <release+0x30>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801044eb:	83 ec 0c             	sub    $0xc,%esp
801044ee:	68 69 79 10 80       	push   $0x80107969
801044f3:	e8 78 be ff ff       	call   80100370 <panic>
801044f8:	90                   	nop
801044f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  lk->pcs[0] = 0;
80104500:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
80104507:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
8010450e:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104513:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
80104519:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
8010451a:	e9 61 ff ff ff       	jmp    80104480 <popcli>
8010451f:	90                   	nop

80104520 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	57                   	push   %edi
80104524:	53                   	push   %ebx
80104525:	8b 55 08             	mov    0x8(%ebp),%edx
80104528:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010452b:	f6 c2 03             	test   $0x3,%dl
8010452e:	75 05                	jne    80104535 <memset+0x15>
80104530:	f6 c1 03             	test   $0x3,%cl
80104533:	74 13                	je     80104548 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104535:	89 d7                	mov    %edx,%edi
80104537:	8b 45 0c             	mov    0xc(%ebp),%eax
8010453a:	fc                   	cld    
8010453b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010453d:	5b                   	pop    %ebx
8010453e:	89 d0                	mov    %edx,%eax
80104540:	5f                   	pop    %edi
80104541:	5d                   	pop    %ebp
80104542:	c3                   	ret    
80104543:	90                   	nop
80104544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104548:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010454c:	c1 e9 02             	shr    $0x2,%ecx
8010454f:	89 fb                	mov    %edi,%ebx
80104551:	89 f8                	mov    %edi,%eax
80104553:	c1 e3 18             	shl    $0x18,%ebx
80104556:	c1 e0 10             	shl    $0x10,%eax
80104559:	09 d8                	or     %ebx,%eax
8010455b:	09 f8                	or     %edi,%eax
8010455d:	c1 e7 08             	shl    $0x8,%edi
80104560:	09 f8                	or     %edi,%eax
80104562:	89 d7                	mov    %edx,%edi
80104564:	fc                   	cld    
80104565:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104567:	5b                   	pop    %ebx
80104568:	89 d0                	mov    %edx,%eax
8010456a:	5f                   	pop    %edi
8010456b:	5d                   	pop    %ebp
8010456c:	c3                   	ret    
8010456d:	8d 76 00             	lea    0x0(%esi),%esi

80104570 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	57                   	push   %edi
80104574:	56                   	push   %esi
80104575:	8b 45 10             	mov    0x10(%ebp),%eax
80104578:	53                   	push   %ebx
80104579:	8b 75 0c             	mov    0xc(%ebp),%esi
8010457c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010457f:	85 c0                	test   %eax,%eax
80104581:	74 29                	je     801045ac <memcmp+0x3c>
    if(*s1 != *s2)
80104583:	0f b6 13             	movzbl (%ebx),%edx
80104586:	0f b6 0e             	movzbl (%esi),%ecx
80104589:	38 d1                	cmp    %dl,%cl
8010458b:	75 2b                	jne    801045b8 <memcmp+0x48>
8010458d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104590:	31 c0                	xor    %eax,%eax
80104592:	eb 14                	jmp    801045a8 <memcmp+0x38>
80104594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104598:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010459d:	83 c0 01             	add    $0x1,%eax
801045a0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801045a4:	38 ca                	cmp    %cl,%dl
801045a6:	75 10                	jne    801045b8 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801045a8:	39 f8                	cmp    %edi,%eax
801045aa:	75 ec                	jne    80104598 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
801045ac:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
801045ad:	31 c0                	xor    %eax,%eax
}
801045af:	5e                   	pop    %esi
801045b0:	5f                   	pop    %edi
801045b1:	5d                   	pop    %ebp
801045b2:	c3                   	ret    
801045b3:	90                   	nop
801045b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801045b8:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
801045bb:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
801045bc:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
801045be:	5e                   	pop    %esi
801045bf:	5f                   	pop    %edi
801045c0:	5d                   	pop    %ebp
801045c1:	c3                   	ret    
801045c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045d0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	56                   	push   %esi
801045d4:	53                   	push   %ebx
801045d5:	8b 45 08             	mov    0x8(%ebp),%eax
801045d8:	8b 75 0c             	mov    0xc(%ebp),%esi
801045db:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801045de:	39 c6                	cmp    %eax,%esi
801045e0:	73 2e                	jae    80104610 <memmove+0x40>
801045e2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801045e5:	39 c8                	cmp    %ecx,%eax
801045e7:	73 27                	jae    80104610 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801045e9:	85 db                	test   %ebx,%ebx
801045eb:	8d 53 ff             	lea    -0x1(%ebx),%edx
801045ee:	74 17                	je     80104607 <memmove+0x37>
      *--d = *--s;
801045f0:	29 d9                	sub    %ebx,%ecx
801045f2:	89 cb                	mov    %ecx,%ebx
801045f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045f8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801045fc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801045ff:	83 ea 01             	sub    $0x1,%edx
80104602:	83 fa ff             	cmp    $0xffffffff,%edx
80104605:	75 f1                	jne    801045f8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104607:	5b                   	pop    %ebx
80104608:	5e                   	pop    %esi
80104609:	5d                   	pop    %ebp
8010460a:	c3                   	ret    
8010460b:	90                   	nop
8010460c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
80104610:	31 d2                	xor    %edx,%edx
80104612:	85 db                	test   %ebx,%ebx
80104614:	74 f1                	je     80104607 <memmove+0x37>
80104616:	8d 76 00             	lea    0x0(%esi),%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104620:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104624:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104627:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010462a:	39 d3                	cmp    %edx,%ebx
8010462c:	75 f2                	jne    80104620 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010462e:	5b                   	pop    %ebx
8010462f:	5e                   	pop    %esi
80104630:	5d                   	pop    %ebp
80104631:	c3                   	ret    
80104632:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104639:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104640 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104640:	55                   	push   %ebp
80104641:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104643:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104644:	eb 8a                	jmp    801045d0 <memmove>
80104646:	8d 76 00             	lea    0x0(%esi),%esi
80104649:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104650 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	57                   	push   %edi
80104654:	56                   	push   %esi
80104655:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104658:	53                   	push   %ebx
80104659:	8b 7d 08             	mov    0x8(%ebp),%edi
8010465c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010465f:	85 c9                	test   %ecx,%ecx
80104661:	74 37                	je     8010469a <strncmp+0x4a>
80104663:	0f b6 17             	movzbl (%edi),%edx
80104666:	0f b6 1e             	movzbl (%esi),%ebx
80104669:	84 d2                	test   %dl,%dl
8010466b:	74 3f                	je     801046ac <strncmp+0x5c>
8010466d:	38 d3                	cmp    %dl,%bl
8010466f:	75 3b                	jne    801046ac <strncmp+0x5c>
80104671:	8d 47 01             	lea    0x1(%edi),%eax
80104674:	01 cf                	add    %ecx,%edi
80104676:	eb 1b                	jmp    80104693 <strncmp+0x43>
80104678:	90                   	nop
80104679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104680:	0f b6 10             	movzbl (%eax),%edx
80104683:	84 d2                	test   %dl,%dl
80104685:	74 21                	je     801046a8 <strncmp+0x58>
80104687:	0f b6 19             	movzbl (%ecx),%ebx
8010468a:	83 c0 01             	add    $0x1,%eax
8010468d:	89 ce                	mov    %ecx,%esi
8010468f:	38 da                	cmp    %bl,%dl
80104691:	75 19                	jne    801046ac <strncmp+0x5c>
80104693:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104695:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104698:	75 e6                	jne    80104680 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010469a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010469b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010469d:	5e                   	pop    %esi
8010469e:	5f                   	pop    %edi
8010469f:	5d                   	pop    %ebp
801046a0:	c3                   	ret    
801046a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046a8:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801046ac:	0f b6 c2             	movzbl %dl,%eax
801046af:	29 d8                	sub    %ebx,%eax
}
801046b1:	5b                   	pop    %ebx
801046b2:	5e                   	pop    %esi
801046b3:	5f                   	pop    %edi
801046b4:	5d                   	pop    %ebp
801046b5:	c3                   	ret    
801046b6:	8d 76 00             	lea    0x0(%esi),%esi
801046b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801046c0:	55                   	push   %ebp
801046c1:	89 e5                	mov    %esp,%ebp
801046c3:	56                   	push   %esi
801046c4:	53                   	push   %ebx
801046c5:	8b 45 08             	mov    0x8(%ebp),%eax
801046c8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046cb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801046ce:	89 c2                	mov    %eax,%edx
801046d0:	eb 19                	jmp    801046eb <strncpy+0x2b>
801046d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046d8:	83 c3 01             	add    $0x1,%ebx
801046db:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801046df:	83 c2 01             	add    $0x1,%edx
801046e2:	84 c9                	test   %cl,%cl
801046e4:	88 4a ff             	mov    %cl,-0x1(%edx)
801046e7:	74 09                	je     801046f2 <strncpy+0x32>
801046e9:	89 f1                	mov    %esi,%ecx
801046eb:	85 c9                	test   %ecx,%ecx
801046ed:	8d 71 ff             	lea    -0x1(%ecx),%esi
801046f0:	7f e6                	jg     801046d8 <strncpy+0x18>
    ;
  while(n-- > 0)
801046f2:	31 c9                	xor    %ecx,%ecx
801046f4:	85 f6                	test   %esi,%esi
801046f6:	7e 17                	jle    8010470f <strncpy+0x4f>
801046f8:	90                   	nop
801046f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104700:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104704:	89 f3                	mov    %esi,%ebx
80104706:	83 c1 01             	add    $0x1,%ecx
80104709:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
8010470b:	85 db                	test   %ebx,%ebx
8010470d:	7f f1                	jg     80104700 <strncpy+0x40>
    *s++ = 0;
  return os;
}
8010470f:	5b                   	pop    %ebx
80104710:	5e                   	pop    %esi
80104711:	5d                   	pop    %ebp
80104712:	c3                   	ret    
80104713:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104720 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104728:	8b 45 08             	mov    0x8(%ebp),%eax
8010472b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010472e:	85 c9                	test   %ecx,%ecx
80104730:	7e 26                	jle    80104758 <safestrcpy+0x38>
80104732:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104736:	89 c1                	mov    %eax,%ecx
80104738:	eb 17                	jmp    80104751 <safestrcpy+0x31>
8010473a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104740:	83 c2 01             	add    $0x1,%edx
80104743:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104747:	83 c1 01             	add    $0x1,%ecx
8010474a:	84 db                	test   %bl,%bl
8010474c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010474f:	74 04                	je     80104755 <safestrcpy+0x35>
80104751:	39 f2                	cmp    %esi,%edx
80104753:	75 eb                	jne    80104740 <safestrcpy+0x20>
    ;
  *s = 0;
80104755:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104758:	5b                   	pop    %ebx
80104759:	5e                   	pop    %esi
8010475a:	5d                   	pop    %ebp
8010475b:	c3                   	ret    
8010475c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104760 <strlen>:

int
strlen(const char *s)
{
80104760:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104761:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104763:	89 e5                	mov    %esp,%ebp
80104765:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104768:	80 3a 00             	cmpb   $0x0,(%edx)
8010476b:	74 0c                	je     80104779 <strlen+0x19>
8010476d:	8d 76 00             	lea    0x0(%esi),%esi
80104770:	83 c0 01             	add    $0x1,%eax
80104773:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104777:	75 f7                	jne    80104770 <strlen+0x10>
    ;
  return n;
}
80104779:	5d                   	pop    %ebp
8010477a:	c3                   	ret    

8010477b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010477b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010477f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104783:	55                   	push   %ebp
  pushl %ebx
80104784:	53                   	push   %ebx
  pushl %esi
80104785:	56                   	push   %esi
  pushl %edi
80104786:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104787:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104789:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010478b:	5f                   	pop    %edi
  popl %esi
8010478c:	5e                   	pop    %esi
  popl %ebx
8010478d:	5b                   	pop    %ebx
  popl %ebp
8010478e:	5d                   	pop    %ebp
  ret
8010478f:	c3                   	ret    

80104790 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104790:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104791:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104798:	89 e5                	mov    %esp,%ebp
8010479a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
8010479d:	8b 12                	mov    (%edx),%edx
8010479f:	39 c2                	cmp    %eax,%edx
801047a1:	76 15                	jbe    801047b8 <fetchint+0x28>
801047a3:	8d 48 04             	lea    0x4(%eax),%ecx
801047a6:	39 ca                	cmp    %ecx,%edx
801047a8:	72 0e                	jb     801047b8 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
801047aa:	8b 10                	mov    (%eax),%edx
801047ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801047af:	89 10                	mov    %edx,(%eax)
  return 0;
801047b1:	31 c0                	xor    %eax,%eax
}
801047b3:	5d                   	pop    %ebp
801047b4:	c3                   	ret    
801047b5:	8d 76 00             	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
801047b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  *ip = *(int*)(addr);
  return 0;
}
801047bd:	5d                   	pop    %ebp
801047be:	c3                   	ret    
801047bf:	90                   	nop

801047c0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047c0:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
801047c1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047c7:	89 e5                	mov    %esp,%ebp
801047c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *s, *ep;

  if(addr >= proc->sz)
801047cc:	39 08                	cmp    %ecx,(%eax)
801047ce:	76 2c                	jbe    801047fc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801047d0:	8b 55 0c             	mov    0xc(%ebp),%edx
801047d3:	89 c8                	mov    %ecx,%eax
801047d5:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801047d7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047de:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801047e0:	39 d1                	cmp    %edx,%ecx
801047e2:	73 18                	jae    801047fc <fetchstr+0x3c>
    if(*s == 0)
801047e4:	80 39 00             	cmpb   $0x0,(%ecx)
801047e7:	75 0c                	jne    801047f5 <fetchstr+0x35>
801047e9:	eb 1d                	jmp    80104808 <fetchstr+0x48>
801047eb:	90                   	nop
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047f0:	80 38 00             	cmpb   $0x0,(%eax)
801047f3:	74 13                	je     80104808 <fetchstr+0x48>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801047f5:	83 c0 01             	add    $0x1,%eax
801047f8:	39 c2                	cmp    %eax,%edx
801047fa:	77 f4                	ja     801047f0 <fetchstr+0x30>
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
801047fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
80104801:	5d                   	pop    %ebp
80104802:	c3                   	ret    
80104803:	90                   	nop
80104804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
80104808:	29 c8                	sub    %ecx,%eax
  return -1;
}
8010480a:	5d                   	pop    %ebp
8010480b:	c3                   	ret    
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104810 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104810:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104817:	55                   	push   %ebp
80104818:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010481a:	8b 42 18             	mov    0x18(%edx),%eax
8010481d:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104820:	8b 12                	mov    (%edx),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104822:	8b 40 44             	mov    0x44(%eax),%eax
80104825:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104828:	8d 48 04             	lea    0x4(%eax),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010482b:	39 d1                	cmp    %edx,%ecx
8010482d:	73 19                	jae    80104848 <argint+0x38>
8010482f:	8d 48 08             	lea    0x8(%eax),%ecx
80104832:	39 ca                	cmp    %ecx,%edx
80104834:	72 12                	jb     80104848 <argint+0x38>
    return -1;
  *ip = *(int*)(addr);
80104836:	8b 50 04             	mov    0x4(%eax),%edx
80104839:	8b 45 0c             	mov    0xc(%ebp),%eax
8010483c:	89 10                	mov    %edx,(%eax)
  return 0;
8010483e:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
80104840:	5d                   	pop    %ebp
80104841:	c3                   	ret    
80104842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104848:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
8010484d:	5d                   	pop    %ebp
8010484e:	c3                   	ret    
8010484f:	90                   	nop

80104850 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104850:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104856:	55                   	push   %ebp
80104857:	89 e5                	mov    %esp,%ebp
80104859:	56                   	push   %esi
8010485a:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010485b:	8b 48 18             	mov    0x18(%eax),%ecx
8010485e:	8b 5d 08             	mov    0x8(%ebp),%ebx
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104861:	8b 55 10             	mov    0x10(%ebp),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104864:	8b 49 44             	mov    0x44(%ecx),%ecx
80104867:	8d 1c 99             	lea    (%ecx,%ebx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010486a:	8b 08                	mov    (%eax),%ecx
argptr(int n, char **pp, int size)
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
8010486c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104871:	8d 73 04             	lea    0x4(%ebx),%esi

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104874:	39 ce                	cmp    %ecx,%esi
80104876:	73 1f                	jae    80104897 <argptr+0x47>
80104878:	8d 73 08             	lea    0x8(%ebx),%esi
8010487b:	39 f1                	cmp    %esi,%ecx
8010487d:	72 18                	jb     80104897 <argptr+0x47>
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
8010487f:	85 d2                	test   %edx,%edx
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
80104881:	8b 5b 04             	mov    0x4(%ebx),%ebx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
80104884:	78 11                	js     80104897 <argptr+0x47>
80104886:	39 cb                	cmp    %ecx,%ebx
80104888:	73 0d                	jae    80104897 <argptr+0x47>
8010488a:	01 da                	add    %ebx,%edx
8010488c:	39 ca                	cmp    %ecx,%edx
8010488e:	77 07                	ja     80104897 <argptr+0x47>
    return -1;
  *pp = (char*)i;
80104890:	8b 45 0c             	mov    0xc(%ebp),%eax
80104893:	89 18                	mov    %ebx,(%eax)
  return 0;
80104895:	31 c0                	xor    %eax,%eax
}
80104897:	5b                   	pop    %ebx
80104898:	5e                   	pop    %esi
80104899:	5d                   	pop    %ebp
8010489a:	c3                   	ret    
8010489b:	90                   	nop
8010489c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048a0 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801048a6:	55                   	push   %ebp
801048a7:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048a9:	8b 50 18             	mov    0x18(%eax),%edx
801048ac:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801048af:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801048b1:	8b 52 44             	mov    0x44(%edx),%edx
801048b4:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
801048b7:	8d 4a 04             	lea    0x4(%edx),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
801048ba:	39 c1                	cmp    %eax,%ecx
801048bc:	73 07                	jae    801048c5 <argstr+0x25>
801048be:	8d 4a 08             	lea    0x8(%edx),%ecx
801048c1:	39 c8                	cmp    %ecx,%eax
801048c3:	73 0b                	jae    801048d0 <argstr+0x30>
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801048c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801048ca:	5d                   	pop    %ebp
801048cb:	c3                   	ret    
801048cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
801048d0:	8b 4a 04             	mov    0x4(%edx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
801048d3:	39 c1                	cmp    %eax,%ecx
801048d5:	73 ee                	jae    801048c5 <argstr+0x25>
    return -1;
  *pp = (char*)addr;
801048d7:	8b 55 0c             	mov    0xc(%ebp),%edx
801048da:	89 c8                	mov    %ecx,%eax
801048dc:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801048de:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801048e5:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801048e7:	39 d1                	cmp    %edx,%ecx
801048e9:	73 da                	jae    801048c5 <argstr+0x25>
    if(*s == 0)
801048eb:	80 39 00             	cmpb   $0x0,(%ecx)
801048ee:	75 0d                	jne    801048fd <argstr+0x5d>
801048f0:	eb 1e                	jmp    80104910 <argstr+0x70>
801048f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048f8:	80 38 00             	cmpb   $0x0,(%eax)
801048fb:	74 13                	je     80104910 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801048fd:	83 c0 01             	add    $0x1,%eax
80104900:	39 c2                	cmp    %eax,%edx
80104902:	77 f4                	ja     801048f8 <argstr+0x58>
80104904:	eb bf                	jmp    801048c5 <argstr+0x25>
80104906:	8d 76 00             	lea    0x0(%esi),%esi
80104909:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(*s == 0)
      return s - *pp;
80104910:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104912:	5d                   	pop    %ebp
80104913:	c3                   	ret    
80104914:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010491a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104920 <getcountinit>:

// Check if initialized
int init = 0;

// Initializes data structures for getcount()
void getcountinit() {
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	83 ec 10             	sub    $0x10,%esp
  initlock(&lock, "getcount lock");
80104926:	68 71 79 10 80       	push   $0x80107971
8010492b:	68 e0 4c 11 80       	push   $0x80114ce0
80104930:	e8 9b f9 ff ff       	call   801042d0 <initlock>
  init = 1;
80104935:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
8010493c:	00 00 00 
}
8010493f:	83 c4 10             	add    $0x10,%esp
80104942:	c9                   	leave  
80104943:	c3                   	ret    
80104944:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010494a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104950 <syscall>:
[SYS_mkSmallFilesdir]   sys_mkSmallFilesdir,
};

void
syscall(void)
{
80104950:	55                   	push   %ebp
80104951:	89 e5                	mov    %esp,%ebp
80104953:	53                   	push   %ebx
80104954:	83 ec 04             	sub    $0x4,%esp
  if (init == 0) {
80104957:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
8010495c:	85 c0                	test   %eax,%eax
8010495e:	0f 84 8c 00 00 00    	je     801049f0 <syscall+0xa0>
    getcountinit();
    init = 1;
  }
  int num;

  num = proc->tf->eax;
80104964:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  acquire(&lock);
8010496a:	83 ec 0c             	sub    $0xc,%esp
    getcountinit();
    init = 1;
  }
  int num;

  num = proc->tf->eax;
8010496d:	8b 40 18             	mov    0x18(%eax),%eax
80104970:	8b 58 1c             	mov    0x1c(%eax),%ebx
  acquire(&lock);
80104973:	68 e0 4c 11 80       	push   $0x80114ce0
80104978:	e8 73 f9 ff ff       	call   801042f0 <acquire>
  updatecount(num);
8010497d:	89 1c 24             	mov    %ebx,(%esp)
80104980:	e8 9b 0d 00 00       	call   80105720 <updatecount>
  release(&lock);
80104985:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
8010498c:	e8 3f fb ff ff       	call   801044d0 <release>
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
80104991:	83 c4 10             	add    $0x10,%esp
80104994:	83 fb 18             	cmp    $0x18,%ebx
80104997:	77 27                	ja     801049c0 <syscall+0x70>
80104999:	8b 04 9d a0 79 10 80 	mov    -0x7fef8660(,%ebx,4),%eax
801049a0:	85 c0                	test   %eax,%eax
801049a2:	74 1c                	je     801049c0 <syscall+0x70>
    proc->tf->eax = syscalls[num]();
801049a4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801049ab:	8b 5a 18             	mov    0x18(%edx),%ebx
801049ae:	ff d0                	call   *%eax
801049b0:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
801049b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049b6:	c9                   	leave  
801049b7:	c3                   	ret    
801049b8:	90                   	nop
801049b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&lock);
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801049c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  updatecount(num);
  release(&lock);
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
801049c6:	53                   	push   %ebx
            proc->pid, proc->name, num);
801049c7:	8d 50 6c             	lea    0x6c(%eax),%edx
  updatecount(num);
  release(&lock);
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
801049ca:	52                   	push   %edx
801049cb:	ff 70 10             	pushl  0x10(%eax)
801049ce:	68 7f 79 10 80       	push   $0x8010797f
801049d3:	e8 88 bc ff ff       	call   80100660 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801049d8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049de:	83 c4 10             	add    $0x10,%esp
801049e1:	8b 40 18             	mov    0x18(%eax),%eax
801049e4:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801049eb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049ee:	c9                   	leave  
801049ef:	c3                   	ret    
// Check if initialized
int init = 0;

// Initializes data structures for getcount()
void getcountinit() {
  initlock(&lock, "getcount lock");
801049f0:	83 ec 08             	sub    $0x8,%esp
801049f3:	68 71 79 10 80       	push   $0x80107971
801049f8:	68 e0 4c 11 80       	push   $0x80114ce0
801049fd:	e8 ce f8 ff ff       	call   801042d0 <initlock>
  init = 1;
80104a02:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
80104a09:	00 00 00 
80104a0c:	83 c4 10             	add    $0x10,%esp
80104a0f:	e9 50 ff ff ff       	jmp    80104964 <syscall+0x14>
80104a14:	66 90                	xchg   %ax,%ax
80104a16:	66 90                	xchg   %ax,%ax
80104a18:	66 90                	xchg   %ax,%ax
80104a1a:	66 90                	xchg   %ax,%ax
80104a1c:	66 90                	xchg   %ax,%ax
80104a1e:	66 90                	xchg   %ax,%ax

80104a20 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	57                   	push   %edi
80104a24:	56                   	push   %esi
80104a25:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a26:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a29:	83 ec 44             	sub    $0x44,%esp
80104a2c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a2f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a32:	56                   	push   %esi
80104a33:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a34:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a37:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a3a:	e8 01 d5 ff ff       	call   80101f40 <nameiparent>
80104a3f:	83 c4 10             	add    $0x10,%esp
80104a42:	85 c0                	test   %eax,%eax
80104a44:	0f 84 66 01 00 00    	je     80104bb0 <create+0x190>
    return 0;
  ilock(dp);
80104a4a:	83 ec 0c             	sub    $0xc,%esp
80104a4d:	89 c7                	mov    %eax,%edi
80104a4f:	50                   	push   %eax
80104a50:	e8 fb cb ff ff       	call   80101650 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104a55:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104a58:	83 c4 0c             	add    $0xc,%esp
80104a5b:	50                   	push   %eax
80104a5c:	56                   	push   %esi
80104a5d:	57                   	push   %edi
80104a5e:	e8 9d d1 ff ff       	call   80101c00 <dirlookup>
80104a63:	83 c4 10             	add    $0x10,%esp
80104a66:	85 c0                	test   %eax,%eax
80104a68:	89 c3                	mov    %eax,%ebx
80104a6a:	74 5c                	je     80104ac8 <create+0xa8>
    iunlockput(dp);
80104a6c:	83 ec 0c             	sub    $0xc,%esp
80104a6f:	57                   	push   %edi
80104a70:	e8 4b ce ff ff       	call   801018c0 <iunlockput>
    ilock(ip);
80104a75:	89 1c 24             	mov    %ebx,(%esp)
80104a78:	e8 d3 cb ff ff       	call   80101650 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a7d:	83 c4 10             	add    $0x10,%esp
80104a80:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104a85:	74 19                	je     80104aa0 <create+0x80>
      return ip;

    if(type == T_SMALLFILE && ip->type == T_SMALLFILE)
80104a87:	66 83 7d c4 05       	cmpw   $0x5,-0x3c(%ebp)
80104a8c:	75 1d                	jne    80104aab <create+0x8b>
80104a8e:	66 83 7b 50 05       	cmpw   $0x5,0x50(%ebx)
80104a93:	89 d8                	mov    %ebx,%eax
80104a95:	75 14                	jne    80104aab <create+0x8b>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a97:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a9a:	5b                   	pop    %ebx
80104a9b:	5e                   	pop    %esi
80104a9c:	5f                   	pop    %edi
80104a9d:	5d                   	pop    %ebp
80104a9e:	c3                   	ret    
80104a9f:	90                   	nop
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
80104aa0:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104aa5:	0f 84 f5 00 00 00    	je     80104ba0 <create+0x180>
      return ip;

    if(type == T_SMALLFILE && ip->type == T_SMALLFILE)
      return ip;
    iunlockput(ip);
80104aab:	83 ec 0c             	sub    $0xc,%esp
80104aae:	53                   	push   %ebx
80104aaf:	e8 0c ce ff ff       	call   801018c0 <iunlockput>
    return 0;
80104ab4:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ab7:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return ip;

    if(type == T_SMALLFILE && ip->type == T_SMALLFILE)
      return ip;
    iunlockput(ip);
    return 0;
80104aba:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104abc:	5b                   	pop    %ebx
80104abd:	5e                   	pop    %esi
80104abe:	5f                   	pop    %edi
80104abf:	5d                   	pop    %ebp
80104ac0:	c3                   	ret    
80104ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104ac8:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104acc:	83 ec 08             	sub    $0x8,%esp
80104acf:	50                   	push   %eax
80104ad0:	ff 37                	pushl  (%edi)
80104ad2:	e8 09 ca ff ff       	call   801014e0 <ialloc>
80104ad7:	83 c4 10             	add    $0x10,%esp
80104ada:	85 c0                	test   %eax,%eax
80104adc:	89 c3                	mov    %eax,%ebx
80104ade:	0f 84 e0 00 00 00    	je     80104bc4 <create+0x1a4>
    panic("create: ialloc");

  ilock(ip);
80104ae4:	83 ec 0c             	sub    $0xc,%esp
80104ae7:	50                   	push   %eax
80104ae8:	e8 63 cb ff ff       	call   80101650 <ilock>
  ip->major = major;
80104aed:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104af1:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104af5:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104af9:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104afd:	b8 01 00 00 00       	mov    $0x1,%eax
80104b02:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104b06:	89 1c 24             	mov    %ebx,(%esp)
80104b09:	e8 92 ca ff ff       	call   801015a0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104b0e:	83 c4 10             	add    $0x10,%esp
80104b11:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104b16:	74 38                	je     80104b50 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(type == T_SMALLDIR){  // Create . and .. entries.
80104b18:	66 83 7d c4 04       	cmpw   $0x4,-0x3c(%ebp)
80104b1d:	74 31                	je     80104b50 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104b1f:	83 ec 04             	sub    $0x4,%esp
80104b22:	ff 73 04             	pushl  0x4(%ebx)
80104b25:	56                   	push   %esi
80104b26:	57                   	push   %edi
80104b27:	e8 34 d3 ff ff       	call   80101e60 <dirlink>
80104b2c:	83 c4 10             	add    $0x10,%esp
80104b2f:	85 c0                	test   %eax,%eax
80104b31:	0f 88 80 00 00 00    	js     80104bb7 <create+0x197>
    panic("create: dirlink");

  iunlockput(dp);
80104b37:	83 ec 0c             	sub    $0xc,%esp
80104b3a:	57                   	push   %edi
80104b3b:	e8 80 cd ff ff       	call   801018c0 <iunlockput>

  return ip;
80104b40:	83 c4 10             	add    $0x10,%esp
}
80104b43:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104b46:	89 d8                	mov    %ebx,%eax
}
80104b48:	5b                   	pop    %ebx
80104b49:	5e                   	pop    %esi
80104b4a:	5f                   	pop    %edi
80104b4b:	5d                   	pop    %ebp
80104b4c:	c3                   	ret    
80104b4d:	8d 76 00             	lea    0x0(%esi),%esi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104b50:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104b55:	83 ec 0c             	sub    $0xc,%esp
80104b58:	57                   	push   %edi
80104b59:	e8 42 ca ff ff       	call   801015a0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b5e:	83 c4 0c             	add    $0xc,%esp
80104b61:	ff 73 04             	pushl  0x4(%ebx)
80104b64:	68 20 7a 10 80       	push   $0x80107a20
80104b69:	53                   	push   %ebx
80104b6a:	e8 f1 d2 ff ff       	call   80101e60 <dirlink>
80104b6f:	83 c4 10             	add    $0x10,%esp
80104b72:	85 c0                	test   %eax,%eax
80104b74:	78 18                	js     80104b8e <create+0x16e>

  if(type == T_SMALLDIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b76:	83 ec 04             	sub    $0x4,%esp
80104b79:	ff 77 04             	pushl  0x4(%edi)
80104b7c:	68 1f 7a 10 80       	push   $0x80107a1f
80104b81:	53                   	push   %ebx
80104b82:	e8 d9 d2 ff ff       	call   80101e60 <dirlink>
80104b87:	83 c4 10             	add    $0x10,%esp
80104b8a:	85 c0                	test   %eax,%eax
80104b8c:	79 91                	jns    80104b1f <create+0xff>
  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
80104b8e:	83 ec 0c             	sub    $0xc,%esp
80104b91:	68 13 7a 10 80       	push   $0x80107a13
80104b96:	e8 d5 b7 ff ff       	call   80100370 <panic>
80104b9b:	90                   	nop
80104b9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ba0:	89 d8                	mov    %ebx,%eax
80104ba2:	e9 f0 fe ff ff       	jmp    80104a97 <create+0x77>
80104ba7:	89 f6                	mov    %esi,%esi
80104ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104bb0:	31 c0                	xor    %eax,%eax
80104bb2:	e9 e0 fe ff ff       	jmp    80104a97 <create+0x77>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104bb7:	83 ec 0c             	sub    $0xc,%esp
80104bba:	68 22 7a 10 80       	push   $0x80107a22
80104bbf:	e8 ac b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104bc4:	83 ec 0c             	sub    $0xc,%esp
80104bc7:	68 04 7a 10 80       	push   $0x80107a04
80104bcc:	e8 9f b7 ff ff       	call   80100370 <panic>
80104bd1:	eb 0d                	jmp    80104be0 <argfd.constprop.0>
80104bd3:	90                   	nop
80104bd4:	90                   	nop
80104bd5:	90                   	nop
80104bd6:	90                   	nop
80104bd7:	90                   	nop
80104bd8:	90                   	nop
80104bd9:	90                   	nop
80104bda:	90                   	nop
80104bdb:	90                   	nop
80104bdc:	90                   	nop
80104bdd:	90                   	nop
80104bde:	90                   	nop
80104bdf:	90                   	nop

80104be0 <argfd.constprop.0>:


// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104be0:	55                   	push   %ebp
80104be1:	89 e5                	mov    %esp,%ebp
80104be3:	56                   	push   %esi
80104be4:	53                   	push   %ebx
80104be5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104be7:	8d 45 f4             	lea    -0xc(%ebp),%eax


// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104bea:	89 d3                	mov    %edx,%ebx
80104bec:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104bef:	50                   	push   %eax
80104bf0:	6a 00                	push   $0x0
80104bf2:	e8 19 fc ff ff       	call   80104810 <argint>
80104bf7:	83 c4 10             	add    $0x10,%esp
80104bfa:	85 c0                	test   %eax,%eax
80104bfc:	78 3a                	js     80104c38 <argfd.constprop.0+0x58>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104bfe:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c01:	83 f8 0f             	cmp    $0xf,%eax
80104c04:	77 32                	ja     80104c38 <argfd.constprop.0+0x58>
80104c06:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104c0d:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
80104c11:	85 d2                	test   %edx,%edx
80104c13:	74 23                	je     80104c38 <argfd.constprop.0+0x58>
    return -1;
  if(pfd)
80104c15:	85 f6                	test   %esi,%esi
80104c17:	74 02                	je     80104c1b <argfd.constprop.0+0x3b>
    *pfd = fd;
80104c19:	89 06                	mov    %eax,(%esi)
  if(pf)
80104c1b:	85 db                	test   %ebx,%ebx
80104c1d:	74 11                	je     80104c30 <argfd.constprop.0+0x50>
    *pf = f;
80104c1f:	89 13                	mov    %edx,(%ebx)
  return 0;
80104c21:	31 c0                	xor    %eax,%eax
}
80104c23:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c26:	5b                   	pop    %ebx
80104c27:	5e                   	pop    %esi
80104c28:	5d                   	pop    %ebp
80104c29:	c3                   	ret    
80104c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104c30:	31 c0                	xor    %eax,%eax
80104c32:	eb ef                	jmp    80104c23 <argfd.constprop.0+0x43>
80104c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104c38:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c3d:	eb e4                	jmp    80104c23 <argfd.constprop.0+0x43>
80104c3f:	90                   	nop

80104c40 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104c40:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c41:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104c43:	89 e5                	mov    %esp,%ebp
80104c45:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c46:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104c49:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c4c:	e8 8f ff ff ff       	call   80104be0 <argfd.constprop.0>
80104c51:	85 c0                	test   %eax,%eax
80104c53:	78 1b                	js     80104c70 <sys_dup+0x30>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104c55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c58:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104c5e:	31 db                	xor    %ebx,%ebx
    if(proc->ofile[fd] == 0){
80104c60:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104c64:	85 c9                	test   %ecx,%ecx
80104c66:	74 18                	je     80104c80 <sys_dup+0x40>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104c68:	83 c3 01             	add    $0x1,%ebx
80104c6b:	83 fb 10             	cmp    $0x10,%ebx
80104c6e:	75 f0                	jne    80104c60 <sys_dup+0x20>
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104c75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c78:	c9                   	leave  
80104c79:	c3                   	ret    
80104c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104c80:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104c83:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104c87:	52                   	push   %edx
80104c88:	e8 33 c1 ff ff       	call   80100dc0 <filedup>
  return fd;
80104c8d:	89 d8                	mov    %ebx,%eax
80104c8f:	83 c4 10             	add    $0x10,%esp
}
80104c92:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c95:	c9                   	leave  
80104c96:	c3                   	ret    
80104c97:	89 f6                	mov    %esi,%esi
80104c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104ca0 <sys_read>:

int
sys_read(void)
{
80104ca0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ca1:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104ca3:	89 e5                	mov    %esp,%ebp
80104ca5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104ca8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cab:	e8 30 ff ff ff       	call   80104be0 <argfd.constprop.0>
80104cb0:	85 c0                	test   %eax,%eax
80104cb2:	78 4c                	js     80104d00 <sys_read+0x60>
80104cb4:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104cb7:	83 ec 08             	sub    $0x8,%esp
80104cba:	50                   	push   %eax
80104cbb:	6a 02                	push   $0x2
80104cbd:	e8 4e fb ff ff       	call   80104810 <argint>
80104cc2:	83 c4 10             	add    $0x10,%esp
80104cc5:	85 c0                	test   %eax,%eax
80104cc7:	78 37                	js     80104d00 <sys_read+0x60>
80104cc9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104ccc:	83 ec 04             	sub    $0x4,%esp
80104ccf:	ff 75 f0             	pushl  -0x10(%ebp)
80104cd2:	50                   	push   %eax
80104cd3:	6a 01                	push   $0x1
80104cd5:	e8 76 fb ff ff       	call   80104850 <argptr>
80104cda:	83 c4 10             	add    $0x10,%esp
80104cdd:	85 c0                	test   %eax,%eax
80104cdf:	78 1f                	js     80104d00 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104ce1:	83 ec 04             	sub    $0x4,%esp
80104ce4:	ff 75 f0             	pushl  -0x10(%ebp)
80104ce7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cea:	ff 75 ec             	pushl  -0x14(%ebp)
80104ced:	e8 3e c2 ff ff       	call   80100f30 <fileread>
80104cf2:	83 c4 10             	add    $0x10,%esp
}
80104cf5:	c9                   	leave  
80104cf6:	c3                   	ret    
80104cf7:	89 f6                	mov    %esi,%esi
80104cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104d05:	c9                   	leave  
80104d06:	c3                   	ret    
80104d07:	89 f6                	mov    %esi,%esi
80104d09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d10 <sys_write>:

int
sys_write(void)
{
80104d10:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d11:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104d13:	89 e5                	mov    %esp,%ebp
80104d15:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104d18:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104d1b:	e8 c0 fe ff ff       	call   80104be0 <argfd.constprop.0>
80104d20:	85 c0                	test   %eax,%eax
80104d22:	78 4c                	js     80104d70 <sys_write+0x60>
80104d24:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d27:	83 ec 08             	sub    $0x8,%esp
80104d2a:	50                   	push   %eax
80104d2b:	6a 02                	push   $0x2
80104d2d:	e8 de fa ff ff       	call   80104810 <argint>
80104d32:	83 c4 10             	add    $0x10,%esp
80104d35:	85 c0                	test   %eax,%eax
80104d37:	78 37                	js     80104d70 <sys_write+0x60>
80104d39:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d3c:	83 ec 04             	sub    $0x4,%esp
80104d3f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d42:	50                   	push   %eax
80104d43:	6a 01                	push   $0x1
80104d45:	e8 06 fb ff ff       	call   80104850 <argptr>
80104d4a:	83 c4 10             	add    $0x10,%esp
80104d4d:	85 c0                	test   %eax,%eax
80104d4f:	78 1f                	js     80104d70 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104d51:	83 ec 04             	sub    $0x4,%esp
80104d54:	ff 75 f0             	pushl  -0x10(%ebp)
80104d57:	ff 75 f4             	pushl  -0xc(%ebp)
80104d5a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d5d:	e8 5e c2 ff ff       	call   80100fc0 <filewrite>
80104d62:	83 c4 10             	add    $0x10,%esp
}
80104d65:	c9                   	leave  
80104d66:	c3                   	ret    
80104d67:	89 f6                	mov    %esi,%esi
80104d69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104d75:	c9                   	leave  
80104d76:	c3                   	ret    
80104d77:	89 f6                	mov    %esi,%esi
80104d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d80 <sys_close>:

int
sys_close(void)
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104d86:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d89:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d8c:	e8 4f fe ff ff       	call   80104be0 <argfd.constprop.0>
80104d91:	85 c0                	test   %eax,%eax
80104d93:	78 2b                	js     80104dc0 <sys_close+0x40>
    return -1;
  proc->ofile[fd] = 0;
80104d95:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104d98:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
80104d9e:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  proc->ofile[fd] = 0;
80104da1:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104da8:	00 
  fileclose(f);
80104da9:	ff 75 f4             	pushl  -0xc(%ebp)
80104dac:	e8 5f c0 ff ff       	call   80100e10 <fileclose>
  return 0;
80104db1:	83 c4 10             	add    $0x10,%esp
80104db4:	31 c0                	xor    %eax,%eax
}
80104db6:	c9                   	leave  
80104db7:	c3                   	ret    
80104db8:	90                   	nop
80104db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104dc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104dc5:	c9                   	leave  
80104dc6:	c3                   	ret    
80104dc7:	89 f6                	mov    %esi,%esi
80104dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104dd0 <sys_fstat>:

int
sys_fstat(void)
{
80104dd0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104dd1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104dd3:	89 e5                	mov    %esp,%ebp
80104dd5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104dd8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104ddb:	e8 00 fe ff ff       	call   80104be0 <argfd.constprop.0>
80104de0:	85 c0                	test   %eax,%eax
80104de2:	78 2c                	js     80104e10 <sys_fstat+0x40>
80104de4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104de7:	83 ec 04             	sub    $0x4,%esp
80104dea:	6a 14                	push   $0x14
80104dec:	50                   	push   %eax
80104ded:	6a 01                	push   $0x1
80104def:	e8 5c fa ff ff       	call   80104850 <argptr>
80104df4:	83 c4 10             	add    $0x10,%esp
80104df7:	85 c0                	test   %eax,%eax
80104df9:	78 15                	js     80104e10 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104dfb:	83 ec 08             	sub    $0x8,%esp
80104dfe:	ff 75 f4             	pushl  -0xc(%ebp)
80104e01:	ff 75 f0             	pushl  -0x10(%ebp)
80104e04:	e8 d7 c0 ff ff       	call   80100ee0 <filestat>
80104e09:	83 c4 10             	add    $0x10,%esp
}
80104e0c:	c9                   	leave  
80104e0d:	c3                   	ret    
80104e0e:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104e10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	89 f6                	mov    %esi,%esi
80104e19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e20 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e20:	55                   	push   %ebp
80104e21:	89 e5                	mov    %esp,%ebp
80104e23:	57                   	push   %edi
80104e24:	56                   	push   %esi
80104e25:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e26:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e29:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e2c:	50                   	push   %eax
80104e2d:	6a 00                	push   $0x0
80104e2f:	e8 6c fa ff ff       	call   801048a0 <argstr>
80104e34:	83 c4 10             	add    $0x10,%esp
80104e37:	85 c0                	test   %eax,%eax
80104e39:	0f 88 03 01 00 00    	js     80104f42 <sys_link+0x122>
80104e3f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e42:	83 ec 08             	sub    $0x8,%esp
80104e45:	50                   	push   %eax
80104e46:	6a 01                	push   $0x1
80104e48:	e8 53 fa ff ff       	call   801048a0 <argstr>
80104e4d:	83 c4 10             	add    $0x10,%esp
80104e50:	85 c0                	test   %eax,%eax
80104e52:	0f 88 ea 00 00 00    	js     80104f42 <sys_link+0x122>
    return -1;

  begin_op();
80104e58:	e8 f3 dd ff ff       	call   80102c50 <begin_op>
  if((ip = namei(old)) == 0){
80104e5d:	83 ec 0c             	sub    $0xc,%esp
80104e60:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e63:	e8 b8 d0 ff ff       	call   80101f20 <namei>
80104e68:	83 c4 10             	add    $0x10,%esp
80104e6b:	85 c0                	test   %eax,%eax
80104e6d:	89 c3                	mov    %eax,%ebx
80104e6f:	0f 84 f3 00 00 00    	je     80104f68 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104e75:	83 ec 0c             	sub    $0xc,%esp
80104e78:	50                   	push   %eax
80104e79:	e8 d2 c7 ff ff       	call   80101650 <ilock>
  if(ip->type == T_DIR){
80104e7e:	0f b7 43 50          	movzwl 0x50(%ebx),%eax
80104e82:	83 c4 10             	add    $0x10,%esp
80104e85:	66 83 f8 01          	cmp    $0x1,%ax
80104e89:	0f 84 c1 00 00 00    	je     80104f50 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_SMALLDIR){
80104e8f:	66 83 f8 04          	cmp    $0x4,%ax
80104e93:	0f 84 b7 00 00 00    	je     80104f50 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104e99:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e9e:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104ea1:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104ea4:	53                   	push   %ebx
80104ea5:	e8 f6 c6 ff ff       	call   801015a0 <iupdate>
  iunlock(ip);
80104eaa:	89 1c 24             	mov    %ebx,(%esp)
80104ead:	e8 7e c8 ff ff       	call   80101730 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104eb2:	58                   	pop    %eax
80104eb3:	5a                   	pop    %edx
80104eb4:	57                   	push   %edi
80104eb5:	ff 75 d0             	pushl  -0x30(%ebp)
80104eb8:	e8 83 d0 ff ff       	call   80101f40 <nameiparent>
80104ebd:	83 c4 10             	add    $0x10,%esp
80104ec0:	85 c0                	test   %eax,%eax
80104ec2:	89 c6                	mov    %eax,%esi
80104ec4:	74 56                	je     80104f1c <sys_link+0xfc>
    goto bad;
  ilock(dp);
80104ec6:	83 ec 0c             	sub    $0xc,%esp
80104ec9:	50                   	push   %eax
80104eca:	e8 81 c7 ff ff       	call   80101650 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104ecf:	83 c4 10             	add    $0x10,%esp
80104ed2:	8b 03                	mov    (%ebx),%eax
80104ed4:	39 06                	cmp    %eax,(%esi)
80104ed6:	75 38                	jne    80104f10 <sys_link+0xf0>
80104ed8:	83 ec 04             	sub    $0x4,%esp
80104edb:	ff 73 04             	pushl  0x4(%ebx)
80104ede:	57                   	push   %edi
80104edf:	56                   	push   %esi
80104ee0:	e8 7b cf ff ff       	call   80101e60 <dirlink>
80104ee5:	83 c4 10             	add    $0x10,%esp
80104ee8:	85 c0                	test   %eax,%eax
80104eea:	78 24                	js     80104f10 <sys_link+0xf0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104eec:	83 ec 0c             	sub    $0xc,%esp
80104eef:	56                   	push   %esi
80104ef0:	e8 cb c9 ff ff       	call   801018c0 <iunlockput>
  iput(ip);
80104ef5:	89 1c 24             	mov    %ebx,(%esp)
80104ef8:	e8 83 c8 ff ff       	call   80101780 <iput>

  end_op();
80104efd:	e8 be dd ff ff       	call   80102cc0 <end_op>

  return 0;
80104f02:	83 c4 10             	add    $0x10,%esp
80104f05:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104f07:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f0a:	5b                   	pop    %ebx
80104f0b:	5e                   	pop    %esi
80104f0c:	5f                   	pop    %edi
80104f0d:	5d                   	pop    %ebp
80104f0e:	c3                   	ret    
80104f0f:	90                   	nop

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104f10:	83 ec 0c             	sub    $0xc,%esp
80104f13:	56                   	push   %esi
80104f14:	e8 a7 c9 ff ff       	call   801018c0 <iunlockput>
    goto bad;
80104f19:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104f1c:	83 ec 0c             	sub    $0xc,%esp
80104f1f:	53                   	push   %ebx
80104f20:	e8 2b c7 ff ff       	call   80101650 <ilock>
  ip->nlink--;
80104f25:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f2a:	89 1c 24             	mov    %ebx,(%esp)
80104f2d:	e8 6e c6 ff ff       	call   801015a0 <iupdate>
  iunlockput(ip);
80104f32:	89 1c 24             	mov    %ebx,(%esp)
80104f35:	e8 86 c9 ff ff       	call   801018c0 <iunlockput>
  end_op();
80104f3a:	e8 81 dd ff ff       	call   80102cc0 <end_op>
  return -1;
80104f3f:	83 c4 10             	add    $0x10,%esp
}
80104f42:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104f45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f4a:	5b                   	pop    %ebx
80104f4b:	5e                   	pop    %esi
80104f4c:	5f                   	pop    %edi
80104f4d:	5d                   	pop    %ebp
80104f4e:	c3                   	ret    
80104f4f:	90                   	nop
    end_op();
    return -1;
  }

  if(ip->type == T_SMALLDIR){
    iunlockput(ip);
80104f50:	83 ec 0c             	sub    $0xc,%esp
80104f53:	53                   	push   %ebx
80104f54:	e8 67 c9 ff ff       	call   801018c0 <iunlockput>
    end_op();
80104f59:	e8 62 dd ff ff       	call   80102cc0 <end_op>
    return -1;
80104f5e:	83 c4 10             	add    $0x10,%esp
80104f61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f66:	eb 9f                	jmp    80104f07 <sys_link+0xe7>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104f68:	e8 53 dd ff ff       	call   80102cc0 <end_op>
    return -1;
80104f6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f72:	eb 93                	jmp    80104f07 <sys_link+0xe7>
80104f74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f80 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	57                   	push   %edi
80104f84:	56                   	push   %esi
80104f85:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104f86:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104f89:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104f8c:	50                   	push   %eax
80104f8d:	6a 00                	push   $0x0
80104f8f:	e8 0c f9 ff ff       	call   801048a0 <argstr>
80104f94:	83 c4 10             	add    $0x10,%esp
80104f97:	85 c0                	test   %eax,%eax
80104f99:	0f 88 82 01 00 00    	js     80105121 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104f9f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104fa2:	e8 a9 dc ff ff       	call   80102c50 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104fa7:	83 ec 08             	sub    $0x8,%esp
80104faa:	53                   	push   %ebx
80104fab:	ff 75 c0             	pushl  -0x40(%ebp)
80104fae:	e8 8d cf ff ff       	call   80101f40 <nameiparent>
80104fb3:	83 c4 10             	add    $0x10,%esp
80104fb6:	85 c0                	test   %eax,%eax
80104fb8:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104fbb:	0f 84 6a 01 00 00    	je     8010512b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80104fc1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104fc4:	83 ec 0c             	sub    $0xc,%esp
80104fc7:	56                   	push   %esi
80104fc8:	e8 83 c6 ff ff       	call   80101650 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104fcd:	58                   	pop    %eax
80104fce:	5a                   	pop    %edx
80104fcf:	68 20 7a 10 80       	push   $0x80107a20
80104fd4:	53                   	push   %ebx
80104fd5:	e8 06 cc ff ff       	call   80101be0 <namecmp>
80104fda:	83 c4 10             	add    $0x10,%esp
80104fdd:	85 c0                	test   %eax,%eax
80104fdf:	0f 84 fc 00 00 00    	je     801050e1 <sys_unlink+0x161>
80104fe5:	83 ec 08             	sub    $0x8,%esp
80104fe8:	68 1f 7a 10 80       	push   $0x80107a1f
80104fed:	53                   	push   %ebx
80104fee:	e8 ed cb ff ff       	call   80101be0 <namecmp>
80104ff3:	83 c4 10             	add    $0x10,%esp
80104ff6:	85 c0                	test   %eax,%eax
80104ff8:	0f 84 e3 00 00 00    	je     801050e1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104ffe:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105001:	83 ec 04             	sub    $0x4,%esp
80105004:	50                   	push   %eax
80105005:	53                   	push   %ebx
80105006:	56                   	push   %esi
80105007:	e8 f4 cb ff ff       	call   80101c00 <dirlookup>
8010500c:	83 c4 10             	add    $0x10,%esp
8010500f:	85 c0                	test   %eax,%eax
80105011:	89 c3                	mov    %eax,%ebx
80105013:	0f 84 c8 00 00 00    	je     801050e1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80105019:	83 ec 0c             	sub    $0xc,%esp
8010501c:	50                   	push   %eax
8010501d:	e8 2e c6 ff ff       	call   80101650 <ilock>

  if(ip->nlink < 1)
80105022:	83 c4 10             	add    $0x10,%esp
80105025:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010502a:	0f 8e 24 01 00 00    	jle    80105154 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105030:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105035:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105038:	74 66                	je     801050a0 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010503a:	83 ec 04             	sub    $0x4,%esp
8010503d:	6a 10                	push   $0x10
8010503f:	6a 00                	push   $0x0
80105041:	56                   	push   %esi
80105042:	e8 d9 f4 ff ff       	call   80104520 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105047:	6a 10                	push   $0x10
80105049:	ff 75 c4             	pushl  -0x3c(%ebp)
8010504c:	56                   	push   %esi
8010504d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105050:	e8 eb c9 ff ff       	call   80101a40 <writei>
80105055:	83 c4 20             	add    $0x20,%esp
80105058:	83 f8 10             	cmp    $0x10,%eax
8010505b:	0f 85 e6 00 00 00    	jne    80105147 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105061:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105066:	0f 84 9c 00 00 00    	je     80105108 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010506c:	83 ec 0c             	sub    $0xc,%esp
8010506f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105072:	e8 49 c8 ff ff       	call   801018c0 <iunlockput>

  ip->nlink--;
80105077:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010507c:	89 1c 24             	mov    %ebx,(%esp)
8010507f:	e8 1c c5 ff ff       	call   801015a0 <iupdate>
  iunlockput(ip);
80105084:	89 1c 24             	mov    %ebx,(%esp)
80105087:	e8 34 c8 ff ff       	call   801018c0 <iunlockput>

  end_op();
8010508c:	e8 2f dc ff ff       	call   80102cc0 <end_op>

  return 0;
80105091:	83 c4 10             	add    $0x10,%esp
80105094:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105096:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105099:	5b                   	pop    %ebx
8010509a:	5e                   	pop    %esi
8010509b:	5f                   	pop    %edi
8010509c:	5d                   	pop    %ebp
8010509d:	c3                   	ret    
8010509e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801050a0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801050a4:	76 94                	jbe    8010503a <sys_unlink+0xba>
801050a6:	bf 20 00 00 00       	mov    $0x20,%edi
801050ab:	eb 0f                	jmp    801050bc <sys_unlink+0x13c>
801050ad:	8d 76 00             	lea    0x0(%esi),%esi
801050b0:	83 c7 10             	add    $0x10,%edi
801050b3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801050b6:	0f 83 7e ff ff ff    	jae    8010503a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801050bc:	6a 10                	push   $0x10
801050be:	57                   	push   %edi
801050bf:	56                   	push   %esi
801050c0:	53                   	push   %ebx
801050c1:	e8 4a c8 ff ff       	call   80101910 <readi>
801050c6:	83 c4 10             	add    $0x10,%esp
801050c9:	83 f8 10             	cmp    $0x10,%eax
801050cc:	75 6c                	jne    8010513a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
801050ce:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050d3:	74 db                	je     801050b0 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801050d5:	83 ec 0c             	sub    $0xc,%esp
801050d8:	53                   	push   %ebx
801050d9:	e8 e2 c7 ff ff       	call   801018c0 <iunlockput>
    goto bad;
801050de:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801050e1:	83 ec 0c             	sub    $0xc,%esp
801050e4:	ff 75 b4             	pushl  -0x4c(%ebp)
801050e7:	e8 d4 c7 ff ff       	call   801018c0 <iunlockput>
  end_op();
801050ec:	e8 cf db ff ff       	call   80102cc0 <end_op>
  return -1;
801050f1:	83 c4 10             	add    $0x10,%esp
}
801050f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801050f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050fc:	5b                   	pop    %ebx
801050fd:	5e                   	pop    %esi
801050fe:	5f                   	pop    %edi
801050ff:	5d                   	pop    %ebp
80105100:	c3                   	ret    
80105101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
80105108:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
8010510b:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
8010510e:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105113:	50                   	push   %eax
80105114:	e8 87 c4 ff ff       	call   801015a0 <iupdate>
80105119:	83 c4 10             	add    $0x10,%esp
8010511c:	e9 4b ff ff ff       	jmp    8010506c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105126:	e9 6b ff ff ff       	jmp    80105096 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010512b:	e8 90 db ff ff       	call   80102cc0 <end_op>
    return -1;
80105130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105135:	e9 5c ff ff ff       	jmp    80105096 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010513a:	83 ec 0c             	sub    $0xc,%esp
8010513d:	68 44 7a 10 80       	push   $0x80107a44
80105142:	e8 29 b2 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105147:	83 ec 0c             	sub    $0xc,%esp
8010514a:	68 56 7a 10 80       	push   $0x80107a56
8010514f:	e8 1c b2 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105154:	83 ec 0c             	sub    $0xc,%esp
80105157:	68 32 7a 10 80       	push   $0x80107a32
8010515c:	e8 0f b2 ff ff       	call   80100370 <panic>
80105161:	eb 0d                	jmp    80105170 <sys_open>
80105163:	90                   	nop
80105164:	90                   	nop
80105165:	90                   	nop
80105166:	90                   	nop
80105167:	90                   	nop
80105168:	90                   	nop
80105169:	90                   	nop
8010516a:	90                   	nop
8010516b:	90                   	nop
8010516c:	90                   	nop
8010516d:	90                   	nop
8010516e:	90                   	nop
8010516f:	90                   	nop

80105170 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105170:	55                   	push   %ebp
80105171:	89 e5                	mov    %esp,%ebp
80105173:	57                   	push   %edi
80105174:	56                   	push   %esi
80105175:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105176:	8d 45 d0             	lea    -0x30(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105179:	83 ec 34             	sub    $0x34,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010517c:	50                   	push   %eax
8010517d:	6a 00                	push   $0x0
8010517f:	e8 1c f7 ff ff       	call   801048a0 <argstr>
80105184:	83 c4 10             	add    $0x10,%esp
80105187:	85 c0                	test   %eax,%eax
80105189:	0f 88 ba 00 00 00    	js     80105249 <sys_open+0xd9>
8010518f:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105192:	83 ec 08             	sub    $0x8,%esp
80105195:	50                   	push   %eax
80105196:	6a 01                	push   $0x1
80105198:	e8 73 f6 ff ff       	call   80104810 <argint>
8010519d:	83 c4 10             	add    $0x10,%esp
801051a0:	85 c0                	test   %eax,%eax
801051a2:	0f 88 a1 00 00 00    	js     80105249 <sys_open+0xd9>
    return -1;

  begin_op();
801051a8:	e8 a3 da ff ff       	call   80102c50 <begin_op>

  if(omode & O_CREATE){
801051ad:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801051b0:	f6 c4 02             	test   $0x2,%ah
801051b3:	0f 84 2f 01 00 00    	je     801052e8 <sys_open+0x178>
    if(omode & O_SMALLFILE){
801051b9:	f6 c4 04             	test   $0x4,%ah
801051bc:	0f 85 9e 00 00 00    	jne    80105260 <sys_open+0xf0>
      }
      if((ip = create(path, T_SMALLFILE, 0, 0)) == 0)
        return -1;
    } else {
      char name[DIRSIZ];
      struct inode *dp = nameiparent(path, name);
801051c2:	8d 45 da             	lea    -0x26(%ebp),%eax
801051c5:	83 ec 08             	sub    $0x8,%esp
801051c8:	50                   	push   %eax
801051c9:	ff 75 d0             	pushl  -0x30(%ebp)
801051cc:	e8 6f cd ff ff       	call   80101f40 <nameiparent>
      if(dp->type == T_SMALLDIR){
801051d1:	83 c4 10             	add    $0x10,%esp
801051d4:	66 83 78 50 04       	cmpw   $0x4,0x50(%eax)
801051d9:	0f 84 63 01 00 00    	je     80105342 <sys_open+0x1d2>
        cprintf("nononon");
        end_op();
        return -1;
      }
      ip = create(path, T_FILE, 0, 0);
801051df:	83 ec 0c             	sub    $0xc,%esp
801051e2:	8b 45 d0             	mov    -0x30(%ebp),%eax
801051e5:	31 c9                	xor    %ecx,%ecx
801051e7:	6a 00                	push   $0x0
801051e9:	ba 02 00 00 00       	mov    $0x2,%edx
801051ee:	e8 2d f8 ff ff       	call   80104a20 <create>
      if(ip == 0){
801051f3:	83 c4 10             	add    $0x10,%esp
801051f6:	85 c0                	test   %eax,%eax
      if(dp->type == T_SMALLDIR){
        cprintf("nononon");
        end_op();
        return -1;
      }
      ip = create(path, T_FILE, 0, 0);
801051f8:	89 c7                	mov    %eax,%edi
      if(ip == 0){
801051fa:	0f 84 6b 01 00 00    	je     8010536b <sys_open+0x1fb>
      }
    }
  }
*/

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105200:	e8 4b bb ff ff       	call   80100d50 <filealloc>
80105205:	85 c0                	test   %eax,%eax
80105207:	89 c6                	mov    %eax,%esi
80105209:	74 2d                	je     80105238 <sys_open+0xc8>
8010520b:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80105212:	31 db                	xor    %ebx,%ebx
80105214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105218:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
8010521c:	85 c0                	test   %eax,%eax
8010521e:	0f 84 7c 00 00 00    	je     801052a0 <sys_open+0x130>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105224:	83 c3 01             	add    $0x1,%ebx
80105227:	83 fb 10             	cmp    $0x10,%ebx
8010522a:	75 ec                	jne    80105218 <sys_open+0xa8>
  }
*/

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
8010522c:	83 ec 0c             	sub    $0xc,%esp
8010522f:	56                   	push   %esi
80105230:	e8 db bb ff ff       	call   80100e10 <fileclose>
80105235:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105238:	83 ec 0c             	sub    $0xc,%esp
8010523b:	57                   	push   %edi
8010523c:	e8 7f c6 ff ff       	call   801018c0 <iunlockput>
    end_op();
80105241:	e8 7a da ff ff       	call   80102cc0 <end_op>
    return -1;
80105246:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105249:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
8010524c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105251:	5b                   	pop    %ebx
80105252:	5e                   	pop    %esi
80105253:	5f                   	pop    %edi
80105254:	5d                   	pop    %ebp
80105255:	c3                   	ret    
80105256:	8d 76 00             	lea    0x0(%esi),%esi
80105259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  begin_op();

  if(omode & O_CREATE){
    if(omode & O_SMALLFILE){
      char name[DIRSIZ];
      struct inode *dp = nameiparent(path, name);
80105260:	8d 45 da             	lea    -0x26(%ebp),%eax
80105263:	83 ec 08             	sub    $0x8,%esp
80105266:	50                   	push   %eax
80105267:	ff 75 d0             	pushl  -0x30(%ebp)
8010526a:	e8 d1 cc ff ff       	call   80101f40 <nameiparent>
      if(dp->type != T_SMALLDIR){
8010526f:	83 c4 10             	add    $0x10,%esp
80105272:	66 83 78 50 04       	cmpw   $0x4,0x50(%eax)
80105277:	0f 85 ab 00 00 00    	jne    80105328 <sys_open+0x1b8>
        cprintf("NONONO");
        end_op();
        return -1;
      }
      if((ip = create(path, T_SMALLFILE, 0, 0)) == 0)
8010527d:	83 ec 0c             	sub    $0xc,%esp
80105280:	8b 45 d0             	mov    -0x30(%ebp),%eax
80105283:	31 c9                	xor    %ecx,%ecx
80105285:	6a 00                	push   $0x0
80105287:	ba 05 00 00 00       	mov    $0x5,%edx
8010528c:	e8 8f f7 ff ff       	call   80104a20 <create>
80105291:	83 c4 10             	add    $0x10,%esp
80105294:	85 c0                	test   %eax,%eax
80105296:	89 c7                	mov    %eax,%edi
80105298:	0f 85 62 ff ff ff    	jne    80105200 <sys_open+0x90>
8010529e:	eb a9                	jmp    80105249 <sys_open+0xd9>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052a0:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801052a3:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801052a7:	57                   	push   %edi
801052a8:	e8 83 c4 ff ff       	call   80101730 <iunlock>
  end_op();
801052ad:	e8 0e da ff ff       	call   80102cc0 <end_op>

  f->type = FD_INODE;
801052b2:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052b8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052bb:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
801052be:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
801052c1:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
801052c8:	89 d0                	mov    %edx,%eax
801052ca:	83 e0 01             	and    $0x1,%eax
801052cd:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052d0:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052d3:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052d6:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
801052da:	89 d8                	mov    %ebx,%eax
}
801052dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052df:	5b                   	pop    %ebx
801052e0:	5e                   	pop    %esi
801052e1:	5f                   	pop    %edi
801052e2:	5d                   	pop    %ebp
801052e3:	c3                   	ret    
801052e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        end_op();
        return -1;
      }
    }
  } else {
    if((ip = namei(path)) == 0){
801052e8:	83 ec 0c             	sub    $0xc,%esp
801052eb:	ff 75 d0             	pushl  -0x30(%ebp)
801052ee:	e8 2d cc ff ff       	call   80101f20 <namei>
801052f3:	83 c4 10             	add    $0x10,%esp
801052f6:	85 c0                	test   %eax,%eax
801052f8:	89 c7                	mov    %eax,%edi
801052fa:	74 60                	je     8010535c <sys_open+0x1ec>
      end_op();
      return -1;
    }
    ilock(ip);
801052fc:	83 ec 0c             	sub    $0xc,%esp
801052ff:	50                   	push   %eax
80105300:	e8 4b c3 ff ff       	call   80101650 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105305:	83 c4 10             	add    $0x10,%esp
80105308:	66 83 7f 50 01       	cmpw   $0x1,0x50(%edi)
8010530d:	0f 85 ed fe ff ff    	jne    80105200 <sys_open+0x90>
80105313:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80105316:	85 d2                	test   %edx,%edx
80105318:	0f 84 e2 fe ff ff    	je     80105200 <sys_open+0x90>
8010531e:	e9 15 ff ff ff       	jmp    80105238 <sys_open+0xc8>
80105323:	90                   	nop
80105324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(omode & O_CREATE){
    if(omode & O_SMALLFILE){
      char name[DIRSIZ];
      struct inode *dp = nameiparent(path, name);
      if(dp->type != T_SMALLDIR){
        cprintf("NONONO");
80105328:	83 ec 0c             	sub    $0xc,%esp
8010532b:	68 65 7a 10 80       	push   $0x80107a65
80105330:	e8 2b b3 ff ff       	call   80100660 <cprintf>
        end_op();
80105335:	e8 86 d9 ff ff       	call   80102cc0 <end_op>
        return -1;
8010533a:	83 c4 10             	add    $0x10,%esp
8010533d:	e9 07 ff ff ff       	jmp    80105249 <sys_open+0xd9>
        return -1;
    } else {
      char name[DIRSIZ];
      struct inode *dp = nameiparent(path, name);
      if(dp->type == T_SMALLDIR){
        cprintf("nononon");
80105342:	83 ec 0c             	sub    $0xc,%esp
80105345:	68 6c 7a 10 80       	push   $0x80107a6c
8010534a:	e8 11 b3 ff ff       	call   80100660 <cprintf>
        end_op();
8010534f:	e8 6c d9 ff ff       	call   80102cc0 <end_op>
        return -1;
80105354:	83 c4 10             	add    $0x10,%esp
80105357:	e9 ed fe ff ff       	jmp    80105249 <sys_open+0xd9>
        return -1;
      }
    }
  } else {
    if((ip = namei(path)) == 0){
      end_op();
8010535c:	e8 5f d9 ff ff       	call   80102cc0 <end_op>
      return -1;
80105361:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105366:	e9 71 ff ff ff       	jmp    801052dc <sys_open+0x16c>
        end_op();
        return -1;
      }
      ip = create(path, T_FILE, 0, 0);
      if(ip == 0){
        end_op();
8010536b:	e8 50 d9 ff ff       	call   80102cc0 <end_op>
        return -1;
80105370:	e9 d4 fe ff ff       	jmp    80105249 <sys_open+0xd9>
80105375:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105380 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105386:	e8 c5 d8 ff ff       	call   80102c50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010538b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010538e:	83 ec 08             	sub    $0x8,%esp
80105391:	50                   	push   %eax
80105392:	6a 00                	push   $0x0
80105394:	e8 07 f5 ff ff       	call   801048a0 <argstr>
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	85 c0                	test   %eax,%eax
8010539e:	78 30                	js     801053d0 <sys_mkdir+0x50>
801053a0:	83 ec 0c             	sub    $0xc,%esp
801053a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053a6:	31 c9                	xor    %ecx,%ecx
801053a8:	6a 00                	push   $0x0
801053aa:	ba 01 00 00 00       	mov    $0x1,%edx
801053af:	e8 6c f6 ff ff       	call   80104a20 <create>
801053b4:	83 c4 10             	add    $0x10,%esp
801053b7:	85 c0                	test   %eax,%eax
801053b9:	74 15                	je     801053d0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801053bb:	83 ec 0c             	sub    $0xc,%esp
801053be:	50                   	push   %eax
801053bf:	e8 fc c4 ff ff       	call   801018c0 <iunlockput>
  end_op();
801053c4:	e8 f7 d8 ff ff       	call   80102cc0 <end_op>
  return 0;
801053c9:	83 c4 10             	add    $0x10,%esp
801053cc:	31 c0                	xor    %eax,%eax
}
801053ce:	c9                   	leave  
801053cf:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801053d0:	e8 eb d8 ff ff       	call   80102cc0 <end_op>
    return -1;
801053d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801053da:	c9                   	leave  
801053db:	c3                   	ret    
801053dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053e0 <sys_mkSmallFilesdir>:

int
sys_mkSmallFilesdir(void)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053e6:	e8 65 d8 ff ff       	call   80102c50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_SMALLDIR, 0, 0)) == 0){
801053eb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053ee:	83 ec 08             	sub    $0x8,%esp
801053f1:	50                   	push   %eax
801053f2:	6a 00                	push   $0x0
801053f4:	e8 a7 f4 ff ff       	call   801048a0 <argstr>
801053f9:	83 c4 10             	add    $0x10,%esp
801053fc:	85 c0                	test   %eax,%eax
801053fe:	78 30                	js     80105430 <sys_mkSmallFilesdir+0x50>
80105400:	83 ec 0c             	sub    $0xc,%esp
80105403:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105406:	31 c9                	xor    %ecx,%ecx
80105408:	6a 00                	push   $0x0
8010540a:	ba 04 00 00 00       	mov    $0x4,%edx
8010540f:	e8 0c f6 ff ff       	call   80104a20 <create>
80105414:	83 c4 10             	add    $0x10,%esp
80105417:	85 c0                	test   %eax,%eax
80105419:	74 15                	je     80105430 <sys_mkSmallFilesdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010541b:	83 ec 0c             	sub    $0xc,%esp
8010541e:	50                   	push   %eax
8010541f:	e8 9c c4 ff ff       	call   801018c0 <iunlockput>
  end_op();
80105424:	e8 97 d8 ff ff       	call   80102cc0 <end_op>
  return 0;
80105429:	83 c4 10             	add    $0x10,%esp
8010542c:	31 c0                	xor    %eax,%eax
}
8010542e:	c9                   	leave  
8010542f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_SMALLDIR, 0, 0)) == 0){
    end_op();
80105430:	e8 8b d8 ff ff       	call   80102cc0 <end_op>
    return -1;
80105435:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010543a:	c9                   	leave  
8010543b:	c3                   	ret    
8010543c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105440 <sys_mknod>:

int
sys_mknod(void)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105446:	e8 05 d8 ff ff       	call   80102c50 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010544b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010544e:	83 ec 08             	sub    $0x8,%esp
80105451:	50                   	push   %eax
80105452:	6a 00                	push   $0x0
80105454:	e8 47 f4 ff ff       	call   801048a0 <argstr>
80105459:	83 c4 10             	add    $0x10,%esp
8010545c:	85 c0                	test   %eax,%eax
8010545e:	78 60                	js     801054c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105460:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105463:	83 ec 08             	sub    $0x8,%esp
80105466:	50                   	push   %eax
80105467:	6a 01                	push   $0x1
80105469:	e8 a2 f3 ff ff       	call   80104810 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
8010546e:	83 c4 10             	add    $0x10,%esp
80105471:	85 c0                	test   %eax,%eax
80105473:	78 4b                	js     801054c0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
80105475:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105478:	83 ec 08             	sub    $0x8,%esp
8010547b:	50                   	push   %eax
8010547c:	6a 02                	push   $0x2
8010547e:	e8 8d f3 ff ff       	call   80104810 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
80105483:	83 c4 10             	add    $0x10,%esp
80105486:	85 c0                	test   %eax,%eax
80105488:	78 36                	js     801054c0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
8010548a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010548e:	83 ec 0c             	sub    $0xc,%esp
80105491:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105495:	ba 03 00 00 00       	mov    $0x3,%edx
8010549a:	50                   	push   %eax
8010549b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010549e:	e8 7d f5 ff ff       	call   80104a20 <create>
801054a3:	83 c4 10             	add    $0x10,%esp
801054a6:	85 c0                	test   %eax,%eax
801054a8:	74 16                	je     801054c0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
801054aa:	83 ec 0c             	sub    $0xc,%esp
801054ad:	50                   	push   %eax
801054ae:	e8 0d c4 ff ff       	call   801018c0 <iunlockput>
  end_op();
801054b3:	e8 08 d8 ff ff       	call   80102cc0 <end_op>
  return 0;
801054b8:	83 c4 10             	add    $0x10,%esp
801054bb:	31 c0                	xor    %eax,%eax
}
801054bd:	c9                   	leave  
801054be:	c3                   	ret    
801054bf:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
801054c0:	e8 fb d7 ff ff       	call   80102cc0 <end_op>
    return -1;
801054c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801054ca:	c9                   	leave  
801054cb:	c3                   	ret    
801054cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054d0 <sys_chdir>:

int
sys_chdir(void)
{
801054d0:	55                   	push   %ebp
801054d1:	89 e5                	mov    %esp,%ebp
801054d3:	53                   	push   %ebx
801054d4:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
801054d7:	e8 74 d7 ff ff       	call   80102c50 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054dc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054df:	83 ec 08             	sub    $0x8,%esp
801054e2:	50                   	push   %eax
801054e3:	6a 00                	push   $0x0
801054e5:	e8 b6 f3 ff ff       	call   801048a0 <argstr>
801054ea:	83 c4 10             	add    $0x10,%esp
801054ed:	85 c0                	test   %eax,%eax
801054ef:	78 7f                	js     80105570 <sys_chdir+0xa0>
801054f1:	83 ec 0c             	sub    $0xc,%esp
801054f4:	ff 75 f4             	pushl  -0xc(%ebp)
801054f7:	e8 24 ca ff ff       	call   80101f20 <namei>
801054fc:	83 c4 10             	add    $0x10,%esp
801054ff:	85 c0                	test   %eax,%eax
80105501:	89 c3                	mov    %eax,%ebx
80105503:	74 6b                	je     80105570 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105505:	83 ec 0c             	sub    $0xc,%esp
80105508:	50                   	push   %eax
80105509:	e8 42 c1 ff ff       	call   80101650 <ilock>
  if(ip->type != T_DIR){
8010550e:	83 c4 10             	add    $0x10,%esp
80105511:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105516:	75 38                	jne    80105550 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105518:	83 ec 0c             	sub    $0xc,%esp
8010551b:	53                   	push   %ebx
8010551c:	e8 0f c2 ff ff       	call   80101730 <iunlock>
  iput(proc->cwd);
80105521:	58                   	pop    %eax
80105522:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105528:	ff 70 68             	pushl  0x68(%eax)
8010552b:	e8 50 c2 ff ff       	call   80101780 <iput>
  end_op();
80105530:	e8 8b d7 ff ff       	call   80102cc0 <end_op>
  proc->cwd = ip;
80105535:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
8010553b:	83 c4 10             	add    $0x10,%esp
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
8010553e:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
80105541:	31 c0                	xor    %eax,%eax
}
80105543:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105546:	c9                   	leave  
80105547:	c3                   	ret    
80105548:	90                   	nop
80105549:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
80105550:	83 ec 0c             	sub    $0xc,%esp
80105553:	53                   	push   %ebx
80105554:	e8 67 c3 ff ff       	call   801018c0 <iunlockput>
    end_op();
80105559:	e8 62 d7 ff ff       	call   80102cc0 <end_op>
    return -1;
8010555e:	83 c4 10             	add    $0x10,%esp
80105561:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105566:	eb db                	jmp    80105543 <sys_chdir+0x73>
80105568:	90                   	nop
80105569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
80105570:	e8 4b d7 ff ff       	call   80102cc0 <end_op>
    return -1;
80105575:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010557a:	eb c7                	jmp    80105543 <sys_chdir+0x73>
8010557c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105580 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
80105580:	55                   	push   %ebp
80105581:	89 e5                	mov    %esp,%ebp
80105583:	57                   	push   %edi
80105584:	56                   	push   %esi
80105585:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105586:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
8010558c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105592:	50                   	push   %eax
80105593:	6a 00                	push   $0x0
80105595:	e8 06 f3 ff ff       	call   801048a0 <argstr>
8010559a:	83 c4 10             	add    $0x10,%esp
8010559d:	85 c0                	test   %eax,%eax
8010559f:	78 7f                	js     80105620 <sys_exec+0xa0>
801055a1:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801055a7:	83 ec 08             	sub    $0x8,%esp
801055aa:	50                   	push   %eax
801055ab:	6a 01                	push   $0x1
801055ad:	e8 5e f2 ff ff       	call   80104810 <argint>
801055b2:	83 c4 10             	add    $0x10,%esp
801055b5:	85 c0                	test   %eax,%eax
801055b7:	78 67                	js     80105620 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801055b9:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055bf:	83 ec 04             	sub    $0x4,%esp
801055c2:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
801055c8:	68 80 00 00 00       	push   $0x80
801055cd:	6a 00                	push   $0x0
801055cf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801055d5:	50                   	push   %eax
801055d6:	31 db                	xor    %ebx,%ebx
801055d8:	e8 43 ef ff ff       	call   80104520 <memset>
801055dd:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055e0:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801055e6:	83 ec 08             	sub    $0x8,%esp
801055e9:	57                   	push   %edi
801055ea:	8d 04 98             	lea    (%eax,%ebx,4),%eax
801055ed:	50                   	push   %eax
801055ee:	e8 9d f1 ff ff       	call   80104790 <fetchint>
801055f3:	83 c4 10             	add    $0x10,%esp
801055f6:	85 c0                	test   %eax,%eax
801055f8:	78 26                	js     80105620 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
801055fa:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105600:	85 c0                	test   %eax,%eax
80105602:	74 2c                	je     80105630 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105604:	83 ec 08             	sub    $0x8,%esp
80105607:	56                   	push   %esi
80105608:	50                   	push   %eax
80105609:	e8 b2 f1 ff ff       	call   801047c0 <fetchstr>
8010560e:	83 c4 10             	add    $0x10,%esp
80105611:	85 c0                	test   %eax,%eax
80105613:	78 0b                	js     80105620 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105615:	83 c3 01             	add    $0x1,%ebx
80105618:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010561b:	83 fb 20             	cmp    $0x20,%ebx
8010561e:	75 c0                	jne    801055e0 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105620:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105623:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105628:	5b                   	pop    %ebx
80105629:	5e                   	pop    %esi
8010562a:	5f                   	pop    %edi
8010562b:	5d                   	pop    %ebp
8010562c:	c3                   	ret    
8010562d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105630:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105636:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
80105639:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105640:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80105644:	50                   	push   %eax
80105645:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010564b:	e8 a0 b3 ff ff       	call   801009f0 <exec>
80105650:	83 c4 10             	add    $0x10,%esp
}
80105653:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105656:	5b                   	pop    %ebx
80105657:	5e                   	pop    %esi
80105658:	5f                   	pop    %edi
80105659:	5d                   	pop    %ebp
8010565a:	c3                   	ret    
8010565b:	90                   	nop
8010565c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105660 <sys_pipe>:

int
sys_pipe(void)
{
80105660:	55                   	push   %ebp
80105661:	89 e5                	mov    %esp,%ebp
80105663:	57                   	push   %edi
80105664:	56                   	push   %esi
80105665:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105666:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
80105669:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010566c:	6a 08                	push   $0x8
8010566e:	50                   	push   %eax
8010566f:	6a 00                	push   $0x0
80105671:	e8 da f1 ff ff       	call   80104850 <argptr>
80105676:	83 c4 10             	add    $0x10,%esp
80105679:	85 c0                	test   %eax,%eax
8010567b:	78 48                	js     801056c5 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010567d:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105680:	83 ec 08             	sub    $0x8,%esp
80105683:	50                   	push   %eax
80105684:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105687:	50                   	push   %eax
80105688:	e8 63 dd ff ff       	call   801033f0 <pipealloc>
8010568d:	83 c4 10             	add    $0x10,%esp
80105690:	85 c0                	test   %eax,%eax
80105692:	78 31                	js     801056c5 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105694:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105697:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010569e:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
801056a0:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
801056a4:	85 d2                	test   %edx,%edx
801056a6:	74 28                	je     801056d0 <sys_pipe+0x70>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801056a8:	83 c0 01             	add    $0x1,%eax
801056ab:	83 f8 10             	cmp    $0x10,%eax
801056ae:	75 f0                	jne    801056a0 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
801056b0:	83 ec 0c             	sub    $0xc,%esp
801056b3:	53                   	push   %ebx
801056b4:	e8 57 b7 ff ff       	call   80100e10 <fileclose>
    fileclose(wf);
801056b9:	58                   	pop    %eax
801056ba:	ff 75 e4             	pushl  -0x1c(%ebp)
801056bd:	e8 4e b7 ff ff       	call   80100e10 <fileclose>
    return -1;
801056c2:	83 c4 10             	add    $0x10,%esp
801056c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ca:	eb 45                	jmp    80105711 <sys_pipe+0xb1>
801056cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056d0:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056d3:	8b 7d e4             	mov    -0x1c(%ebp),%edi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801056d6:	31 d2                	xor    %edx,%edx
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
801056d8:	89 5e 28             	mov    %ebx,0x28(%esi)
801056db:	90                   	nop
801056dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
801056e0:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
801056e5:	74 19                	je     80105700 <sys_pipe+0xa0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
801056e7:	83 c2 01             	add    $0x1,%edx
801056ea:	83 fa 10             	cmp    $0x10,%edx
801056ed:	75 f1                	jne    801056e0 <sys_pipe+0x80>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
801056ef:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
801056f6:	eb b8                	jmp    801056b0 <sys_pipe+0x50>
801056f8:	90                   	nop
801056f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105700:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105704:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105707:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105709:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010570c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010570f:	31 c0                	xor    %eax,%eax
}
80105711:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105714:	5b                   	pop    %ebx
80105715:	5e                   	pop    %esi
80105716:	5f                   	pop    %edi
80105717:	5d                   	pop    %ebp
80105718:	c3                   	ret    
80105719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105720 <updatecount>:
int count_array[23];
int inits = 0;

void
updatecount(int syscall) {
  if (inits == 0) {
80105720:	a1 c4 a5 10 80       	mov    0x8010a5c4,%eax

int count_array[23];
int inits = 0;

void
updatecount(int syscall) {
80105725:	55                   	push   %ebp
80105726:	89 e5                	mov    %esp,%ebp
  if (inits == 0) {
80105728:	85 c0                	test   %eax,%eax

int count_array[23];
int inits = 0;

void
updatecount(int syscall) {
8010572a:	8b 55 08             	mov    0x8(%ebp),%edx
  if (inits == 0) {
8010572d:	75 19                	jne    80105748 <updatecount+0x28>
8010572f:	b8 40 4d 11 80       	mov    $0x80114d40,%eax
80105734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int i;
    for (i = 0; i < 23; i++) {
      count_array[i] = 0;
80105738:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010573e:	83 c0 04             	add    $0x4,%eax

void
updatecount(int syscall) {
  if (inits == 0) {
    int i;
    for (i = 0; i < 23; i++) {
80105741:	3d 9c 4d 11 80       	cmp    $0x80114d9c,%eax
80105746:	75 f0                	jne    80105738 <updatecount+0x18>
      count_array[i] = 0;
     }
  }
  inits = 1;
80105748:	c7 05 c4 a5 10 80 01 	movl   $0x1,0x8010a5c4
8010574f:	00 00 00 
  count_array[syscall]++;
80105752:	83 04 95 40 4d 11 80 	addl   $0x1,-0x7feeb2c0(,%edx,4)
80105759:	01 
}
8010575a:	5d                   	pop    %ebp
8010575b:	c3                   	ret    
8010575c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105760 <getcount>:

int
getcount(void)
{
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	83 ec 20             	sub    $0x20,%esp
  int *counts;
  int size;
  if(argint(1, &size) < 0 || argptr(0, (void*)&counts, size) < 0)
80105766:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105769:	50                   	push   %eax
8010576a:	6a 01                	push   $0x1
8010576c:	e8 9f f0 ff ff       	call   80104810 <argint>
80105771:	83 c4 10             	add    $0x10,%esp
80105774:	85 c0                	test   %eax,%eax
80105776:	78 48                	js     801057c0 <getcount+0x60>
80105778:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010577b:	83 ec 04             	sub    $0x4,%esp
8010577e:	ff 75 f4             	pushl  -0xc(%ebp)
80105781:	50                   	push   %eax
80105782:	6a 00                	push   $0x0
80105784:	e8 c7 f0 ff ff       	call   80104850 <argptr>
80105789:	83 c4 10             	add    $0x10,%esp
8010578c:	85 c0                	test   %eax,%eax
8010578e:	78 30                	js     801057c0 <getcount+0x60>
    return -1;
  if (size < 23 || counts == 0) {
80105790:	83 7d f4 16          	cmpl   $0x16,-0xc(%ebp)
80105794:	7e 2a                	jle    801057c0 <getcount+0x60>
80105796:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105799:	85 d2                	test   %edx,%edx
8010579b:	74 23                	je     801057c0 <getcount+0x60>
8010579d:	31 c0                	xor    %eax,%eax
8010579f:	eb 0a                	jmp    801057ab <getcount+0x4b>
801057a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057a8:	8b 55 f0             	mov    -0x10(%ebp),%edx
    return -1;
  }
  int i;
  for (i = 0; i < 23; i++) {
    counts[i] = count_array[i];
801057ab:	8b 88 40 4d 11 80    	mov    -0x7feeb2c0(%eax),%ecx
801057b1:	89 0c 02             	mov    %ecx,(%edx,%eax,1)
801057b4:	83 c0 04             	add    $0x4,%eax
    return -1;
  if (size < 23 || counts == 0) {
    return -1;
  }
  int i;
  for (i = 0; i < 23; i++) {
801057b7:	83 f8 5c             	cmp    $0x5c,%eax
801057ba:	75 ec                	jne    801057a8 <getcount+0x48>
    counts[i] = count_array[i];
  }
  return 0;
801057bc:	31 c0                	xor    %eax,%eax

}
801057be:	c9                   	leave  
801057bf:	c3                   	ret    
getcount(void)
{
  int *counts;
  int size;
  if(argint(1, &size) < 0 || argptr(0, (void*)&counts, size) < 0)
    return -1;
801057c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for (i = 0; i < 23; i++) {
    counts[i] = count_array[i];
  }
  return 0;

}
801057c5:	c9                   	leave  
801057c6:	c3                   	ret    
801057c7:	89 f6                	mov    %esi,%esi
801057c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057d0 <updatem>:

int numberz;
void
updatem(int newsz){
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
	numberz=newsz;
801057d3:	8b 45 08             	mov    0x8(%ebp),%eax
}
801057d6:	5d                   	pop    %ebp
}

int numberz;
void
updatem(int newsz){
	numberz=newsz;
801057d7:	a3 20 4d 11 80       	mov    %eax,0x80114d20
}
801057dc:	c3                   	ret    
801057dd:	8d 76 00             	lea    0x0(%esi),%esi

801057e0 <currentm>:

int
currentm(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	53                   	push   %ebx
801057e4:	83 ec 1c             	sub    $0x1c,%esp
	int pages;
	float num;
	const uint MAXPAGES = 524288;

	num = numberz/PGSIZE;
801057e7:	8b 15 20 4d 11 80    	mov    0x80114d20,%edx
	num = num+1;
	pages=(int)num;
801057ed:	d9 7d f6             	fnstcw -0xa(%ebp)
{
	int pages;
	float num;
	const uint MAXPAGES = 524288;

	num = numberz/PGSIZE;
801057f0:	8d 82 ff 0f 00 00    	lea    0xfff(%edx),%eax
801057f6:	85 d2                	test   %edx,%edx
801057f8:	0f 49 c2             	cmovns %edx,%eax
801057fb:	c1 f8 0c             	sar    $0xc,%eax
801057fe:	89 45 ec             	mov    %eax,-0x14(%ebp)
	num = num+1;
	pages=(int)num;
80105801:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
{
	int pages;
	float num;
	const uint MAXPAGES = 524288;

	num = numberz/PGSIZE;
80105805:	db 45 ec             	fildl  -0x14(%ebp)
	num = num+1;
	pages=(int)num;
80105808:	d8 05 bc 7a 10 80    	fadds  0x80107abc
8010580e:	b4 0c                	mov    $0xc,%ah
80105810:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80105814:	d9 6d f4             	fldcw  -0xc(%ebp)
80105817:	db 5d f0             	fistpl -0x10(%ebp)
8010581a:	d9 6d f6             	fldcw  -0xa(%ebp)
8010581d:	8b 5d f0             	mov    -0x10(%ebp),%ebx
	int rempages = MAXPAGES-pages;
	cprintf("# of Pages for Current Process: %d\n", pages);
80105820:	53                   	push   %ebx
80105821:	68 74 7a 10 80       	push   $0x80107a74
80105826:	e8 35 ae ff ff       	call   80100660 <cprintf>
	cprintf("# of Pages Available for C/P: %d\n", rempages);
8010582b:	58                   	pop    %eax
8010582c:	b8 00 00 08 00       	mov    $0x80000,%eax
80105831:	5a                   	pop    %edx
80105832:	29 d8                	sub    %ebx,%eax
80105834:	50                   	push   %eax
80105835:	68 98 7a 10 80       	push   $0x80107a98
8010583a:	e8 21 ae ff ff       	call   80100660 <cprintf>
	return 0;
}
8010583f:	31 c0                	xor    %eax,%eax
80105841:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105844:	c9                   	leave  
80105845:	c3                   	ret    
80105846:	66 90                	xchg   %ax,%ax
80105848:	66 90                	xchg   %ax,%ax
8010584a:	66 90                	xchg   %ax,%ax
8010584c:	66 90                	xchg   %ax,%ax
8010584e:	66 90                	xchg   %ax,%ax

80105850 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105853:	5d                   	pop    %ebp
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105854:	e9 17 e2 ff ff       	jmp    80103a70 <fork>
80105859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105860 <sys_exit>:
}

int
sys_exit(void)
{
80105860:	55                   	push   %ebp
80105861:	89 e5                	mov    %esp,%ebp
80105863:	83 ec 08             	sub    $0x8,%esp
  exit();
80105866:	e8 75 e4 ff ff       	call   80103ce0 <exit>
  return 0;  // not reached
}
8010586b:	31 c0                	xor    %eax,%eax
8010586d:	c9                   	leave  
8010586e:	c3                   	ret    
8010586f:	90                   	nop

80105870 <sys_wait>:

int
sys_wait(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105873:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105874:	e9 b7 e6 ff ff       	jmp    80103f30 <wait>
80105879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105880 <sys_kill>:
}

int
sys_kill(void)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105886:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105889:	50                   	push   %eax
8010588a:	6a 00                	push   $0x0
8010588c:	e8 7f ef ff ff       	call   80104810 <argint>
80105891:	83 c4 10             	add    $0x10,%esp
80105894:	85 c0                	test   %eax,%eax
80105896:	78 18                	js     801058b0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105898:	83 ec 0c             	sub    $0xc,%esp
8010589b:	ff 75 f4             	pushl  -0xc(%ebp)
8010589e:	e8 cd e7 ff ff       	call   80104070 <kill>
801058a3:	83 c4 10             	add    $0x10,%esp
}
801058a6:	c9                   	leave  
801058a7:	c3                   	ret    
801058a8:	90                   	nop
801058a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
801058b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
801058b5:	c9                   	leave  
801058b6:	c3                   	ret    
801058b7:	89 f6                	mov    %esi,%esi
801058b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058c0 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
801058c0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
801058c6:	55                   	push   %ebp
801058c7:	89 e5                	mov    %esp,%ebp
  return proc->pid;
801058c9:	8b 40 10             	mov    0x10(%eax),%eax
}
801058cc:	5d                   	pop    %ebp
801058cd:	c3                   	ret    
801058ce:	66 90                	xchg   %ax,%ax

801058d0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return proc->pid;
}

int
sys_sbrk(void)
{
801058d7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058da:	50                   	push   %eax
801058db:	6a 00                	push   $0x0
801058dd:	e8 2e ef ff ff       	call   80104810 <argint>
801058e2:	83 c4 10             	add    $0x10,%esp
801058e5:	85 c0                	test   %eax,%eax
801058e7:	78 27                	js     80105910 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
801058e9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
801058ef:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
801058f2:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801058f4:	ff 75 f4             	pushl  -0xc(%ebp)
801058f7:	e8 04 e1 ff ff       	call   80103a00 <growproc>
801058fc:	83 c4 10             	add    $0x10,%esp
801058ff:	85 c0                	test   %eax,%eax
80105901:	78 0d                	js     80105910 <sys_sbrk+0x40>
    return -1;
  return addr;
80105903:	89 d8                	mov    %ebx,%eax
}
80105905:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105908:	c9                   	leave  
80105909:	c3                   	ret    
8010590a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
80105910:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105915:	eb ee                	jmp    80105905 <sys_sbrk+0x35>
80105917:	89 f6                	mov    %esi,%esi
80105919:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105920 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105924:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
80105927:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010592a:	50                   	push   %eax
8010592b:	6a 00                	push   $0x0
8010592d:	e8 de ee ff ff       	call   80104810 <argint>
80105932:	83 c4 10             	add    $0x10,%esp
80105935:	85 c0                	test   %eax,%eax
80105937:	0f 88 8a 00 00 00    	js     801059c7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010593d:	83 ec 0c             	sub    $0xc,%esp
80105940:	68 a0 4d 11 80       	push   $0x80114da0
80105945:	e8 a6 e9 ff ff       	call   801042f0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010594a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010594d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105950:	8b 1d e0 55 11 80    	mov    0x801155e0,%ebx
  while(ticks - ticks0 < n){
80105956:	85 d2                	test   %edx,%edx
80105958:	75 27                	jne    80105981 <sys_sleep+0x61>
8010595a:	eb 54                	jmp    801059b0 <sys_sleep+0x90>
8010595c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105960:	83 ec 08             	sub    $0x8,%esp
80105963:	68 a0 4d 11 80       	push   $0x80114da0
80105968:	68 e0 55 11 80       	push   $0x801155e0
8010596d:	e8 fe e4 ff ff       	call   80103e70 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105972:	a1 e0 55 11 80       	mov    0x801155e0,%eax
80105977:	83 c4 10             	add    $0x10,%esp
8010597a:	29 d8                	sub    %ebx,%eax
8010597c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010597f:	73 2f                	jae    801059b0 <sys_sleep+0x90>
    if(proc->killed){
80105981:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105987:	8b 40 24             	mov    0x24(%eax),%eax
8010598a:	85 c0                	test   %eax,%eax
8010598c:	74 d2                	je     80105960 <sys_sleep+0x40>
      release(&tickslock);
8010598e:	83 ec 0c             	sub    $0xc,%esp
80105991:	68 a0 4d 11 80       	push   $0x80114da0
80105996:	e8 35 eb ff ff       	call   801044d0 <release>
      return -1;
8010599b:	83 c4 10             	add    $0x10,%esp
8010599e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
801059a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059a6:	c9                   	leave  
801059a7:	c3                   	ret    
801059a8:	90                   	nop
801059a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
801059b0:	83 ec 0c             	sub    $0xc,%esp
801059b3:	68 a0 4d 11 80       	push   $0x80114da0
801059b8:	e8 13 eb ff ff       	call   801044d0 <release>
  return 0;
801059bd:	83 c4 10             	add    $0x10,%esp
801059c0:	31 c0                	xor    %eax,%eax
}
801059c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059c5:	c9                   	leave  
801059c6:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
801059c7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059cc:	eb d5                	jmp    801059a3 <sys_sleep+0x83>
801059ce:	66 90                	xchg   %ax,%ax

801059d0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059d0:	55                   	push   %ebp
801059d1:	89 e5                	mov    %esp,%ebp
801059d3:	53                   	push   %ebx
801059d4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059d7:	68 a0 4d 11 80       	push   $0x80114da0
801059dc:	e8 0f e9 ff ff       	call   801042f0 <acquire>
  xticks = ticks;
801059e1:	8b 1d e0 55 11 80    	mov    0x801155e0,%ebx
  release(&tickslock);
801059e7:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801059ee:	e8 dd ea ff ff       	call   801044d0 <release>
  return xticks;
}
801059f3:	89 d8                	mov    %ebx,%eax
801059f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059f8:	c9                   	leave  
801059f9:	c3                   	ret    
801059fa:	66 90                	xchg   %ax,%ax
801059fc:	66 90                	xchg   %ax,%ax
801059fe:	66 90                	xchg   %ax,%ax

80105a00 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
80105a00:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105a01:	ba 43 00 00 00       	mov    $0x43,%edx
80105a06:	b8 34 00 00 00       	mov    $0x34,%eax
80105a0b:	89 e5                	mov    %esp,%ebp
80105a0d:	83 ec 14             	sub    $0x14,%esp
80105a10:	ee                   	out    %al,(%dx)
80105a11:	ba 40 00 00 00       	mov    $0x40,%edx
80105a16:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
80105a1b:	ee                   	out    %al,(%dx)
80105a1c:	b8 2e 00 00 00       	mov    $0x2e,%eax
80105a21:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
80105a22:	6a 00                	push   $0x0
80105a24:	e8 f7 d8 ff ff       	call   80103320 <picenable>
}
80105a29:	83 c4 10             	add    $0x10,%esp
80105a2c:	c9                   	leave  
80105a2d:	c3                   	ret    

80105a2e <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105a2e:	1e                   	push   %ds
  pushl %es
80105a2f:	06                   	push   %es
  pushl %fs
80105a30:	0f a0                	push   %fs
  pushl %gs
80105a32:	0f a8                	push   %gs
  pushal
80105a34:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105a35:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105a39:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105a3b:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80105a3d:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105a41:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105a43:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105a45:	54                   	push   %esp
  call trap
80105a46:	e8 e5 00 00 00       	call   80105b30 <trap>
  addl $4, %esp
80105a4b:	83 c4 04             	add    $0x4,%esp

80105a4e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105a4e:	61                   	popa   
  popl %gs
80105a4f:	0f a9                	pop    %gs
  popl %fs
80105a51:	0f a1                	pop    %fs
  popl %es
80105a53:	07                   	pop    %es
  popl %ds
80105a54:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105a55:	83 c4 08             	add    $0x8,%esp
  iret
80105a58:	cf                   	iret   
80105a59:	66 90                	xchg   %ax,%ax
80105a5b:	66 90                	xchg   %ax,%ax
80105a5d:	66 90                	xchg   %ax,%ax
80105a5f:	90                   	nop

80105a60 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105a60:	31 c0                	xor    %eax,%eax
80105a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a68:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105a6f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105a74:	c6 04 c5 e4 4d 11 80 	movb   $0x0,-0x7feeb21c(,%eax,8)
80105a7b:	00 
80105a7c:	66 89 0c c5 e2 4d 11 	mov    %cx,-0x7feeb21e(,%eax,8)
80105a83:	80 
80105a84:	c6 04 c5 e5 4d 11 80 	movb   $0x8e,-0x7feeb21b(,%eax,8)
80105a8b:	8e 
80105a8c:	66 89 14 c5 e0 4d 11 	mov    %dx,-0x7feeb220(,%eax,8)
80105a93:	80 
80105a94:	c1 ea 10             	shr    $0x10,%edx
80105a97:	66 89 14 c5 e6 4d 11 	mov    %dx,-0x7feeb21a(,%eax,8)
80105a9e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105a9f:	83 c0 01             	add    $0x1,%eax
80105aa2:	3d 00 01 00 00       	cmp    $0x100,%eax
80105aa7:	75 bf                	jne    80105a68 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105aa9:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105aaa:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105aaf:	89 e5                	mov    %esp,%ebp
80105ab1:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ab4:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105ab9:	68 c0 7a 10 80       	push   $0x80107ac0
80105abe:	68 a0 4d 11 80       	push   $0x80114da0
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105ac3:	66 89 15 e2 4f 11 80 	mov    %dx,0x80114fe2
80105aca:	c6 05 e4 4f 11 80 00 	movb   $0x0,0x80114fe4
80105ad1:	66 a3 e0 4f 11 80    	mov    %ax,0x80114fe0
80105ad7:	c1 e8 10             	shr    $0x10,%eax
80105ada:	c6 05 e5 4f 11 80 ef 	movb   $0xef,0x80114fe5
80105ae1:	66 a3 e6 4f 11 80    	mov    %ax,0x80114fe6

  initlock(&tickslock, "time");
80105ae7:	e8 e4 e7 ff ff       	call   801042d0 <initlock>
}
80105aec:	83 c4 10             	add    $0x10,%esp
80105aef:	c9                   	leave  
80105af0:	c3                   	ret    
80105af1:	eb 0d                	jmp    80105b00 <idtinit>
80105af3:	90                   	nop
80105af4:	90                   	nop
80105af5:	90                   	nop
80105af6:	90                   	nop
80105af7:	90                   	nop
80105af8:	90                   	nop
80105af9:	90                   	nop
80105afa:	90                   	nop
80105afb:	90                   	nop
80105afc:	90                   	nop
80105afd:	90                   	nop
80105afe:	90                   	nop
80105aff:	90                   	nop

80105b00 <idtinit>:

void
idtinit(void)
{
80105b00:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105b01:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b06:	89 e5                	mov    %esp,%ebp
80105b08:	83 ec 10             	sub    $0x10,%esp
80105b0b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105b0f:	b8 e0 4d 11 80       	mov    $0x80114de0,%eax
80105b14:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105b18:	c1 e8 10             	shr    $0x10,%eax
80105b1b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105b1f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105b22:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105b25:	c9                   	leave  
80105b26:	c3                   	ret    
80105b27:	89 f6                	mov    %esi,%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b30 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105b30:	55                   	push   %ebp
80105b31:	89 e5                	mov    %esp,%ebp
80105b33:	57                   	push   %edi
80105b34:	56                   	push   %esi
80105b35:	53                   	push   %ebx
80105b36:	83 ec 0c             	sub    $0xc,%esp
80105b39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105b3c:	8b 43 30             	mov    0x30(%ebx),%eax
80105b3f:	83 f8 40             	cmp    $0x40,%eax
80105b42:	0f 84 f8 00 00 00    	je     80105c40 <trap+0x110>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105b48:	83 e8 20             	sub    $0x20,%eax
80105b4b:	83 f8 1f             	cmp    $0x1f,%eax
80105b4e:	77 68                	ja     80105bb8 <trap+0x88>
80105b50:	ff 24 85 68 7b 10 80 	jmp    *-0x7fef8498(,%eax,4)
80105b57:	89 f6                	mov    %esi,%esi
80105b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105b60:	e8 0b cc ff ff       	call   80102770 <cpunum>
80105b65:	85 c0                	test   %eax,%eax
80105b67:	0f 84 b3 01 00 00    	je     80105d20 <trap+0x1f0>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105b6d:	e8 9e cc ff ff       	call   80102810 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b72:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b78:	85 c0                	test   %eax,%eax
80105b7a:	74 2d                	je     80105ba9 <trap+0x79>
80105b7c:	8b 50 24             	mov    0x24(%eax),%edx
80105b7f:	85 d2                	test   %edx,%edx
80105b81:	0f 85 86 00 00 00    	jne    80105c0d <trap+0xdd>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105b87:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b8b:	0f 84 ef 00 00 00    	je     80105c80 <trap+0x150>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b91:	8b 40 24             	mov    0x24(%eax),%eax
80105b94:	85 c0                	test   %eax,%eax
80105b96:	74 11                	je     80105ba9 <trap+0x79>
80105b98:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105b9c:	83 e0 03             	and    $0x3,%eax
80105b9f:	66 83 f8 03          	cmp    $0x3,%ax
80105ba3:	0f 84 c1 00 00 00    	je     80105c6a <trap+0x13a>
    exit();
}
80105ba9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bac:	5b                   	pop    %ebx
80105bad:	5e                   	pop    %esi
80105bae:	5f                   	pop    %edi
80105baf:	5d                   	pop    %ebp
80105bb0:	c3                   	ret    
80105bb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80105bb8:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105bbf:	85 c9                	test   %ecx,%ecx
80105bc1:	0f 84 8d 01 00 00    	je     80105d54 <trap+0x224>
80105bc7:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105bcb:	0f 84 83 01 00 00    	je     80105d54 <trap+0x224>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105bd1:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bd4:	8b 73 38             	mov    0x38(%ebx),%esi
80105bd7:	e8 94 cb ff ff       	call   80102770 <cpunum>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bdc:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105be3:	57                   	push   %edi
80105be4:	56                   	push   %esi
80105be5:	50                   	push   %eax
80105be6:	ff 73 34             	pushl  0x34(%ebx)
80105be9:	ff 73 30             	pushl  0x30(%ebx)
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bec:	8d 42 6c             	lea    0x6c(%edx),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bef:	50                   	push   %eax
80105bf0:	ff 72 10             	pushl  0x10(%edx)
80105bf3:	68 24 7b 10 80       	push   $0x80107b24
80105bf8:	e8 63 aa ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80105bfd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c03:	83 c4 20             	add    $0x20,%esp
80105c06:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c0d:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105c11:	83 e2 03             	and    $0x3,%edx
80105c14:	66 83 fa 03          	cmp    $0x3,%dx
80105c18:	0f 85 69 ff ff ff    	jne    80105b87 <trap+0x57>
    exit();
80105c1e:	e8 bd e0 ff ff       	call   80103ce0 <exit>
80105c23:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c29:	85 c0                	test   %eax,%eax
80105c2b:	0f 85 56 ff ff ff    	jne    80105b87 <trap+0x57>
80105c31:	e9 73 ff ff ff       	jmp    80105ba9 <trap+0x79>
80105c36:	8d 76 00             	lea    0x0(%esi),%esi
80105c39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
80105c40:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c46:	8b 70 24             	mov    0x24(%eax),%esi
80105c49:	85 f6                	test   %esi,%esi
80105c4b:	0f 85 bf 00 00 00    	jne    80105d10 <trap+0x1e0>
      exit();
    proc->tf = tf;
80105c51:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105c54:	e8 f7 ec ff ff       	call   80104950 <syscall>
    if(proc->killed)
80105c59:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c5f:	8b 58 24             	mov    0x24(%eax),%ebx
80105c62:	85 db                	test   %ebx,%ebx
80105c64:	0f 84 3f ff ff ff    	je     80105ba9 <trap+0x79>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105c6a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c6d:	5b                   	pop    %ebx
80105c6e:	5e                   	pop    %esi
80105c6f:	5f                   	pop    %edi
80105c70:	5d                   	pop    %ebp
    if(proc->killed)
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
80105c71:	e9 6a e0 ff ff       	jmp    80103ce0 <exit>
80105c76:	8d 76 00             	lea    0x0(%esi),%esi
80105c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c80:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105c84:	0f 85 07 ff ff ff    	jne    80105b91 <trap+0x61>
    yield();
80105c8a:	e8 a1 e1 ff ff       	call   80103e30 <yield>
80105c8f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c95:	85 c0                	test   %eax,%eax
80105c97:	0f 85 f4 fe ff ff    	jne    80105b91 <trap+0x61>
80105c9d:	e9 07 ff ff ff       	jmp    80105ba9 <trap+0x79>
80105ca2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105ca8:	e8 a3 c9 ff ff       	call   80102650 <kbdintr>
    lapiceoi();
80105cad:	e8 5e cb ff ff       	call   80102810 <lapiceoi>
    break;
80105cb2:	e9 bb fe ff ff       	jmp    80105b72 <trap+0x42>
80105cb7:	89 f6                	mov    %esi,%esi
80105cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105cc0:	e8 2b 02 00 00       	call   80105ef0 <uartintr>
80105cc5:	e9 a3 fe ff ff       	jmp    80105b6d <trap+0x3d>
80105cca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105cd0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105cd4:	8b 7b 38             	mov    0x38(%ebx),%edi
80105cd7:	e8 94 ca ff ff       	call   80102770 <cpunum>
80105cdc:	57                   	push   %edi
80105cdd:	56                   	push   %esi
80105cde:	50                   	push   %eax
80105cdf:	68 cc 7a 10 80       	push   $0x80107acc
80105ce4:	e8 77 a9 ff ff       	call   80100660 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80105ce9:	e8 22 cb ff ff       	call   80102810 <lapiceoi>
    break;
80105cee:	83 c4 10             	add    $0x10,%esp
80105cf1:	e9 7c fe ff ff       	jmp    80105b72 <trap+0x42>
80105cf6:	8d 76 00             	lea    0x0(%esi),%esi
80105cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105d00:	e8 bb c3 ff ff       	call   801020c0 <ideintr>
    lapiceoi();
80105d05:	e8 06 cb ff ff       	call   80102810 <lapiceoi>
    break;
80105d0a:	e9 63 fe ff ff       	jmp    80105b72 <trap+0x42>
80105d0f:	90                   	nop
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
80105d10:	e8 cb df ff ff       	call   80103ce0 <exit>
80105d15:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105d1b:	e9 31 ff ff ff       	jmp    80105c51 <trap+0x121>
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
80105d20:	83 ec 0c             	sub    $0xc,%esp
80105d23:	68 a0 4d 11 80       	push   $0x80114da0
80105d28:	e8 c3 e5 ff ff       	call   801042f0 <acquire>
      ticks++;
      wakeup(&ticks);
80105d2d:	c7 04 24 e0 55 11 80 	movl   $0x801155e0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
      ticks++;
80105d34:	83 05 e0 55 11 80 01 	addl   $0x1,0x801155e0
      wakeup(&ticks);
80105d3b:	e8 d0 e2 ff ff       	call   80104010 <wakeup>
      release(&tickslock);
80105d40:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80105d47:	e8 84 e7 ff ff       	call   801044d0 <release>
80105d4c:	83 c4 10             	add    $0x10,%esp
80105d4f:	e9 19 fe ff ff       	jmp    80105b6d <trap+0x3d>
80105d54:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d57:	8b 73 38             	mov    0x38(%ebx),%esi
80105d5a:	e8 11 ca ff ff       	call   80102770 <cpunum>
80105d5f:	83 ec 0c             	sub    $0xc,%esp
80105d62:	57                   	push   %edi
80105d63:	56                   	push   %esi
80105d64:	50                   	push   %eax
80105d65:	ff 73 30             	pushl  0x30(%ebx)
80105d68:	68 f0 7a 10 80       	push   $0x80107af0
80105d6d:	e8 ee a8 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80105d72:	83 c4 14             	add    $0x14,%esp
80105d75:	68 c5 7a 10 80       	push   $0x80107ac5
80105d7a:	e8 f1 a5 ff ff       	call   80100370 <panic>
80105d7f:	90                   	nop

80105d80 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d80:	a1 c8 a5 10 80       	mov    0x8010a5c8,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105d85:	55                   	push   %ebp
80105d86:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105d88:	85 c0                	test   %eax,%eax
80105d8a:	74 1c                	je     80105da8 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d8c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d91:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d92:	a8 01                	test   $0x1,%al
80105d94:	74 12                	je     80105da8 <uartgetc+0x28>
80105d96:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d9b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d9c:	0f b6 c0             	movzbl %al,%eax
}
80105d9f:	5d                   	pop    %ebp
80105da0:	c3                   	ret    
80105da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105da8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105dad:	5d                   	pop    %ebp
80105dae:	c3                   	ret    
80105daf:	90                   	nop

80105db0 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105db0:	55                   	push   %ebp
80105db1:	89 e5                	mov    %esp,%ebp
80105db3:	57                   	push   %edi
80105db4:	56                   	push   %esi
80105db5:	53                   	push   %ebx
80105db6:	89 c7                	mov    %eax,%edi
80105db8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105dbd:	be fd 03 00 00       	mov    $0x3fd,%esi
80105dc2:	83 ec 0c             	sub    $0xc,%esp
80105dc5:	eb 1b                	jmp    80105de2 <uartputc.part.0+0x32>
80105dc7:	89 f6                	mov    %esi,%esi
80105dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105dd0:	83 ec 0c             	sub    $0xc,%esp
80105dd3:	6a 0a                	push   $0xa
80105dd5:	e8 56 ca ff ff       	call   80102830 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105dda:	83 c4 10             	add    $0x10,%esp
80105ddd:	83 eb 01             	sub    $0x1,%ebx
80105de0:	74 07                	je     80105de9 <uartputc.part.0+0x39>
80105de2:	89 f2                	mov    %esi,%edx
80105de4:	ec                   	in     (%dx),%al
80105de5:	a8 20                	test   $0x20,%al
80105de7:	74 e7                	je     80105dd0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105de9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dee:	89 f8                	mov    %edi,%eax
80105df0:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105df1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105df4:	5b                   	pop    %ebx
80105df5:	5e                   	pop    %esi
80105df6:	5f                   	pop    %edi
80105df7:	5d                   	pop    %ebp
80105df8:	c3                   	ret    
80105df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e00 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105e00:	55                   	push   %ebp
80105e01:	31 c9                	xor    %ecx,%ecx
80105e03:	89 c8                	mov    %ecx,%eax
80105e05:	89 e5                	mov    %esp,%ebp
80105e07:	57                   	push   %edi
80105e08:	56                   	push   %esi
80105e09:	53                   	push   %ebx
80105e0a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105e0f:	89 da                	mov    %ebx,%edx
80105e11:	83 ec 0c             	sub    $0xc,%esp
80105e14:	ee                   	out    %al,(%dx)
80105e15:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105e1a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105e1f:	89 fa                	mov    %edi,%edx
80105e21:	ee                   	out    %al,(%dx)
80105e22:	b8 0c 00 00 00       	mov    $0xc,%eax
80105e27:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e2c:	ee                   	out    %al,(%dx)
80105e2d:	be f9 03 00 00       	mov    $0x3f9,%esi
80105e32:	89 c8                	mov    %ecx,%eax
80105e34:	89 f2                	mov    %esi,%edx
80105e36:	ee                   	out    %al,(%dx)
80105e37:	b8 03 00 00 00       	mov    $0x3,%eax
80105e3c:	89 fa                	mov    %edi,%edx
80105e3e:	ee                   	out    %al,(%dx)
80105e3f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105e44:	89 c8                	mov    %ecx,%eax
80105e46:	ee                   	out    %al,(%dx)
80105e47:	b8 01 00 00 00       	mov    $0x1,%eax
80105e4c:	89 f2                	mov    %esi,%edx
80105e4e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e4f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e54:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105e55:	3c ff                	cmp    $0xff,%al
80105e57:	74 5a                	je     80105eb3 <uartinit+0xb3>
    return;
  uart = 1;
80105e59:	c7 05 c8 a5 10 80 01 	movl   $0x1,0x8010a5c8
80105e60:	00 00 00 
80105e63:	89 da                	mov    %ebx,%edx
80105e65:	ec                   	in     (%dx),%al
80105e66:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e6b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
80105e6c:	83 ec 0c             	sub    $0xc,%esp
80105e6f:	6a 04                	push   $0x4
80105e71:	e8 aa d4 ff ff       	call   80103320 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105e76:	59                   	pop    %ecx
80105e77:	5b                   	pop    %ebx
80105e78:	6a 00                	push   $0x0
80105e7a:	6a 04                	push   $0x4
80105e7c:	bb e8 7b 10 80       	mov    $0x80107be8,%ebx
80105e81:	e8 9a c4 ff ff       	call   80102320 <ioapicenable>
80105e86:	83 c4 10             	add    $0x10,%esp
80105e89:	b8 78 00 00 00       	mov    $0x78,%eax
80105e8e:	eb 0a                	jmp    80105e9a <uartinit+0x9a>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105e90:	83 c3 01             	add    $0x1,%ebx
80105e93:	0f be 03             	movsbl (%ebx),%eax
80105e96:	84 c0                	test   %al,%al
80105e98:	74 19                	je     80105eb3 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105e9a:	8b 15 c8 a5 10 80    	mov    0x8010a5c8,%edx
80105ea0:	85 d2                	test   %edx,%edx
80105ea2:	74 ec                	je     80105e90 <uartinit+0x90>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105ea4:	83 c3 01             	add    $0x1,%ebx
80105ea7:	e8 04 ff ff ff       	call   80105db0 <uartputc.part.0>
80105eac:	0f be 03             	movsbl (%ebx),%eax
80105eaf:	84 c0                	test   %al,%al
80105eb1:	75 e7                	jne    80105e9a <uartinit+0x9a>
    uartputc(*p);
}
80105eb3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105eb6:	5b                   	pop    %ebx
80105eb7:	5e                   	pop    %esi
80105eb8:	5f                   	pop    %edi
80105eb9:	5d                   	pop    %ebp
80105eba:	c3                   	ret    
80105ebb:	90                   	nop
80105ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ec0 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105ec0:	8b 15 c8 a5 10 80    	mov    0x8010a5c8,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105ec6:	55                   	push   %ebp
80105ec7:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105ec9:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105ece:	74 10                	je     80105ee0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105ed0:	5d                   	pop    %ebp
80105ed1:	e9 da fe ff ff       	jmp    80105db0 <uartputc.part.0>
80105ed6:	8d 76 00             	lea    0x0(%esi),%esi
80105ed9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105ee0:	5d                   	pop    %ebp
80105ee1:	c3                   	ret    
80105ee2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ef0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105ef6:	68 80 5d 10 80       	push   $0x80105d80
80105efb:	e8 f0 a8 ff ff       	call   801007f0 <consoleintr>
}
80105f00:	83 c4 10             	add    $0x10,%esp
80105f03:	c9                   	leave  
80105f04:	c3                   	ret    

80105f05 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $0
80105f07:	6a 00                	push   $0x0
  jmp alltraps
80105f09:	e9 20 fb ff ff       	jmp    80105a2e <alltraps>

80105f0e <vector1>:
.globl vector1
vector1:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $1
80105f10:	6a 01                	push   $0x1
  jmp alltraps
80105f12:	e9 17 fb ff ff       	jmp    80105a2e <alltraps>

80105f17 <vector2>:
.globl vector2
vector2:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $2
80105f19:	6a 02                	push   $0x2
  jmp alltraps
80105f1b:	e9 0e fb ff ff       	jmp    80105a2e <alltraps>

80105f20 <vector3>:
.globl vector3
vector3:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $3
80105f22:	6a 03                	push   $0x3
  jmp alltraps
80105f24:	e9 05 fb ff ff       	jmp    80105a2e <alltraps>

80105f29 <vector4>:
.globl vector4
vector4:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $4
80105f2b:	6a 04                	push   $0x4
  jmp alltraps
80105f2d:	e9 fc fa ff ff       	jmp    80105a2e <alltraps>

80105f32 <vector5>:
.globl vector5
vector5:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $5
80105f34:	6a 05                	push   $0x5
  jmp alltraps
80105f36:	e9 f3 fa ff ff       	jmp    80105a2e <alltraps>

80105f3b <vector6>:
.globl vector6
vector6:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $6
80105f3d:	6a 06                	push   $0x6
  jmp alltraps
80105f3f:	e9 ea fa ff ff       	jmp    80105a2e <alltraps>

80105f44 <vector7>:
.globl vector7
vector7:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $7
80105f46:	6a 07                	push   $0x7
  jmp alltraps
80105f48:	e9 e1 fa ff ff       	jmp    80105a2e <alltraps>

80105f4d <vector8>:
.globl vector8
vector8:
  pushl $8
80105f4d:	6a 08                	push   $0x8
  jmp alltraps
80105f4f:	e9 da fa ff ff       	jmp    80105a2e <alltraps>

80105f54 <vector9>:
.globl vector9
vector9:
  pushl $0
80105f54:	6a 00                	push   $0x0
  pushl $9
80105f56:	6a 09                	push   $0x9
  jmp alltraps
80105f58:	e9 d1 fa ff ff       	jmp    80105a2e <alltraps>

80105f5d <vector10>:
.globl vector10
vector10:
  pushl $10
80105f5d:	6a 0a                	push   $0xa
  jmp alltraps
80105f5f:	e9 ca fa ff ff       	jmp    80105a2e <alltraps>

80105f64 <vector11>:
.globl vector11
vector11:
  pushl $11
80105f64:	6a 0b                	push   $0xb
  jmp alltraps
80105f66:	e9 c3 fa ff ff       	jmp    80105a2e <alltraps>

80105f6b <vector12>:
.globl vector12
vector12:
  pushl $12
80105f6b:	6a 0c                	push   $0xc
  jmp alltraps
80105f6d:	e9 bc fa ff ff       	jmp    80105a2e <alltraps>

80105f72 <vector13>:
.globl vector13
vector13:
  pushl $13
80105f72:	6a 0d                	push   $0xd
  jmp alltraps
80105f74:	e9 b5 fa ff ff       	jmp    80105a2e <alltraps>

80105f79 <vector14>:
.globl vector14
vector14:
  pushl $14
80105f79:	6a 0e                	push   $0xe
  jmp alltraps
80105f7b:	e9 ae fa ff ff       	jmp    80105a2e <alltraps>

80105f80 <vector15>:
.globl vector15
vector15:
  pushl $0
80105f80:	6a 00                	push   $0x0
  pushl $15
80105f82:	6a 0f                	push   $0xf
  jmp alltraps
80105f84:	e9 a5 fa ff ff       	jmp    80105a2e <alltraps>

80105f89 <vector16>:
.globl vector16
vector16:
  pushl $0
80105f89:	6a 00                	push   $0x0
  pushl $16
80105f8b:	6a 10                	push   $0x10
  jmp alltraps
80105f8d:	e9 9c fa ff ff       	jmp    80105a2e <alltraps>

80105f92 <vector17>:
.globl vector17
vector17:
  pushl $17
80105f92:	6a 11                	push   $0x11
  jmp alltraps
80105f94:	e9 95 fa ff ff       	jmp    80105a2e <alltraps>

80105f99 <vector18>:
.globl vector18
vector18:
  pushl $0
80105f99:	6a 00                	push   $0x0
  pushl $18
80105f9b:	6a 12                	push   $0x12
  jmp alltraps
80105f9d:	e9 8c fa ff ff       	jmp    80105a2e <alltraps>

80105fa2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $19
80105fa4:	6a 13                	push   $0x13
  jmp alltraps
80105fa6:	e9 83 fa ff ff       	jmp    80105a2e <alltraps>

80105fab <vector20>:
.globl vector20
vector20:
  pushl $0
80105fab:	6a 00                	push   $0x0
  pushl $20
80105fad:	6a 14                	push   $0x14
  jmp alltraps
80105faf:	e9 7a fa ff ff       	jmp    80105a2e <alltraps>

80105fb4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105fb4:	6a 00                	push   $0x0
  pushl $21
80105fb6:	6a 15                	push   $0x15
  jmp alltraps
80105fb8:	e9 71 fa ff ff       	jmp    80105a2e <alltraps>

80105fbd <vector22>:
.globl vector22
vector22:
  pushl $0
80105fbd:	6a 00                	push   $0x0
  pushl $22
80105fbf:	6a 16                	push   $0x16
  jmp alltraps
80105fc1:	e9 68 fa ff ff       	jmp    80105a2e <alltraps>

80105fc6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $23
80105fc8:	6a 17                	push   $0x17
  jmp alltraps
80105fca:	e9 5f fa ff ff       	jmp    80105a2e <alltraps>

80105fcf <vector24>:
.globl vector24
vector24:
  pushl $0
80105fcf:	6a 00                	push   $0x0
  pushl $24
80105fd1:	6a 18                	push   $0x18
  jmp alltraps
80105fd3:	e9 56 fa ff ff       	jmp    80105a2e <alltraps>

80105fd8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105fd8:	6a 00                	push   $0x0
  pushl $25
80105fda:	6a 19                	push   $0x19
  jmp alltraps
80105fdc:	e9 4d fa ff ff       	jmp    80105a2e <alltraps>

80105fe1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105fe1:	6a 00                	push   $0x0
  pushl $26
80105fe3:	6a 1a                	push   $0x1a
  jmp alltraps
80105fe5:	e9 44 fa ff ff       	jmp    80105a2e <alltraps>

80105fea <vector27>:
.globl vector27
vector27:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $27
80105fec:	6a 1b                	push   $0x1b
  jmp alltraps
80105fee:	e9 3b fa ff ff       	jmp    80105a2e <alltraps>

80105ff3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105ff3:	6a 00                	push   $0x0
  pushl $28
80105ff5:	6a 1c                	push   $0x1c
  jmp alltraps
80105ff7:	e9 32 fa ff ff       	jmp    80105a2e <alltraps>

80105ffc <vector29>:
.globl vector29
vector29:
  pushl $0
80105ffc:	6a 00                	push   $0x0
  pushl $29
80105ffe:	6a 1d                	push   $0x1d
  jmp alltraps
80106000:	e9 29 fa ff ff       	jmp    80105a2e <alltraps>

80106005 <vector30>:
.globl vector30
vector30:
  pushl $0
80106005:	6a 00                	push   $0x0
  pushl $30
80106007:	6a 1e                	push   $0x1e
  jmp alltraps
80106009:	e9 20 fa ff ff       	jmp    80105a2e <alltraps>

8010600e <vector31>:
.globl vector31
vector31:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $31
80106010:	6a 1f                	push   $0x1f
  jmp alltraps
80106012:	e9 17 fa ff ff       	jmp    80105a2e <alltraps>

80106017 <vector32>:
.globl vector32
vector32:
  pushl $0
80106017:	6a 00                	push   $0x0
  pushl $32
80106019:	6a 20                	push   $0x20
  jmp alltraps
8010601b:	e9 0e fa ff ff       	jmp    80105a2e <alltraps>

80106020 <vector33>:
.globl vector33
vector33:
  pushl $0
80106020:	6a 00                	push   $0x0
  pushl $33
80106022:	6a 21                	push   $0x21
  jmp alltraps
80106024:	e9 05 fa ff ff       	jmp    80105a2e <alltraps>

80106029 <vector34>:
.globl vector34
vector34:
  pushl $0
80106029:	6a 00                	push   $0x0
  pushl $34
8010602b:	6a 22                	push   $0x22
  jmp alltraps
8010602d:	e9 fc f9 ff ff       	jmp    80105a2e <alltraps>

80106032 <vector35>:
.globl vector35
vector35:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $35
80106034:	6a 23                	push   $0x23
  jmp alltraps
80106036:	e9 f3 f9 ff ff       	jmp    80105a2e <alltraps>

8010603b <vector36>:
.globl vector36
vector36:
  pushl $0
8010603b:	6a 00                	push   $0x0
  pushl $36
8010603d:	6a 24                	push   $0x24
  jmp alltraps
8010603f:	e9 ea f9 ff ff       	jmp    80105a2e <alltraps>

80106044 <vector37>:
.globl vector37
vector37:
  pushl $0
80106044:	6a 00                	push   $0x0
  pushl $37
80106046:	6a 25                	push   $0x25
  jmp alltraps
80106048:	e9 e1 f9 ff ff       	jmp    80105a2e <alltraps>

8010604d <vector38>:
.globl vector38
vector38:
  pushl $0
8010604d:	6a 00                	push   $0x0
  pushl $38
8010604f:	6a 26                	push   $0x26
  jmp alltraps
80106051:	e9 d8 f9 ff ff       	jmp    80105a2e <alltraps>

80106056 <vector39>:
.globl vector39
vector39:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $39
80106058:	6a 27                	push   $0x27
  jmp alltraps
8010605a:	e9 cf f9 ff ff       	jmp    80105a2e <alltraps>

8010605f <vector40>:
.globl vector40
vector40:
  pushl $0
8010605f:	6a 00                	push   $0x0
  pushl $40
80106061:	6a 28                	push   $0x28
  jmp alltraps
80106063:	e9 c6 f9 ff ff       	jmp    80105a2e <alltraps>

80106068 <vector41>:
.globl vector41
vector41:
  pushl $0
80106068:	6a 00                	push   $0x0
  pushl $41
8010606a:	6a 29                	push   $0x29
  jmp alltraps
8010606c:	e9 bd f9 ff ff       	jmp    80105a2e <alltraps>

80106071 <vector42>:
.globl vector42
vector42:
  pushl $0
80106071:	6a 00                	push   $0x0
  pushl $42
80106073:	6a 2a                	push   $0x2a
  jmp alltraps
80106075:	e9 b4 f9 ff ff       	jmp    80105a2e <alltraps>

8010607a <vector43>:
.globl vector43
vector43:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $43
8010607c:	6a 2b                	push   $0x2b
  jmp alltraps
8010607e:	e9 ab f9 ff ff       	jmp    80105a2e <alltraps>

80106083 <vector44>:
.globl vector44
vector44:
  pushl $0
80106083:	6a 00                	push   $0x0
  pushl $44
80106085:	6a 2c                	push   $0x2c
  jmp alltraps
80106087:	e9 a2 f9 ff ff       	jmp    80105a2e <alltraps>

8010608c <vector45>:
.globl vector45
vector45:
  pushl $0
8010608c:	6a 00                	push   $0x0
  pushl $45
8010608e:	6a 2d                	push   $0x2d
  jmp alltraps
80106090:	e9 99 f9 ff ff       	jmp    80105a2e <alltraps>

80106095 <vector46>:
.globl vector46
vector46:
  pushl $0
80106095:	6a 00                	push   $0x0
  pushl $46
80106097:	6a 2e                	push   $0x2e
  jmp alltraps
80106099:	e9 90 f9 ff ff       	jmp    80105a2e <alltraps>

8010609e <vector47>:
.globl vector47
vector47:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $47
801060a0:	6a 2f                	push   $0x2f
  jmp alltraps
801060a2:	e9 87 f9 ff ff       	jmp    80105a2e <alltraps>

801060a7 <vector48>:
.globl vector48
vector48:
  pushl $0
801060a7:	6a 00                	push   $0x0
  pushl $48
801060a9:	6a 30                	push   $0x30
  jmp alltraps
801060ab:	e9 7e f9 ff ff       	jmp    80105a2e <alltraps>

801060b0 <vector49>:
.globl vector49
vector49:
  pushl $0
801060b0:	6a 00                	push   $0x0
  pushl $49
801060b2:	6a 31                	push   $0x31
  jmp alltraps
801060b4:	e9 75 f9 ff ff       	jmp    80105a2e <alltraps>

801060b9 <vector50>:
.globl vector50
vector50:
  pushl $0
801060b9:	6a 00                	push   $0x0
  pushl $50
801060bb:	6a 32                	push   $0x32
  jmp alltraps
801060bd:	e9 6c f9 ff ff       	jmp    80105a2e <alltraps>

801060c2 <vector51>:
.globl vector51
vector51:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $51
801060c4:	6a 33                	push   $0x33
  jmp alltraps
801060c6:	e9 63 f9 ff ff       	jmp    80105a2e <alltraps>

801060cb <vector52>:
.globl vector52
vector52:
  pushl $0
801060cb:	6a 00                	push   $0x0
  pushl $52
801060cd:	6a 34                	push   $0x34
  jmp alltraps
801060cf:	e9 5a f9 ff ff       	jmp    80105a2e <alltraps>

801060d4 <vector53>:
.globl vector53
vector53:
  pushl $0
801060d4:	6a 00                	push   $0x0
  pushl $53
801060d6:	6a 35                	push   $0x35
  jmp alltraps
801060d8:	e9 51 f9 ff ff       	jmp    80105a2e <alltraps>

801060dd <vector54>:
.globl vector54
vector54:
  pushl $0
801060dd:	6a 00                	push   $0x0
  pushl $54
801060df:	6a 36                	push   $0x36
  jmp alltraps
801060e1:	e9 48 f9 ff ff       	jmp    80105a2e <alltraps>

801060e6 <vector55>:
.globl vector55
vector55:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $55
801060e8:	6a 37                	push   $0x37
  jmp alltraps
801060ea:	e9 3f f9 ff ff       	jmp    80105a2e <alltraps>

801060ef <vector56>:
.globl vector56
vector56:
  pushl $0
801060ef:	6a 00                	push   $0x0
  pushl $56
801060f1:	6a 38                	push   $0x38
  jmp alltraps
801060f3:	e9 36 f9 ff ff       	jmp    80105a2e <alltraps>

801060f8 <vector57>:
.globl vector57
vector57:
  pushl $0
801060f8:	6a 00                	push   $0x0
  pushl $57
801060fa:	6a 39                	push   $0x39
  jmp alltraps
801060fc:	e9 2d f9 ff ff       	jmp    80105a2e <alltraps>

80106101 <vector58>:
.globl vector58
vector58:
  pushl $0
80106101:	6a 00                	push   $0x0
  pushl $58
80106103:	6a 3a                	push   $0x3a
  jmp alltraps
80106105:	e9 24 f9 ff ff       	jmp    80105a2e <alltraps>

8010610a <vector59>:
.globl vector59
vector59:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $59
8010610c:	6a 3b                	push   $0x3b
  jmp alltraps
8010610e:	e9 1b f9 ff ff       	jmp    80105a2e <alltraps>

80106113 <vector60>:
.globl vector60
vector60:
  pushl $0
80106113:	6a 00                	push   $0x0
  pushl $60
80106115:	6a 3c                	push   $0x3c
  jmp alltraps
80106117:	e9 12 f9 ff ff       	jmp    80105a2e <alltraps>

8010611c <vector61>:
.globl vector61
vector61:
  pushl $0
8010611c:	6a 00                	push   $0x0
  pushl $61
8010611e:	6a 3d                	push   $0x3d
  jmp alltraps
80106120:	e9 09 f9 ff ff       	jmp    80105a2e <alltraps>

80106125 <vector62>:
.globl vector62
vector62:
  pushl $0
80106125:	6a 00                	push   $0x0
  pushl $62
80106127:	6a 3e                	push   $0x3e
  jmp alltraps
80106129:	e9 00 f9 ff ff       	jmp    80105a2e <alltraps>

8010612e <vector63>:
.globl vector63
vector63:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $63
80106130:	6a 3f                	push   $0x3f
  jmp alltraps
80106132:	e9 f7 f8 ff ff       	jmp    80105a2e <alltraps>

80106137 <vector64>:
.globl vector64
vector64:
  pushl $0
80106137:	6a 00                	push   $0x0
  pushl $64
80106139:	6a 40                	push   $0x40
  jmp alltraps
8010613b:	e9 ee f8 ff ff       	jmp    80105a2e <alltraps>

80106140 <vector65>:
.globl vector65
vector65:
  pushl $0
80106140:	6a 00                	push   $0x0
  pushl $65
80106142:	6a 41                	push   $0x41
  jmp alltraps
80106144:	e9 e5 f8 ff ff       	jmp    80105a2e <alltraps>

80106149 <vector66>:
.globl vector66
vector66:
  pushl $0
80106149:	6a 00                	push   $0x0
  pushl $66
8010614b:	6a 42                	push   $0x42
  jmp alltraps
8010614d:	e9 dc f8 ff ff       	jmp    80105a2e <alltraps>

80106152 <vector67>:
.globl vector67
vector67:
  pushl $0
80106152:	6a 00                	push   $0x0
  pushl $67
80106154:	6a 43                	push   $0x43
  jmp alltraps
80106156:	e9 d3 f8 ff ff       	jmp    80105a2e <alltraps>

8010615b <vector68>:
.globl vector68
vector68:
  pushl $0
8010615b:	6a 00                	push   $0x0
  pushl $68
8010615d:	6a 44                	push   $0x44
  jmp alltraps
8010615f:	e9 ca f8 ff ff       	jmp    80105a2e <alltraps>

80106164 <vector69>:
.globl vector69
vector69:
  pushl $0
80106164:	6a 00                	push   $0x0
  pushl $69
80106166:	6a 45                	push   $0x45
  jmp alltraps
80106168:	e9 c1 f8 ff ff       	jmp    80105a2e <alltraps>

8010616d <vector70>:
.globl vector70
vector70:
  pushl $0
8010616d:	6a 00                	push   $0x0
  pushl $70
8010616f:	6a 46                	push   $0x46
  jmp alltraps
80106171:	e9 b8 f8 ff ff       	jmp    80105a2e <alltraps>

80106176 <vector71>:
.globl vector71
vector71:
  pushl $0
80106176:	6a 00                	push   $0x0
  pushl $71
80106178:	6a 47                	push   $0x47
  jmp alltraps
8010617a:	e9 af f8 ff ff       	jmp    80105a2e <alltraps>

8010617f <vector72>:
.globl vector72
vector72:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $72
80106181:	6a 48                	push   $0x48
  jmp alltraps
80106183:	e9 a6 f8 ff ff       	jmp    80105a2e <alltraps>

80106188 <vector73>:
.globl vector73
vector73:
  pushl $0
80106188:	6a 00                	push   $0x0
  pushl $73
8010618a:	6a 49                	push   $0x49
  jmp alltraps
8010618c:	e9 9d f8 ff ff       	jmp    80105a2e <alltraps>

80106191 <vector74>:
.globl vector74
vector74:
  pushl $0
80106191:	6a 00                	push   $0x0
  pushl $74
80106193:	6a 4a                	push   $0x4a
  jmp alltraps
80106195:	e9 94 f8 ff ff       	jmp    80105a2e <alltraps>

8010619a <vector75>:
.globl vector75
vector75:
  pushl $0
8010619a:	6a 00                	push   $0x0
  pushl $75
8010619c:	6a 4b                	push   $0x4b
  jmp alltraps
8010619e:	e9 8b f8 ff ff       	jmp    80105a2e <alltraps>

801061a3 <vector76>:
.globl vector76
vector76:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $76
801061a5:	6a 4c                	push   $0x4c
  jmp alltraps
801061a7:	e9 82 f8 ff ff       	jmp    80105a2e <alltraps>

801061ac <vector77>:
.globl vector77
vector77:
  pushl $0
801061ac:	6a 00                	push   $0x0
  pushl $77
801061ae:	6a 4d                	push   $0x4d
  jmp alltraps
801061b0:	e9 79 f8 ff ff       	jmp    80105a2e <alltraps>

801061b5 <vector78>:
.globl vector78
vector78:
  pushl $0
801061b5:	6a 00                	push   $0x0
  pushl $78
801061b7:	6a 4e                	push   $0x4e
  jmp alltraps
801061b9:	e9 70 f8 ff ff       	jmp    80105a2e <alltraps>

801061be <vector79>:
.globl vector79
vector79:
  pushl $0
801061be:	6a 00                	push   $0x0
  pushl $79
801061c0:	6a 4f                	push   $0x4f
  jmp alltraps
801061c2:	e9 67 f8 ff ff       	jmp    80105a2e <alltraps>

801061c7 <vector80>:
.globl vector80
vector80:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $80
801061c9:	6a 50                	push   $0x50
  jmp alltraps
801061cb:	e9 5e f8 ff ff       	jmp    80105a2e <alltraps>

801061d0 <vector81>:
.globl vector81
vector81:
  pushl $0
801061d0:	6a 00                	push   $0x0
  pushl $81
801061d2:	6a 51                	push   $0x51
  jmp alltraps
801061d4:	e9 55 f8 ff ff       	jmp    80105a2e <alltraps>

801061d9 <vector82>:
.globl vector82
vector82:
  pushl $0
801061d9:	6a 00                	push   $0x0
  pushl $82
801061db:	6a 52                	push   $0x52
  jmp alltraps
801061dd:	e9 4c f8 ff ff       	jmp    80105a2e <alltraps>

801061e2 <vector83>:
.globl vector83
vector83:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $83
801061e4:	6a 53                	push   $0x53
  jmp alltraps
801061e6:	e9 43 f8 ff ff       	jmp    80105a2e <alltraps>

801061eb <vector84>:
.globl vector84
vector84:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $84
801061ed:	6a 54                	push   $0x54
  jmp alltraps
801061ef:	e9 3a f8 ff ff       	jmp    80105a2e <alltraps>

801061f4 <vector85>:
.globl vector85
vector85:
  pushl $0
801061f4:	6a 00                	push   $0x0
  pushl $85
801061f6:	6a 55                	push   $0x55
  jmp alltraps
801061f8:	e9 31 f8 ff ff       	jmp    80105a2e <alltraps>

801061fd <vector86>:
.globl vector86
vector86:
  pushl $0
801061fd:	6a 00                	push   $0x0
  pushl $86
801061ff:	6a 56                	push   $0x56
  jmp alltraps
80106201:	e9 28 f8 ff ff       	jmp    80105a2e <alltraps>

80106206 <vector87>:
.globl vector87
vector87:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $87
80106208:	6a 57                	push   $0x57
  jmp alltraps
8010620a:	e9 1f f8 ff ff       	jmp    80105a2e <alltraps>

8010620f <vector88>:
.globl vector88
vector88:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $88
80106211:	6a 58                	push   $0x58
  jmp alltraps
80106213:	e9 16 f8 ff ff       	jmp    80105a2e <alltraps>

80106218 <vector89>:
.globl vector89
vector89:
  pushl $0
80106218:	6a 00                	push   $0x0
  pushl $89
8010621a:	6a 59                	push   $0x59
  jmp alltraps
8010621c:	e9 0d f8 ff ff       	jmp    80105a2e <alltraps>

80106221 <vector90>:
.globl vector90
vector90:
  pushl $0
80106221:	6a 00                	push   $0x0
  pushl $90
80106223:	6a 5a                	push   $0x5a
  jmp alltraps
80106225:	e9 04 f8 ff ff       	jmp    80105a2e <alltraps>

8010622a <vector91>:
.globl vector91
vector91:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $91
8010622c:	6a 5b                	push   $0x5b
  jmp alltraps
8010622e:	e9 fb f7 ff ff       	jmp    80105a2e <alltraps>

80106233 <vector92>:
.globl vector92
vector92:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $92
80106235:	6a 5c                	push   $0x5c
  jmp alltraps
80106237:	e9 f2 f7 ff ff       	jmp    80105a2e <alltraps>

8010623c <vector93>:
.globl vector93
vector93:
  pushl $0
8010623c:	6a 00                	push   $0x0
  pushl $93
8010623e:	6a 5d                	push   $0x5d
  jmp alltraps
80106240:	e9 e9 f7 ff ff       	jmp    80105a2e <alltraps>

80106245 <vector94>:
.globl vector94
vector94:
  pushl $0
80106245:	6a 00                	push   $0x0
  pushl $94
80106247:	6a 5e                	push   $0x5e
  jmp alltraps
80106249:	e9 e0 f7 ff ff       	jmp    80105a2e <alltraps>

8010624e <vector95>:
.globl vector95
vector95:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $95
80106250:	6a 5f                	push   $0x5f
  jmp alltraps
80106252:	e9 d7 f7 ff ff       	jmp    80105a2e <alltraps>

80106257 <vector96>:
.globl vector96
vector96:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $96
80106259:	6a 60                	push   $0x60
  jmp alltraps
8010625b:	e9 ce f7 ff ff       	jmp    80105a2e <alltraps>

80106260 <vector97>:
.globl vector97
vector97:
  pushl $0
80106260:	6a 00                	push   $0x0
  pushl $97
80106262:	6a 61                	push   $0x61
  jmp alltraps
80106264:	e9 c5 f7 ff ff       	jmp    80105a2e <alltraps>

80106269 <vector98>:
.globl vector98
vector98:
  pushl $0
80106269:	6a 00                	push   $0x0
  pushl $98
8010626b:	6a 62                	push   $0x62
  jmp alltraps
8010626d:	e9 bc f7 ff ff       	jmp    80105a2e <alltraps>

80106272 <vector99>:
.globl vector99
vector99:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $99
80106274:	6a 63                	push   $0x63
  jmp alltraps
80106276:	e9 b3 f7 ff ff       	jmp    80105a2e <alltraps>

8010627b <vector100>:
.globl vector100
vector100:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $100
8010627d:	6a 64                	push   $0x64
  jmp alltraps
8010627f:	e9 aa f7 ff ff       	jmp    80105a2e <alltraps>

80106284 <vector101>:
.globl vector101
vector101:
  pushl $0
80106284:	6a 00                	push   $0x0
  pushl $101
80106286:	6a 65                	push   $0x65
  jmp alltraps
80106288:	e9 a1 f7 ff ff       	jmp    80105a2e <alltraps>

8010628d <vector102>:
.globl vector102
vector102:
  pushl $0
8010628d:	6a 00                	push   $0x0
  pushl $102
8010628f:	6a 66                	push   $0x66
  jmp alltraps
80106291:	e9 98 f7 ff ff       	jmp    80105a2e <alltraps>

80106296 <vector103>:
.globl vector103
vector103:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $103
80106298:	6a 67                	push   $0x67
  jmp alltraps
8010629a:	e9 8f f7 ff ff       	jmp    80105a2e <alltraps>

8010629f <vector104>:
.globl vector104
vector104:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $104
801062a1:	6a 68                	push   $0x68
  jmp alltraps
801062a3:	e9 86 f7 ff ff       	jmp    80105a2e <alltraps>

801062a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801062a8:	6a 00                	push   $0x0
  pushl $105
801062aa:	6a 69                	push   $0x69
  jmp alltraps
801062ac:	e9 7d f7 ff ff       	jmp    80105a2e <alltraps>

801062b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801062b1:	6a 00                	push   $0x0
  pushl $106
801062b3:	6a 6a                	push   $0x6a
  jmp alltraps
801062b5:	e9 74 f7 ff ff       	jmp    80105a2e <alltraps>

801062ba <vector107>:
.globl vector107
vector107:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $107
801062bc:	6a 6b                	push   $0x6b
  jmp alltraps
801062be:	e9 6b f7 ff ff       	jmp    80105a2e <alltraps>

801062c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $108
801062c5:	6a 6c                	push   $0x6c
  jmp alltraps
801062c7:	e9 62 f7 ff ff       	jmp    80105a2e <alltraps>

801062cc <vector109>:
.globl vector109
vector109:
  pushl $0
801062cc:	6a 00                	push   $0x0
  pushl $109
801062ce:	6a 6d                	push   $0x6d
  jmp alltraps
801062d0:	e9 59 f7 ff ff       	jmp    80105a2e <alltraps>

801062d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801062d5:	6a 00                	push   $0x0
  pushl $110
801062d7:	6a 6e                	push   $0x6e
  jmp alltraps
801062d9:	e9 50 f7 ff ff       	jmp    80105a2e <alltraps>

801062de <vector111>:
.globl vector111
vector111:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $111
801062e0:	6a 6f                	push   $0x6f
  jmp alltraps
801062e2:	e9 47 f7 ff ff       	jmp    80105a2e <alltraps>

801062e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $112
801062e9:	6a 70                	push   $0x70
  jmp alltraps
801062eb:	e9 3e f7 ff ff       	jmp    80105a2e <alltraps>

801062f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801062f0:	6a 00                	push   $0x0
  pushl $113
801062f2:	6a 71                	push   $0x71
  jmp alltraps
801062f4:	e9 35 f7 ff ff       	jmp    80105a2e <alltraps>

801062f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801062f9:	6a 00                	push   $0x0
  pushl $114
801062fb:	6a 72                	push   $0x72
  jmp alltraps
801062fd:	e9 2c f7 ff ff       	jmp    80105a2e <alltraps>

80106302 <vector115>:
.globl vector115
vector115:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $115
80106304:	6a 73                	push   $0x73
  jmp alltraps
80106306:	e9 23 f7 ff ff       	jmp    80105a2e <alltraps>

8010630b <vector116>:
.globl vector116
vector116:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $116
8010630d:	6a 74                	push   $0x74
  jmp alltraps
8010630f:	e9 1a f7 ff ff       	jmp    80105a2e <alltraps>

80106314 <vector117>:
.globl vector117
vector117:
  pushl $0
80106314:	6a 00                	push   $0x0
  pushl $117
80106316:	6a 75                	push   $0x75
  jmp alltraps
80106318:	e9 11 f7 ff ff       	jmp    80105a2e <alltraps>

8010631d <vector118>:
.globl vector118
vector118:
  pushl $0
8010631d:	6a 00                	push   $0x0
  pushl $118
8010631f:	6a 76                	push   $0x76
  jmp alltraps
80106321:	e9 08 f7 ff ff       	jmp    80105a2e <alltraps>

80106326 <vector119>:
.globl vector119
vector119:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $119
80106328:	6a 77                	push   $0x77
  jmp alltraps
8010632a:	e9 ff f6 ff ff       	jmp    80105a2e <alltraps>

8010632f <vector120>:
.globl vector120
vector120:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $120
80106331:	6a 78                	push   $0x78
  jmp alltraps
80106333:	e9 f6 f6 ff ff       	jmp    80105a2e <alltraps>

80106338 <vector121>:
.globl vector121
vector121:
  pushl $0
80106338:	6a 00                	push   $0x0
  pushl $121
8010633a:	6a 79                	push   $0x79
  jmp alltraps
8010633c:	e9 ed f6 ff ff       	jmp    80105a2e <alltraps>

80106341 <vector122>:
.globl vector122
vector122:
  pushl $0
80106341:	6a 00                	push   $0x0
  pushl $122
80106343:	6a 7a                	push   $0x7a
  jmp alltraps
80106345:	e9 e4 f6 ff ff       	jmp    80105a2e <alltraps>

8010634a <vector123>:
.globl vector123
vector123:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $123
8010634c:	6a 7b                	push   $0x7b
  jmp alltraps
8010634e:	e9 db f6 ff ff       	jmp    80105a2e <alltraps>

80106353 <vector124>:
.globl vector124
vector124:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $124
80106355:	6a 7c                	push   $0x7c
  jmp alltraps
80106357:	e9 d2 f6 ff ff       	jmp    80105a2e <alltraps>

8010635c <vector125>:
.globl vector125
vector125:
  pushl $0
8010635c:	6a 00                	push   $0x0
  pushl $125
8010635e:	6a 7d                	push   $0x7d
  jmp alltraps
80106360:	e9 c9 f6 ff ff       	jmp    80105a2e <alltraps>

80106365 <vector126>:
.globl vector126
vector126:
  pushl $0
80106365:	6a 00                	push   $0x0
  pushl $126
80106367:	6a 7e                	push   $0x7e
  jmp alltraps
80106369:	e9 c0 f6 ff ff       	jmp    80105a2e <alltraps>

8010636e <vector127>:
.globl vector127
vector127:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $127
80106370:	6a 7f                	push   $0x7f
  jmp alltraps
80106372:	e9 b7 f6 ff ff       	jmp    80105a2e <alltraps>

80106377 <vector128>:
.globl vector128
vector128:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $128
80106379:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010637e:	e9 ab f6 ff ff       	jmp    80105a2e <alltraps>

80106383 <vector129>:
.globl vector129
vector129:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $129
80106385:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010638a:	e9 9f f6 ff ff       	jmp    80105a2e <alltraps>

8010638f <vector130>:
.globl vector130
vector130:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $130
80106391:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106396:	e9 93 f6 ff ff       	jmp    80105a2e <alltraps>

8010639b <vector131>:
.globl vector131
vector131:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $131
8010639d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801063a2:	e9 87 f6 ff ff       	jmp    80105a2e <alltraps>

801063a7 <vector132>:
.globl vector132
vector132:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $132
801063a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801063ae:	e9 7b f6 ff ff       	jmp    80105a2e <alltraps>

801063b3 <vector133>:
.globl vector133
vector133:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $133
801063b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801063ba:	e9 6f f6 ff ff       	jmp    80105a2e <alltraps>

801063bf <vector134>:
.globl vector134
vector134:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $134
801063c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801063c6:	e9 63 f6 ff ff       	jmp    80105a2e <alltraps>

801063cb <vector135>:
.globl vector135
vector135:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $135
801063cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801063d2:	e9 57 f6 ff ff       	jmp    80105a2e <alltraps>

801063d7 <vector136>:
.globl vector136
vector136:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $136
801063d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801063de:	e9 4b f6 ff ff       	jmp    80105a2e <alltraps>

801063e3 <vector137>:
.globl vector137
vector137:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $137
801063e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801063ea:	e9 3f f6 ff ff       	jmp    80105a2e <alltraps>

801063ef <vector138>:
.globl vector138
vector138:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $138
801063f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801063f6:	e9 33 f6 ff ff       	jmp    80105a2e <alltraps>

801063fb <vector139>:
.globl vector139
vector139:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $139
801063fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106402:	e9 27 f6 ff ff       	jmp    80105a2e <alltraps>

80106407 <vector140>:
.globl vector140
vector140:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $140
80106409:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010640e:	e9 1b f6 ff ff       	jmp    80105a2e <alltraps>

80106413 <vector141>:
.globl vector141
vector141:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $141
80106415:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010641a:	e9 0f f6 ff ff       	jmp    80105a2e <alltraps>

8010641f <vector142>:
.globl vector142
vector142:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $142
80106421:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106426:	e9 03 f6 ff ff       	jmp    80105a2e <alltraps>

8010642b <vector143>:
.globl vector143
vector143:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $143
8010642d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106432:	e9 f7 f5 ff ff       	jmp    80105a2e <alltraps>

80106437 <vector144>:
.globl vector144
vector144:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $144
80106439:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010643e:	e9 eb f5 ff ff       	jmp    80105a2e <alltraps>

80106443 <vector145>:
.globl vector145
vector145:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $145
80106445:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010644a:	e9 df f5 ff ff       	jmp    80105a2e <alltraps>

8010644f <vector146>:
.globl vector146
vector146:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $146
80106451:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106456:	e9 d3 f5 ff ff       	jmp    80105a2e <alltraps>

8010645b <vector147>:
.globl vector147
vector147:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $147
8010645d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106462:	e9 c7 f5 ff ff       	jmp    80105a2e <alltraps>

80106467 <vector148>:
.globl vector148
vector148:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $148
80106469:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010646e:	e9 bb f5 ff ff       	jmp    80105a2e <alltraps>

80106473 <vector149>:
.globl vector149
vector149:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $149
80106475:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010647a:	e9 af f5 ff ff       	jmp    80105a2e <alltraps>

8010647f <vector150>:
.globl vector150
vector150:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $150
80106481:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106486:	e9 a3 f5 ff ff       	jmp    80105a2e <alltraps>

8010648b <vector151>:
.globl vector151
vector151:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $151
8010648d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106492:	e9 97 f5 ff ff       	jmp    80105a2e <alltraps>

80106497 <vector152>:
.globl vector152
vector152:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $152
80106499:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010649e:	e9 8b f5 ff ff       	jmp    80105a2e <alltraps>

801064a3 <vector153>:
.globl vector153
vector153:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $153
801064a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801064aa:	e9 7f f5 ff ff       	jmp    80105a2e <alltraps>

801064af <vector154>:
.globl vector154
vector154:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $154
801064b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801064b6:	e9 73 f5 ff ff       	jmp    80105a2e <alltraps>

801064bb <vector155>:
.globl vector155
vector155:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $155
801064bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801064c2:	e9 67 f5 ff ff       	jmp    80105a2e <alltraps>

801064c7 <vector156>:
.globl vector156
vector156:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $156
801064c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801064ce:	e9 5b f5 ff ff       	jmp    80105a2e <alltraps>

801064d3 <vector157>:
.globl vector157
vector157:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $157
801064d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801064da:	e9 4f f5 ff ff       	jmp    80105a2e <alltraps>

801064df <vector158>:
.globl vector158
vector158:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $158
801064e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801064e6:	e9 43 f5 ff ff       	jmp    80105a2e <alltraps>

801064eb <vector159>:
.globl vector159
vector159:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $159
801064ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801064f2:	e9 37 f5 ff ff       	jmp    80105a2e <alltraps>

801064f7 <vector160>:
.globl vector160
vector160:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $160
801064f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801064fe:	e9 2b f5 ff ff       	jmp    80105a2e <alltraps>

80106503 <vector161>:
.globl vector161
vector161:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $161
80106505:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010650a:	e9 1f f5 ff ff       	jmp    80105a2e <alltraps>

8010650f <vector162>:
.globl vector162
vector162:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $162
80106511:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106516:	e9 13 f5 ff ff       	jmp    80105a2e <alltraps>

8010651b <vector163>:
.globl vector163
vector163:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $163
8010651d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106522:	e9 07 f5 ff ff       	jmp    80105a2e <alltraps>

80106527 <vector164>:
.globl vector164
vector164:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $164
80106529:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010652e:	e9 fb f4 ff ff       	jmp    80105a2e <alltraps>

80106533 <vector165>:
.globl vector165
vector165:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $165
80106535:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010653a:	e9 ef f4 ff ff       	jmp    80105a2e <alltraps>

8010653f <vector166>:
.globl vector166
vector166:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $166
80106541:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106546:	e9 e3 f4 ff ff       	jmp    80105a2e <alltraps>

8010654b <vector167>:
.globl vector167
vector167:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $167
8010654d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106552:	e9 d7 f4 ff ff       	jmp    80105a2e <alltraps>

80106557 <vector168>:
.globl vector168
vector168:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $168
80106559:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010655e:	e9 cb f4 ff ff       	jmp    80105a2e <alltraps>

80106563 <vector169>:
.globl vector169
vector169:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $169
80106565:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010656a:	e9 bf f4 ff ff       	jmp    80105a2e <alltraps>

8010656f <vector170>:
.globl vector170
vector170:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $170
80106571:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106576:	e9 b3 f4 ff ff       	jmp    80105a2e <alltraps>

8010657b <vector171>:
.globl vector171
vector171:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $171
8010657d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106582:	e9 a7 f4 ff ff       	jmp    80105a2e <alltraps>

80106587 <vector172>:
.globl vector172
vector172:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $172
80106589:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010658e:	e9 9b f4 ff ff       	jmp    80105a2e <alltraps>

80106593 <vector173>:
.globl vector173
vector173:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $173
80106595:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010659a:	e9 8f f4 ff ff       	jmp    80105a2e <alltraps>

8010659f <vector174>:
.globl vector174
vector174:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $174
801065a1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801065a6:	e9 83 f4 ff ff       	jmp    80105a2e <alltraps>

801065ab <vector175>:
.globl vector175
vector175:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $175
801065ad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801065b2:	e9 77 f4 ff ff       	jmp    80105a2e <alltraps>

801065b7 <vector176>:
.globl vector176
vector176:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $176
801065b9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801065be:	e9 6b f4 ff ff       	jmp    80105a2e <alltraps>

801065c3 <vector177>:
.globl vector177
vector177:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $177
801065c5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801065ca:	e9 5f f4 ff ff       	jmp    80105a2e <alltraps>

801065cf <vector178>:
.globl vector178
vector178:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $178
801065d1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801065d6:	e9 53 f4 ff ff       	jmp    80105a2e <alltraps>

801065db <vector179>:
.globl vector179
vector179:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $179
801065dd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801065e2:	e9 47 f4 ff ff       	jmp    80105a2e <alltraps>

801065e7 <vector180>:
.globl vector180
vector180:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $180
801065e9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801065ee:	e9 3b f4 ff ff       	jmp    80105a2e <alltraps>

801065f3 <vector181>:
.globl vector181
vector181:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $181
801065f5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801065fa:	e9 2f f4 ff ff       	jmp    80105a2e <alltraps>

801065ff <vector182>:
.globl vector182
vector182:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $182
80106601:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106606:	e9 23 f4 ff ff       	jmp    80105a2e <alltraps>

8010660b <vector183>:
.globl vector183
vector183:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $183
8010660d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106612:	e9 17 f4 ff ff       	jmp    80105a2e <alltraps>

80106617 <vector184>:
.globl vector184
vector184:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $184
80106619:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010661e:	e9 0b f4 ff ff       	jmp    80105a2e <alltraps>

80106623 <vector185>:
.globl vector185
vector185:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $185
80106625:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010662a:	e9 ff f3 ff ff       	jmp    80105a2e <alltraps>

8010662f <vector186>:
.globl vector186
vector186:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $186
80106631:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106636:	e9 f3 f3 ff ff       	jmp    80105a2e <alltraps>

8010663b <vector187>:
.globl vector187
vector187:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $187
8010663d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106642:	e9 e7 f3 ff ff       	jmp    80105a2e <alltraps>

80106647 <vector188>:
.globl vector188
vector188:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $188
80106649:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010664e:	e9 db f3 ff ff       	jmp    80105a2e <alltraps>

80106653 <vector189>:
.globl vector189
vector189:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $189
80106655:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010665a:	e9 cf f3 ff ff       	jmp    80105a2e <alltraps>

8010665f <vector190>:
.globl vector190
vector190:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $190
80106661:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106666:	e9 c3 f3 ff ff       	jmp    80105a2e <alltraps>

8010666b <vector191>:
.globl vector191
vector191:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $191
8010666d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106672:	e9 b7 f3 ff ff       	jmp    80105a2e <alltraps>

80106677 <vector192>:
.globl vector192
vector192:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $192
80106679:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010667e:	e9 ab f3 ff ff       	jmp    80105a2e <alltraps>

80106683 <vector193>:
.globl vector193
vector193:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $193
80106685:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010668a:	e9 9f f3 ff ff       	jmp    80105a2e <alltraps>

8010668f <vector194>:
.globl vector194
vector194:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $194
80106691:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106696:	e9 93 f3 ff ff       	jmp    80105a2e <alltraps>

8010669b <vector195>:
.globl vector195
vector195:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $195
8010669d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801066a2:	e9 87 f3 ff ff       	jmp    80105a2e <alltraps>

801066a7 <vector196>:
.globl vector196
vector196:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $196
801066a9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801066ae:	e9 7b f3 ff ff       	jmp    80105a2e <alltraps>

801066b3 <vector197>:
.globl vector197
vector197:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $197
801066b5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801066ba:	e9 6f f3 ff ff       	jmp    80105a2e <alltraps>

801066bf <vector198>:
.globl vector198
vector198:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $198
801066c1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801066c6:	e9 63 f3 ff ff       	jmp    80105a2e <alltraps>

801066cb <vector199>:
.globl vector199
vector199:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $199
801066cd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801066d2:	e9 57 f3 ff ff       	jmp    80105a2e <alltraps>

801066d7 <vector200>:
.globl vector200
vector200:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $200
801066d9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801066de:	e9 4b f3 ff ff       	jmp    80105a2e <alltraps>

801066e3 <vector201>:
.globl vector201
vector201:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $201
801066e5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801066ea:	e9 3f f3 ff ff       	jmp    80105a2e <alltraps>

801066ef <vector202>:
.globl vector202
vector202:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $202
801066f1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801066f6:	e9 33 f3 ff ff       	jmp    80105a2e <alltraps>

801066fb <vector203>:
.globl vector203
vector203:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $203
801066fd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106702:	e9 27 f3 ff ff       	jmp    80105a2e <alltraps>

80106707 <vector204>:
.globl vector204
vector204:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $204
80106709:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010670e:	e9 1b f3 ff ff       	jmp    80105a2e <alltraps>

80106713 <vector205>:
.globl vector205
vector205:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $205
80106715:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010671a:	e9 0f f3 ff ff       	jmp    80105a2e <alltraps>

8010671f <vector206>:
.globl vector206
vector206:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $206
80106721:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106726:	e9 03 f3 ff ff       	jmp    80105a2e <alltraps>

8010672b <vector207>:
.globl vector207
vector207:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $207
8010672d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106732:	e9 f7 f2 ff ff       	jmp    80105a2e <alltraps>

80106737 <vector208>:
.globl vector208
vector208:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $208
80106739:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010673e:	e9 eb f2 ff ff       	jmp    80105a2e <alltraps>

80106743 <vector209>:
.globl vector209
vector209:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $209
80106745:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010674a:	e9 df f2 ff ff       	jmp    80105a2e <alltraps>

8010674f <vector210>:
.globl vector210
vector210:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $210
80106751:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106756:	e9 d3 f2 ff ff       	jmp    80105a2e <alltraps>

8010675b <vector211>:
.globl vector211
vector211:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $211
8010675d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106762:	e9 c7 f2 ff ff       	jmp    80105a2e <alltraps>

80106767 <vector212>:
.globl vector212
vector212:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $212
80106769:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010676e:	e9 bb f2 ff ff       	jmp    80105a2e <alltraps>

80106773 <vector213>:
.globl vector213
vector213:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $213
80106775:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010677a:	e9 af f2 ff ff       	jmp    80105a2e <alltraps>

8010677f <vector214>:
.globl vector214
vector214:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $214
80106781:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106786:	e9 a3 f2 ff ff       	jmp    80105a2e <alltraps>

8010678b <vector215>:
.globl vector215
vector215:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $215
8010678d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106792:	e9 97 f2 ff ff       	jmp    80105a2e <alltraps>

80106797 <vector216>:
.globl vector216
vector216:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $216
80106799:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010679e:	e9 8b f2 ff ff       	jmp    80105a2e <alltraps>

801067a3 <vector217>:
.globl vector217
vector217:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $217
801067a5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801067aa:	e9 7f f2 ff ff       	jmp    80105a2e <alltraps>

801067af <vector218>:
.globl vector218
vector218:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $218
801067b1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801067b6:	e9 73 f2 ff ff       	jmp    80105a2e <alltraps>

801067bb <vector219>:
.globl vector219
vector219:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $219
801067bd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801067c2:	e9 67 f2 ff ff       	jmp    80105a2e <alltraps>

801067c7 <vector220>:
.globl vector220
vector220:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $220
801067c9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801067ce:	e9 5b f2 ff ff       	jmp    80105a2e <alltraps>

801067d3 <vector221>:
.globl vector221
vector221:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $221
801067d5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801067da:	e9 4f f2 ff ff       	jmp    80105a2e <alltraps>

801067df <vector222>:
.globl vector222
vector222:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $222
801067e1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801067e6:	e9 43 f2 ff ff       	jmp    80105a2e <alltraps>

801067eb <vector223>:
.globl vector223
vector223:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $223
801067ed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801067f2:	e9 37 f2 ff ff       	jmp    80105a2e <alltraps>

801067f7 <vector224>:
.globl vector224
vector224:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $224
801067f9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801067fe:	e9 2b f2 ff ff       	jmp    80105a2e <alltraps>

80106803 <vector225>:
.globl vector225
vector225:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $225
80106805:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010680a:	e9 1f f2 ff ff       	jmp    80105a2e <alltraps>

8010680f <vector226>:
.globl vector226
vector226:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $226
80106811:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106816:	e9 13 f2 ff ff       	jmp    80105a2e <alltraps>

8010681b <vector227>:
.globl vector227
vector227:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $227
8010681d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106822:	e9 07 f2 ff ff       	jmp    80105a2e <alltraps>

80106827 <vector228>:
.globl vector228
vector228:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $228
80106829:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010682e:	e9 fb f1 ff ff       	jmp    80105a2e <alltraps>

80106833 <vector229>:
.globl vector229
vector229:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $229
80106835:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010683a:	e9 ef f1 ff ff       	jmp    80105a2e <alltraps>

8010683f <vector230>:
.globl vector230
vector230:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $230
80106841:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106846:	e9 e3 f1 ff ff       	jmp    80105a2e <alltraps>

8010684b <vector231>:
.globl vector231
vector231:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $231
8010684d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106852:	e9 d7 f1 ff ff       	jmp    80105a2e <alltraps>

80106857 <vector232>:
.globl vector232
vector232:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $232
80106859:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010685e:	e9 cb f1 ff ff       	jmp    80105a2e <alltraps>

80106863 <vector233>:
.globl vector233
vector233:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $233
80106865:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010686a:	e9 bf f1 ff ff       	jmp    80105a2e <alltraps>

8010686f <vector234>:
.globl vector234
vector234:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $234
80106871:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106876:	e9 b3 f1 ff ff       	jmp    80105a2e <alltraps>

8010687b <vector235>:
.globl vector235
vector235:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $235
8010687d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106882:	e9 a7 f1 ff ff       	jmp    80105a2e <alltraps>

80106887 <vector236>:
.globl vector236
vector236:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $236
80106889:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010688e:	e9 9b f1 ff ff       	jmp    80105a2e <alltraps>

80106893 <vector237>:
.globl vector237
vector237:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $237
80106895:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010689a:	e9 8f f1 ff ff       	jmp    80105a2e <alltraps>

8010689f <vector238>:
.globl vector238
vector238:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $238
801068a1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801068a6:	e9 83 f1 ff ff       	jmp    80105a2e <alltraps>

801068ab <vector239>:
.globl vector239
vector239:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $239
801068ad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801068b2:	e9 77 f1 ff ff       	jmp    80105a2e <alltraps>

801068b7 <vector240>:
.globl vector240
vector240:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $240
801068b9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801068be:	e9 6b f1 ff ff       	jmp    80105a2e <alltraps>

801068c3 <vector241>:
.globl vector241
vector241:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $241
801068c5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801068ca:	e9 5f f1 ff ff       	jmp    80105a2e <alltraps>

801068cf <vector242>:
.globl vector242
vector242:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $242
801068d1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801068d6:	e9 53 f1 ff ff       	jmp    80105a2e <alltraps>

801068db <vector243>:
.globl vector243
vector243:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $243
801068dd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801068e2:	e9 47 f1 ff ff       	jmp    80105a2e <alltraps>

801068e7 <vector244>:
.globl vector244
vector244:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $244
801068e9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801068ee:	e9 3b f1 ff ff       	jmp    80105a2e <alltraps>

801068f3 <vector245>:
.globl vector245
vector245:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $245
801068f5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801068fa:	e9 2f f1 ff ff       	jmp    80105a2e <alltraps>

801068ff <vector246>:
.globl vector246
vector246:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $246
80106901:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106906:	e9 23 f1 ff ff       	jmp    80105a2e <alltraps>

8010690b <vector247>:
.globl vector247
vector247:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $247
8010690d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106912:	e9 17 f1 ff ff       	jmp    80105a2e <alltraps>

80106917 <vector248>:
.globl vector248
vector248:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $248
80106919:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010691e:	e9 0b f1 ff ff       	jmp    80105a2e <alltraps>

80106923 <vector249>:
.globl vector249
vector249:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $249
80106925:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010692a:	e9 ff f0 ff ff       	jmp    80105a2e <alltraps>

8010692f <vector250>:
.globl vector250
vector250:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $250
80106931:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106936:	e9 f3 f0 ff ff       	jmp    80105a2e <alltraps>

8010693b <vector251>:
.globl vector251
vector251:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $251
8010693d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106942:	e9 e7 f0 ff ff       	jmp    80105a2e <alltraps>

80106947 <vector252>:
.globl vector252
vector252:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $252
80106949:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010694e:	e9 db f0 ff ff       	jmp    80105a2e <alltraps>

80106953 <vector253>:
.globl vector253
vector253:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $253
80106955:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010695a:	e9 cf f0 ff ff       	jmp    80105a2e <alltraps>

8010695f <vector254>:
.globl vector254
vector254:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $254
80106961:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106966:	e9 c3 f0 ff ff       	jmp    80105a2e <alltraps>

8010696b <vector255>:
.globl vector255
vector255:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $255
8010696d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106972:	e9 b7 f0 ff ff       	jmp    80105a2e <alltraps>
80106977:	66 90                	xchg   %ax,%ax
80106979:	66 90                	xchg   %ax,%ax
8010697b:	66 90                	xchg   %ax,%ax
8010697d:	66 90                	xchg   %ax,%ax
8010697f:	90                   	nop

80106980 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
80106986:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106988:	c1 ea 16             	shr    $0x16,%edx
8010698b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010698e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106991:	8b 07                	mov    (%edi),%eax
80106993:	a8 01                	test   $0x1,%al
80106995:	74 29                	je     801069c0 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106997:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010699c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801069a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801069a5:	c1 eb 0a             	shr    $0xa,%ebx
801069a8:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
801069ae:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
801069b1:	5b                   	pop    %ebx
801069b2:	5e                   	pop    %esi
801069b3:	5f                   	pop    %edi
801069b4:	5d                   	pop    %ebp
801069b5:	c3                   	ret    
801069b6:	8d 76 00             	lea    0x0(%esi),%esi
801069b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801069c0:	85 c9                	test   %ecx,%ecx
801069c2:	74 2c                	je     801069f0 <walkpgdir+0x70>
801069c4:	e8 47 bb ff ff       	call   80102510 <kalloc>
801069c9:	85 c0                	test   %eax,%eax
801069cb:	89 c6                	mov    %eax,%esi
801069cd:	74 21                	je     801069f0 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
801069cf:	83 ec 04             	sub    $0x4,%esp
801069d2:	68 00 10 00 00       	push   $0x1000
801069d7:	6a 00                	push   $0x0
801069d9:	50                   	push   %eax
801069da:	e8 41 db ff ff       	call   80104520 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069df:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801069e5:	83 c4 10             	add    $0x10,%esp
801069e8:	83 c8 07             	or     $0x7,%eax
801069eb:	89 07                	mov    %eax,(%edi)
801069ed:	eb b3                	jmp    801069a2 <walkpgdir+0x22>
801069ef:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
801069f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801069f3:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801069f5:	5b                   	pop    %ebx
801069f6:	5e                   	pop    %esi
801069f7:	5f                   	pop    %edi
801069f8:	5d                   	pop    %ebp
801069f9:	c3                   	ret    
801069fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106a00 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a00:	55                   	push   %ebp
80106a01:	89 e5                	mov    %esp,%ebp
80106a03:	57                   	push   %edi
80106a04:	56                   	push   %esi
80106a05:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106a06:	89 d3                	mov    %edx,%ebx
80106a08:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106a0e:	83 ec 1c             	sub    $0x1c,%esp
80106a11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a14:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106a18:	8b 7d 08             	mov    0x8(%ebp),%edi
80106a1b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106a20:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a23:	8b 45 0c             	mov    0xc(%ebp),%eax
80106a26:	29 df                	sub    %ebx,%edi
80106a28:	83 c8 01             	or     $0x1,%eax
80106a2b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106a2e:	eb 15                	jmp    80106a45 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106a30:	f6 00 01             	testb  $0x1,(%eax)
80106a33:	75 45                	jne    80106a7a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a35:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106a38:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a3b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106a3d:	74 31                	je     80106a70 <mappages+0x70>
      break;
    a += PGSIZE;
80106a3f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a45:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a48:	b9 01 00 00 00       	mov    $0x1,%ecx
80106a4d:	89 da                	mov    %ebx,%edx
80106a4f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106a52:	e8 29 ff ff ff       	call   80106980 <walkpgdir>
80106a57:	85 c0                	test   %eax,%eax
80106a59:	75 d5                	jne    80106a30 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a5b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80106a5e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a63:	5b                   	pop    %ebx
80106a64:	5e                   	pop    %esi
80106a65:	5f                   	pop    %edi
80106a66:	5d                   	pop    %ebp
80106a67:	c3                   	ret    
80106a68:	90                   	nop
80106a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a70:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106a73:	31 c0                	xor    %eax,%eax
}
80106a75:	5b                   	pop    %ebx
80106a76:	5e                   	pop    %esi
80106a77:	5f                   	pop    %edi
80106a78:	5d                   	pop    %ebp
80106a79:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106a7a:	83 ec 0c             	sub    $0xc,%esp
80106a7d:	68 f0 7b 10 80       	push   $0x80107bf0
80106a82:	e8 e9 98 ff ff       	call   80100370 <panic>
80106a87:	89 f6                	mov    %esi,%esi
80106a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a90 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a90:	55                   	push   %ebp
80106a91:	89 e5                	mov    %esp,%ebp
80106a93:	57                   	push   %edi
80106a94:	56                   	push   %esi
80106a95:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a96:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a9c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a9e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106aa4:	83 ec 1c             	sub    $0x1c,%esp
80106aa7:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106aaa:	39 d3                	cmp    %edx,%ebx
80106aac:	73 66                	jae    80106b14 <deallocuvm.part.0+0x84>
80106aae:	89 d6                	mov    %edx,%esi
80106ab0:	eb 3d                	jmp    80106aef <deallocuvm.part.0+0x5f>
80106ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106ab8:	8b 10                	mov    (%eax),%edx
80106aba:	f6 c2 01             	test   $0x1,%dl
80106abd:	74 26                	je     80106ae5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106abf:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106ac5:	74 58                	je     80106b1f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106ac7:	83 ec 0c             	sub    $0xc,%esp
80106aca:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106ad0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106ad3:	52                   	push   %edx
80106ad4:	e8 87 b8 ff ff       	call   80102360 <kfree>
      *pte = 0;
80106ad9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106adc:	83 c4 10             	add    $0x10,%esp
80106adf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106ae5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106aeb:	39 f3                	cmp    %esi,%ebx
80106aed:	73 25                	jae    80106b14 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106aef:	31 c9                	xor    %ecx,%ecx
80106af1:	89 da                	mov    %ebx,%edx
80106af3:	89 f8                	mov    %edi,%eax
80106af5:	e8 86 fe ff ff       	call   80106980 <walkpgdir>
    if(!pte)
80106afa:	85 c0                	test   %eax,%eax
80106afc:	75 ba                	jne    80106ab8 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106afe:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106b04:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106b0a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b10:	39 f3                	cmp    %esi,%ebx
80106b12:	72 db                	jb     80106aef <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106b14:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106b17:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b1a:	5b                   	pop    %ebx
80106b1b:	5e                   	pop    %esi
80106b1c:	5f                   	pop    %edi
80106b1d:	5d                   	pop    %ebp
80106b1e:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106b1f:	83 ec 0c             	sub    $0xc,%esp
80106b22:	68 52 75 10 80       	push   $0x80107552
80106b27:	e8 44 98 ff ff       	call   80100370 <panic>
80106b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b30 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	53                   	push   %ebx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b34:	31 db                	xor    %ebx,%ebx

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106b36:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80106b39:	e8 32 bc ff ff       	call   80102770 <cpunum>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b3e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80106b44:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106b49:	8d 90 a0 27 11 80    	lea    -0x7feed860(%eax),%edx
80106b4f:	c6 80 1d 28 11 80 9a 	movb   $0x9a,-0x7feed7e3(%eax)
80106b56:	c6 80 1e 28 11 80 cf 	movb   $0xcf,-0x7feed7e2(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b5d:	c6 80 25 28 11 80 92 	movb   $0x92,-0x7feed7db(%eax)
80106b64:	c6 80 26 28 11 80 cf 	movb   $0xcf,-0x7feed7da(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b6b:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b6f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b74:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b78:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
80106b7f:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b81:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b86:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b8d:	66 89 8a 90 00 00 00 	mov    %cx,0x90(%edx)
80106b94:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b96:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b9b:	66 89 9a 92 00 00 00 	mov    %bx,0x92(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106ba2:	31 db                	xor    %ebx,%ebx
80106ba4:	66 89 8a 98 00 00 00 	mov    %cx,0x98(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106bab:	8d 88 54 28 11 80    	lea    -0x7feed7ac(%eax),%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106bb1:	66 89 9a 9a 00 00 00 	mov    %bx,0x9a(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106bb8:	31 db                	xor    %ebx,%ebx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106bba:	c6 80 35 28 11 80 fa 	movb   $0xfa,-0x7feed7cb(%eax)
80106bc1:	c6 80 36 28 11 80 cf 	movb   $0xcf,-0x7feed7ca(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106bc8:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106bcf:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106bd6:	89 cb                	mov    %ecx,%ebx
80106bd8:	c1 e9 18             	shr    $0x18,%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106bdb:	c6 80 3d 28 11 80 f2 	movb   $0xf2,-0x7feed7c3(%eax)
80106be2:	c6 80 3e 28 11 80 cf 	movb   $0xcf,-0x7feed7c2(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106be9:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
80106bef:	c6 80 2d 28 11 80 92 	movb   $0x92,-0x7feed7d3(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106bf6:	b9 37 00 00 00       	mov    $0x37,%ecx
80106bfb:	c6 80 2e 28 11 80 c0 	movb   $0xc0,-0x7feed7d2(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80106c02:	05 10 28 11 80       	add    $0x80112810,%eax
80106c07:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106c0b:	c1 eb 10             	shr    $0x10,%ebx
  pd[1] = (uint)p;
80106c0e:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106c12:	c1 e8 10             	shr    $0x10,%eax
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106c15:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
80106c19:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106c1d:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
80106c24:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c2b:	c6 82 94 00 00 00 00 	movb   $0x0,0x94(%edx)
80106c32:	c6 82 97 00 00 00 00 	movb   $0x0,0x97(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c39:	c6 82 9c 00 00 00 00 	movb   $0x0,0x9c(%edx)
80106c40:	c6 82 9f 00 00 00 00 	movb   $0x0,0x9f(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106c47:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106c4d:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106c51:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c54:	0f 01 10             	lgdtl  (%eax)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
80106c57:	b8 18 00 00 00       	mov    $0x18,%eax
80106c5c:	8e e8                	mov    %eax,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
80106c5e:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106c65:	00 00 00 00 

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80106c69:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
}
80106c70:	83 c4 14             	add    $0x14,%esp
80106c73:	5b                   	pop    %ebx
80106c74:	5d                   	pop    %ebp
80106c75:	c3                   	ret    
80106c76:	8d 76 00             	lea    0x0(%esi),%esi
80106c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c80 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106c80:	55                   	push   %ebp
80106c81:	89 e5                	mov    %esp,%ebp
80106c83:	56                   	push   %esi
80106c84:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106c85:	e8 86 b8 ff ff       	call   80102510 <kalloc>
80106c8a:	85 c0                	test   %eax,%eax
80106c8c:	74 52                	je     80106ce0 <setupkvm+0x60>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106c8e:	83 ec 04             	sub    $0x4,%esp
80106c91:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106c93:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106c98:	68 00 10 00 00       	push   $0x1000
80106c9d:	6a 00                	push   $0x0
80106c9f:	50                   	push   %eax
80106ca0:	e8 7b d8 ff ff       	call   80104520 <memset>
80106ca5:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106ca8:	8b 43 04             	mov    0x4(%ebx),%eax
80106cab:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106cae:	83 ec 08             	sub    $0x8,%esp
80106cb1:	8b 13                	mov    (%ebx),%edx
80106cb3:	ff 73 0c             	pushl  0xc(%ebx)
80106cb6:	50                   	push   %eax
80106cb7:	29 c1                	sub    %eax,%ecx
80106cb9:	89 f0                	mov    %esi,%eax
80106cbb:	e8 40 fd ff ff       	call   80106a00 <mappages>
80106cc0:	83 c4 10             	add    $0x10,%esp
80106cc3:	85 c0                	test   %eax,%eax
80106cc5:	78 19                	js     80106ce0 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106cc7:	83 c3 10             	add    $0x10,%ebx
80106cca:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106cd0:	75 d6                	jne    80106ca8 <setupkvm+0x28>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106cd2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106cd5:	89 f0                	mov    %esi,%eax
80106cd7:	5b                   	pop    %ebx
80106cd8:	5e                   	pop    %esi
80106cd9:	5d                   	pop    %ebp
80106cda:	c3                   	ret    
80106cdb:	90                   	nop
80106cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106ce0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106ce3:	31 c0                	xor    %eax,%eax
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106ce5:	5b                   	pop    %ebx
80106ce6:	5e                   	pop    %esi
80106ce7:	5d                   	pop    %ebp
80106ce8:	c3                   	ret    
80106ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106cf0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106cf0:	55                   	push   %ebp
80106cf1:	89 e5                	mov    %esp,%ebp
80106cf3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106cf6:	e8 85 ff ff ff       	call   80106c80 <setupkvm>
80106cfb:	a3 e4 55 11 80       	mov    %eax,0x801155e4
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d00:	05 00 00 00 80       	add    $0x80000000,%eax
80106d05:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106d08:	c9                   	leave  
80106d09:	c3                   	ret    
80106d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d10 <switchkvm>:
80106d10:	a1 e4 55 11 80       	mov    0x801155e4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106d15:	55                   	push   %ebp
80106d16:	89 e5                	mov    %esp,%ebp
80106d18:	05 00 00 00 80       	add    $0x80000000,%eax
80106d1d:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106d20:	5d                   	pop    %ebp
80106d21:	c3                   	ret    
80106d22:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d30 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106d30:	55                   	push   %ebp
80106d31:	89 e5                	mov    %esp,%ebp
80106d33:	53                   	push   %ebx
80106d34:	83 ec 04             	sub    $0x4,%esp
80106d37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106d3a:	85 db                	test   %ebx,%ebx
80106d3c:	0f 84 93 00 00 00    	je     80106dd5 <switchuvm+0xa5>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106d42:	8b 43 08             	mov    0x8(%ebx),%eax
80106d45:	85 c0                	test   %eax,%eax
80106d47:	0f 84 a2 00 00 00    	je     80106def <switchuvm+0xbf>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106d4d:	8b 43 04             	mov    0x4(%ebx),%eax
80106d50:	85 c0                	test   %eax,%eax
80106d52:	0f 84 8a 00 00 00    	je     80106de2 <switchuvm+0xb2>
    panic("switchuvm: no pgdir");

  pushcli();
80106d58:	e8 f3 d6 ff ff       	call   80104450 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106d5d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106d63:	b9 67 00 00 00       	mov    $0x67,%ecx
80106d68:	8d 50 08             	lea    0x8(%eax),%edx
80106d6b:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106d72:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80106d79:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106d80:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106d87:	89 d1                	mov    %edx,%ecx
80106d89:	c1 ea 18             	shr    $0x18,%edx
80106d8c:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80106d92:	c1 e9 10             	shr    $0x10,%ecx
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
80106d95:	ba 10 00 00 00       	mov    $0x10,%edx
80106d9a:	66 89 50 10          	mov    %dx,0x10(%eax)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106d9e:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106da4:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106da7:	8d 91 00 10 00 00    	lea    0x1000(%ecx),%edx
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
80106dad:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106db2:	66 89 48 6e          	mov    %cx,0x6e(%eax)

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106db6:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106db9:	b8 30 00 00 00       	mov    $0x30,%eax
80106dbe:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106dc1:	8b 43 04             	mov    0x4(%ebx),%eax
80106dc4:	05 00 00 00 80       	add    $0x80000000,%eax
80106dc9:	0f 22 d8             	mov    %eax,%cr3
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106dcc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106dcf:	c9                   	leave  
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106dd0:	e9 ab d6 ff ff       	jmp    80104480 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106dd5:	83 ec 0c             	sub    $0xc,%esp
80106dd8:	68 f6 7b 10 80       	push   $0x80107bf6
80106ddd:	e8 8e 95 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106de2:	83 ec 0c             	sub    $0xc,%esp
80106de5:	68 21 7c 10 80       	push   $0x80107c21
80106dea:	e8 81 95 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106def:	83 ec 0c             	sub    $0xc,%esp
80106df2:	68 0c 7c 10 80       	push   $0x80107c0c
80106df7:	e8 74 95 ff ff       	call   80100370 <panic>
80106dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e00 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	57                   	push   %edi
80106e04:	56                   	push   %esi
80106e05:	53                   	push   %ebx
80106e06:	83 ec 1c             	sub    $0x1c,%esp
80106e09:	8b 75 10             	mov    0x10(%ebp),%esi
80106e0c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e0f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106e12:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106e18:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106e1b:	77 49                	ja     80106e66 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106e1d:	e8 ee b6 ff ff       	call   80102510 <kalloc>
  memset(mem, 0, PGSIZE);
80106e22:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106e25:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106e27:	68 00 10 00 00       	push   $0x1000
80106e2c:	6a 00                	push   $0x0
80106e2e:	50                   	push   %eax
80106e2f:	e8 ec d6 ff ff       	call   80104520 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e34:	58                   	pop    %eax
80106e35:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e3b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e40:	5a                   	pop    %edx
80106e41:	6a 06                	push   $0x6
80106e43:	50                   	push   %eax
80106e44:	31 d2                	xor    %edx,%edx
80106e46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e49:	e8 b2 fb ff ff       	call   80106a00 <mappages>
  memmove(mem, init, sz);
80106e4e:	89 75 10             	mov    %esi,0x10(%ebp)
80106e51:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106e54:	83 c4 10             	add    $0x10,%esp
80106e57:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106e5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e5d:	5b                   	pop    %ebx
80106e5e:	5e                   	pop    %esi
80106e5f:	5f                   	pop    %edi
80106e60:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106e61:	e9 6a d7 ff ff       	jmp    801045d0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106e66:	83 ec 0c             	sub    $0xc,%esp
80106e69:	68 35 7c 10 80       	push   $0x80107c35
80106e6e:	e8 fd 94 ff ff       	call   80100370 <panic>
80106e73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e80 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106e80:	55                   	push   %ebp
80106e81:	89 e5                	mov    %esp,%ebp
80106e83:	57                   	push   %edi
80106e84:	56                   	push   %esi
80106e85:	53                   	push   %ebx
80106e86:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106e89:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106e90:	0f 85 91 00 00 00    	jne    80106f27 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106e96:	8b 75 18             	mov    0x18(%ebp),%esi
80106e99:	31 db                	xor    %ebx,%ebx
80106e9b:	85 f6                	test   %esi,%esi
80106e9d:	75 1a                	jne    80106eb9 <loaduvm+0x39>
80106e9f:	eb 6f                	jmp    80106f10 <loaduvm+0x90>
80106ea1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ea8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106eae:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106eb4:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106eb7:	76 57                	jbe    80106f10 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106eb9:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ebc:	8b 45 08             	mov    0x8(%ebp),%eax
80106ebf:	31 c9                	xor    %ecx,%ecx
80106ec1:	01 da                	add    %ebx,%edx
80106ec3:	e8 b8 fa ff ff       	call   80106980 <walkpgdir>
80106ec8:	85 c0                	test   %eax,%eax
80106eca:	74 4e                	je     80106f1a <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106ecc:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ece:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106ed1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106ed6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106edb:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106ee1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ee4:	01 d9                	add    %ebx,%ecx
80106ee6:	05 00 00 00 80       	add    $0x80000000,%eax
80106eeb:	57                   	push   %edi
80106eec:	51                   	push   %ecx
80106eed:	50                   	push   %eax
80106eee:	ff 75 10             	pushl  0x10(%ebp)
80106ef1:	e8 1a aa ff ff       	call   80101910 <readi>
80106ef6:	83 c4 10             	add    $0x10,%esp
80106ef9:	39 c7                	cmp    %eax,%edi
80106efb:	74 ab                	je     80106ea8 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106efd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106f00:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106f05:	5b                   	pop    %ebx
80106f06:	5e                   	pop    %esi
80106f07:	5f                   	pop    %edi
80106f08:	5d                   	pop    %ebp
80106f09:	c3                   	ret    
80106f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f10:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106f13:	31 c0                	xor    %eax,%eax
}
80106f15:	5b                   	pop    %ebx
80106f16:	5e                   	pop    %esi
80106f17:	5f                   	pop    %edi
80106f18:	5d                   	pop    %ebp
80106f19:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106f1a:	83 ec 0c             	sub    $0xc,%esp
80106f1d:	68 4f 7c 10 80       	push   $0x80107c4f
80106f22:	e8 49 94 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106f27:	83 ec 0c             	sub    $0xc,%esp
80106f2a:	68 f0 7c 10 80       	push   $0x80107cf0
80106f2f:	e8 3c 94 ff ff       	call   80100370 <panic>
80106f34:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f3a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f40 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106f40:	55                   	push   %ebp
80106f41:	89 e5                	mov    %esp,%ebp
80106f43:	57                   	push   %edi
80106f44:	56                   	push   %esi
80106f45:	53                   	push   %ebx
80106f46:	83 ec 0c             	sub    $0xc,%esp
80106f49:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106f4c:	85 ff                	test   %edi,%edi
80106f4e:	0f 88 8c 00 00 00    	js     80106fe0 <allocuvm+0xa0>
    return 0;
  if(newsz < oldsz)
80106f54:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106f57:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106f5a:	0f 82 82 00 00 00    	jb     80106fe2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106f60:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106f66:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106f6c:	39 df                	cmp    %ebx,%edi
80106f6e:	77 43                	ja     80106fb3 <allocuvm+0x73>
80106f70:	eb 7e                	jmp    80106ff0 <allocuvm+0xb0>
80106f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106f78:	83 ec 04             	sub    $0x4,%esp
80106f7b:	68 00 10 00 00       	push   $0x1000
80106f80:	6a 00                	push   $0x0
80106f82:	50                   	push   %eax
80106f83:	e8 98 d5 ff ff       	call   80104520 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106f88:	58                   	pop    %eax
80106f89:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f8f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f94:	5a                   	pop    %edx
80106f95:	6a 06                	push   $0x6
80106f97:	50                   	push   %eax
80106f98:	89 da                	mov    %ebx,%edx
80106f9a:	8b 45 08             	mov    0x8(%ebp),%eax
80106f9d:	e8 5e fa ff ff       	call   80106a00 <mappages>
80106fa2:	83 c4 10             	add    $0x10,%esp
80106fa5:	85 c0                	test   %eax,%eax
80106fa7:	78 67                	js     80107010 <allocuvm+0xd0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106fa9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106faf:	39 df                	cmp    %ebx,%edi
80106fb1:	76 3d                	jbe    80106ff0 <allocuvm+0xb0>
    mem = kalloc();
80106fb3:	e8 58 b5 ff ff       	call   80102510 <kalloc>
    if(mem == 0){
80106fb8:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106fba:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106fbc:	75 ba                	jne    80106f78 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106fbe:	83 ec 0c             	sub    $0xc,%esp
80106fc1:	68 6d 7c 10 80       	push   $0x80107c6d
80106fc6:	e8 95 96 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106fcb:	83 c4 10             	add    $0x10,%esp
80106fce:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106fd1:	76 0d                	jbe    80106fe0 <allocuvm+0xa0>
80106fd3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106fd6:	8b 45 08             	mov    0x8(%ebp),%eax
80106fd9:	89 fa                	mov    %edi,%edx
80106fdb:	e8 b0 fa ff ff       	call   80106a90 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106fe0:	31 c0                	xor    %eax,%eax
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
  return newsz;
}
80106fe2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fe5:	5b                   	pop    %ebx
80106fe6:	5e                   	pop    %esi
80106fe7:	5f                   	pop    %edi
80106fe8:	5d                   	pop    %ebp
80106fe9:	c3                   	ret    
80106fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      kfree(mem);
      return 0;
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
80106ff0:	83 ec 0c             	sub    $0xc,%esp
80106ff3:	57                   	push   %edi
80106ff4:	e8 d7 e7 ff ff       	call   801057d0 <updatem>
  return newsz;
80106ff9:	83 c4 10             	add    $0x10,%esp
}
80106ffc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
  return newsz;
80106fff:	89 f8                	mov    %edi,%eax
}
80107001:	5b                   	pop    %ebx
80107002:	5e                   	pop    %esi
80107003:	5f                   	pop    %edi
80107004:	5d                   	pop    %ebp
80107005:	c3                   	ret    
80107006:	8d 76 00             	lea    0x0(%esi),%esi
80107009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80107010:	83 ec 0c             	sub    $0xc,%esp
80107013:	68 85 7c 10 80       	push   $0x80107c85
80107018:	e8 43 96 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010701d:	83 c4 10             	add    $0x10,%esp
80107020:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80107023:	76 0d                	jbe    80107032 <allocuvm+0xf2>
80107025:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107028:	8b 45 08             	mov    0x8(%ebp),%eax
8010702b:	89 fa                	mov    %edi,%edx
8010702d:	e8 5e fa ff ff       	call   80106a90 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80107032:	83 ec 0c             	sub    $0xc,%esp
80107035:	56                   	push   %esi
80107036:	e8 25 b3 ff ff       	call   80102360 <kfree>
      return 0;
8010703b:	83 c4 10             	add    $0x10,%esp
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
  return newsz;
}
8010703e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80107041:	31 c0                	xor    %eax,%eax
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
  return newsz;
}
80107043:	5b                   	pop    %ebx
80107044:	5e                   	pop    %esi
80107045:	5f                   	pop    %edi
80107046:	5d                   	pop    %ebp
80107047:	c3                   	ret    
80107048:	90                   	nop
80107049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107050 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	8b 55 0c             	mov    0xc(%ebp),%edx
80107056:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107059:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010705c:	39 d1                	cmp    %edx,%ecx
8010705e:	73 10                	jae    80107070 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107060:	5d                   	pop    %ebp
80107061:	e9 2a fa ff ff       	jmp    80106a90 <deallocuvm.part.0>
80107066:	8d 76 00             	lea    0x0(%esi),%esi
80107069:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107070:	89 d0                	mov    %edx,%eax
80107072:	5d                   	pop    %ebp
80107073:	c3                   	ret    
80107074:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010707a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107080 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	57                   	push   %edi
80107084:	56                   	push   %esi
80107085:	53                   	push   %ebx
80107086:	83 ec 0c             	sub    $0xc,%esp
80107089:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010708c:	85 f6                	test   %esi,%esi
8010708e:	74 59                	je     801070e9 <freevm+0x69>
80107090:	31 c9                	xor    %ecx,%ecx
80107092:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107097:	89 f0                	mov    %esi,%eax
80107099:	e8 f2 f9 ff ff       	call   80106a90 <deallocuvm.part.0>
8010709e:	89 f3                	mov    %esi,%ebx
801070a0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
801070a6:	eb 0f                	jmp    801070b7 <freevm+0x37>
801070a8:	90                   	nop
801070a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070b0:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801070b3:	39 fb                	cmp    %edi,%ebx
801070b5:	74 23                	je     801070da <freevm+0x5a>
    if(pgdir[i] & PTE_P){
801070b7:	8b 03                	mov    (%ebx),%eax
801070b9:	a8 01                	test   $0x1,%al
801070bb:	74 f3                	je     801070b0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
801070bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801070c2:	83 ec 0c             	sub    $0xc,%esp
801070c5:	83 c3 04             	add    $0x4,%ebx
801070c8:	05 00 00 00 80       	add    $0x80000000,%eax
801070cd:	50                   	push   %eax
801070ce:	e8 8d b2 ff ff       	call   80102360 <kfree>
801070d3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801070d6:	39 fb                	cmp    %edi,%ebx
801070d8:	75 dd                	jne    801070b7 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801070da:	89 75 08             	mov    %esi,0x8(%ebp)
}
801070dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070e0:	5b                   	pop    %ebx
801070e1:	5e                   	pop    %esi
801070e2:	5f                   	pop    %edi
801070e3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801070e4:	e9 77 b2 ff ff       	jmp    80102360 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801070e9:	83 ec 0c             	sub    $0xc,%esp
801070ec:	68 a1 7c 10 80       	push   $0x80107ca1
801070f1:	e8 7a 92 ff ff       	call   80100370 <panic>
801070f6:	8d 76 00             	lea    0x0(%esi),%esi
801070f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107100 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107100:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107101:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107103:	89 e5                	mov    %esp,%ebp
80107105:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107108:	8b 55 0c             	mov    0xc(%ebp),%edx
8010710b:	8b 45 08             	mov    0x8(%ebp),%eax
8010710e:	e8 6d f8 ff ff       	call   80106980 <walkpgdir>
  if(pte == 0)
80107113:	85 c0                	test   %eax,%eax
80107115:	74 05                	je     8010711c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107117:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010711a:	c9                   	leave  
8010711b:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
8010711c:	83 ec 0c             	sub    $0xc,%esp
8010711f:	68 b2 7c 10 80       	push   $0x80107cb2
80107124:	e8 47 92 ff ff       	call   80100370 <panic>
80107129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107130 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107130:	55                   	push   %ebp
80107131:	89 e5                	mov    %esp,%ebp
80107133:	57                   	push   %edi
80107134:	56                   	push   %esi
80107135:	53                   	push   %ebx
80107136:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107139:	e8 42 fb ff ff       	call   80106c80 <setupkvm>
8010713e:	85 c0                	test   %eax,%eax
80107140:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107143:	0f 84 b2 00 00 00    	je     801071fb <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107149:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010714c:	85 c9                	test   %ecx,%ecx
8010714e:	0f 84 9c 00 00 00    	je     801071f0 <copyuvm+0xc0>
80107154:	31 f6                	xor    %esi,%esi
80107156:	eb 4a                	jmp    801071a2 <copyuvm+0x72>
80107158:	90                   	nop
80107159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107160:	83 ec 04             	sub    $0x4,%esp
80107163:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107169:	68 00 10 00 00       	push   $0x1000
8010716e:	57                   	push   %edi
8010716f:	50                   	push   %eax
80107170:	e8 5b d4 ff ff       	call   801045d0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107175:	58                   	pop    %eax
80107176:	5a                   	pop    %edx
80107177:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
8010717d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107180:	ff 75 e4             	pushl  -0x1c(%ebp)
80107183:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107188:	52                   	push   %edx
80107189:	89 f2                	mov    %esi,%edx
8010718b:	e8 70 f8 ff ff       	call   80106a00 <mappages>
80107190:	83 c4 10             	add    $0x10,%esp
80107193:	85 c0                	test   %eax,%eax
80107195:	78 3e                	js     801071d5 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107197:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010719d:	39 75 0c             	cmp    %esi,0xc(%ebp)
801071a0:	76 4e                	jbe    801071f0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801071a2:	8b 45 08             	mov    0x8(%ebp),%eax
801071a5:	31 c9                	xor    %ecx,%ecx
801071a7:	89 f2                	mov    %esi,%edx
801071a9:	e8 d2 f7 ff ff       	call   80106980 <walkpgdir>
801071ae:	85 c0                	test   %eax,%eax
801071b0:	74 5a                	je     8010720c <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
801071b2:	8b 18                	mov    (%eax),%ebx
801071b4:	f6 c3 01             	test   $0x1,%bl
801071b7:	74 46                	je     801071ff <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801071b9:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
801071bb:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
801071c1:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
801071c4:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
801071ca:	e8 41 b3 ff ff       	call   80102510 <kalloc>
801071cf:	85 c0                	test   %eax,%eax
801071d1:	89 c3                	mov    %eax,%ebx
801071d3:	75 8b                	jne    80107160 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801071d5:	83 ec 0c             	sub    $0xc,%esp
801071d8:	ff 75 e0             	pushl  -0x20(%ebp)
801071db:	e8 a0 fe ff ff       	call   80107080 <freevm>
  return 0;
801071e0:	83 c4 10             	add    $0x10,%esp
801071e3:	31 c0                	xor    %eax,%eax
}
801071e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071e8:	5b                   	pop    %ebx
801071e9:	5e                   	pop    %esi
801071ea:	5f                   	pop    %edi
801071eb:	5d                   	pop    %ebp
801071ec:	c3                   	ret    
801071ed:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
801071f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071f6:	5b                   	pop    %ebx
801071f7:	5e                   	pop    %esi
801071f8:	5f                   	pop    %edi
801071f9:	5d                   	pop    %ebp
801071fa:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
801071fb:	31 c0                	xor    %eax,%eax
801071fd:	eb e6                	jmp    801071e5 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801071ff:	83 ec 0c             	sub    $0xc,%esp
80107202:	68 d6 7c 10 80       	push   $0x80107cd6
80107207:	e8 64 91 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010720c:	83 ec 0c             	sub    $0xc,%esp
8010720f:	68 bc 7c 10 80       	push   $0x80107cbc
80107214:	e8 57 91 ff ff       	call   80100370 <panic>
80107219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107220 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107220:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107221:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107223:	89 e5                	mov    %esp,%ebp
80107225:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107228:	8b 55 0c             	mov    0xc(%ebp),%edx
8010722b:	8b 45 08             	mov    0x8(%ebp),%eax
8010722e:	e8 4d f7 ff ff       	call   80106980 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107233:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107235:	89 c2                	mov    %eax,%edx
80107237:	83 e2 05             	and    $0x5,%edx
8010723a:	83 fa 05             	cmp    $0x5,%edx
8010723d:	75 11                	jne    80107250 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010723f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107244:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107245:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010724a:	c3                   	ret    
8010724b:	90                   	nop
8010724c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107250:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107252:	c9                   	leave  
80107253:	c3                   	ret    
80107254:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010725a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107260 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107260:	55                   	push   %ebp
80107261:	89 e5                	mov    %esp,%ebp
80107263:	57                   	push   %edi
80107264:	56                   	push   %esi
80107265:	53                   	push   %ebx
80107266:	83 ec 1c             	sub    $0x1c,%esp
80107269:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010726c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010726f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107272:	85 db                	test   %ebx,%ebx
80107274:	75 40                	jne    801072b6 <copyout+0x56>
80107276:	eb 70                	jmp    801072e8 <copyout+0x88>
80107278:	90                   	nop
80107279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107280:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107283:	89 f1                	mov    %esi,%ecx
80107285:	29 d1                	sub    %edx,%ecx
80107287:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010728d:	39 d9                	cmp    %ebx,%ecx
8010728f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107292:	29 f2                	sub    %esi,%edx
80107294:	83 ec 04             	sub    $0x4,%esp
80107297:	01 d0                	add    %edx,%eax
80107299:	51                   	push   %ecx
8010729a:	57                   	push   %edi
8010729b:	50                   	push   %eax
8010729c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010729f:	e8 2c d3 ff ff       	call   801045d0 <memmove>
    len -= n;
    buf += n;
801072a4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072a7:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
801072aa:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
801072b0:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801072b2:	29 cb                	sub    %ecx,%ebx
801072b4:	74 32                	je     801072e8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801072b6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801072b8:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
801072bb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801072be:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801072c4:	56                   	push   %esi
801072c5:	ff 75 08             	pushl  0x8(%ebp)
801072c8:	e8 53 ff ff ff       	call   80107220 <uva2ka>
    if(pa0 == 0)
801072cd:	83 c4 10             	add    $0x10,%esp
801072d0:	85 c0                	test   %eax,%eax
801072d2:	75 ac                	jne    80107280 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801072d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801072d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801072dc:	5b                   	pop    %ebx
801072dd:	5e                   	pop    %esi
801072de:	5f                   	pop    %edi
801072df:	5d                   	pop    %ebp
801072e0:	c3                   	ret    
801072e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072e8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801072eb:	31 c0                	xor    %eax,%eax
}
801072ed:	5b                   	pop    %ebx
801072ee:	5e                   	pop    %esi
801072ef:	5f                   	pop    %edi
801072f0:	5d                   	pop    %ebp
801072f1:	c3                   	ret    
