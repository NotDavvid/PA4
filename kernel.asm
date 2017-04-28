
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
8010002d:	b8 40 2f 10 80       	mov    $0x80102f40,%eax
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
8010004c:	68 e0 72 10 80       	push   $0x801072e0
80100051:	68 e0 b5 10 80       	push   $0x8010b5e0
80100056:	e8 55 42 00 00       	call   801042b0 <initlock>

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
80100092:	68 e7 72 10 80       	push   $0x801072e7
80100097:	50                   	push   %eax
80100098:	e8 03 41 00 00       	call   801041a0 <initsleeplock>
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
801000e4:	e8 e7 41 00 00       	call   801042d0 <acquire>

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
80100162:	e8 49 43 00 00       	call   801044b0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 40 00 00       	call   801041e0 <acquiresleep>
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
8010017e:	e8 bd 1f 00 00       	call   80102140 <iderw>
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
80100193:	68 ee 72 10 80       	push   $0x801072ee
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
801001ae:	e8 cd 40 00 00       	call   80104280 <holdingsleep>
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
801001c4:	e9 77 1f 00 00       	jmp    80102140 <iderw>
// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 ff 72 10 80       	push   $0x801072ff
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
801001ef:	e8 8c 40 00 00       	call   80104280 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 3c 40 00 00       	call   80104240 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 e0 b5 10 80 	movl   $0x8010b5e0,(%esp)
8010020b:	e8 c0 40 00 00       	call   801042d0 <acquire>
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
8010025c:	e9 4f 42 00 00       	jmp    801044b0 <release>
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
  if(!holdingsleep(&b->lock))
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 06 73 10 80       	push   $0x80107306
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
8010028c:	e8 3f 40 00 00       	call   801042d0 <acquire>
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
801002bd:	e8 8e 3b 00 00       	call   80103e50 <sleep>

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
801002e7:	e8 c4 41 00 00       	call   801044b0 <release>
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
80100346:	e8 65 41 00 00       	call   801044b0 <release>
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
80100393:	68 0d 73 10 80       	push   $0x8010730d
80100398:	e8 c3 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
8010039d:	58                   	pop    %eax
8010039e:	ff 75 08             	pushl  0x8(%ebp)
801003a1:	e8 ba 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003a6:	c7 04 24 46 78 10 80 	movl   $0x80107846,(%esp)
801003ad:	e8 ae 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003b2:	5a                   	pop    %edx
801003b3:	8d 45 08             	lea    0x8(%ebp),%eax
801003b6:	59                   	pop    %ecx
801003b7:	53                   	push   %ebx
801003b8:	50                   	push   %eax
801003b9:	e8 e2 3f 00 00       	call   801043a0 <getcallerpcs>
801003be:	83 c4 10             	add    $0x10,%esp
801003c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
801003c8:	83 ec 08             	sub    $0x8,%esp
801003cb:	ff 33                	pushl  (%ebx)
801003cd:	83 c3 04             	add    $0x4,%ebx
801003d0:	68 29 73 10 80       	push   $0x80107329
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
8010041a:	e8 71 5a 00 00       	call   80105e90 <uartputc>
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
801004d3:	e8 b8 59 00 00       	call   80105e90 <uartputc>
801004d8:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004df:	e8 ac 59 00 00       	call   80105e90 <uartputc>
801004e4:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801004eb:	e8 a0 59 00 00       	call   80105e90 <uartputc>
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
80100514:	e8 97 40 00 00       	call   801045b0 <memmove>
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100519:	b8 80 07 00 00       	mov    $0x780,%eax
8010051e:	83 c4 0c             	add    $0xc,%esp
80100521:	29 d8                	sub    %ebx,%eax
80100523:	01 c0                	add    %eax,%eax
80100525:	50                   	push   %eax
80100526:	6a 00                	push   $0x0
80100528:	56                   	push   %esi
80100529:	e8 d2 3f 00 00       	call   80104500 <memset>
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
80100540:	68 2d 73 10 80       	push   $0x8010732d
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
801005b1:	0f b6 92 58 73 10 80 	movzbl -0x7fef8ca8(%edx),%edx
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
8010061b:	e8 b0 3c 00 00       	call   801042d0 <acquire>
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
80100647:	e8 64 3e 00 00       	call   801044b0 <release>
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
8010070d:	e8 9e 3d 00 00       	call   801044b0 <release>
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
80100788:	b8 40 73 10 80       	mov    $0x80107340,%eax
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
801007c8:	e8 03 3b 00 00       	call   801042d0 <acquire>
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	e9 a4 fe ff ff       	jmp    80100679 <cprintf+0x19>

  if (fmt == 0)
    panic("null fmt");
801007d5:	83 ec 0c             	sub    $0xc,%esp
801007d8:	68 47 73 10 80       	push   $0x80107347
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
80100803:	e8 c8 3a 00 00       	call   801042d0 <acquire>
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
80100868:	e8 43 3c 00 00       	call   801044b0 <release>
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
801008f6:	e8 f5 36 00 00       	call   80103ff0 <wakeup>
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
80100977:	e9 64 37 00 00       	jmp    801040e0 <procdump>
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
801009a6:	68 50 73 10 80       	push   $0x80107350
801009ab:	68 20 a5 10 80       	push   $0x8010a520
801009b0:	e8 fb 38 00 00       	call   801042b0 <initlock>

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
801009da:	e8 21 29 00 00       	call   80103300 <picenable>
  ioapicenable(IRQ_KBD, 0);
801009df:	58                   	pop    %eax
801009e0:	5a                   	pop    %edx
801009e1:	6a 00                	push   $0x0
801009e3:	6a 01                	push   $0x1
801009e5:	e8 16 19 00 00       	call   80102300 <ioapicenable>
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
801009fc:	e8 2f 22 00 00       	call   80102c30 <begin_op>

  if((ip = namei(path)) == 0){
80100a01:	83 ec 0c             	sub    $0xc,%esp
80100a04:	ff 75 08             	pushl  0x8(%ebp)
80100a07:	e8 f4 14 00 00       	call   80101f00 <namei>
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
80100a44:	e8 57 22 00 00       	call   80102ca0 <end_op>
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
80100a6c:	e8 df 61 00 00       	call   80106c50 <setupkvm>
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
80100afc:	e8 0f 64 00 00       	call   80106f10 <allocuvm>
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
80100b32:	e8 19 63 00 00       	call   80106e50 <loaduvm>
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
80100b51:	e8 fa 64 00 00       	call   80107050 <freevm>
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
80100b67:	e8 34 21 00 00       	call   80102ca0 <end_op>
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
80100b8d:	e8 7e 63 00 00       	call   80106f10 <allocuvm>
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
80100ba4:	e8 a7 64 00 00       	call   80107050 <freevm>
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
80100bb6:	e8 e5 20 00 00       	call   80102ca0 <end_op>
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
80100bd9:	e8 f2 64 00 00       	call   801070d0 <clearpteu>
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
80100c09:	e8 32 3b 00 00       	call   80104740 <strlen>
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
80100c1c:	e8 1f 3b 00 00       	call   80104740 <strlen>
80100c21:	83 c0 01             	add    $0x1,%eax
80100c24:	50                   	push   %eax
80100c25:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c28:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c2b:	53                   	push   %ebx
80100c2c:	56                   	push   %esi
80100c2d:	e8 fe 65 00 00       	call   80107230 <copyout>
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
80100c97:	e8 94 65 00 00       	call   80107230 <copyout>
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
80100cda:	e8 21 3a 00 00       	call   80104700 <safestrcpy>

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
80100d0e:	e8 ed 5f 00 00       	call   80106d00 <switchuvm>
  freevm(oldpgdir);
80100d13:	89 3c 24             	mov    %edi,(%esp)
80100d16:	e8 35 63 00 00       	call   80107050 <freevm>
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
80100d36:	68 69 73 10 80       	push   $0x80107369
80100d3b:	68 e0 ff 10 80       	push   $0x8010ffe0
80100d40:	e8 6b 35 00 00       	call   801042b0 <initlock>
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
80100d61:	e8 6a 35 00 00       	call   801042d0 <acquire>
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
80100d91:	e8 1a 37 00 00       	call   801044b0 <release>
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
80100da8:	e8 03 37 00 00       	call   801044b0 <release>
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
80100dcf:	e8 fc 34 00 00       	call   801042d0 <acquire>
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
80100dec:	e8 bf 36 00 00       	call   801044b0 <release>
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
80100dfb:	68 70 73 10 80       	push   $0x80107370
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
80100e21:	e8 aa 34 00 00       	call   801042d0 <acquire>
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
80100e4c:	e9 5f 36 00 00       	jmp    801044b0 <release>
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
80100e78:	e8 33 36 00 00       	call   801044b0 <release>

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
80100ea1:	e8 2a 26 00 00       	call   801034d0 <pipeclose>
80100ea6:	83 c4 10             	add    $0x10,%esp
80100ea9:	eb df                	jmp    80100e8a <fileclose+0x7a>
80100eab:	90                   	nop
80100eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  else if(ff.type == FD_INODE){
    begin_op();
80100eb0:	e8 7b 1d 00 00       	call   80102c30 <begin_op>
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
80100eca:	e9 d1 1d 00 00       	jmp    80102ca0 <end_op>
{
  struct file ff;

  acquire(&ftable.lock);
  if(f->ref < 1)
    panic("fileclose");
80100ecf:	83 ec 0c             	sub    $0xc,%esp
80100ed2:	68 78 73 10 80       	push   $0x80107378
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
80100f9d:	e9 fe 26 00 00       	jmp    801036a0 <piperead>
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
80100fb2:	68 82 73 10 80       	push   $0x80107382
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
80101019:	e8 82 1c 00 00       	call   80102ca0 <end_op>
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
80101046:	e8 e5 1b 00 00       	call   80102c30 <begin_op>
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
80101063:	e8 e8 09 00 00       	call   80101a50 <writei>
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
8010107d:	e8 1e 1c 00 00       	call   80102ca0 <end_op>

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
801010bc:	e9 af 24 00 00       	jmp    80103570 <pipewrite>
      end_op();

      if(r < 0)
        break;
      if(r != n1)
        panic("short filewrite");
801010c1:	83 ec 0c             	sub    $0xc,%esp
801010c4:	68 8b 73 10 80       	push   $0x8010738b
801010c9:	e8 a2 f2 ff ff       	call   80100370 <panic>
      i += r;
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
801010ce:	83 ec 0c             	sub    $0xc,%esp
801010d1:	68 91 73 10 80       	push   $0x80107391
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
80101182:	68 9b 73 10 80       	push   $0x8010739b
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
8010119d:	e8 6e 1c 00 00       	call   80102e10 <log_write>
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
801011c5:	e8 36 33 00 00       	call   80104500 <memset>
  log_write(bp);
801011ca:	89 1c 24             	mov    %ebx,(%esp)
801011cd:	e8 3e 1c 00 00       	call   80102e10 <log_write>
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
8010120a:	e8 c1 30 00 00       	call   801042d0 <acquire>
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
80101252:	e8 59 32 00 00       	call   801044b0 <release>
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
8010129f:	e8 0c 32 00 00       	call   801044b0 <release>

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
801012b4:	68 b1 73 10 80       	push   $0x801073b1
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
8010132d:	e8 de 1a 00 00       	call   80102e10 <log_write>
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
8010137a:	68 c1 73 10 80       	push   $0x801073c1
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
801013b1:	e8 fa 31 00 00       	call   801045b0 <memmove>
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
8010142c:	e8 df 19 00 00       	call   80102e10 <log_write>
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
80101446:	68 d4 73 10 80       	push   $0x801073d4
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
8010145c:	68 e7 73 10 80       	push   $0x801073e7
80101461:	68 00 0a 11 80       	push   $0x80110a00
80101466:	e8 45 2e 00 00       	call   801042b0 <initlock>
8010146b:	83 c4 10             	add    $0x10,%esp
8010146e:	66 90                	xchg   %ax,%ax
  for(i = 0; i < NINODE; i++) {
    initsleeplock(&icache.inode[i].lock, "inode");
80101470:	83 ec 08             	sub    $0x8,%esp
80101473:	68 ee 73 10 80       	push   $0x801073ee
80101478:	53                   	push   %ebx
80101479:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010147f:	e8 1c 2d 00 00       	call   801041a0 <initsleeplock>
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
801014c9:	68 68 74 10 80       	push   $0x80107468
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
8010155e:	e8 9d 2f 00 00       	call   80104500 <memset>
      dip->type = type;
80101563:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101567:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010156a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010156d:	89 3c 24             	mov    %edi,(%esp)
80101570:	e8 9b 18 00 00       	call   80102e10 <log_write>
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
80101593:	68 f4 73 10 80       	push   $0x801073f4
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
80101601:	e8 aa 2f 00 00       	call   801045b0 <memmove>
  log_write(bp);
80101606:	89 34 24             	mov    %esi,(%esp)
80101609:	e8 02 18 00 00       	call   80102e10 <log_write>
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
8010162f:	e8 9c 2c 00 00       	call   801042d0 <acquire>
  ip->ref++;
80101634:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101638:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
8010163f:	e8 6c 2e 00 00       	call   801044b0 <release>
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
80101672:	e8 69 2b 00 00       	call   801041e0 <acquiresleep>

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
801016e8:	e8 c3 2e 00 00       	call   801045b0 <memmove>
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
8010170a:	68 0c 74 10 80       	push   $0x8010740c
8010170f:	e8 5c ec ff ff       	call   80100370 <panic>
{
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
    panic("ilock");
80101714:	83 ec 0c             	sub    $0xc,%esp
80101717:	68 06 74 10 80       	push   $0x80107406
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
80101743:	e8 38 2b 00 00       	call   80104280 <holdingsleep>
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
8010175f:	e9 dc 2a 00 00       	jmp    80104240 <releasesleep>
// Unlock the given inode.
void
iunlock(struct inode *ip)
{
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    panic("iunlock");
80101764:	83 ec 0c             	sub    $0xc,%esp
80101767:	68 1b 74 10 80       	push   $0x8010741b
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
80101791:	e8 3a 2b 00 00       	call   801042d0 <acquire>
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
801017b5:	e9 f6 2c 00 00       	jmp    801044b0 <release>
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
801017de:	e8 cd 2c 00 00       	call   801044b0 <release>
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
8010183f:	e8 8c 2a 00 00       	call   801042d0 <acquire>
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
80101944:	0f 82 f6 00 00 00    	jb     80101a40 <readi+0x130>
8010194a:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010194d:	89 fb                	mov    %edi,%ebx
8010194f:	01 f3                	add    %esi,%ebx
80101951:	0f 82 e9 00 00 00    	jb     80101a40 <readi+0x130>
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
    cprintf("small file read\n");
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
    cprintf("small file read\n");
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
    memmove(dst, (char *)(ip->addrs) + off, n);
    cprintf("small file read\n");
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

  if(ip->type == T_SMALLFILE){
    memmove(dst, (char *)(ip->addrs) + off, n);
    cprintf("small file read\n");
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
801019c0:	e8 eb 2b 00 00       	call   801045b0 <memmove>
      brelse(bp);
801019c5:	8b 55 dc             	mov    -0x24(%ebp),%edx
801019c8:	89 14 24             	mov    %edx,(%esp)
801019cb:	e8 10 e8 ff ff       	call   801001e0 <brelse>

  if(ip->type == T_SMALLFILE){
    memmove(dst, (char *)(ip->addrs) + off, n);
    cprintf("small file read\n");
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
801019f8:	77 46                	ja     80101a40 <readi+0x130>
801019fa:	8b 04 c5 80 09 11 80 	mov    -0x7feef680(,%eax,8),%eax
80101a01:	85 c0                	test   %eax,%eax
80101a03:	74 3b                	je     80101a40 <readi+0x130>
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
80101a29:	e8 82 2b 00 00       	call   801045b0 <memmove>
    cprintf("small file read\n");
80101a2e:	c7 04 24 23 74 10 80 	movl   $0x80107423,(%esp)
80101a35:	e8 26 ec ff ff       	call   80100660 <cprintf>
80101a3a:	83 c4 10             	add    $0x10,%esp
80101a3d:	eb 9c                	jmp    801019db <readi+0xcb>
80101a3f:	90                   	nop
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
80101a40:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a45:	eb 97                	jmp    801019de <readi+0xce>
80101a47:	89 f6                	mov    %esi,%esi
80101a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101a50 <writei>:

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a50:	55                   	push   %ebp
80101a51:	89 e5                	mov    %esp,%ebp
80101a53:	57                   	push   %edi
80101a54:	56                   	push   %esi
80101a55:	53                   	push   %ebx
80101a56:	83 ec 1c             	sub    $0x1c,%esp
80101a59:	8b 45 08             	mov    0x8(%ebp),%eax
80101a5c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a5f:	8b 7d 14             	mov    0x14(%ebp),%edi
80101a62:	89 45 d8             	mov    %eax,-0x28(%ebp)
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a65:	0f b7 40 50          	movzwl 0x50(%eax),%eax

// PAGEBREAK!
// Write data to inode.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a69:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a6c:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101a6f:	8b 75 10             	mov    0x10(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a72:	66 83 f8 03          	cmp    $0x3,%ax
80101a76:	0f 84 c4 00 00 00    	je     80101b40 <writei+0xf0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a7c:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101a7f:	39 77 58             	cmp    %esi,0x58(%edi)
80101a82:	0f 82 28 01 00 00    	jb     80101bb0 <writei+0x160>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101a88:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101a8b:	89 fa                	mov    %edi,%edx
80101a8d:	01 f2                	add    %esi,%edx
80101a8f:	0f 82 1b 01 00 00    	jb     80101bb0 <writei+0x160>
80101a95:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101a9b:	0f 87 0f 01 00 00    	ja     80101bb0 <writei+0x160>
    return -1;

if(ip->type == T_SMALLFILE){
80101aa1:	66 83 f8 05          	cmp    $0x5,%ax
80101aa5:	0f 84 d5 00 00 00    	je     80101b80 <writei+0x130>
  memmove((char *)(ip->addrs) + off, src, n);
  cprintf("small file write\n");
} else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101aab:	85 ff                	test   %edi,%edi
80101aad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101ab4:	74 7c                	je     80101b32 <writei+0xe2>
80101ab6:	8d 76 00             	lea    0x0(%esi),%esi
80101ab9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ac0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ac3:	89 f2                	mov    %esi,%edx
      m = min(n - tot, BSIZE - off%BSIZE);
80101ac5:	bb 00 02 00 00       	mov    $0x200,%ebx
if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
  cprintf("small file write\n");
} else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101aca:	c1 ea 09             	shr    $0x9,%edx
80101acd:	89 f8                	mov    %edi,%eax
80101acf:	e8 ec f7 ff ff       	call   801012c0 <bmap>
80101ad4:	83 ec 08             	sub    $0x8,%esp
80101ad7:	50                   	push   %eax
80101ad8:	ff 37                	pushl  (%edi)
80101ada:	e8 f1 e5 ff ff       	call   801000d0 <bread>
80101adf:	89 c7                	mov    %eax,%edi
      m = min(n - tot, BSIZE - off%BSIZE);
80101ae1:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ae4:	2b 45 e4             	sub    -0x1c(%ebp),%eax
80101ae7:	89 f1                	mov    %esi,%ecx
80101ae9:	83 c4 0c             	add    $0xc,%esp
80101aec:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
80101af2:	29 cb                	sub    %ecx,%ebx
80101af4:	39 c3                	cmp    %eax,%ebx
80101af6:	0f 47 d8             	cmova  %eax,%ebx
      memmove(bp->data + off%BSIZE, src, m);
80101af9:	8d 44 0f 5c          	lea    0x5c(%edi,%ecx,1),%eax
80101afd:	53                   	push   %ebx
80101afe:	ff 75 dc             	pushl  -0x24(%ebp)

if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
  cprintf("small file write\n");
} else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b01:	01 de                	add    %ebx,%esi
      bp = bread(ip->dev, bmap(ip, off/BSIZE));
      m = min(n - tot, BSIZE - off%BSIZE);
      memmove(bp->data + off%BSIZE, src, m);
80101b03:	50                   	push   %eax
80101b04:	e8 a7 2a 00 00       	call   801045b0 <memmove>
      log_write(bp);
80101b09:	89 3c 24             	mov    %edi,(%esp)
80101b0c:	e8 ff 12 00 00       	call   80102e10 <log_write>
      brelse(bp);
80101b11:	89 3c 24             	mov    %edi,(%esp)
80101b14:	e8 c7 e6 ff ff       	call   801001e0 <brelse>

if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
  cprintf("small file write\n");
} else{
    for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b19:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b1c:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b1f:	83 c4 10             	add    $0x10,%esp
80101b22:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b25:	39 55 e0             	cmp    %edx,-0x20(%ebp)
80101b28:	77 96                	ja     80101ac0 <writei+0x70>
      log_write(bp);
      brelse(bp);
  }
}

  if(n > 0 && off > ip->size){
80101b2a:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b2d:	39 70 58             	cmp    %esi,0x58(%eax)
80101b30:	72 36                	jb     80101b68 <writei+0x118>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b32:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b38:	5b                   	pop    %ebx
80101b39:	5e                   	pop    %esi
80101b3a:	5f                   	pop    %edi
80101b3b:	5d                   	pop    %ebp
80101b3c:	c3                   	ret    
80101b3d:	8d 76 00             	lea    0x0(%esi),%esi
{
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b40:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101b43:	0f bf 46 52          	movswl 0x52(%esi),%eax
80101b47:	66 83 f8 09          	cmp    $0x9,%ax
80101b4b:	77 63                	ja     80101bb0 <writei+0x160>
80101b4d:	8b 04 c5 84 09 11 80 	mov    -0x7feef67c(,%eax,8),%eax
80101b54:	85 c0                	test   %eax,%eax
80101b56:	74 58                	je     80101bb0 <writei+0x160>
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b58:	89 7d 10             	mov    %edi,0x10(%ebp)
  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
  }
  return n;
}
80101b5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b5e:	5b                   	pop    %ebx
80101b5f:	5e                   	pop    %esi
80101b60:	5f                   	pop    %edi
80101b61:	5d                   	pop    %ebp
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
80101b62:	ff e0                	jmp    *%eax
80101b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
}

  if(n > 0 && off > ip->size){
    ip->size = off;
    iupdate(ip);
80101b68:	83 ec 0c             	sub    $0xc,%esp
      brelse(bp);
  }
}

  if(n > 0 && off > ip->size){
    ip->size = off;
80101b6b:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b6e:	50                   	push   %eax
80101b6f:	e8 2c fa ff ff       	call   801015a0 <iupdate>
80101b74:	83 c4 10             	add    $0x10,%esp
80101b77:	eb b9                	jmp    80101b32 <writei+0xe2>
80101b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  if(off + n > MAXFILE*BSIZE)
    return -1;

if(ip->type == T_SMALLFILE){
  memmove((char *)(ip->addrs) + off, src, n);
80101b80:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b83:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101b86:	83 ec 04             	sub    $0x4,%esp
80101b89:	8d 44 30 5c          	lea    0x5c(%eax,%esi,1),%eax
80101b8d:	57                   	push   %edi
80101b8e:	ff 75 dc             	pushl  -0x24(%ebp)
80101b91:	50                   	push   %eax
80101b92:	e8 19 2a 00 00       	call   801045b0 <memmove>
  cprintf("small file write\n");
80101b97:	c7 04 24 34 74 10 80 	movl   $0x80107434,(%esp)
80101b9e:	e8 bd ea ff ff       	call   80100660 <cprintf>
      log_write(bp);
      brelse(bp);
  }
}

  if(n > 0 && off > ip->size){
80101ba3:	83 c4 10             	add    $0x10,%esp
80101ba6:	85 ff                	test   %edi,%edi
80101ba8:	74 88                	je     80101b32 <writei+0xe2>
80101baa:	e9 7b ff ff ff       	jmp    80101b2a <writei+0xda>
80101baf:	90                   	nop
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
80101bb0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101bb5:	e9 7b ff ff ff       	jmp    80101b35 <writei+0xe5>
80101bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101bc0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101bc6:	6a 0e                	push   $0xe
80101bc8:	ff 75 0c             	pushl  0xc(%ebp)
80101bcb:	ff 75 08             	pushl  0x8(%ebp)
80101bce:	e8 5d 2a 00 00       	call   80104630 <strncmp>
}
80101bd3:	c9                   	leave  
80101bd4:	c3                   	ret    
80101bd5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101be0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101be0:	55                   	push   %ebp
80101be1:	89 e5                	mov    %esp,%ebp
80101be3:	57                   	push   %edi
80101be4:	56                   	push   %esi
80101be5:	53                   	push   %ebx
80101be6:	83 ec 1c             	sub    $0x1c,%esp
80101be9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bf1:	0f 85 80 00 00 00    	jne    80101c77 <dirlookup+0x97>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bf7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bfa:	31 ff                	xor    %edi,%edi
80101bfc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bff:	85 d2                	test   %edx,%edx
80101c01:	75 0d                	jne    80101c10 <dirlookup+0x30>
80101c03:	eb 5b                	jmp    80101c60 <dirlookup+0x80>
80101c05:	8d 76 00             	lea    0x0(%esi),%esi
80101c08:	83 c7 10             	add    $0x10,%edi
80101c0b:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101c0e:	76 50                	jbe    80101c60 <dirlookup+0x80>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101c10:	6a 10                	push   $0x10
80101c12:	57                   	push   %edi
80101c13:	56                   	push   %esi
80101c14:	53                   	push   %ebx
80101c15:	e8 f6 fc ff ff       	call   80101910 <readi>
80101c1a:	83 c4 10             	add    $0x10,%esp
80101c1d:	83 f8 10             	cmp    $0x10,%eax
80101c20:	75 48                	jne    80101c6a <dirlookup+0x8a>
      panic("dirlink read");
    if(de.inum == 0)
80101c22:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101c27:	74 df                	je     80101c08 <dirlookup+0x28>
// Directories

int
namecmp(const char *s, const char *t)
{
  return strncmp(s, t, DIRSIZ);
80101c29:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c2c:	83 ec 04             	sub    $0x4,%esp
80101c2f:	6a 0e                	push   $0xe
80101c31:	50                   	push   %eax
80101c32:	ff 75 0c             	pushl  0xc(%ebp)
80101c35:	e8 f6 29 00 00       	call   80104630 <strncmp>
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
    if(de.inum == 0)
      continue;
    if(namecmp(name, de.name) == 0){
80101c3a:	83 c4 10             	add    $0x10,%esp
80101c3d:	85 c0                	test   %eax,%eax
80101c3f:	75 c7                	jne    80101c08 <dirlookup+0x28>
      // entry matches path element
      if(poff)
80101c41:	8b 45 10             	mov    0x10(%ebp),%eax
80101c44:	85 c0                	test   %eax,%eax
80101c46:	74 05                	je     80101c4d <dirlookup+0x6d>
        *poff = off;
80101c48:	8b 45 10             	mov    0x10(%ebp),%eax
80101c4b:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
      return iget(dp->dev, inum);
80101c4d:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
80101c51:	8b 03                	mov    (%ebx),%eax
80101c53:	e8 98 f5 ff ff       	call   801011f0 <iget>
    }
  }

  return 0;
}
80101c58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c5b:	5b                   	pop    %ebx
80101c5c:	5e                   	pop    %esi
80101c5d:	5f                   	pop    %edi
80101c5e:	5d                   	pop    %ebp
80101c5f:	c3                   	ret    
80101c60:	8d 65 f4             	lea    -0xc(%ebp),%esp
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
80101c63:	31 c0                	xor    %eax,%eax
}
80101c65:	5b                   	pop    %ebx
80101c66:	5e                   	pop    %esi
80101c67:	5f                   	pop    %edi
80101c68:	5d                   	pop    %ebp
80101c69:	c3                   	ret    
  if(dp->type != T_DIR)
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101c6a:	83 ec 0c             	sub    $0xc,%esp
80101c6d:	68 58 74 10 80       	push   $0x80107458
80101c72:	e8 f9 e6 ff ff       	call   80100370 <panic>
{
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
    panic("dirlookup not DIR");
80101c77:	83 ec 0c             	sub    $0xc,%esp
80101c7a:	68 46 74 10 80       	push   $0x80107446
80101c7f:	e8 ec e6 ff ff       	call   80100370 <panic>
80101c84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101c8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101c90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c90:	55                   	push   %ebp
80101c91:	89 e5                	mov    %esp,%ebp
80101c93:	57                   	push   %edi
80101c94:	56                   	push   %esi
80101c95:	53                   	push   %ebx
80101c96:	89 cf                	mov    %ecx,%edi
80101c98:	89 c3                	mov    %eax,%ebx
80101c9a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c9d:	80 38 2f             	cmpb   $0x2f,(%eax)
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101ca0:	89 55 e0             	mov    %edx,-0x20(%ebp)
  struct inode *ip, *next;

  if(*path == '/')
80101ca3:	0f 84 53 01 00 00    	je     80101dfc <namex+0x16c>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101ca9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101caf:	83 ec 0c             	sub    $0xc,%esp
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);
80101cb2:	8b 70 68             	mov    0x68(%eax),%esi
// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
  acquire(&icache.lock);
80101cb5:	68 00 0a 11 80       	push   $0x80110a00
80101cba:	e8 11 26 00 00       	call   801042d0 <acquire>
  ip->ref++;
80101cbf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101cc3:	c7 04 24 00 0a 11 80 	movl   $0x80110a00,(%esp)
80101cca:	e8 e1 27 00 00       	call   801044b0 <release>
80101ccf:	83 c4 10             	add    $0x10,%esp
80101cd2:	eb 07                	jmp    80101cdb <namex+0x4b>
80101cd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  char *s;
  int len;

  while(*path == '/')
    path++;
80101cd8:	83 c3 01             	add    $0x1,%ebx
skipelem(char *path, char *name)
{
  char *s;
  int len;

  while(*path == '/')
80101cdb:	0f b6 03             	movzbl (%ebx),%eax
80101cde:	3c 2f                	cmp    $0x2f,%al
80101ce0:	74 f6                	je     80101cd8 <namex+0x48>
    path++;
  if(*path == 0)
80101ce2:	84 c0                	test   %al,%al
80101ce4:	0f 84 e3 00 00 00    	je     80101dcd <namex+0x13d>
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101cea:	0f b6 03             	movzbl (%ebx),%eax
80101ced:	89 da                	mov    %ebx,%edx
80101cef:	84 c0                	test   %al,%al
80101cf1:	0f 84 ac 00 00 00    	je     80101da3 <namex+0x113>
80101cf7:	3c 2f                	cmp    $0x2f,%al
80101cf9:	75 09                	jne    80101d04 <namex+0x74>
80101cfb:	e9 a3 00 00 00       	jmp    80101da3 <namex+0x113>
80101d00:	84 c0                	test   %al,%al
80101d02:	74 0a                	je     80101d0e <namex+0x7e>
    path++;
80101d04:	83 c2 01             	add    $0x1,%edx
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101d07:	0f b6 02             	movzbl (%edx),%eax
80101d0a:	3c 2f                	cmp    $0x2f,%al
80101d0c:	75 f2                	jne    80101d00 <namex+0x70>
80101d0e:	89 d1                	mov    %edx,%ecx
80101d10:	29 d9                	sub    %ebx,%ecx
    path++;
  len = path - s;
  if(len >= DIRSIZ)
80101d12:	83 f9 0d             	cmp    $0xd,%ecx
80101d15:	0f 8e 8d 00 00 00    	jle    80101da8 <namex+0x118>
    memmove(name, s, DIRSIZ);
80101d1b:	83 ec 04             	sub    $0x4,%esp
80101d1e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d21:	6a 0e                	push   $0xe
80101d23:	53                   	push   %ebx
80101d24:	57                   	push   %edi
80101d25:	e8 86 28 00 00       	call   801045b0 <memmove>
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d2a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
80101d2d:	83 c4 10             	add    $0x10,%esp
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
    path++;
80101d30:	89 d3                	mov    %edx,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d32:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d35:	75 11                	jne    80101d48 <namex+0xb8>
80101d37:	89 f6                	mov    %esi,%esi
80101d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d40:	83 c3 01             	add    $0x1,%ebx
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
    name[len] = 0;
  }
  while(*path == '/')
80101d43:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d46:	74 f8                	je     80101d40 <namex+0xb0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(proc->cwd);

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d48:	83 ec 0c             	sub    $0xc,%esp
80101d4b:	56                   	push   %esi
80101d4c:	e8 ff f8 ff ff       	call   80101650 <ilock>
    if(ip->type != T_DIR){
80101d51:	83 c4 10             	add    $0x10,%esp
80101d54:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d59:	0f 85 7f 00 00 00    	jne    80101dde <namex+0x14e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d5f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d62:	85 d2                	test   %edx,%edx
80101d64:	74 09                	je     80101d6f <namex+0xdf>
80101d66:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d69:	0f 84 a3 00 00 00    	je     80101e12 <namex+0x182>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d6f:	83 ec 04             	sub    $0x4,%esp
80101d72:	6a 00                	push   $0x0
80101d74:	57                   	push   %edi
80101d75:	56                   	push   %esi
80101d76:	e8 65 fe ff ff       	call   80101be0 <dirlookup>
80101d7b:	83 c4 10             	add    $0x10,%esp
80101d7e:	85 c0                	test   %eax,%eax
80101d80:	74 5c                	je     80101dde <namex+0x14e>

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101d82:	83 ec 0c             	sub    $0xc,%esp
80101d85:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d88:	56                   	push   %esi
80101d89:	e8 a2 f9 ff ff       	call   80101730 <iunlock>
  iput(ip);
80101d8e:	89 34 24             	mov    %esi,(%esp)
80101d91:	e8 ea f9 ff ff       	call   80101780 <iput>
80101d96:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d99:	83 c4 10             	add    $0x10,%esp
80101d9c:	89 c6                	mov    %eax,%esi
80101d9e:	e9 38 ff ff ff       	jmp    80101cdb <namex+0x4b>
  while(*path == '/')
    path++;
  if(*path == 0)
    return 0;
  s = path;
  while(*path != '/' && *path != 0)
80101da3:	31 c9                	xor    %ecx,%ecx
80101da5:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
  len = path - s;
  if(len >= DIRSIZ)
    memmove(name, s, DIRSIZ);
  else {
    memmove(name, s, len);
80101da8:	83 ec 04             	sub    $0x4,%esp
80101dab:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dae:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101db1:	51                   	push   %ecx
80101db2:	53                   	push   %ebx
80101db3:	57                   	push   %edi
80101db4:	e8 f7 27 00 00       	call   801045b0 <memmove>
    name[len] = 0;
80101db9:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101dbc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dbf:	83 c4 10             	add    $0x10,%esp
80101dc2:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dc6:	89 d3                	mov    %edx,%ebx
80101dc8:	e9 65 ff ff ff       	jmp    80101d32 <namex+0xa2>
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dcd:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dd0:	85 c0                	test   %eax,%eax
80101dd2:	75 54                	jne    80101e28 <namex+0x198>
80101dd4:	89 f0                	mov    %esi,%eax
    iput(ip);
    return 0;
  }
  return ip;
}
80101dd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd9:	5b                   	pop    %ebx
80101dda:	5e                   	pop    %esi
80101ddb:	5f                   	pop    %edi
80101ddc:	5d                   	pop    %ebp
80101ddd:	c3                   	ret    

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
  iunlock(ip);
80101dde:	83 ec 0c             	sub    $0xc,%esp
80101de1:	56                   	push   %esi
80101de2:	e8 49 f9 ff ff       	call   80101730 <iunlock>
  iput(ip);
80101de7:	89 34 24             	mov    %esi,(%esp)
80101dea:	e8 91 f9 ff ff       	call   80101780 <iput>
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101def:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101df2:	8d 65 f4             	lea    -0xc(%ebp),%esp
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
      iunlockput(ip);
      return 0;
80101df5:	31 c0                	xor    %eax,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101df7:	5b                   	pop    %ebx
80101df8:	5e                   	pop    %esi
80101df9:	5f                   	pop    %edi
80101dfa:	5d                   	pop    %ebp
80101dfb:	c3                   	ret    
namex(char *path, int nameiparent, char *name)
{
  struct inode *ip, *next;

  if(*path == '/')
    ip = iget(ROOTDEV, ROOTINO);
80101dfc:	ba 01 00 00 00       	mov    $0x1,%edx
80101e01:	b8 01 00 00 00       	mov    $0x1,%eax
80101e06:	e8 e5 f3 ff ff       	call   801011f0 <iget>
80101e0b:	89 c6                	mov    %eax,%esi
80101e0d:	e9 c9 fe ff ff       	jmp    80101cdb <namex+0x4b>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
80101e12:	83 ec 0c             	sub    $0xc,%esp
80101e15:	56                   	push   %esi
80101e16:	e8 15 f9 ff ff       	call   80101730 <iunlock>
      return ip;
80101e1b:	83 c4 10             	add    $0x10,%esp
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e1e:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
    if(nameiparent && *path == '\0'){
      // Stop one level early.
      iunlock(ip);
      return ip;
80101e21:	89 f0                	mov    %esi,%eax
  if(nameiparent){
    iput(ip);
    return 0;
  }
  return ip;
}
80101e23:	5b                   	pop    %ebx
80101e24:	5e                   	pop    %esi
80101e25:	5f                   	pop    %edi
80101e26:	5d                   	pop    %ebp
80101e27:	c3                   	ret    
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
    iput(ip);
80101e28:	83 ec 0c             	sub    $0xc,%esp
80101e2b:	56                   	push   %esi
80101e2c:	e8 4f f9 ff ff       	call   80101780 <iput>
    return 0;
80101e31:	83 c4 10             	add    $0x10,%esp
80101e34:	31 c0                	xor    %eax,%eax
80101e36:	eb 9e                	jmp    80101dd6 <namex+0x146>
80101e38:	90                   	nop
80101e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e40 <dirlink>:
}

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
80101e40:	55                   	push   %ebp
80101e41:	89 e5                	mov    %esp,%ebp
80101e43:	57                   	push   %edi
80101e44:	56                   	push   %esi
80101e45:	53                   	push   %ebx
80101e46:	83 ec 20             	sub    $0x20,%esp
80101e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e4c:	6a 00                	push   $0x0
80101e4e:	ff 75 0c             	pushl  0xc(%ebp)
80101e51:	53                   	push   %ebx
80101e52:	e8 89 fd ff ff       	call   80101be0 <dirlookup>
80101e57:	83 c4 10             	add    $0x10,%esp
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	75 67                	jne    80101ec5 <dirlink+0x85>
    iput(ip);
    return -1;
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e5e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e61:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e64:	85 ff                	test   %edi,%edi
80101e66:	74 29                	je     80101e91 <dirlink+0x51>
80101e68:	31 ff                	xor    %edi,%edi
80101e6a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e6d:	eb 09                	jmp    80101e78 <dirlink+0x38>
80101e6f:	90                   	nop
80101e70:	83 c7 10             	add    $0x10,%edi
80101e73:	39 7b 58             	cmp    %edi,0x58(%ebx)
80101e76:	76 19                	jbe    80101e91 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e78:	6a 10                	push   $0x10
80101e7a:	57                   	push   %edi
80101e7b:	56                   	push   %esi
80101e7c:	53                   	push   %ebx
80101e7d:	e8 8e fa ff ff       	call   80101910 <readi>
80101e82:	83 c4 10             	add    $0x10,%esp
80101e85:	83 f8 10             	cmp    $0x10,%eax
80101e88:	75 4e                	jne    80101ed8 <dirlink+0x98>
      panic("dirlink read");
    if(de.inum == 0)
80101e8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e8f:	75 df                	jne    80101e70 <dirlink+0x30>
      break;
  }

  strncpy(de.name, name, DIRSIZ);
80101e91:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e94:	83 ec 04             	sub    $0x4,%esp
80101e97:	6a 0e                	push   $0xe
80101e99:	ff 75 0c             	pushl  0xc(%ebp)
80101e9c:	50                   	push   %eax
80101e9d:	e8 fe 27 00 00       	call   801046a0 <strncpy>
  de.inum = inum;
80101ea2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ea5:	6a 10                	push   $0x10
80101ea7:	57                   	push   %edi
80101ea8:	56                   	push   %esi
80101ea9:	53                   	push   %ebx
    if(de.inum == 0)
      break;
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
80101eaa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eae:	e8 9d fb ff ff       	call   80101a50 <writei>
80101eb3:	83 c4 20             	add    $0x20,%esp
80101eb6:	83 f8 10             	cmp    $0x10,%eax
80101eb9:	75 2a                	jne    80101ee5 <dirlink+0xa5>
    panic("dirlink");

  return 0;
80101ebb:	31 c0                	xor    %eax,%eax
}
80101ebd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec0:	5b                   	pop    %ebx
80101ec1:	5e                   	pop    %esi
80101ec2:	5f                   	pop    %edi
80101ec3:	5d                   	pop    %ebp
80101ec4:	c3                   	ret    
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
    iput(ip);
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	50                   	push   %eax
80101ec9:	e8 b2 f8 ff ff       	call   80101780 <iput>
    return -1;
80101ece:	83 c4 10             	add    $0x10,%esp
80101ed1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ed6:	eb e5                	jmp    80101ebd <dirlink+0x7d>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("dirlink read");
80101ed8:	83 ec 0c             	sub    $0xc,%esp
80101edb:	68 58 74 10 80       	push   $0x80107458
80101ee0:	e8 8b e4 ff ff       	call   80100370 <panic>
  }

  strncpy(de.name, name, DIRSIZ);
  de.inum = inum;
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("dirlink");
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	68 4a 7a 10 80       	push   $0x80107a4a
80101eed:	e8 7e e4 ff ff       	call   80100370 <panic>
80101ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <namei>:
  return ip;
}

struct inode*
namei(char *path)
{
80101f00:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f01:	31 d2                	xor    %edx,%edx
  return ip;
}

struct inode*
namei(char *path)
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f0e:	e8 7d fd ff ff       	call   80101c90 <namex>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f20:	55                   	push   %ebp
  return namex(path, 1, name);
80101f21:	ba 01 00 00 00       	mov    $0x1,%edx
  return namex(path, 0, name);
}

struct inode*
nameiparent(char *path, char *name)
{
80101f26:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f2e:	5d                   	pop    %ebp
}

struct inode*
nameiparent(char *path, char *name)
{
  return namex(path, 1, name);
80101f2f:	e9 5c fd ff ff       	jmp    80101c90 <namex>
80101f34:	66 90                	xchg   %ax,%ax
80101f36:	66 90                	xchg   %ax,%ax
80101f38:	66 90                	xchg   %ax,%ax
80101f3a:	66 90                	xchg   %ax,%ax
80101f3c:	66 90                	xchg   %ax,%ax
80101f3e:	66 90                	xchg   %ax,%ax

80101f40 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f40:	55                   	push   %ebp
  if(b == 0)
80101f41:	85 c0                	test   %eax,%eax
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f43:	89 e5                	mov    %esp,%ebp
80101f45:	56                   	push   %esi
80101f46:	53                   	push   %ebx
  if(b == 0)
80101f47:	0f 84 ad 00 00 00    	je     80101ffa <idestart+0xba>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f4d:	8b 58 08             	mov    0x8(%eax),%ebx
80101f50:	89 c1                	mov    %eax,%ecx
80101f52:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f58:	0f 87 8f 00 00 00    	ja     80101fed <idestart+0xad>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f5e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101f63:	90                   	nop
80101f64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f68:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f69:	83 e0 c0             	and    $0xffffffc0,%eax
80101f6c:	3c 40                	cmp    $0x40,%al
80101f6e:	75 f8                	jne    80101f68 <idestart+0x28>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f70:	31 f6                	xor    %esi,%esi
80101f72:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f77:	89 f0                	mov    %esi,%eax
80101f79:	ee                   	out    %al,(%dx)
80101f7a:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f7f:	b8 01 00 00 00       	mov    $0x1,%eax
80101f84:	ee                   	out    %al,(%dx)
80101f85:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f8a:	89 d8                	mov    %ebx,%eax
80101f8c:	ee                   	out    %al,(%dx)
80101f8d:	89 d8                	mov    %ebx,%eax
80101f8f:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f94:	c1 f8 08             	sar    $0x8,%eax
80101f97:	ee                   	out    %al,(%dx)
80101f98:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101f9d:	89 f0                	mov    %esi,%eax
80101f9f:	ee                   	out    %al,(%dx)
80101fa0:	0f b6 41 04          	movzbl 0x4(%ecx),%eax
80101fa4:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fa9:	83 e0 01             	and    $0x1,%eax
80101fac:	c1 e0 04             	shl    $0x4,%eax
80101faf:	83 c8 e0             	or     $0xffffffe0,%eax
80101fb2:	ee                   	out    %al,(%dx)
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
80101fb3:	f6 01 04             	testb  $0x4,(%ecx)
80101fb6:	ba f7 01 00 00       	mov    $0x1f7,%edx
80101fbb:	75 13                	jne    80101fd0 <idestart+0x90>
80101fbd:	b8 20 00 00 00       	mov    $0x20,%eax
80101fc2:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fc6:	5b                   	pop    %ebx
80101fc7:	5e                   	pop    %esi
80101fc8:	5d                   	pop    %ebp
80101fc9:	c3                   	ret    
80101fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fd0:	b8 30 00 00 00       	mov    $0x30,%eax
80101fd5:	ee                   	out    %al,(%dx)
}

static inline void
outsl(int port, const void *addr, int cnt)
{
  asm volatile("cld; rep outsl" :
80101fd6:	ba f0 01 00 00       	mov    $0x1f0,%edx
  outb(0x1f4, (sector >> 8) & 0xff);
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
  if(b->flags & B_DIRTY){
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
80101fdb:	8d 71 5c             	lea    0x5c(%ecx),%esi
80101fde:	b9 80 00 00 00       	mov    $0x80,%ecx
80101fe3:	fc                   	cld    
80101fe4:	f3 6f                	rep outsl %ds:(%esi),(%dx)
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fe6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fe9:	5b                   	pop    %ebx
80101fea:	5e                   	pop    %esi
80101feb:	5d                   	pop    %ebp
80101fec:	c3                   	ret    
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
  if(b->blockno >= FSSIZE)
    panic("incorrect blockno");
80101fed:	83 ec 0c             	sub    $0xc,%esp
80101ff0:	68 c4 74 10 80       	push   $0x801074c4
80101ff5:	e8 76 e3 ff ff       	call   80100370 <panic>
// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
  if(b == 0)
    panic("idestart");
80101ffa:	83 ec 0c             	sub    $0xc,%esp
80101ffd:	68 bb 74 10 80       	push   $0x801074bb
80102002:	e8 69 e3 ff ff       	call   80100370 <panic>
80102007:	89 f6                	mov    %esi,%esi
80102009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102010 <ideinit>:
  return 0;
}

void
ideinit(void)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	83 ec 10             	sub    $0x10,%esp
  int i;

  initlock(&idelock, "ide");
80102016:	68 d6 74 10 80       	push   $0x801074d6
8010201b:	68 80 a5 10 80       	push   $0x8010a580
80102020:	e8 8b 22 00 00       	call   801042b0 <initlock>
  picenable(IRQ_IDE);
80102025:	c7 04 24 0e 00 00 00 	movl   $0xe,(%esp)
8010202c:	e8 cf 12 00 00       	call   80103300 <picenable>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102031:	58                   	pop    %eax
80102032:	a1 80 2d 11 80       	mov    0x80112d80,%eax
80102037:	5a                   	pop    %edx
80102038:	83 e8 01             	sub    $0x1,%eax
8010203b:	50                   	push   %eax
8010203c:	6a 0e                	push   $0xe
8010203e:	e8 bd 02 00 00       	call   80102300 <ioapicenable>
80102043:	83 c4 10             	add    $0x10,%esp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102046:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204b:	90                   	nop
8010204c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102050:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102051:	83 e0 c0             	and    $0xffffffc0,%eax
80102054:	3c 40                	cmp    $0x40,%al
80102056:	75 f8                	jne    80102050 <ideinit+0x40>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102058:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010205d:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102062:	ee                   	out    %al,(%dx)
80102063:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102068:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010206d:	eb 06                	jmp    80102075 <ideinit+0x65>
8010206f:	90                   	nop
  ioapicenable(IRQ_IDE, ncpu - 1);
  idewait(0);

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
  for(i=0; i<1000; i++){
80102070:	83 e9 01             	sub    $0x1,%ecx
80102073:	74 0f                	je     80102084 <ideinit+0x74>
80102075:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102076:	84 c0                	test   %al,%al
80102078:	74 f6                	je     80102070 <ideinit+0x60>
      havedisk1 = 1;
8010207a:	c7 05 60 a5 10 80 01 	movl   $0x1,0x8010a560
80102081:	00 00 00 
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102084:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102089:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
8010208e:	ee                   	out    %al,(%dx)
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
}
8010208f:	c9                   	leave  
80102090:	c3                   	ret    
80102091:	eb 0d                	jmp    801020a0 <ideintr>
80102093:	90                   	nop
80102094:	90                   	nop
80102095:	90                   	nop
80102096:	90                   	nop
80102097:	90                   	nop
80102098:	90                   	nop
80102099:	90                   	nop
8010209a:	90                   	nop
8010209b:	90                   	nop
8010209c:	90                   	nop
8010209d:	90                   	nop
8010209e:	90                   	nop
8010209f:	90                   	nop

801020a0 <ideintr>:
}

// Interrupt handler.
void
ideintr(void)
{
801020a0:	55                   	push   %ebp
801020a1:	89 e5                	mov    %esp,%ebp
801020a3:	57                   	push   %edi
801020a4:	56                   	push   %esi
801020a5:	53                   	push   %ebx
801020a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020a9:	68 80 a5 10 80       	push   $0x8010a580
801020ae:	e8 1d 22 00 00       	call   801042d0 <acquire>
  if((b = idequeue) == 0){
801020b3:	8b 1d 64 a5 10 80    	mov    0x8010a564,%ebx
801020b9:	83 c4 10             	add    $0x10,%esp
801020bc:	85 db                	test   %ebx,%ebx
801020be:	74 34                	je     801020f4 <ideintr+0x54>
    release(&idelock);
    // cprintf("spurious IDE interrupt\n");
    return;
  }
  idequeue = b->qnext;
801020c0:	8b 43 58             	mov    0x58(%ebx),%eax
801020c3:	a3 64 a5 10 80       	mov    %eax,0x8010a564

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020c8:	8b 33                	mov    (%ebx),%esi
801020ca:	f7 c6 04 00 00 00    	test   $0x4,%esi
801020d0:	74 3e                	je     80102110 <ideintr+0x70>
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020d2:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801020d5:	83 ec 0c             	sub    $0xc,%esp
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
801020d8:	83 ce 02             	or     $0x2,%esi
801020db:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801020dd:	53                   	push   %ebx
801020de:	e8 0d 1f 00 00       	call   80103ff0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801020e3:	a1 64 a5 10 80       	mov    0x8010a564,%eax
801020e8:	83 c4 10             	add    $0x10,%esp
801020eb:	85 c0                	test   %eax,%eax
801020ed:	74 05                	je     801020f4 <ideintr+0x54>
    idestart(idequeue);
801020ef:	e8 4c fe ff ff       	call   80101f40 <idestart>
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
  if((b = idequeue) == 0){
    release(&idelock);
801020f4:	83 ec 0c             	sub    $0xc,%esp
801020f7:	68 80 a5 10 80       	push   $0x8010a580
801020fc:	e8 af 23 00 00       	call   801044b0 <release>
  // Start disk on next buf in queue.
  if(idequeue != 0)
    idestart(idequeue);

  release(&idelock);
}
80102101:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102104:	5b                   	pop    %ebx
80102105:	5e                   	pop    %esi
80102106:	5f                   	pop    %edi
80102107:	5d                   	pop    %ebp
80102108:	c3                   	ret    
80102109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102110:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102115:	8d 76 00             	lea    0x0(%esi),%esi
80102118:	ec                   	in     (%dx),%al
static int
idewait(int checkerr)
{
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102119:	89 c1                	mov    %eax,%ecx
8010211b:	83 e1 c0             	and    $0xffffffc0,%ecx
8010211e:	80 f9 40             	cmp    $0x40,%cl
80102121:	75 f5                	jne    80102118 <ideintr+0x78>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102123:	a8 21                	test   $0x21,%al
80102125:	75 ab                	jne    801020d2 <ideintr+0x32>
  }
  idequeue = b->qnext;

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
    insl(0x1f0, b->data, BSIZE/4);
80102127:	8d 7b 5c             	lea    0x5c(%ebx),%edi
}

static inline void
insl(int port, void *addr, int cnt)
{
  asm volatile("cld; rep insl" :
8010212a:	b9 80 00 00 00       	mov    $0x80,%ecx
8010212f:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102134:	fc                   	cld    
80102135:	f3 6d                	rep insl (%dx),%es:(%edi)
80102137:	8b 33                	mov    (%ebx),%esi
80102139:	eb 97                	jmp    801020d2 <ideintr+0x32>
8010213b:	90                   	nop
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	53                   	push   %ebx
80102144:	83 ec 10             	sub    $0x10,%esp
80102147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010214a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010214d:	50                   	push   %eax
8010214e:	e8 2d 21 00 00       	call   80104280 <holdingsleep>
80102153:	83 c4 10             	add    $0x10,%esp
80102156:	85 c0                	test   %eax,%eax
80102158:	0f 84 ad 00 00 00    	je     8010220b <iderw+0xcb>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	0f 84 b9 00 00 00    	je     80102225 <iderw+0xe5>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010216c:	8b 53 04             	mov    0x4(%ebx),%edx
8010216f:	85 d2                	test   %edx,%edx
80102171:	74 0d                	je     80102180 <iderw+0x40>
80102173:	a1 60 a5 10 80       	mov    0x8010a560,%eax
80102178:	85 c0                	test   %eax,%eax
8010217a:	0f 84 98 00 00 00    	je     80102218 <iderw+0xd8>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102180:	83 ec 0c             	sub    $0xc,%esp
80102183:	68 80 a5 10 80       	push   $0x8010a580
80102188:	e8 43 21 00 00       	call   801042d0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	8b 15 64 a5 10 80    	mov    0x8010a564,%edx
80102193:	83 c4 10             	add    $0x10,%esp
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
80102196:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	85 d2                	test   %edx,%edx
8010219f:	75 09                	jne    801021aa <iderw+0x6a>
801021a1:	eb 58                	jmp    801021fb <iderw+0xbb>
801021a3:	90                   	nop
801021a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021a8:	89 c2                	mov    %eax,%edx
801021aa:	8b 42 58             	mov    0x58(%edx),%eax
801021ad:	85 c0                	test   %eax,%eax
801021af:	75 f7                	jne    801021a8 <iderw+0x68>
801021b1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021b4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021b6:	3b 1d 64 a5 10 80    	cmp    0x8010a564,%ebx
801021bc:	74 44                	je     80102202 <iderw+0xc2>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 e0 06             	and    $0x6,%eax
801021c3:	83 f8 02             	cmp    $0x2,%eax
801021c6:	74 23                	je     801021eb <iderw+0xab>
801021c8:	90                   	nop
801021c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021d0:	83 ec 08             	sub    $0x8,%esp
801021d3:	68 80 a5 10 80       	push   $0x8010a580
801021d8:	53                   	push   %ebx
801021d9:	e8 72 1c 00 00       	call   80103e50 <sleep>
  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021de:	8b 03                	mov    (%ebx),%eax
801021e0:	83 c4 10             	add    $0x10,%esp
801021e3:	83 e0 06             	and    $0x6,%eax
801021e6:	83 f8 02             	cmp    $0x2,%eax
801021e9:	75 e5                	jne    801021d0 <iderw+0x90>
    sleep(b, &idelock);
  }

  release(&idelock);
801021eb:	c7 45 08 80 a5 10 80 	movl   $0x8010a580,0x8(%ebp)
}
801021f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f5:	c9                   	leave  
  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
    sleep(b, &idelock);
  }

  release(&idelock);
801021f6:	e9 b5 22 00 00       	jmp    801044b0 <release>

  acquire(&idelock);  //DOC:acquire-lock

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801021fb:	ba 64 a5 10 80       	mov    $0x8010a564,%edx
80102200:	eb b2                	jmp    801021b4 <iderw+0x74>
    ;
  *pp = b;

  // Start disk if necessary.
  if(idequeue == b)
    idestart(b);
80102202:	89 d8                	mov    %ebx,%eax
80102204:	e8 37 fd ff ff       	call   80101f40 <idestart>
80102209:	eb b3                	jmp    801021be <iderw+0x7e>
iderw(struct buf *b)
{
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
8010220b:	83 ec 0c             	sub    $0xc,%esp
8010220e:	68 da 74 10 80       	push   $0x801074da
80102213:	e8 58 e1 ff ff       	call   80100370 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
    panic("iderw: ide disk 1 not present");
80102218:	83 ec 0c             	sub    $0xc,%esp
8010221b:	68 05 75 10 80       	push   $0x80107505
80102220:	e8 4b e1 ff ff       	call   80100370 <panic>
  struct buf **pp;

  if(!holdingsleep(&b->lock))
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
    panic("iderw: nothing to do");
80102225:	83 ec 0c             	sub    $0xc,%esp
80102228:	68 f0 74 10 80       	push   $0x801074f0
8010222d:	e8 3e e1 ff ff       	call   80100370 <panic>
80102232:	66 90                	xchg   %ax,%ax
80102234:	66 90                	xchg   %ax,%ax
80102236:	66 90                	xchg   %ax,%ax
80102238:	66 90                	xchg   %ax,%ax
8010223a:	66 90                	xchg   %ax,%ax
8010223c:	66 90                	xchg   %ax,%ax
8010223e:	66 90                	xchg   %ax,%ax

80102240 <ioapicinit>:
void
ioapicinit(void)
{
  int i, id, maxintr;

  if(!ismp)
80102240:	a1 84 27 11 80       	mov    0x80112784,%eax
80102245:	85 c0                	test   %eax,%eax
80102247:	0f 84 a8 00 00 00    	je     801022f5 <ioapicinit+0xb5>
  ioapic->data = data;
}

void
ioapicinit(void)
{
8010224d:	55                   	push   %ebp
  int i, id, maxintr;

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
8010224e:	c7 05 54 26 11 80 00 	movl   $0xfec00000,0x80112654
80102255:	00 c0 fe 
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102258:	89 e5                	mov    %esp,%ebp
8010225a:	56                   	push   %esi
8010225b:	53                   	push   %ebx
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010225c:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102263:	00 00 00 
  return ioapic->data;
80102266:	8b 15 54 26 11 80    	mov    0x80112654,%edx
8010226c:	8b 72 10             	mov    0x10(%edx),%esi
};

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
8010226f:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102275:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010227b:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx

  if(!ismp)
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102282:	89 f0                	mov    %esi,%eax
80102284:	c1 e8 10             	shr    $0x10,%eax
80102287:	0f b6 f0             	movzbl %al,%esi

static uint
ioapicread(int reg)
{
  ioapic->reg = reg;
  return ioapic->data;
8010228a:	8b 41 10             	mov    0x10(%ecx),%eax
    return;

  ioapic = (volatile struct ioapic*)IOAPIC;
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010228d:	c1 e8 18             	shr    $0x18,%eax
80102290:	39 d0                	cmp    %edx,%eax
80102292:	74 16                	je     801022aa <ioapicinit+0x6a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102294:	83 ec 0c             	sub    $0xc,%esp
80102297:	68 24 75 10 80       	push   $0x80107524
8010229c:	e8 bf e3 ff ff       	call   80100660 <cprintf>
801022a1:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801022a7:	83 c4 10             	add    $0x10,%esp
801022aa:	83 c6 21             	add    $0x21,%esi
  ioapic->data = data;
}

void
ioapicinit(void)
{
801022ad:	ba 10 00 00 00       	mov    $0x10,%edx
801022b2:	b8 20 00 00 00       	mov    $0x20,%eax
801022b7:	89 f6                	mov    %esi,%esi
801022b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022c0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022c2:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022c8:	89 c3                	mov    %eax,%ebx
801022ca:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801022d0:	83 c0 01             	add    $0x1,%eax

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
801022d3:	89 59 10             	mov    %ebx,0x10(%ecx)
801022d6:	8d 5a 01             	lea    0x1(%edx),%ebx
801022d9:	83 c2 02             	add    $0x2,%edx
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022dc:	39 f0                	cmp    %esi,%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
801022de:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801022e0:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
801022e6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  if(id != ioapicid)
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801022ed:	75 d1                	jne    801022c0 <ioapicinit+0x80>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022f2:	5b                   	pop    %ebx
801022f3:	5e                   	pop    %esi
801022f4:	5d                   	pop    %ebp
801022f5:	f3 c3                	repz ret 
801022f7:	89 f6                	mov    %esi,%esi
801022f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102300 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
  if(!ismp)
80102300:	8b 15 84 27 11 80    	mov    0x80112784,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
80102306:	55                   	push   %ebp
80102307:	89 e5                	mov    %esp,%ebp
  if(!ismp)
80102309:	85 d2                	test   %edx,%edx
  }
}

void
ioapicenable(int irq, int cpunum)
{
8010230b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!ismp)
8010230e:	74 2b                	je     8010233b <ioapicenable+0x3b>
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102310:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
    return;

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102316:	8d 50 20             	lea    0x20(%eax),%edx
80102319:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010231d:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010231f:	8b 0d 54 26 11 80    	mov    0x80112654,%ecx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
80102325:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102328:	89 51 10             	mov    %edx,0x10(%ecx)

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010232b:	8b 55 0c             	mov    0xc(%ebp),%edx
}

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
8010232e:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102330:	a1 54 26 11 80       	mov    0x80112654,%eax

  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102335:	c1 e2 18             	shl    $0x18,%edx

static void
ioapicwrite(int reg, uint data)
{
  ioapic->reg = reg;
  ioapic->data = data;
80102338:	89 50 10             	mov    %edx,0x10(%eax)
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
}
8010233b:	5d                   	pop    %ebp
8010233c:	c3                   	ret    
8010233d:	66 90                	xchg   %ax,%ax
8010233f:	90                   	nop

80102340 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102340:	55                   	push   %ebp
80102341:	89 e5                	mov    %esp,%ebp
80102343:	53                   	push   %ebx
80102344:	83 ec 04             	sub    $0x4,%esp
80102347:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010234a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102350:	75 70                	jne    801023c2 <kfree+0x82>
80102352:	81 fb e8 55 11 80    	cmp    $0x801155e8,%ebx
80102358:	72 68                	jb     801023c2 <kfree+0x82>
8010235a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102360:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102365:	77 5b                	ja     801023c2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102367:	83 ec 04             	sub    $0x4,%esp
8010236a:	68 00 10 00 00       	push   $0x1000
8010236f:	6a 01                	push   $0x1
80102371:	53                   	push   %ebx
80102372:	e8 89 21 00 00       	call   80104500 <memset>

  if(kmem.use_lock)
80102377:	8b 15 94 26 11 80    	mov    0x80112694,%edx
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	85 d2                	test   %edx,%edx
80102382:	75 2c                	jne    801023b0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102384:	a1 98 26 11 80       	mov    0x80112698,%eax
80102389:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010238b:	a1 94 26 11 80       	mov    0x80112694,%eax

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
80102390:	89 1d 98 26 11 80    	mov    %ebx,0x80112698
  if(kmem.use_lock)
80102396:	85 c0                	test   %eax,%eax
80102398:	75 06                	jne    801023a0 <kfree+0x60>
    release(&kmem.lock);
}
8010239a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239d:	c9                   	leave  
8010239e:	c3                   	ret    
8010239f:	90                   	nop
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801023a0:	c7 45 08 60 26 11 80 	movl   $0x80112660,0x8(%ebp)
}
801023a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801023aa:	c9                   	leave  
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
801023ab:	e9 00 21 00 00       	jmp    801044b0 <release>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
801023b0:	83 ec 0c             	sub    $0xc,%esp
801023b3:	68 60 26 11 80       	push   $0x80112660
801023b8:	e8 13 1f 00 00       	call   801042d0 <acquire>
801023bd:	83 c4 10             	add    $0x10,%esp
801023c0:	eb c2                	jmp    80102384 <kfree+0x44>
kfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");
801023c2:	83 ec 0c             	sub    $0xc,%esp
801023c5:	68 56 75 10 80       	push   $0x80107556
801023ca:	e8 a1 df ff ff       	call   80100370 <panic>
801023cf:	90                   	nop

801023d0 <freerange>:
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023d0:	55                   	push   %ebp
801023d1:	89 e5                	mov    %esp,%ebp
801023d3:	56                   	push   %esi
801023d4:	53                   	push   %ebx
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
801023d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
801023db:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023e1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023e7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023ed:	39 de                	cmp    %ebx,%esi
801023ef:	72 23                	jb     80102414 <freerange+0x44>
801023f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023f8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023fe:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102401:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102407:	50                   	push   %eax
80102408:	e8 33 ff ff ff       	call   80102340 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010240d:	83 c4 10             	add    $0x10,%esp
80102410:	39 f3                	cmp    %esi,%ebx
80102412:	76 e4                	jbe    801023f8 <freerange+0x28>
    kfree(p);
}
80102414:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102417:	5b                   	pop    %ebx
80102418:	5e                   	pop    %esi
80102419:	5d                   	pop    %ebp
8010241a:	c3                   	ret    
8010241b:	90                   	nop
8010241c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102420 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	56                   	push   %esi
80102424:	53                   	push   %ebx
80102425:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102428:	83 ec 08             	sub    $0x8,%esp
8010242b:	68 5c 75 10 80       	push   $0x8010755c
80102430:	68 60 26 11 80       	push   $0x80112660
80102435:	e8 76 1e 00 00       	call   801042b0 <initlock>

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010243d:	83 c4 10             	add    $0x10,%esp
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
80102440:	c7 05 94 26 11 80 00 	movl   $0x0,0x80112694
80102447:	00 00 00 

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010244a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102450:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102456:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010245c:	39 de                	cmp    %ebx,%esi
8010245e:	72 1c                	jb     8010247c <kinit1+0x5c>
    kfree(p);
80102460:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102466:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102469:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010246f:	50                   	push   %eax
80102470:	e8 cb fe ff ff       	call   80102340 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102475:	83 c4 10             	add    $0x10,%esp
80102478:	39 de                	cmp    %ebx,%esi
8010247a:	73 e4                	jae    80102460 <kinit1+0x40>
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}
8010247c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010247f:	5b                   	pop    %ebx
80102480:	5e                   	pop    %esi
80102481:	5d                   	pop    %ebp
80102482:	c3                   	ret    
80102483:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102489:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102490 <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102495:	8b 45 08             	mov    0x8(%ebp),%eax
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
80102498:	8b 75 0c             	mov    0xc(%ebp),%esi

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
8010249b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801024a1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024a7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801024ad:	39 de                	cmp    %ebx,%esi
801024af:	72 23                	jb     801024d4 <kinit2+0x44>
801024b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024b8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024be:	83 ec 0c             	sub    $0xc,%esp
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024c1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024c7:	50                   	push   %eax
801024c8:	e8 73 fe ff ff       	call   80102340 <kfree>
void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024cd:	83 c4 10             	add    $0x10,%esp
801024d0:	39 de                	cmp    %ebx,%esi
801024d2:	73 e4                	jae    801024b8 <kinit2+0x28>

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
801024d4:	c7 05 94 26 11 80 01 	movl   $0x1,0x80112694
801024db:	00 00 00 
}
801024de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024e1:	5b                   	pop    %ebx
801024e2:	5e                   	pop    %esi
801024e3:	5d                   	pop    %ebp
801024e4:	c3                   	ret    
801024e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024f0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801024f0:	55                   	push   %ebp
801024f1:	89 e5                	mov    %esp,%ebp
801024f3:	53                   	push   %ebx
801024f4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801024f7:	a1 94 26 11 80       	mov    0x80112694,%eax
801024fc:	85 c0                	test   %eax,%eax
801024fe:	75 30                	jne    80102530 <kalloc+0x40>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102500:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102506:	85 db                	test   %ebx,%ebx
80102508:	74 1c                	je     80102526 <kalloc+0x36>
    kmem.freelist = r->next;
8010250a:	8b 13                	mov    (%ebx),%edx
8010250c:	89 15 98 26 11 80    	mov    %edx,0x80112698
  if(kmem.use_lock)
80102512:	85 c0                	test   %eax,%eax
80102514:	74 10                	je     80102526 <kalloc+0x36>
    release(&kmem.lock);
80102516:	83 ec 0c             	sub    $0xc,%esp
80102519:	68 60 26 11 80       	push   $0x80112660
8010251e:	e8 8d 1f 00 00       	call   801044b0 <release>
80102523:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
}
80102526:	89 d8                	mov    %ebx,%eax
80102528:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010252b:	c9                   	leave  
8010252c:	c3                   	ret    
8010252d:	8d 76 00             	lea    0x0(%esi),%esi
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
80102530:	83 ec 0c             	sub    $0xc,%esp
80102533:	68 60 26 11 80       	push   $0x80112660
80102538:	e8 93 1d 00 00       	call   801042d0 <acquire>
  r = kmem.freelist;
8010253d:	8b 1d 98 26 11 80    	mov    0x80112698,%ebx
  if(r)
80102543:	83 c4 10             	add    $0x10,%esp
80102546:	a1 94 26 11 80       	mov    0x80112694,%eax
8010254b:	85 db                	test   %ebx,%ebx
8010254d:	75 bb                	jne    8010250a <kalloc+0x1a>
8010254f:	eb c1                	jmp    80102512 <kalloc+0x22>
80102551:	66 90                	xchg   %ax,%ax
80102553:	66 90                	xchg   %ax,%ax
80102555:	66 90                	xchg   %ax,%ax
80102557:	66 90                	xchg   %ax,%ax
80102559:	66 90                	xchg   %ax,%ax
8010255b:	66 90                	xchg   %ax,%ax
8010255d:	66 90                	xchg   %ax,%ax
8010255f:	90                   	nop

80102560 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102560:	55                   	push   %ebp
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102561:	ba 64 00 00 00       	mov    $0x64,%edx
80102566:	89 e5                	mov    %esp,%ebp
80102568:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102569:	a8 01                	test   $0x1,%al
8010256b:	0f 84 af 00 00 00    	je     80102620 <kbdgetc+0xc0>
80102571:	ba 60 00 00 00       	mov    $0x60,%edx
80102576:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102577:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
8010257a:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102580:	74 7e                	je     80102600 <kbdgetc+0xa0>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102582:	84 c0                	test   %al,%al
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102584:	8b 0d b4 a5 10 80    	mov    0x8010a5b4,%ecx
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
8010258a:	79 24                	jns    801025b0 <kbdgetc+0x50>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
8010258c:	f6 c1 40             	test   $0x40,%cl
8010258f:	75 05                	jne    80102596 <kbdgetc+0x36>
80102591:	89 c2                	mov    %eax,%edx
80102593:	83 e2 7f             	and    $0x7f,%edx
    shift &= ~(shiftcode[data] | E0ESC);
80102596:	0f b6 82 a0 76 10 80 	movzbl -0x7fef8960(%edx),%eax
8010259d:	83 c8 40             	or     $0x40,%eax
801025a0:	0f b6 c0             	movzbl %al,%eax
801025a3:	f7 d0                	not    %eax
801025a5:	21 c8                	and    %ecx,%eax
801025a7:	a3 b4 a5 10 80       	mov    %eax,0x8010a5b4
    return 0;
801025ac:	31 c0                	xor    %eax,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025ae:	5d                   	pop    %ebp
801025af:	c3                   	ret    
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801025b0:	f6 c1 40             	test   $0x40,%cl
801025b3:	74 09                	je     801025be <kbdgetc+0x5e>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025b5:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801025b8:	83 e1 bf             	and    $0xffffffbf,%ecx
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801025bb:	0f b6 d0             	movzbl %al,%edx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025be:	0f b6 82 a0 76 10 80 	movzbl -0x7fef8960(%edx),%eax
801025c5:	09 c1                	or     %eax,%ecx
801025c7:	0f b6 82 a0 75 10 80 	movzbl -0x7fef8a60(%edx),%eax
801025ce:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025d0:	89 c8                	mov    %ecx,%eax
    data |= 0x80;
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
801025d2:	89 0d b4 a5 10 80    	mov    %ecx,0x8010a5b4
  c = charcode[shift & (CTL | SHIFT)][data];
801025d8:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025db:	83 e1 08             	and    $0x8,%ecx
    shift &= ~E0ESC;
  }

  shift |= shiftcode[data];
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
801025de:	8b 04 85 80 75 10 80 	mov    -0x7fef8a80(,%eax,4),%eax
801025e5:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025e9:	74 c3                	je     801025ae <kbdgetc+0x4e>
    if('a' <= c && c <= 'z')
801025eb:	8d 50 9f             	lea    -0x61(%eax),%edx
801025ee:	83 fa 19             	cmp    $0x19,%edx
801025f1:	77 1d                	ja     80102610 <kbdgetc+0xb0>
      c += 'A' - 'a';
801025f3:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025f6:	5d                   	pop    %ebp
801025f7:	c3                   	ret    
801025f8:	90                   	nop
801025f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
    return 0;
80102600:	31 c0                	xor    %eax,%eax
  if((st & KBS_DIB) == 0)
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102602:	83 0d b4 a5 10 80 40 	orl    $0x40,0x8010a5b4
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102609:	5d                   	pop    %ebp
8010260a:	c3                   	ret    
8010260b:	90                   	nop
8010260c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  shift ^= togglecode[data];
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
80102610:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102613:	8d 50 20             	lea    0x20(%eax),%edx
  }
  return c;
}
80102616:	5d                   	pop    %ebp
  c = charcode[shift & (CTL | SHIFT)][data];
  if(shift & CAPSLOCK){
    if('a' <= c && c <= 'z')
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
80102617:	83 f9 19             	cmp    $0x19,%ecx
8010261a:	0f 46 c2             	cmovbe %edx,%eax
  }
  return c;
}
8010261d:	c3                   	ret    
8010261e:	66 90                	xchg   %ax,%ax
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
    return -1;
80102620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      c += 'A' - 'a';
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102625:	5d                   	pop    %ebp
80102626:	c3                   	ret    
80102627:	89 f6                	mov    %esi,%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kbdintr>:

void
kbdintr(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102636:	68 60 25 10 80       	push   $0x80102560
8010263b:	e8 b0 e1 ff ff       	call   801007f0 <consoleintr>
}
80102640:	83 c4 10             	add    $0x10,%esp
80102643:	c9                   	leave  
80102644:	c3                   	ret    
80102645:	66 90                	xchg   %ax,%ax
80102647:	66 90                	xchg   %ax,%ax
80102649:	66 90                	xchg   %ax,%ax
8010264b:	66 90                	xchg   %ax,%ax
8010264d:	66 90                	xchg   %ax,%ax
8010264f:	90                   	nop

80102650 <lapicinit>:
//PAGEBREAK!

void
lapicinit(void)
{
  if(!lapic)
80102650:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}
//PAGEBREAK!

void
lapicinit(void)
{
80102655:	55                   	push   %ebp
80102656:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102658:	85 c0                	test   %eax,%eax
8010265a:	0f 84 c8 00 00 00    	je     80102728 <lapicinit+0xd8>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102660:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102667:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266a:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010266d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102677:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010267a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102681:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102684:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102687:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010268e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102691:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102694:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010269b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ae:	8b 50 30             	mov    0x30(%eax),%edx
801026b1:	c1 ea 10             	shr    $0x10,%edx
801026b4:	80 fa 03             	cmp    $0x3,%dl
801026b7:	77 77                	ja     80102730 <lapicinit+0xe0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c3:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d0:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026dd:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ea:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f7:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801026fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102701:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102704:	8b 50 20             	mov    0x20(%eax),%edx
80102707:	89 f6                	mov    %esi,%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102710:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102716:	80 e6 10             	and    $0x10,%dh
80102719:	75 f5                	jne    80102710 <lapicinit+0xc0>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010271b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102722:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102725:	8b 40 20             	mov    0x20(%eax),%eax
  while(lapic[ICRLO] & DELIVS)
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102728:	5d                   	pop    %ebp
80102729:	c3                   	ret    
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102730:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102737:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx
8010273d:	e9 77 ff ff ff       	jmp    801026b9 <lapicinit+0x69>
80102742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <cpunum>:
  lapicw(TPR, 0);
}

int
cpunum(void)
{
80102750:	55                   	push   %ebp
80102751:	89 e5                	mov    %esp,%ebp
80102753:	56                   	push   %esi
80102754:	53                   	push   %ebx

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80102755:	9c                   	pushf  
80102756:	58                   	pop    %eax
  // Cannot call cpu when interrupts are enabled:
  // result not guaranteed to last long enough to be used!
  // Would prefer to panic but even printing is chancy here:
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
80102757:	f6 c4 02             	test   $0x2,%ah
8010275a:	74 12                	je     8010276e <cpunum+0x1e>
    static int n;
    if(n++ == 0)
8010275c:	a1 b8 a5 10 80       	mov    0x8010a5b8,%eax
80102761:	8d 50 01             	lea    0x1(%eax),%edx
80102764:	85 c0                	test   %eax,%eax
80102766:	89 15 b8 a5 10 80    	mov    %edx,0x8010a5b8
8010276c:	74 4d                	je     801027bb <cpunum+0x6b>
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
8010276e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102773:	85 c0                	test   %eax,%eax
80102775:	74 60                	je     801027d7 <cpunum+0x87>
    return 0;

  apicid = lapic[ID] >> 24;
80102777:	8b 58 20             	mov    0x20(%eax),%ebx
  for (i = 0; i < ncpu; ++i) {
8010277a:	8b 35 80 2d 11 80    	mov    0x80112d80,%esi
  }

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
80102780:	c1 eb 18             	shr    $0x18,%ebx
  for (i = 0; i < ncpu; ++i) {
80102783:	85 f6                	test   %esi,%esi
80102785:	7e 59                	jle    801027e0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
80102787:	0f b6 05 a0 27 11 80 	movzbl 0x801127a0,%eax
8010278e:	39 c3                	cmp    %eax,%ebx
80102790:	74 45                	je     801027d7 <cpunum+0x87>
80102792:	ba 5c 28 11 80       	mov    $0x8011285c,%edx
80102797:	31 c0                	xor    %eax,%eax
80102799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  if (!lapic)
    return 0;

  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
801027a0:	83 c0 01             	add    $0x1,%eax
801027a3:	39 f0                	cmp    %esi,%eax
801027a5:	74 39                	je     801027e0 <cpunum+0x90>
    if (cpus[i].apicid == apicid)
801027a7:	0f b6 0a             	movzbl (%edx),%ecx
801027aa:	81 c2 bc 00 00 00    	add    $0xbc,%edx
801027b0:	39 cb                	cmp    %ecx,%ebx
801027b2:	75 ec                	jne    801027a0 <cpunum+0x50>
      return i;
  }
  panic("unknown apicid\n");
}
801027b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027b7:	5b                   	pop    %ebx
801027b8:	5e                   	pop    %esi
801027b9:	5d                   	pop    %ebp
801027ba:	c3                   	ret    
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
801027bb:	83 ec 08             	sub    $0x8,%esp
801027be:	ff 75 04             	pushl  0x4(%ebp)
801027c1:	68 a0 77 10 80       	push   $0x801077a0
801027c6:	e8 95 de ff ff       	call   80100660 <cprintf>
        __builtin_return_address(0));
  }

  if (!lapic)
801027cb:	a1 9c 26 11 80       	mov    0x8011269c,%eax
  // almost everything, including cprintf and panic, calls cpu,
  // often indirectly through acquire and release.
  if(readeflags()&FL_IF){
    static int n;
    if(n++ == 0)
      cprintf("cpu called from %x with interrupts enabled\n",
801027d0:	83 c4 10             	add    $0x10,%esp
        __builtin_return_address(0));
  }

  if (!lapic)
801027d3:	85 c0                	test   %eax,%eax
801027d5:	75 a0                	jne    80102777 <cpunum+0x27>
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
801027d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
      cprintf("cpu called from %x with interrupts enabled\n",
        __builtin_return_address(0));
  }

  if (!lapic)
    return 0;
801027da:	31 c0                	xor    %eax,%eax
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
}
801027dc:	5b                   	pop    %ebx
801027dd:	5e                   	pop    %esi
801027de:	5d                   	pop    %ebp
801027df:	c3                   	ret    
  apicid = lapic[ID] >> 24;
  for (i = 0; i < ncpu; ++i) {
    if (cpus[i].apicid == apicid)
      return i;
  }
  panic("unknown apicid\n");
801027e0:	83 ec 0c             	sub    $0xc,%esp
801027e3:	68 cc 77 10 80       	push   $0x801077cc
801027e8:	e8 83 db ff ff       	call   80100370 <panic>
801027ed:	8d 76 00             	lea    0x0(%esi),%esi

801027f0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801027f0:	a1 9c 26 11 80       	mov    0x8011269c,%eax
}

// Acknowledge interrupt.
void
lapiceoi(void)
{
801027f5:	55                   	push   %ebp
801027f6:	89 e5                	mov    %esp,%ebp
  if(lapic)
801027f8:	85 c0                	test   %eax,%eax
801027fa:	74 0d                	je     80102809 <lapiceoi+0x19>
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801027fc:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102803:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102806:	8b 40 20             	mov    0x20(%eax),%eax
void
lapiceoi(void)
{
  if(lapic)
    lapicw(EOI, 0);
}
80102809:	5d                   	pop    %ebp
8010280a:	c3                   	ret    
8010280b:	90                   	nop
8010280c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102810 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102810:	55                   	push   %ebp
80102811:	89 e5                	mov    %esp,%ebp
}
80102813:	5d                   	pop    %ebp
80102814:	c3                   	ret    
80102815:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102819:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102820 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102820:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102821:	ba 70 00 00 00       	mov    $0x70,%edx
80102826:	b8 0f 00 00 00       	mov    $0xf,%eax
8010282b:	89 e5                	mov    %esp,%ebp
8010282d:	53                   	push   %ebx
8010282e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102831:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102834:	ee                   	out    %al,(%dx)
80102835:	ba 71 00 00 00       	mov    $0x71,%edx
8010283a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010283f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102840:	31 c0                	xor    %eax,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102842:	c1 e3 18             	shl    $0x18,%ebx
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102845:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010284b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010284d:	c1 e9 0c             	shr    $0xc,%ecx
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102850:	c1 e8 04             	shr    $0x4,%eax
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102853:	89 da                	mov    %ebx,%edx
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102855:	80 cd 06             	or     $0x6,%ch
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
  wrv[1] = addr >> 4;
80102858:	66 a3 69 04 00 80    	mov    %ax,0x80000469
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010285e:	a1 9c 26 11 80       	mov    0x8011269c,%eax
80102863:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102869:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010286c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102873:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102876:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102879:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102880:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102883:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102886:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010288c:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
8010288f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102895:	8b 58 20             	mov    0x20(%eax),%ebx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
80102898:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010289e:	8b 50 20             	mov    0x20(%eax),%edx
volatile uint *lapic;  // Initialized in mp.c

static void
lapicw(int index, int value)
{
  lapic[index] = value;
801028a1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801028a7:	8b 40 20             	mov    0x20(%eax),%eax
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
    microdelay(200);
  }
}
801028aa:	5b                   	pop    %ebx
801028ab:	5d                   	pop    %ebp
801028ac:	c3                   	ret    
801028ad:	8d 76 00             	lea    0x0(%esi),%esi

801028b0 <cmostime>:
  r->year   = cmos_read(YEAR);
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void cmostime(struct rtcdate *r)
{
801028b0:	55                   	push   %ebp
801028b1:	ba 70 00 00 00       	mov    $0x70,%edx
801028b6:	b8 0b 00 00 00       	mov    $0xb,%eax
801028bb:	89 e5                	mov    %esp,%ebp
801028bd:	57                   	push   %edi
801028be:	56                   	push   %esi
801028bf:	53                   	push   %ebx
801028c0:	83 ec 4c             	sub    $0x4c,%esp
801028c3:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c4:	ba 71 00 00 00       	mov    $0x71,%edx
801028c9:	ec                   	in     (%dx),%al
801028ca:	83 e0 04             	and    $0x4,%eax
801028cd:	8d 75 d0             	lea    -0x30(%ebp),%esi
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028d0:	31 db                	xor    %ebx,%ebx
801028d2:	88 45 b7             	mov    %al,-0x49(%ebp)
801028d5:	bf 70 00 00 00       	mov    $0x70,%edi
801028da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801028e0:	89 d8                	mov    %ebx,%eax
801028e2:	89 fa                	mov    %edi,%edx
801028e4:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028e5:	b9 71 00 00 00       	mov    $0x71,%ecx
801028ea:	89 ca                	mov    %ecx,%edx
801028ec:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
801028ed:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f0:	89 fa                	mov    %edi,%edx
801028f2:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028f5:	b8 02 00 00 00       	mov    $0x2,%eax
801028fa:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fb:	89 ca                	mov    %ecx,%edx
801028fd:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
801028fe:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102901:	89 fa                	mov    %edi,%edx
80102903:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102906:	b8 04 00 00 00       	mov    $0x4,%eax
8010290b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290c:	89 ca                	mov    %ecx,%edx
8010290e:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
8010290f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102912:	89 fa                	mov    %edi,%edx
80102914:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102917:	b8 07 00 00 00       	mov    $0x7,%eax
8010291c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291d:	89 ca                	mov    %ecx,%edx
8010291f:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102920:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102923:	89 fa                	mov    %edi,%edx
80102925:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102928:	b8 08 00 00 00       	mov    $0x8,%eax
8010292d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010292e:	89 ca                	mov    %ecx,%edx
80102930:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
80102931:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102934:	89 fa                	mov    %edi,%edx
80102936:	89 45 c8             	mov    %eax,-0x38(%ebp)
80102939:	b8 09 00 00 00       	mov    $0x9,%eax
8010293e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010293f:	89 ca                	mov    %ecx,%edx
80102941:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
80102942:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102945:	89 fa                	mov    %edi,%edx
80102947:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010294a:	b8 0a 00 00 00       	mov    $0xa,%eax
8010294f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102950:	89 ca                	mov    %ecx,%edx
80102952:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102953:	84 c0                	test   %al,%al
80102955:	78 89                	js     801028e0 <cmostime+0x30>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102957:	89 d8                	mov    %ebx,%eax
80102959:	89 fa                	mov    %edi,%edx
8010295b:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010295c:	89 ca                	mov    %ecx,%edx
8010295e:	ec                   	in     (%dx),%al
  return inb(CMOS_RETURN);
}

static void fill_rtcdate(struct rtcdate *r)
{
  r->second = cmos_read(SECS);
8010295f:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102962:	89 fa                	mov    %edi,%edx
80102964:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102967:	b8 02 00 00 00       	mov    $0x2,%eax
8010296c:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010296d:	89 ca                	mov    %ecx,%edx
8010296f:	ec                   	in     (%dx),%al
  r->minute = cmos_read(MINS);
80102970:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102973:	89 fa                	mov    %edi,%edx
80102975:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102978:	b8 04 00 00 00       	mov    $0x4,%eax
8010297d:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010297e:	89 ca                	mov    %ecx,%edx
80102980:	ec                   	in     (%dx),%al
  r->hour   = cmos_read(HOURS);
80102981:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102984:	89 fa                	mov    %edi,%edx
80102986:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102989:	b8 07 00 00 00       	mov    $0x7,%eax
8010298e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010298f:	89 ca                	mov    %ecx,%edx
80102991:	ec                   	in     (%dx),%al
  r->day    = cmos_read(DAY);
80102992:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102995:	89 fa                	mov    %edi,%edx
80102997:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010299a:	b8 08 00 00 00       	mov    $0x8,%eax
8010299f:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029a0:	89 ca                	mov    %ecx,%edx
801029a2:	ec                   	in     (%dx),%al
  r->month  = cmos_read(MONTH);
801029a3:	0f b6 c0             	movzbl %al,%eax
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029a6:	89 fa                	mov    %edi,%edx
801029a8:	89 45 e0             	mov    %eax,-0x20(%ebp)
801029ab:	b8 09 00 00 00       	mov    $0x9,%eax
801029b0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801029b1:	89 ca                	mov    %ecx,%edx
801029b3:	ec                   	in     (%dx),%al
  r->year   = cmos_read(YEAR);
801029b4:	0f b6 c0             	movzbl %al,%eax
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029b7:	83 ec 04             	sub    $0x4,%esp
  r->second = cmos_read(SECS);
  r->minute = cmos_read(MINS);
  r->hour   = cmos_read(HOURS);
  r->day    = cmos_read(DAY);
  r->month  = cmos_read(MONTH);
  r->year   = cmos_read(YEAR);
801029ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801029bd:	8d 45 b8             	lea    -0x48(%ebp),%eax
801029c0:	6a 18                	push   $0x18
801029c2:	56                   	push   %esi
801029c3:	50                   	push   %eax
801029c4:	e8 87 1b 00 00       	call   80104550 <memcmp>
801029c9:	83 c4 10             	add    $0x10,%esp
801029cc:	85 c0                	test   %eax,%eax
801029ce:	0f 85 0c ff ff ff    	jne    801028e0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
801029d4:	80 7d b7 00          	cmpb   $0x0,-0x49(%ebp)
801029d8:	75 78                	jne    80102a52 <cmostime+0x1a2>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801029da:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029dd:	89 c2                	mov    %eax,%edx
801029df:	83 e0 0f             	and    $0xf,%eax
801029e2:	c1 ea 04             	shr    $0x4,%edx
801029e5:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029e8:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029eb:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
801029ee:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029f1:	89 c2                	mov    %eax,%edx
801029f3:	83 e0 0f             	and    $0xf,%eax
801029f6:	c1 ea 04             	shr    $0x4,%edx
801029f9:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029fc:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ff:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102a02:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a05:	89 c2                	mov    %eax,%edx
80102a07:	83 e0 0f             	and    $0xf,%eax
80102a0a:	c1 ea 04             	shr    $0x4,%edx
80102a0d:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a10:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a13:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102a16:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a19:	89 c2                	mov    %eax,%edx
80102a1b:	83 e0 0f             	and    $0xf,%eax
80102a1e:	c1 ea 04             	shr    $0x4,%edx
80102a21:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a24:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a27:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102a2a:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a2d:	89 c2                	mov    %eax,%edx
80102a2f:	83 e0 0f             	and    $0xf,%eax
80102a32:	c1 ea 04             	shr    $0x4,%edx
80102a35:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a38:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a3b:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102a3e:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a41:	89 c2                	mov    %eax,%edx
80102a43:	83 e0 0f             	and    $0xf,%eax
80102a46:	c1 ea 04             	shr    $0x4,%edx
80102a49:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102a4c:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102a4f:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102a52:	8b 75 08             	mov    0x8(%ebp),%esi
80102a55:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102a58:	89 06                	mov    %eax,(%esi)
80102a5a:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102a5d:	89 46 04             	mov    %eax,0x4(%esi)
80102a60:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102a63:	89 46 08             	mov    %eax,0x8(%esi)
80102a66:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102a69:	89 46 0c             	mov    %eax,0xc(%esi)
80102a6c:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a6f:	89 46 10             	mov    %eax,0x10(%esi)
80102a72:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a75:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a78:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a82:	5b                   	pop    %ebx
80102a83:	5e                   	pop    %esi
80102a84:	5f                   	pop    %edi
80102a85:	5d                   	pop    %ebp
80102a86:	c3                   	ret    
80102a87:	66 90                	xchg   %ax,%ax
80102a89:	66 90                	xchg   %ax,%ax
80102a8b:	66 90                	xchg   %ax,%ax
80102a8d:	66 90                	xchg   %ax,%ax
80102a8f:	90                   	nop

80102a90 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a90:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102a96:	85 c9                	test   %ecx,%ecx
80102a98:	0f 8e 85 00 00 00    	jle    80102b23 <install_trans+0x93>
}

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80102a9e:	55                   	push   %ebp
80102a9f:	89 e5                	mov    %esp,%ebp
80102aa1:	57                   	push   %edi
80102aa2:	56                   	push   %esi
80102aa3:	53                   	push   %ebx
80102aa4:	31 db                	xor    %ebx,%ebx
80102aa6:	83 ec 0c             	sub    $0xc,%esp
80102aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102ab0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102ab5:	83 ec 08             	sub    $0x8,%esp
80102ab8:	01 d8                	add    %ebx,%eax
80102aba:	83 c0 01             	add    $0x1,%eax
80102abd:	50                   	push   %eax
80102abe:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102ac4:	e8 07 d6 ff ff       	call   801000d0 <bread>
80102ac9:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102acb:	58                   	pop    %eax
80102acc:	5a                   	pop    %edx
80102acd:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102ad4:	ff 35 e4 26 11 80    	pushl  0x801126e4
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102ada:	83 c3 01             	add    $0x1,%ebx
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102add:	e8 ee d5 ff ff       	call   801000d0 <bread>
80102ae2:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102ae4:	8d 47 5c             	lea    0x5c(%edi),%eax
80102ae7:	83 c4 0c             	add    $0xc,%esp
80102aea:	68 00 02 00 00       	push   $0x200
80102aef:	50                   	push   %eax
80102af0:	8d 46 5c             	lea    0x5c(%esi),%eax
80102af3:	50                   	push   %eax
80102af4:	e8 b7 1a 00 00       	call   801045b0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102af9:	89 34 24             	mov    %esi,(%esp)
80102afc:	e8 9f d6 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102b01:	89 3c 24             	mov    %edi,(%esp)
80102b04:	e8 d7 d6 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102b09:	89 34 24             	mov    %esi,(%esp)
80102b0c:	e8 cf d6 ff ff       	call   801001e0 <brelse>
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102b11:	83 c4 10             	add    $0x10,%esp
80102b14:	39 1d e8 26 11 80    	cmp    %ebx,0x801126e8
80102b1a:	7f 94                	jg     80102ab0 <install_trans+0x20>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    bwrite(dbuf);  // write dst to disk
    brelse(lbuf);
    brelse(dbuf);
  }
}
80102b1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b1f:	5b                   	pop    %ebx
80102b20:	5e                   	pop    %esi
80102b21:	5f                   	pop    %edi
80102b22:	5d                   	pop    %ebp
80102b23:	f3 c3                	repz ret 
80102b25:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102b30 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102b30:	55                   	push   %ebp
80102b31:	89 e5                	mov    %esp,%ebp
80102b33:	53                   	push   %ebx
80102b34:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102b37:	ff 35 d4 26 11 80    	pushl  0x801126d4
80102b3d:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102b43:	e8 88 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b48:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
  for (i = 0; i < log.lh.n; i++) {
80102b4e:	83 c4 10             	add    $0x10,%esp
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102b51:	89 c3                	mov    %eax,%ebx
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b53:	85 c9                	test   %ecx,%ecx
write_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102b55:	89 48 5c             	mov    %ecx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102b58:	7e 1f                	jle    80102b79 <write_head+0x49>
80102b5a:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
80102b61:	31 d2                	xor    %edx,%edx
80102b63:	90                   	nop
80102b64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102b68:	8b 8a ec 26 11 80    	mov    -0x7feed914(%edx),%ecx
80102b6e:	89 4c 13 60          	mov    %ecx,0x60(%ebx,%edx,1)
80102b72:	83 c2 04             	add    $0x4,%edx
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102b75:	39 c2                	cmp    %eax,%edx
80102b77:	75 ef                	jne    80102b68 <write_head+0x38>
    hb->block[i] = log.lh.block[i];
  }
  bwrite(buf);
80102b79:	83 ec 0c             	sub    $0xc,%esp
80102b7c:	53                   	push   %ebx
80102b7d:	e8 1e d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b82:	89 1c 24             	mov    %ebx,(%esp)
80102b85:	e8 56 d6 ff ff       	call   801001e0 <brelse>
}
80102b8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b8d:	c9                   	leave  
80102b8e:	c3                   	ret    
80102b8f:	90                   	nop

80102b90 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	53                   	push   %ebx
80102b94:	83 ec 2c             	sub    $0x2c,%esp
80102b97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80102b9a:	68 dc 77 10 80       	push   $0x801077dc
80102b9f:	68 a0 26 11 80       	push   $0x801126a0
80102ba4:	e8 07 17 00 00       	call   801042b0 <initlock>
  readsb(dev, &sb);
80102ba9:	58                   	pop    %eax
80102baa:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102bad:	5a                   	pop    %edx
80102bae:	50                   	push   %eax
80102baf:	53                   	push   %ebx
80102bb0:	e8 db e7 ff ff       	call   80101390 <readsb>
  log.start = sb.logstart;
  log.size = sb.nlog;
80102bb5:	8b 55 e8             	mov    -0x18(%ebp),%edx
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102bb8:	8b 45 ec             	mov    -0x14(%ebp),%eax

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bbb:	59                   	pop    %ecx
  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
80102bbc:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
80102bc2:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
  readsb(dev, &sb);
  log.start = sb.logstart;
80102bc8:	a3 d4 26 11 80       	mov    %eax,0x801126d4

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
80102bcd:	5a                   	pop    %edx
80102bce:	50                   	push   %eax
80102bcf:	53                   	push   %ebx
80102bd0:	e8 fb d4 ff ff       	call   801000d0 <bread>
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bd5:	8b 48 5c             	mov    0x5c(%eax),%ecx
  for (i = 0; i < log.lh.n; i++) {
80102bd8:	83 c4 10             	add    $0x10,%esp
80102bdb:	85 c9                	test   %ecx,%ecx
read_head(void)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
80102bdd:	89 0d e8 26 11 80    	mov    %ecx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
80102be3:	7e 1c                	jle    80102c01 <initlog+0x71>
80102be5:	8d 1c 8d 00 00 00 00 	lea    0x0(,%ecx,4),%ebx
80102bec:	31 d2                	xor    %edx,%edx
80102bee:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
80102bf0:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102bf4:	83 c2 04             	add    $0x4,%edx
80102bf7:	89 8a e8 26 11 80    	mov    %ecx,-0x7feed918(%edx)
{
  struct buf *buf = bread(log.dev, log.start);
  struct logheader *lh = (struct logheader *) (buf->data);
  int i;
  log.lh.n = lh->n;
  for (i = 0; i < log.lh.n; i++) {
80102bfd:	39 da                	cmp    %ebx,%edx
80102bff:	75 ef                	jne    80102bf0 <initlog+0x60>
    log.lh.block[i] = lh->block[i];
  }
  brelse(buf);
80102c01:	83 ec 0c             	sub    $0xc,%esp
80102c04:	50                   	push   %eax
80102c05:	e8 d6 d5 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102c0a:	e8 81 fe ff ff       	call   80102a90 <install_trans>
  log.lh.n = 0;
80102c0f:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102c16:	00 00 00 
  write_head(); // clear the log
80102c19:	e8 12 ff ff ff       	call   80102b30 <write_head>
  readsb(dev, &sb);
  log.start = sb.logstart;
  log.size = sb.nlog;
  log.dev = dev;
  recover_from_log();
}
80102c1e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c21:	c9                   	leave  
80102c22:	c3                   	ret    
80102c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c30 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102c36:	68 a0 26 11 80       	push   $0x801126a0
80102c3b:	e8 90 16 00 00       	call   801042d0 <acquire>
80102c40:	83 c4 10             	add    $0x10,%esp
80102c43:	eb 18                	jmp    80102c5d <begin_op+0x2d>
80102c45:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102c48:	83 ec 08             	sub    $0x8,%esp
80102c4b:	68 a0 26 11 80       	push   $0x801126a0
80102c50:	68 a0 26 11 80       	push   $0x801126a0
80102c55:	e8 f6 11 00 00       	call   80103e50 <sleep>
80102c5a:	83 c4 10             	add    $0x10,%esp
void
begin_op(void)
{
  acquire(&log.lock);
  while(1){
    if(log.committing){
80102c5d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80102c62:	85 c0                	test   %eax,%eax
80102c64:	75 e2                	jne    80102c48 <begin_op+0x18>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102c66:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102c6b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102c71:	83 c0 01             	add    $0x1,%eax
80102c74:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c77:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c7a:	83 fa 1e             	cmp    $0x1e,%edx
80102c7d:	7f c9                	jg     80102c48 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c7f:	83 ec 0c             	sub    $0xc,%esp
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
80102c82:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80102c87:	68 a0 26 11 80       	push   $0x801126a0
80102c8c:	e8 1f 18 00 00       	call   801044b0 <release>
      break;
    }
  }
}
80102c91:	83 c4 10             	add    $0x10,%esp
80102c94:	c9                   	leave  
80102c95:	c3                   	ret    
80102c96:	8d 76 00             	lea    0x0(%esi),%esi
80102c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102ca0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	57                   	push   %edi
80102ca4:	56                   	push   %esi
80102ca5:	53                   	push   %ebx
80102ca6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102ca9:	68 a0 26 11 80       	push   $0x801126a0
80102cae:	e8 1d 16 00 00       	call   801042d0 <acquire>
  log.outstanding -= 1;
80102cb3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
80102cb8:	8b 1d e0 26 11 80    	mov    0x801126e0,%ebx
80102cbe:	83 c4 10             	add    $0x10,%esp
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102cc1:	83 e8 01             	sub    $0x1,%eax
  if(log.committing)
80102cc4:	85 db                	test   %ebx,%ebx
end_op(void)
{
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
80102cc6:	a3 dc 26 11 80       	mov    %eax,0x801126dc
  if(log.committing)
80102ccb:	0f 85 23 01 00 00    	jne    80102df4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102cd1:	85 c0                	test   %eax,%eax
80102cd3:	0f 85 f7 00 00 00    	jne    80102dd0 <end_op+0x130>
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102cd9:	83 ec 0c             	sub    $0xc,%esp
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
80102cdc:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
80102ce3:	00 00 00 
}

static void
commit()
{
  if (log.lh.n > 0) {
80102ce6:	31 db                	xor    %ebx,%ebx
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
  }
  release(&log.lock);
80102ce8:	68 a0 26 11 80       	push   $0x801126a0
80102ced:	e8 be 17 00 00       	call   801044b0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102cf2:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80102cf8:	83 c4 10             	add    $0x10,%esp
80102cfb:	85 c9                	test   %ecx,%ecx
80102cfd:	0f 8e 8a 00 00 00    	jle    80102d8d <end_op+0xed>
80102d03:	90                   	nop
80102d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102d08:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80102d0d:	83 ec 08             	sub    $0x8,%esp
80102d10:	01 d8                	add    %ebx,%eax
80102d12:	83 c0 01             	add    $0x1,%eax
80102d15:	50                   	push   %eax
80102d16:	ff 35 e4 26 11 80    	pushl  0x801126e4
80102d1c:	e8 af d3 ff ff       	call   801000d0 <bread>
80102d21:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d23:	58                   	pop    %eax
80102d24:	5a                   	pop    %edx
80102d25:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80102d2c:	ff 35 e4 26 11 80    	pushl  0x801126e4
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d32:	83 c3 01             	add    $0x1,%ebx
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102d35:	e8 96 d3 ff ff       	call   801000d0 <bread>
80102d3a:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102d3c:	8d 40 5c             	lea    0x5c(%eax),%eax
80102d3f:	83 c4 0c             	add    $0xc,%esp
80102d42:	68 00 02 00 00       	push   $0x200
80102d47:	50                   	push   %eax
80102d48:	8d 46 5c             	lea    0x5c(%esi),%eax
80102d4b:	50                   	push   %eax
80102d4c:	e8 5f 18 00 00       	call   801045b0 <memmove>
    bwrite(to);  // write the log
80102d51:	89 34 24             	mov    %esi,(%esp)
80102d54:	e8 47 d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102d59:	89 3c 24             	mov    %edi,(%esp)
80102d5c:	e8 7f d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102d61:	89 34 24             	mov    %esi,(%esp)
80102d64:	e8 77 d4 ff ff       	call   801001e0 <brelse>
static void
write_log(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d69:	83 c4 10             	add    $0x10,%esp
80102d6c:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
80102d72:	7c 94                	jl     80102d08 <end_op+0x68>
static void
commit()
{
  if (log.lh.n > 0) {
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102d74:	e8 b7 fd ff ff       	call   80102b30 <write_head>
    install_trans(); // Now install writes to home locations
80102d79:	e8 12 fd ff ff       	call   80102a90 <install_trans>
    log.lh.n = 0;
80102d7e:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80102d85:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d88:	e8 a3 fd ff ff       	call   80102b30 <write_head>

  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
80102d8d:	83 ec 0c             	sub    $0xc,%esp
80102d90:	68 a0 26 11 80       	push   $0x801126a0
80102d95:	e8 36 15 00 00       	call   801042d0 <acquire>
    log.committing = 0;
    wakeup(&log);
80102d9a:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
  if(do_commit){
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
    acquire(&log.lock);
    log.committing = 0;
80102da1:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80102da8:	00 00 00 
    wakeup(&log);
80102dab:	e8 40 12 00 00       	call   80103ff0 <wakeup>
    release(&log.lock);
80102db0:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102db7:	e8 f4 16 00 00       	call   801044b0 <release>
80102dbc:	83 c4 10             	add    $0x10,%esp
  }
}
80102dbf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102dc2:	5b                   	pop    %ebx
80102dc3:	5e                   	pop    %esi
80102dc4:	5f                   	pop    %edi
80102dc5:	5d                   	pop    %ebp
80102dc6:	c3                   	ret    
80102dc7:	89 f6                	mov    %esi,%esi
80102dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(log.outstanding == 0){
    do_commit = 1;
    log.committing = 1;
  } else {
    // begin_op() may be waiting for log space.
    wakeup(&log);
80102dd0:	83 ec 0c             	sub    $0xc,%esp
80102dd3:	68 a0 26 11 80       	push   $0x801126a0
80102dd8:	e8 13 12 00 00       	call   80103ff0 <wakeup>
  }
  release(&log.lock);
80102ddd:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80102de4:	e8 c7 16 00 00       	call   801044b0 <release>
80102de9:	83 c4 10             	add    $0x10,%esp
    acquire(&log.lock);
    log.committing = 0;
    wakeup(&log);
    release(&log.lock);
  }
}
80102dec:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102def:	5b                   	pop    %ebx
80102df0:	5e                   	pop    %esi
80102df1:	5f                   	pop    %edi
80102df2:	5d                   	pop    %ebp
80102df3:	c3                   	ret    
  int do_commit = 0;

  acquire(&log.lock);
  log.outstanding -= 1;
  if(log.committing)
    panic("log.committing");
80102df4:	83 ec 0c             	sub    $0xc,%esp
80102df7:	68 e0 77 10 80       	push   $0x801077e0
80102dfc:	e8 6f d5 ff ff       	call   80100370 <panic>
80102e01:	eb 0d                	jmp    80102e10 <log_write>
80102e03:	90                   	nop
80102e04:	90                   	nop
80102e05:	90                   	nop
80102e06:	90                   	nop
80102e07:	90                   	nop
80102e08:	90                   	nop
80102e09:	90                   	nop
80102e0a:	90                   	nop
80102e0b:	90                   	nop
80102e0c:	90                   	nop
80102e0d:	90                   	nop
80102e0e:	90                   	nop
80102e0f:	90                   	nop

80102e10 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	53                   	push   %ebx
80102e14:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e17:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102e1d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102e20:	83 fa 1d             	cmp    $0x1d,%edx
80102e23:	0f 8f 97 00 00 00    	jg     80102ec0 <log_write+0xb0>
80102e29:	a1 d8 26 11 80       	mov    0x801126d8,%eax
80102e2e:	83 e8 01             	sub    $0x1,%eax
80102e31:	39 c2                	cmp    %eax,%edx
80102e33:	0f 8d 87 00 00 00    	jge    80102ec0 <log_write+0xb0>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102e39:	a1 dc 26 11 80       	mov    0x801126dc,%eax
80102e3e:	85 c0                	test   %eax,%eax
80102e40:	0f 8e 87 00 00 00    	jle    80102ecd <log_write+0xbd>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102e46:	83 ec 0c             	sub    $0xc,%esp
80102e49:	68 a0 26 11 80       	push   $0x801126a0
80102e4e:	e8 7d 14 00 00       	call   801042d0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102e53:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80102e59:	83 c4 10             	add    $0x10,%esp
80102e5c:	83 fa 00             	cmp    $0x0,%edx
80102e5f:	7e 50                	jle    80102eb1 <log_write+0xa1>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e61:	8b 4b 08             	mov    0x8(%ebx),%ecx
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e64:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102e66:	3b 0d ec 26 11 80    	cmp    0x801126ec,%ecx
80102e6c:	75 0b                	jne    80102e79 <log_write+0x69>
80102e6e:	eb 38                	jmp    80102ea8 <log_write+0x98>
80102e70:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
80102e77:	74 2f                	je     80102ea8 <log_write+0x98>
    panic("too big a transaction");
  if (log.outstanding < 1)
    panic("log_write outside of trans");

  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
80102e79:	83 c0 01             	add    $0x1,%eax
80102e7c:	39 d0                	cmp    %edx,%eax
80102e7e:	75 f0                	jne    80102e70 <log_write+0x60>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102e80:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e87:	83 c2 01             	add    $0x1,%edx
80102e8a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
  b->flags |= B_DIRTY; // prevent eviction
80102e90:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e93:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80102e9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e9d:	c9                   	leave  
  }
  log.lh.block[i] = b->blockno;
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
  release(&log.lock);
80102e9e:	e9 0d 16 00 00       	jmp    801044b0 <release>
80102ea3:	90                   	nop
80102ea4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  acquire(&log.lock);
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
      break;
  }
  log.lh.block[i] = b->blockno;
80102ea8:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
80102eaf:	eb df                	jmp    80102e90 <log_write+0x80>
80102eb1:	8b 43 08             	mov    0x8(%ebx),%eax
80102eb4:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
80102eb9:	75 d5                	jne    80102e90 <log_write+0x80>
80102ebb:	eb ca                	jmp    80102e87 <log_write+0x77>
80102ebd:	8d 76 00             	lea    0x0(%esi),%esi
log_write(struct buf *b)
{
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    panic("too big a transaction");
80102ec0:	83 ec 0c             	sub    $0xc,%esp
80102ec3:	68 ef 77 10 80       	push   $0x801077ef
80102ec8:	e8 a3 d4 ff ff       	call   80100370 <panic>
  if (log.outstanding < 1)
    panic("log_write outside of trans");
80102ecd:	83 ec 0c             	sub    $0xc,%esp
80102ed0:	68 05 78 10 80       	push   $0x80107805
80102ed5:	e8 96 d4 ff ff       	call   80100370 <panic>
80102eda:	66 90                	xchg   %ax,%ax
80102edc:	66 90                	xchg   %ax,%ax
80102ede:	66 90                	xchg   %ax,%ax

80102ee0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	83 ec 08             	sub    $0x8,%esp
  cprintf("cpu%d: starting\n", cpunum());
80102ee6:	e8 65 f8 ff ff       	call   80102750 <cpunum>
80102eeb:	83 ec 08             	sub    $0x8,%esp
80102eee:	50                   	push   %eax
80102eef:	68 20 78 10 80       	push   $0x80107820
80102ef4:	e8 67 d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102ef9:	e8 d2 2b 00 00       	call   80105ad0 <idtinit>
  xchg(&cpu->started, 1); // tell startothers() we're up
80102efe:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102f05:	b8 01 00 00 00       	mov    $0x1,%eax
80102f0a:	f0 87 82 a8 00 00 00 	lock xchg %eax,0xa8(%edx)
  scheduler();     // start running processes
80102f11:	e8 5a 0c 00 00       	call   80103b70 <scheduler>
80102f16:	8d 76 00             	lea    0x0(%esi),%esi
80102f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102f20 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102f26:	e8 b5 3d 00 00       	call   80106ce0 <switchkvm>
  seginit();
80102f2b:	e8 d0 3b 00 00       	call   80106b00 <seginit>
  lapicinit();
80102f30:	e8 1b f7 ff ff       	call   80102650 <lapicinit>
  mpmain();
80102f35:	e8 a6 ff ff ff       	call   80102ee0 <mpmain>
80102f3a:	66 90                	xchg   %ax,%ax
80102f3c:	66 90                	xchg   %ax,%ax
80102f3e:	66 90                	xchg   %ax,%ax

80102f40 <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
80102f40:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102f44:	83 e4 f0             	and    $0xfffffff0,%esp
80102f47:	ff 71 fc             	pushl  -0x4(%ecx)
80102f4a:	55                   	push   %ebp
80102f4b:	89 e5                	mov    %esp,%ebp
80102f4d:	53                   	push   %ebx
80102f4e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102f4f:	83 ec 08             	sub    $0x8,%esp
80102f52:	68 00 00 40 80       	push   $0x80400000
80102f57:	68 e8 55 11 80       	push   $0x801155e8
80102f5c:	e8 bf f4 ff ff       	call   80102420 <kinit1>
  kvmalloc();      // kernel page table
80102f61:	e8 5a 3d 00 00       	call   80106cc0 <kvmalloc>
  mpinit();        // detect other processors
80102f66:	e8 b5 01 00 00       	call   80103120 <mpinit>
  lapicinit();     // interrupt controller
80102f6b:	e8 e0 f6 ff ff       	call   80102650 <lapicinit>
  seginit();       // segment descriptors
80102f70:	e8 8b 3b 00 00       	call   80106b00 <seginit>
  cprintf("\ncpu%d: starting xv6\n\n", cpunum());
80102f75:	e8 d6 f7 ff ff       	call   80102750 <cpunum>
80102f7a:	5a                   	pop    %edx
80102f7b:	59                   	pop    %ecx
80102f7c:	50                   	push   %eax
80102f7d:	68 31 78 10 80       	push   $0x80107831
80102f82:	e8 d9 d6 ff ff       	call   80100660 <cprintf>
  picinit();       // another interrupt controller
80102f87:	e8 a4 03 00 00       	call   80103330 <picinit>
  ioapicinit();    // another interrupt controller
80102f8c:	e8 af f2 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102f91:	e8 0a da ff ff       	call   801009a0 <consoleinit>
  uartinit();      // serial port
80102f96:	e8 35 2e 00 00       	call   80105dd0 <uartinit>
  pinit();         // process table
80102f9b:	e8 30 09 00 00       	call   801038d0 <pinit>
  tvinit();        // trap vectors
80102fa0:	e8 8b 2a 00 00       	call   80105a30 <tvinit>
  binit();         // buffer cache
80102fa5:	e8 96 d0 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102faa:	e8 81 dd ff ff       	call   80100d30 <fileinit>
  ideinit();       // disk
80102faf:	e8 5c f0 ff ff       	call   80102010 <ideinit>
  if(!ismp)
80102fb4:	8b 1d 84 27 11 80    	mov    0x80112784,%ebx
80102fba:	83 c4 10             	add    $0x10,%esp
80102fbd:	85 db                	test   %ebx,%ebx
80102fbf:	0f 84 ca 00 00 00    	je     8010308f <main+0x14f>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fc5:	83 ec 04             	sub    $0x4,%esp

  for(c = cpus; c < cpus+ncpu; c++){
80102fc8:	bb a0 27 11 80       	mov    $0x801127a0,%ebx

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102fcd:	68 8a 00 00 00       	push   $0x8a
80102fd2:	68 8c a4 10 80       	push   $0x8010a48c
80102fd7:	68 00 70 00 80       	push   $0x80007000
80102fdc:	e8 cf 15 00 00       	call   801045b0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102fe1:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80102fe8:	00 00 00 
80102feb:	83 c4 10             	add    $0x10,%esp
80102fee:	05 a0 27 11 80       	add    $0x801127a0,%eax
80102ff3:	39 d8                	cmp    %ebx,%eax
80102ff5:	76 7c                	jbe    80103073 <main+0x133>
80102ff7:	89 f6                	mov    %esi,%esi
80102ff9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(c == cpus+cpunum())  // We've started already.
80103000:	e8 4b f7 ff ff       	call   80102750 <cpunum>
80103005:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
8010300b:	05 a0 27 11 80       	add    $0x801127a0,%eax
80103010:	39 c3                	cmp    %eax,%ebx
80103012:	74 46                	je     8010305a <main+0x11a>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103014:	e8 d7 f4 ff ff       	call   801024f0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103019:	83 ec 08             	sub    $0x8,%esp

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010301c:	05 00 10 00 00       	add    $0x1000,%eax
    *(void**)(code-8) = mpenter;
80103021:	c7 05 f8 6f 00 80 20 	movl   $0x80102f20,0x80006ff8
80103028:	2f 10 80 

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
    *(void**)(code-4) = stack + KSTACKSIZE;
8010302b:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    *(void**)(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103030:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
80103037:	90 10 00 

    lapicstartap(c->apicid, V2P(code));
8010303a:	68 00 70 00 00       	push   $0x7000
8010303f:	0f b6 03             	movzbl (%ebx),%eax
80103042:	50                   	push   %eax
80103043:	e8 d8 f7 ff ff       	call   80102820 <lapicstartap>
80103048:	83 c4 10             	add    $0x10,%esp
8010304b:	90                   	nop
8010304c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103050:	8b 83 a8 00 00 00    	mov    0xa8(%ebx),%eax
80103056:	85 c0                	test   %eax,%eax
80103058:	74 f6                	je     80103050 <main+0x110>
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);

  for(c = cpus; c < cpus+ncpu; c++){
8010305a:	69 05 80 2d 11 80 bc 	imul   $0xbc,0x80112d80,%eax
80103061:	00 00 00 
80103064:	81 c3 bc 00 00 00    	add    $0xbc,%ebx
8010306a:	05 a0 27 11 80       	add    $0x801127a0,%eax
8010306f:	39 c3                	cmp    %eax,%ebx
80103071:	72 8d                	jb     80103000 <main+0xc0>
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
  startothers();   // start other processors
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103073:	83 ec 08             	sub    $0x8,%esp
80103076:	68 00 00 00 8e       	push   $0x8e000000
8010307b:	68 00 00 40 80       	push   $0x80400000
80103080:	e8 0b f4 ff ff       	call   80102490 <kinit2>
  userinit();      // first user process
80103085:	e8 66 08 00 00       	call   801038f0 <userinit>
  mpmain();        // finish this processor's setup
8010308a:	e8 51 fe ff ff       	call   80102ee0 <mpmain>
  tvinit();        // trap vectors
  binit();         // buffer cache
  fileinit();      // file table
  ideinit();       // disk
  if(!ismp)
    timerinit();   // uniprocessor timer
8010308f:	e8 3c 29 00 00       	call   801059d0 <timerinit>
80103094:	e9 2c ff ff ff       	jmp    80102fc5 <main+0x85>
80103099:	66 90                	xchg   %ax,%ax
8010309b:	66 90                	xchg   %ax,%ax
8010309d:	66 90                	xchg   %ax,%ax
8010309f:	90                   	nop

801030a0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	57                   	push   %edi
801030a4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801030a5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030ab:	53                   	push   %ebx
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
801030ac:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801030af:	83 ec 0c             	sub    $0xc,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030b2:	39 de                	cmp    %ebx,%esi
801030b4:	73 48                	jae    801030fe <mpsearch1+0x5e>
801030b6:	8d 76 00             	lea    0x0(%esi),%esi
801030b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030c0:	83 ec 04             	sub    $0x4,%esp
801030c3:	8d 7e 10             	lea    0x10(%esi),%edi
801030c6:	6a 04                	push   $0x4
801030c8:	68 48 78 10 80       	push   $0x80107848
801030cd:	56                   	push   %esi
801030ce:	e8 7d 14 00 00       	call   80104550 <memcmp>
801030d3:	83 c4 10             	add    $0x10,%esp
801030d6:	85 c0                	test   %eax,%eax
801030d8:	75 1e                	jne    801030f8 <mpsearch1+0x58>
801030da:	8d 7e 10             	lea    0x10(%esi),%edi
801030dd:	89 f2                	mov    %esi,%edx
801030df:	31 c9                	xor    %ecx,%ecx
801030e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
    sum += addr[i];
801030e8:	0f b6 02             	movzbl (%edx),%eax
801030eb:	83 c2 01             	add    $0x1,%edx
801030ee:	01 c1                	add    %eax,%ecx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801030f0:	39 fa                	cmp    %edi,%edx
801030f2:	75 f4                	jne    801030e8 <mpsearch1+0x48>
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801030f4:	84 c9                	test   %cl,%cl
801030f6:	74 10                	je     80103108 <mpsearch1+0x68>
{
  uchar *e, *p, *addr;

  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
801030f8:	39 fb                	cmp    %edi,%ebx
801030fa:	89 fe                	mov    %edi,%esi
801030fc:	77 c2                	ja     801030c0 <mpsearch1+0x20>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
}
801030fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
  addr = P2V(a);
  e = addr+len;
  for(p = addr; p < e; p += sizeof(struct mp))
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
      return (struct mp*)p;
  return 0;
80103101:	31 c0                	xor    %eax,%eax
}
80103103:	5b                   	pop    %ebx
80103104:	5e                   	pop    %esi
80103105:	5f                   	pop    %edi
80103106:	5d                   	pop    %ebp
80103107:	c3                   	ret    
80103108:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010310b:	89 f0                	mov    %esi,%eax
8010310d:	5b                   	pop    %ebx
8010310e:	5e                   	pop    %esi
8010310f:	5f                   	pop    %edi
80103110:	5d                   	pop    %ebp
80103111:	c3                   	ret    
80103112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103120 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103120:	55                   	push   %ebp
80103121:	89 e5                	mov    %esp,%ebp
80103123:	57                   	push   %edi
80103124:	56                   	push   %esi
80103125:	53                   	push   %ebx
80103126:	83 ec 1c             	sub    $0x1c,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103129:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103130:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103137:	c1 e0 08             	shl    $0x8,%eax
8010313a:	09 d0                	or     %edx,%eax
8010313c:	c1 e0 04             	shl    $0x4,%eax
8010313f:	85 c0                	test   %eax,%eax
80103141:	75 1b                	jne    8010315e <mpinit+0x3e>
    if((mp = mpsearch1(p, 1024)))
      return mp;
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
80103143:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010314a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103151:	c1 e0 08             	shl    $0x8,%eax
80103154:	09 d0                	or     %edx,%eax
80103156:	c1 e0 0a             	shl    $0xa,%eax
80103159:	2d 00 04 00 00       	sub    $0x400,%eax
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
    if((mp = mpsearch1(p, 1024)))
8010315e:	ba 00 04 00 00       	mov    $0x400,%edx
80103163:	e8 38 ff ff ff       	call   801030a0 <mpsearch1>
80103168:	85 c0                	test   %eax,%eax
8010316a:	89 c6                	mov    %eax,%esi
8010316c:	0f 84 66 01 00 00    	je     801032d8 <mpinit+0x1b8>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103172:	8b 5e 04             	mov    0x4(%esi),%ebx
80103175:	85 db                	test   %ebx,%ebx
80103177:	0f 84 d6 00 00 00    	je     80103253 <mpinit+0x133>
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010317d:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103183:	83 ec 04             	sub    $0x4,%esp
80103186:	6a 04                	push   $0x4
80103188:	68 4d 78 10 80       	push   $0x8010784d
8010318d:	50                   	push   %eax
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
    return 0;
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010318e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103191:	e8 ba 13 00 00       	call   80104550 <memcmp>
80103196:	83 c4 10             	add    $0x10,%esp
80103199:	85 c0                	test   %eax,%eax
8010319b:	0f 85 b2 00 00 00    	jne    80103253 <mpinit+0x133>
    return 0;
  if(conf->version != 1 && conf->version != 4)
801031a1:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801031a8:	3c 01                	cmp    $0x1,%al
801031aa:	74 08                	je     801031b4 <mpinit+0x94>
801031ac:	3c 04                	cmp    $0x4,%al
801031ae:	0f 85 9f 00 00 00    	jne    80103253 <mpinit+0x133>
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031b4:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031bb:	85 ff                	test   %edi,%edi
801031bd:	74 1e                	je     801031dd <mpinit+0xbd>
801031bf:	31 d2                	xor    %edx,%edx
801031c1:	31 c0                	xor    %eax,%eax
801031c3:	90                   	nop
801031c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
801031c8:	0f b6 8c 03 00 00 00 	movzbl -0x80000000(%ebx,%eax,1),%ecx
801031cf:	80 
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031d0:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801031d3:	01 ca                	add    %ecx,%edx
sum(uchar *addr, int len)
{
  int i, sum;

  sum = 0;
  for(i=0; i<len; i++)
801031d5:	39 c7                	cmp    %eax,%edi
801031d7:	75 ef                	jne    801031c8 <mpinit+0xa8>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
  if(memcmp(conf, "PCMP", 4) != 0)
    return 0;
  if(conf->version != 1 && conf->version != 4)
    return 0;
  if(sum((uchar*)conf, conf->length) != 0)
801031d9:	84 d2                	test   %dl,%dl
801031db:	75 76                	jne    80103253 <mpinit+0x133>
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
801031dd:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801031e0:	85 ff                	test   %edi,%edi
801031e2:	74 6f                	je     80103253 <mpinit+0x133>
    return;
  ismp = 1;
801031e4:	c7 05 84 27 11 80 01 	movl   $0x1,0x80112784
801031eb:	00 00 00 
  lapic = (uint*)conf->lapicaddr;
801031ee:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
801031f4:	a3 9c 26 11 80       	mov    %eax,0x8011269c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801031f9:	0f b7 8b 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%ecx
80103200:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
80103206:	01 f9                	add    %edi,%ecx
80103208:	39 c8                	cmp    %ecx,%eax
8010320a:	0f 83 a0 00 00 00    	jae    801032b0 <mpinit+0x190>
    switch(*p){
80103210:	80 38 04             	cmpb   $0x4,(%eax)
80103213:	0f 87 87 00 00 00    	ja     801032a0 <mpinit+0x180>
80103219:	0f b6 10             	movzbl (%eax),%edx
8010321c:	ff 24 95 54 78 10 80 	jmp    *-0x7fef87ac(,%edx,4)
80103223:	90                   	nop
80103224:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103228:	83 c0 08             	add    $0x8,%eax

  if((conf = mpconfig(&mp)) == 0)
    return;
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010322b:	39 c1                	cmp    %eax,%ecx
8010322d:	77 e1                	ja     80103210 <mpinit+0xf0>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp){
8010322f:	a1 84 27 11 80       	mov    0x80112784,%eax
80103234:	85 c0                	test   %eax,%eax
80103236:	75 78                	jne    801032b0 <mpinit+0x190>
    // Didn't like what we found; fall back to no MP.
    ncpu = 1;
80103238:	c7 05 80 2d 11 80 01 	movl   $0x1,0x80112d80
8010323f:	00 00 00 
    lapic = 0;
80103242:	c7 05 9c 26 11 80 00 	movl   $0x0,0x8011269c
80103249:	00 00 00 
    ioapicid = 0;
8010324c:	c6 05 80 27 11 80 00 	movb   $0x0,0x80112780
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
80103253:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103256:	5b                   	pop    %ebx
80103257:	5e                   	pop    %esi
80103258:	5f                   	pop    %edi
80103259:	5d                   	pop    %ebp
8010325a:	c3                   	ret    
8010325b:	90                   	nop
8010325c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  lapic = (uint*)conf->lapicaddr;
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
80103260:	8b 15 80 2d 11 80    	mov    0x80112d80,%edx
80103266:	83 fa 07             	cmp    $0x7,%edx
80103269:	7f 19                	jg     80103284 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010326b:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
8010326f:	69 fa bc 00 00 00    	imul   $0xbc,%edx,%edi
        ncpu++;
80103275:	83 c2 01             	add    $0x1,%edx
80103278:	89 15 80 2d 11 80    	mov    %edx,0x80112d80
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
    switch(*p){
    case MPPROC:
      proc = (struct mpproc*)p;
      if(ncpu < NCPU) {
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010327e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
        ncpu++;
      }
      p += sizeof(struct mpproc);
80103284:	83 c0 14             	add    $0x14,%eax
      continue;
80103287:	eb a2                	jmp    8010322b <mpinit+0x10b>
80103289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103290:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
80103294:	83 c0 08             	add    $0x8,%eax
      }
      p += sizeof(struct mpproc);
      continue;
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
      ioapicid = ioapic->apicno;
80103297:	88 15 80 27 11 80    	mov    %dl,0x80112780
      p += sizeof(struct mpioapic);
      continue;
8010329d:	eb 8c                	jmp    8010322b <mpinit+0x10b>
8010329f:	90                   	nop
    case MPIOINTR:
    case MPLINTR:
      p += 8;
      continue;
    default:
      ismp = 0;
801032a0:	c7 05 84 27 11 80 00 	movl   $0x0,0x80112784
801032a7:	00 00 00 
      break;
801032aa:	e9 7c ff ff ff       	jmp    8010322b <mpinit+0x10b>
801032af:	90                   	nop
    lapic = 0;
    ioapicid = 0;
    return;
  }

  if(mp->imcrp){
801032b0:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801032b4:	74 9d                	je     80103253 <mpinit+0x133>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032b6:	ba 22 00 00 00       	mov    $0x22,%edx
801032bb:	b8 70 00 00 00       	mov    $0x70,%eax
801032c0:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801032c1:	ba 23 00 00 00       	mov    $0x23,%edx
801032c6:	ec                   	in     (%dx),%al
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801032c7:	83 c8 01             	or     $0x1,%eax
801032ca:	ee                   	out    %al,(%dx)
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
  }
}
801032cb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801032ce:	5b                   	pop    %ebx
801032cf:	5e                   	pop    %esi
801032d0:	5f                   	pop    %edi
801032d1:	5d                   	pop    %ebp
801032d2:	c3                   	ret    
801032d3:	90                   	nop
801032d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032d8:	ba 00 00 01 00       	mov    $0x10000,%edx
801032dd:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801032e2:	e8 b9 fd ff ff       	call   801030a0 <mpsearch1>
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032e7:	85 c0                	test   %eax,%eax
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
    if((mp = mpsearch1(p-1024, 1024)))
      return mp;
  }
  return mpsearch1(0xF0000, 0x10000);
801032e9:	89 c6                	mov    %eax,%esi
mpconfig(struct mp **pmp)
{
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801032eb:	0f 85 81 fe ff ff    	jne    80103172 <mpinit+0x52>
801032f1:	e9 5d ff ff ff       	jmp    80103253 <mpinit+0x133>
801032f6:	66 90                	xchg   %ax,%ax
801032f8:	66 90                	xchg   %ax,%ax
801032fa:	66 90                	xchg   %ax,%ax
801032fc:	66 90                	xchg   %ax,%ax
801032fe:	66 90                	xchg   %ax,%ax

80103300 <picenable>:
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
80103300:	55                   	push   %ebp
  picsetmask(irqmask & ~(1<<irq));
80103301:	b8 fe ff ff ff       	mov    $0xfffffffe,%eax
80103306:	ba 21 00 00 00       	mov    $0x21,%edx
  outb(IO_PIC2+1, mask >> 8);
}

void
picenable(int irq)
{
8010330b:	89 e5                	mov    %esp,%ebp
  picsetmask(irqmask & ~(1<<irq));
8010330d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103310:	d3 c0                	rol    %cl,%eax
80103312:	66 23 05 00 a0 10 80 	and    0x8010a000,%ax
static ushort irqmask = 0xFFFF & ~(1<<IRQ_SLAVE);

static void
picsetmask(ushort mask)
{
  irqmask = mask;
80103319:	66 a3 00 a0 10 80    	mov    %ax,0x8010a000
8010331f:	ee                   	out    %al,(%dx)
80103320:	ba a1 00 00 00       	mov    $0xa1,%edx
80103325:	66 c1 e8 08          	shr    $0x8,%ax
80103329:	ee                   	out    %al,(%dx)

void
picenable(int irq)
{
  picsetmask(irqmask & ~(1<<irq));
}
8010332a:	5d                   	pop    %ebp
8010332b:	c3                   	ret    
8010332c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103330 <picinit>:

// Initialize the 8259A interrupt controllers.
void
picinit(void)
{
80103330:	55                   	push   %ebp
80103331:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103336:	89 e5                	mov    %esp,%ebp
80103338:	57                   	push   %edi
80103339:	56                   	push   %esi
8010333a:	53                   	push   %ebx
8010333b:	bb 21 00 00 00       	mov    $0x21,%ebx
80103340:	89 da                	mov    %ebx,%edx
80103342:	ee                   	out    %al,(%dx)
80103343:	b9 a1 00 00 00       	mov    $0xa1,%ecx
80103348:	89 ca                	mov    %ecx,%edx
8010334a:	ee                   	out    %al,(%dx)
8010334b:	bf 11 00 00 00       	mov    $0x11,%edi
80103350:	be 20 00 00 00       	mov    $0x20,%esi
80103355:	89 f8                	mov    %edi,%eax
80103357:	89 f2                	mov    %esi,%edx
80103359:	ee                   	out    %al,(%dx)
8010335a:	b8 20 00 00 00       	mov    $0x20,%eax
8010335f:	89 da                	mov    %ebx,%edx
80103361:	ee                   	out    %al,(%dx)
80103362:	b8 04 00 00 00       	mov    $0x4,%eax
80103367:	ee                   	out    %al,(%dx)
80103368:	b8 03 00 00 00       	mov    $0x3,%eax
8010336d:	ee                   	out    %al,(%dx)
8010336e:	bb a0 00 00 00       	mov    $0xa0,%ebx
80103373:	89 f8                	mov    %edi,%eax
80103375:	89 da                	mov    %ebx,%edx
80103377:	ee                   	out    %al,(%dx)
80103378:	b8 28 00 00 00       	mov    $0x28,%eax
8010337d:	89 ca                	mov    %ecx,%edx
8010337f:	ee                   	out    %al,(%dx)
80103380:	b8 02 00 00 00       	mov    $0x2,%eax
80103385:	ee                   	out    %al,(%dx)
80103386:	b8 03 00 00 00       	mov    $0x3,%eax
8010338b:	ee                   	out    %al,(%dx)
8010338c:	bf 68 00 00 00       	mov    $0x68,%edi
80103391:	89 f2                	mov    %esi,%edx
80103393:	89 f8                	mov    %edi,%eax
80103395:	ee                   	out    %al,(%dx)
80103396:	b9 0a 00 00 00       	mov    $0xa,%ecx
8010339b:	89 c8                	mov    %ecx,%eax
8010339d:	ee                   	out    %al,(%dx)
8010339e:	89 f8                	mov    %edi,%eax
801033a0:	89 da                	mov    %ebx,%edx
801033a2:	ee                   	out    %al,(%dx)
801033a3:	89 c8                	mov    %ecx,%eax
801033a5:	ee                   	out    %al,(%dx)
  outb(IO_PIC1, 0x0a);             // read IRR by default

  outb(IO_PIC2, 0x68);             // OCW3
  outb(IO_PIC2, 0x0a);             // OCW3

  if(irqmask != 0xFFFF)
801033a6:	0f b7 05 00 a0 10 80 	movzwl 0x8010a000,%eax
801033ad:	66 83 f8 ff          	cmp    $0xffff,%ax
801033b1:	74 10                	je     801033c3 <picinit+0x93>
801033b3:	ba 21 00 00 00       	mov    $0x21,%edx
801033b8:	ee                   	out    %al,(%dx)
801033b9:	ba a1 00 00 00       	mov    $0xa1,%edx
801033be:	66 c1 e8 08          	shr    $0x8,%ax
801033c2:	ee                   	out    %al,(%dx)
    picsetmask(irqmask);
}
801033c3:	5b                   	pop    %ebx
801033c4:	5e                   	pop    %esi
801033c5:	5f                   	pop    %edi
801033c6:	5d                   	pop    %ebp
801033c7:	c3                   	ret    
801033c8:	66 90                	xchg   %ax,%ax
801033ca:	66 90                	xchg   %ax,%ax
801033cc:	66 90                	xchg   %ax,%ax
801033ce:	66 90                	xchg   %ax,%ax

801033d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801033d0:	55                   	push   %ebp
801033d1:	89 e5                	mov    %esp,%ebp
801033d3:	57                   	push   %edi
801033d4:	56                   	push   %esi
801033d5:	53                   	push   %ebx
801033d6:	83 ec 0c             	sub    $0xc,%esp
801033d9:	8b 75 08             	mov    0x8(%ebp),%esi
801033dc:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801033df:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801033e5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801033eb:	e8 60 d9 ff ff       	call   80100d50 <filealloc>
801033f0:	85 c0                	test   %eax,%eax
801033f2:	89 06                	mov    %eax,(%esi)
801033f4:	0f 84 a8 00 00 00    	je     801034a2 <pipealloc+0xd2>
801033fa:	e8 51 d9 ff ff       	call   80100d50 <filealloc>
801033ff:	85 c0                	test   %eax,%eax
80103401:	89 03                	mov    %eax,(%ebx)
80103403:	0f 84 87 00 00 00    	je     80103490 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103409:	e8 e2 f0 ff ff       	call   801024f0 <kalloc>
8010340e:	85 c0                	test   %eax,%eax
80103410:	89 c7                	mov    %eax,%edi
80103412:	0f 84 b0 00 00 00    	je     801034c8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103418:	83 ec 08             	sub    $0x8,%esp
  *f0 = *f1 = 0;
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
    goto bad;
  p->readopen = 1;
8010341b:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103422:	00 00 00 
  p->writeopen = 1;
80103425:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010342c:	00 00 00 
  p->nwrite = 0;
8010342f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103436:	00 00 00 
  p->nread = 0;
80103439:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103440:	00 00 00 
  initlock(&p->lock, "pipe");
80103443:	68 68 78 10 80       	push   $0x80107868
80103448:	50                   	push   %eax
80103449:	e8 62 0e 00 00       	call   801042b0 <initlock>
  (*f0)->type = FD_PIPE;
8010344e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103450:	83 c4 10             	add    $0x10,%esp
  p->readopen = 1;
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
  (*f0)->type = FD_PIPE;
80103453:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103459:	8b 06                	mov    (%esi),%eax
8010345b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010345f:	8b 06                	mov    (%esi),%eax
80103461:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103465:	8b 06                	mov    (%esi),%eax
80103467:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010346a:	8b 03                	mov    (%ebx),%eax
8010346c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103472:	8b 03                	mov    (%ebx),%eax
80103474:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103478:	8b 03                	mov    (%ebx),%eax
8010347a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010347e:	8b 03                	mov    (%ebx),%eax
80103480:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103483:	8d 65 f4             	lea    -0xc(%ebp),%esp
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103486:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103488:	5b                   	pop    %ebx
80103489:	5e                   	pop    %esi
8010348a:	5f                   	pop    %edi
8010348b:	5d                   	pop    %ebp
8010348c:	c3                   	ret    
8010348d:	8d 76 00             	lea    0x0(%esi),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
80103490:	8b 06                	mov    (%esi),%eax
80103492:	85 c0                	test   %eax,%eax
80103494:	74 1e                	je     801034b4 <pipealloc+0xe4>
    fileclose(*f0);
80103496:	83 ec 0c             	sub    $0xc,%esp
80103499:	50                   	push   %eax
8010349a:	e8 71 d9 ff ff       	call   80100e10 <fileclose>
8010349f:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801034a2:	8b 03                	mov    (%ebx),%eax
801034a4:	85 c0                	test   %eax,%eax
801034a6:	74 0c                	je     801034b4 <pipealloc+0xe4>
    fileclose(*f1);
801034a8:	83 ec 0c             	sub    $0xc,%esp
801034ab:	50                   	push   %eax
801034ac:	e8 5f d9 ff ff       	call   80100e10 <fileclose>
801034b1:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801034b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    kfree((char*)p);
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
801034b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801034bc:	5b                   	pop    %ebx
801034bd:	5e                   	pop    %esi
801034be:	5f                   	pop    %edi
801034bf:	5d                   	pop    %ebp
801034c0:	c3                   	ret    
801034c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
801034c8:	8b 06                	mov    (%esi),%eax
801034ca:	85 c0                	test   %eax,%eax
801034cc:	75 c8                	jne    80103496 <pipealloc+0xc6>
801034ce:	eb d2                	jmp    801034a2 <pipealloc+0xd2>

801034d0 <pipeclose>:
  return -1;
}

void
pipeclose(struct pipe *p, int writable)
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	56                   	push   %esi
801034d4:	53                   	push   %ebx
801034d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801034d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801034db:	83 ec 0c             	sub    $0xc,%esp
801034de:	53                   	push   %ebx
801034df:	e8 ec 0d 00 00       	call   801042d0 <acquire>
  if(writable){
801034e4:	83 c4 10             	add    $0x10,%esp
801034e7:	85 f6                	test   %esi,%esi
801034e9:	74 45                	je     80103530 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801034eb:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034f1:	83 ec 0c             	sub    $0xc,%esp
void
pipeclose(struct pipe *p, int writable)
{
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
801034f4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801034fb:	00 00 00 
    wakeup(&p->nread);
801034fe:	50                   	push   %eax
801034ff:	e8 ec 0a 00 00       	call   80103ff0 <wakeup>
80103504:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103507:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010350d:	85 d2                	test   %edx,%edx
8010350f:	75 0a                	jne    8010351b <pipeclose+0x4b>
80103511:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103517:	85 c0                	test   %eax,%eax
80103519:	74 35                	je     80103550 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010351b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010351e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103521:	5b                   	pop    %ebx
80103522:	5e                   	pop    %esi
80103523:	5d                   	pop    %ebp
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103524:	e9 87 0f 00 00       	jmp    801044b0 <release>
80103529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
80103530:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103536:	83 ec 0c             	sub    $0xc,%esp
  acquire(&p->lock);
  if(writable){
    p->writeopen = 0;
    wakeup(&p->nread);
  } else {
    p->readopen = 0;
80103539:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103540:	00 00 00 
    wakeup(&p->nwrite);
80103543:	50                   	push   %eax
80103544:	e8 a7 0a 00 00       	call   80103ff0 <wakeup>
80103549:	83 c4 10             	add    $0x10,%esp
8010354c:	eb b9                	jmp    80103507 <pipeclose+0x37>
8010354e:	66 90                	xchg   %ax,%ax
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
80103550:	83 ec 0c             	sub    $0xc,%esp
80103553:	53                   	push   %ebx
80103554:	e8 57 0f 00 00       	call   801044b0 <release>
    kfree((char*)p);
80103559:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010355c:	83 c4 10             	add    $0x10,%esp
  } else
    release(&p->lock);
}
8010355f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103562:	5b                   	pop    %ebx
80103563:	5e                   	pop    %esi
80103564:	5d                   	pop    %ebp
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
    release(&p->lock);
    kfree((char*)p);
80103565:	e9 d6 ed ff ff       	jmp    80102340 <kfree>
8010356a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103570 <pipewrite>:
}

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103570:	55                   	push   %ebp
80103571:	89 e5                	mov    %esp,%ebp
80103573:	57                   	push   %edi
80103574:	56                   	push   %esi
80103575:	53                   	push   %ebx
80103576:	83 ec 28             	sub    $0x28,%esp
80103579:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;

  acquire(&p->lock);
8010357c:	57                   	push   %edi
8010357d:	e8 4e 0d 00 00       	call   801042d0 <acquire>
  for(i = 0; i < n; i++){
80103582:	8b 45 10             	mov    0x10(%ebp),%eax
80103585:	83 c4 10             	add    $0x10,%esp
80103588:	85 c0                	test   %eax,%eax
8010358a:	0f 8e c6 00 00 00    	jle    80103656 <pipewrite+0xe6>
80103590:	8b 45 0c             	mov    0xc(%ebp),%eax
80103593:	8b 8f 38 02 00 00    	mov    0x238(%edi),%ecx
80103599:	8d b7 34 02 00 00    	lea    0x234(%edi),%esi
8010359f:	8d 9f 38 02 00 00    	lea    0x238(%edi),%ebx
801035a5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801035a8:	03 45 10             	add    0x10(%ebp),%eax
801035ab:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801035ae:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
801035b4:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801035ba:	39 d1                	cmp    %edx,%ecx
801035bc:	0f 85 cf 00 00 00    	jne    80103691 <pipewrite+0x121>
      if(p->readopen == 0 || proc->killed){
801035c2:	8b 97 3c 02 00 00    	mov    0x23c(%edi),%edx
801035c8:	85 d2                	test   %edx,%edx
801035ca:	0f 84 a8 00 00 00    	je     80103678 <pipewrite+0x108>
801035d0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801035d7:	8b 42 24             	mov    0x24(%edx),%eax
801035da:	85 c0                	test   %eax,%eax
801035dc:	74 25                	je     80103603 <pipewrite+0x93>
801035de:	e9 95 00 00 00       	jmp    80103678 <pipewrite+0x108>
801035e3:	90                   	nop
801035e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035e8:	8b 87 3c 02 00 00    	mov    0x23c(%edi),%eax
801035ee:	85 c0                	test   %eax,%eax
801035f0:	0f 84 82 00 00 00    	je     80103678 <pipewrite+0x108>
801035f6:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801035fc:	8b 40 24             	mov    0x24(%eax),%eax
801035ff:	85 c0                	test   %eax,%eax
80103601:	75 75                	jne    80103678 <pipewrite+0x108>
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103603:	83 ec 0c             	sub    $0xc,%esp
80103606:	56                   	push   %esi
80103607:	e8 e4 09 00 00       	call   80103ff0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010360c:	59                   	pop    %ecx
8010360d:	58                   	pop    %eax
8010360e:	57                   	push   %edi
8010360f:	53                   	push   %ebx
80103610:	e8 3b 08 00 00       	call   80103e50 <sleep>
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103615:	8b 87 34 02 00 00    	mov    0x234(%edi),%eax
8010361b:	8b 97 38 02 00 00    	mov    0x238(%edi),%edx
80103621:	83 c4 10             	add    $0x10,%esp
80103624:	05 00 02 00 00       	add    $0x200,%eax
80103629:	39 c2                	cmp    %eax,%edx
8010362b:	74 bb                	je     801035e8 <pipewrite+0x78>
        return -1;
      }
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010362d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103630:	8d 4a 01             	lea    0x1(%edx),%ecx
80103633:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80103637:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010363d:	89 8f 38 02 00 00    	mov    %ecx,0x238(%edi)
80103643:	0f b6 00             	movzbl (%eax),%eax
80103646:	88 44 17 34          	mov    %al,0x34(%edi,%edx,1)
8010364a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
pipewrite(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
8010364d:	3b 45 e0             	cmp    -0x20(%ebp),%eax
80103650:	0f 85 58 ff ff ff    	jne    801035ae <pipewrite+0x3e>
      wakeup(&p->nread);
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103656:	8d 97 34 02 00 00    	lea    0x234(%edi),%edx
8010365c:	83 ec 0c             	sub    $0xc,%esp
8010365f:	52                   	push   %edx
80103660:	e8 8b 09 00 00       	call   80103ff0 <wakeup>
  release(&p->lock);
80103665:	89 3c 24             	mov    %edi,(%esp)
80103668:	e8 43 0e 00 00       	call   801044b0 <release>
  return n;
8010366d:	83 c4 10             	add    $0x10,%esp
80103670:	8b 45 10             	mov    0x10(%ebp),%eax
80103673:	eb 14                	jmp    80103689 <pipewrite+0x119>
80103675:	8d 76 00             	lea    0x0(%esi),%esi

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || proc->killed){
        release(&p->lock);
80103678:	83 ec 0c             	sub    $0xc,%esp
8010367b:	57                   	push   %edi
8010367c:	e8 2f 0e 00 00       	call   801044b0 <release>
        return -1;
80103681:	83 c4 10             	add    $0x10,%esp
80103684:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103689:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010368c:	5b                   	pop    %ebx
8010368d:	5e                   	pop    %esi
8010368e:	5f                   	pop    %edi
8010368f:	5d                   	pop    %ebp
80103690:	c3                   	ret    
{
  int i;

  acquire(&p->lock);
  for(i = 0; i < n; i++){
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103691:	89 ca                	mov    %ecx,%edx
80103693:	eb 98                	jmp    8010362d <pipewrite+0xbd>
80103695:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801036a0 <piperead>:
  return n;
}

int
piperead(struct pipe *p, char *addr, int n)
{
801036a0:	55                   	push   %ebp
801036a1:	89 e5                	mov    %esp,%ebp
801036a3:	57                   	push   %edi
801036a4:	56                   	push   %esi
801036a5:	53                   	push   %ebx
801036a6:	83 ec 18             	sub    $0x18,%esp
801036a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801036af:	53                   	push   %ebx
801036b0:	e8 1b 0c 00 00       	call   801042d0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036b5:	83 c4 10             	add    $0x10,%esp
801036b8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036be:	39 83 38 02 00 00    	cmp    %eax,0x238(%ebx)
801036c4:	75 6a                	jne    80103730 <piperead+0x90>
801036c6:	8b b3 40 02 00 00    	mov    0x240(%ebx),%esi
801036cc:	85 f6                	test   %esi,%esi
801036ce:	0f 84 cc 00 00 00    	je     801037a0 <piperead+0x100>
801036d4:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
801036da:	eb 2d                	jmp    80103709 <piperead+0x69>
801036dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801036e0:	83 ec 08             	sub    $0x8,%esp
801036e3:	53                   	push   %ebx
801036e4:	56                   	push   %esi
801036e5:	e8 66 07 00 00       	call   80103e50 <sleep>
piperead(struct pipe *p, char *addr, int n)
{
  int i;

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801036ea:	83 c4 10             	add    $0x10,%esp
801036ed:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801036f3:	39 83 34 02 00 00    	cmp    %eax,0x234(%ebx)
801036f9:	75 35                	jne    80103730 <piperead+0x90>
801036fb:	8b 93 40 02 00 00    	mov    0x240(%ebx),%edx
80103701:	85 d2                	test   %edx,%edx
80103703:	0f 84 97 00 00 00    	je     801037a0 <piperead+0x100>
    if(proc->killed){
80103709:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103710:	8b 4a 24             	mov    0x24(%edx),%ecx
80103713:	85 c9                	test   %ecx,%ecx
80103715:	74 c9                	je     801036e0 <piperead+0x40>
      release(&p->lock);
80103717:	83 ec 0c             	sub    $0xc,%esp
8010371a:	53                   	push   %ebx
8010371b:	e8 90 0d 00 00       	call   801044b0 <release>
      return -1;
80103720:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
80103723:	8d 65 f4             	lea    -0xc(%ebp),%esp

  acquire(&p->lock);
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
    if(proc->killed){
      release(&p->lock);
      return -1;
80103726:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
8010372b:	5b                   	pop    %ebx
8010372c:	5e                   	pop    %esi
8010372d:	5f                   	pop    %edi
8010372e:	5d                   	pop    %ebp
8010372f:	c3                   	ret    
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103730:	8b 45 10             	mov    0x10(%ebp),%eax
80103733:	85 c0                	test   %eax,%eax
80103735:	7e 69                	jle    801037a0 <piperead+0x100>
    if(p->nread == p->nwrite)
80103737:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010373d:	31 c9                	xor    %ecx,%ecx
8010373f:	eb 15                	jmp    80103756 <piperead+0xb6>
80103741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103748:	8b 93 34 02 00 00    	mov    0x234(%ebx),%edx
8010374e:	3b 93 38 02 00 00    	cmp    0x238(%ebx),%edx
80103754:	74 5a                	je     801037b0 <piperead+0x110>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103756:	8d 72 01             	lea    0x1(%edx),%esi
80103759:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
8010375f:	89 b3 34 02 00 00    	mov    %esi,0x234(%ebx)
80103765:	0f b6 54 13 34       	movzbl 0x34(%ebx,%edx,1),%edx
8010376a:	88 14 0f             	mov    %dl,(%edi,%ecx,1)
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010376d:	83 c1 01             	add    $0x1,%ecx
80103770:	39 4d 10             	cmp    %ecx,0x10(%ebp)
80103773:	75 d3                	jne    80103748 <piperead+0xa8>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103775:	8d 93 38 02 00 00    	lea    0x238(%ebx),%edx
8010377b:	83 ec 0c             	sub    $0xc,%esp
8010377e:	52                   	push   %edx
8010377f:	e8 6c 08 00 00       	call   80103ff0 <wakeup>
  release(&p->lock);
80103784:	89 1c 24             	mov    %ebx,(%esp)
80103787:	e8 24 0d 00 00       	call   801044b0 <release>
  return i;
8010378c:	8b 45 10             	mov    0x10(%ebp),%eax
8010378f:	83 c4 10             	add    $0x10,%esp
}
80103792:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103795:	5b                   	pop    %ebx
80103796:	5e                   	pop    %esi
80103797:	5f                   	pop    %edi
80103798:	5d                   	pop    %ebp
80103799:	c3                   	ret    
8010379a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037a0:	c7 45 10 00 00 00 00 	movl   $0x0,0x10(%ebp)
801037a7:	eb cc                	jmp    80103775 <piperead+0xd5>
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801037b0:	89 4d 10             	mov    %ecx,0x10(%ebp)
801037b3:	eb c0                	jmp    80103775 <piperead+0xd5>
801037b5:	66 90                	xchg   %ax,%ax
801037b7:	66 90                	xchg   %ax,%ax
801037b9:	66 90                	xchg   %ax,%ax
801037bb:	66 90                	xchg   %ax,%ax
801037bd:	66 90                	xchg   %ax,%ax
801037bf:	90                   	nop

801037c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037c0:	55                   	push   %ebp
801037c1:	89 e5                	mov    %esp,%ebp
801037c3:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037c4:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801037c9:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
801037cc:	68 a0 2d 11 80       	push   $0x80112da0
801037d1:	e8 fa 0a 00 00       	call   801042d0 <acquire>
801037d6:	83 c4 10             	add    $0x10,%esp
801037d9:	eb 10                	jmp    801037eb <allocproc+0x2b>
801037db:	90                   	nop
801037dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801037e0:	83 c3 7c             	add    $0x7c,%ebx
801037e3:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
801037e9:	74 75                	je     80103860 <allocproc+0xa0>
    if(p->state == UNUSED)
801037eb:	8b 43 0c             	mov    0xc(%ebx),%eax
801037ee:	85 c0                	test   %eax,%eax
801037f0:	75 ee                	jne    801037e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801037f2:	a1 08 a0 10 80       	mov    0x8010a008,%eax

  release(&ptable.lock);
801037f7:	83 ec 0c             	sub    $0xc,%esp

  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
801037fa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;

  release(&ptable.lock);
80103801:	68 a0 2d 11 80       	push   $0x80112da0
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103806:	8d 50 01             	lea    0x1(%eax),%edx
80103809:	89 43 10             	mov    %eax,0x10(%ebx)
8010380c:	89 15 08 a0 10 80    	mov    %edx,0x8010a008

  release(&ptable.lock);
80103812:	e8 99 0c 00 00       	call   801044b0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103817:	e8 d4 ec ff ff       	call   801024f0 <kalloc>
8010381c:	83 c4 10             	add    $0x10,%esp
8010381f:	85 c0                	test   %eax,%eax
80103821:	89 43 08             	mov    %eax,0x8(%ebx)
80103824:	74 51                	je     80103877 <allocproc+0xb7>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103826:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010382c:	83 ec 04             	sub    $0x4,%esp
  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
8010382f:	05 9c 0f 00 00       	add    $0xf9c,%eax
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103834:	89 53 18             	mov    %edx,0x18(%ebx)
  p->tf = (struct trapframe*)sp;

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;
80103837:	c7 40 14 1e 5a 10 80 	movl   $0x80105a1e,0x14(%eax)

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
8010383e:	6a 14                	push   $0x14
80103840:	6a 00                	push   $0x0
80103842:	50                   	push   %eax
  // which returns to trapret.
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
80103843:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103846:	e8 b5 0c 00 00       	call   80104500 <memset>
  p->context->eip = (uint)forkret;
8010384b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
8010384e:	83 c4 10             	add    $0x10,%esp
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;
80103851:	c7 40 10 80 38 10 80 	movl   $0x80103880,0x10(%eax)

  return p;
80103858:	89 d8                	mov    %ebx,%eax
}
8010385a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010385d:	c9                   	leave  
8010385e:	c3                   	ret    
8010385f:	90                   	nop

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
    if(p->state == UNUSED)
      goto found;

  release(&ptable.lock);
80103860:	83 ec 0c             	sub    $0xc,%esp
80103863:	68 a0 2d 11 80       	push   $0x80112da0
80103868:	e8 43 0c 00 00       	call   801044b0 <release>
  return 0;
8010386d:	83 c4 10             	add    $0x10,%esp
80103870:	31 c0                	xor    %eax,%eax
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
  p->context->eip = (uint)forkret;

  return p;
}
80103872:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103875:	c9                   	leave  
80103876:	c3                   	ret    

  release(&ptable.lock);

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
    p->state = UNUSED;
80103877:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
8010387e:	eb da                	jmp    8010385a <allocproc+0x9a>

80103880 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103880:	55                   	push   %ebp
80103881:	89 e5                	mov    %esp,%ebp
80103883:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103886:	68 a0 2d 11 80       	push   $0x80112da0
8010388b:	e8 20 0c 00 00       	call   801044b0 <release>

  if (first) {
80103890:	a1 04 a0 10 80       	mov    0x8010a004,%eax
80103895:	83 c4 10             	add    $0x10,%esp
80103898:	85 c0                	test   %eax,%eax
8010389a:	75 04                	jne    801038a0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010389c:	c9                   	leave  
8010389d:	c3                   	ret    
8010389e:	66 90                	xchg   %ax,%ax
  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
    iinit(ROOTDEV);
801038a0:	83 ec 0c             	sub    $0xc,%esp

  if (first) {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801038a3:	c7 05 04 a0 10 80 00 	movl   $0x0,0x8010a004
801038aa:	00 00 00 
    iinit(ROOTDEV);
801038ad:	6a 01                	push   $0x1
801038af:	e8 9c db ff ff       	call   80101450 <iinit>
    initlog(ROOTDEV);
801038b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801038bb:	e8 d0 f2 ff ff       	call   80102b90 <initlog>
801038c0:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
801038c3:	c9                   	leave  
801038c4:	c3                   	ret    
801038c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038d0 <pinit>:

static void wakeup1(void *chan);

void
pinit(void)
{
801038d0:	55                   	push   %ebp
801038d1:	89 e5                	mov    %esp,%ebp
801038d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801038d6:	68 6d 78 10 80       	push   $0x8010786d
801038db:	68 a0 2d 11 80       	push   $0x80112da0
801038e0:	e8 cb 09 00 00       	call   801042b0 <initlock>
}
801038e5:	83 c4 10             	add    $0x10,%esp
801038e8:	c9                   	leave  
801038e9:	c3                   	ret    
801038ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801038f0 <userinit>:

//PAGEBREAK: 32
// Set up first user process.
void
userinit(void)
{
801038f0:	55                   	push   %ebp
801038f1:	89 e5                	mov    %esp,%ebp
801038f3:	53                   	push   %ebx
801038f4:	83 ec 04             	sub    $0x4,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
801038f7:	e8 c4 fe ff ff       	call   801037c0 <allocproc>
801038fc:	89 c3                	mov    %eax,%ebx
  
  initproc = p;
801038fe:	a3 bc a5 10 80       	mov    %eax,0x8010a5bc
  if((p->pgdir = setupkvm()) == 0)
80103903:	e8 48 33 00 00       	call   80106c50 <setupkvm>
80103908:	85 c0                	test   %eax,%eax
8010390a:	89 43 04             	mov    %eax,0x4(%ebx)
8010390d:	0f 84 bd 00 00 00    	je     801039d0 <userinit+0xe0>
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103913:	83 ec 04             	sub    $0x4,%esp
80103916:	68 2c 00 00 00       	push   $0x2c
8010391b:	68 60 a4 10 80       	push   $0x8010a460
80103920:	50                   	push   %eax
80103921:	e8 aa 34 00 00       	call   80106dd0 <inituvm>
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
80103926:	83 c4 0c             	add    $0xc,%esp
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
80103929:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010392f:	6a 4c                	push   $0x4c
80103931:	6a 00                	push   $0x0
80103933:	ff 73 18             	pushl  0x18(%ebx)
80103936:	e8 c5 0b 00 00       	call   80104500 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010393b:	8b 43 18             	mov    0x18(%ebx),%eax
8010393e:	ba 23 00 00 00       	mov    $0x23,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103943:	b9 2b 00 00 00       	mov    $0x2b,%ecx
  p->tf->ss = p->tf->ds;
  p->tf->eflags = FL_IF;
  p->tf->esp = PGSIZE;
  p->tf->eip = 0;  // beginning of initcode.S

  safestrcpy(p->name, "initcode", sizeof(p->name));
80103948:	83 c4 0c             	add    $0xc,%esp
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
  p->sz = PGSIZE;
  memset(p->tf, 0, sizeof(*p->tf));
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
8010394b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010394f:	8b 43 18             	mov    0x18(%ebx),%eax
80103952:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103956:	8b 43 18             	mov    0x18(%ebx),%eax
80103959:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010395d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103961:	8b 43 18             	mov    0x18(%ebx),%eax
80103964:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103968:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010396c:	8b 43 18             	mov    0x18(%ebx),%eax
8010396f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103976:	8b 43 18             	mov    0x18(%ebx),%eax
80103979:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103980:	8b 43 18             	mov    0x18(%ebx),%eax
80103983:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
8010398a:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010398d:	6a 10                	push   $0x10
8010398f:	68 8d 78 10 80       	push   $0x8010788d
80103994:	50                   	push   %eax
80103995:	e8 66 0d 00 00       	call   80104700 <safestrcpy>
  p->cwd = namei("/");
8010399a:	c7 04 24 96 78 10 80 	movl   $0x80107896,(%esp)
801039a1:	e8 5a e5 ff ff       	call   80101f00 <namei>
801039a6:	89 43 68             	mov    %eax,0x68(%ebx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
801039a9:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801039b0:	e8 1b 09 00 00       	call   801042d0 <acquire>

  p->state = RUNNABLE;
801039b5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
801039bc:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
801039c3:	e8 e8 0a 00 00       	call   801044b0 <release>
}
801039c8:	83 c4 10             	add    $0x10,%esp
801039cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801039ce:	c9                   	leave  
801039cf:	c3                   	ret    

  p = allocproc();
  
  initproc = p;
  if((p->pgdir = setupkvm()) == 0)
    panic("userinit: out of memory?");
801039d0:	83 ec 0c             	sub    $0xc,%esp
801039d3:	68 74 78 10 80       	push   $0x80107874
801039d8:	e8 93 c9 ff ff       	call   80100370 <panic>
801039dd:	8d 76 00             	lea    0x0(%esi),%esi

801039e0 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801039e0:	55                   	push   %ebp
801039e1:	89 e5                	mov    %esp,%ebp
801039e3:	83 ec 08             	sub    $0x8,%esp
  uint sz;

  sz = proc->sz;
801039e6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int
growproc(int n)
{
801039ed:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint sz;

  sz = proc->sz;
801039f0:	8b 02                	mov    (%edx),%eax
  if(n > 0){
801039f2:	83 f9 00             	cmp    $0x0,%ecx
801039f5:	7e 39                	jle    80103a30 <growproc+0x50>
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
801039f7:	83 ec 04             	sub    $0x4,%esp
801039fa:	01 c1                	add    %eax,%ecx
801039fc:	51                   	push   %ecx
801039fd:	50                   	push   %eax
801039fe:	ff 72 04             	pushl  0x4(%edx)
80103a01:	e8 0a 35 00 00       	call   80106f10 <allocuvm>
80103a06:	83 c4 10             	add    $0x10,%esp
80103a09:	85 c0                	test   %eax,%eax
80103a0b:	74 3b                	je     80103a48 <growproc+0x68>
80103a0d:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      return -1;
  } else if(n < 0){
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  }
  proc->sz = sz;
80103a14:	89 02                	mov    %eax,(%edx)
  switchuvm(proc);
80103a16:	83 ec 0c             	sub    $0xc,%esp
80103a19:	65 ff 35 04 00 00 00 	pushl  %gs:0x4
80103a20:	e8 db 32 00 00       	call   80106d00 <switchuvm>
  return 0;
80103a25:	83 c4 10             	add    $0x10,%esp
80103a28:	31 c0                	xor    %eax,%eax
}
80103a2a:	c9                   	leave  
80103a2b:	c3                   	ret    
80103a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
  } else if(n < 0){
80103a30:	74 e2                	je     80103a14 <growproc+0x34>
    if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0)
80103a32:	83 ec 04             	sub    $0x4,%esp
80103a35:	01 c1                	add    %eax,%ecx
80103a37:	51                   	push   %ecx
80103a38:	50                   	push   %eax
80103a39:	ff 72 04             	pushl  0x4(%edx)
80103a3c:	e8 df 35 00 00       	call   80107020 <deallocuvm>
80103a41:	83 c4 10             	add    $0x10,%esp
80103a44:	85 c0                	test   %eax,%eax
80103a46:	75 c5                	jne    80103a0d <growproc+0x2d>
  uint sz;

  sz = proc->sz;
  if(n > 0){
    if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0)
      return -1;
80103a48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return -1;
  }
  proc->sz = sz;
  switchuvm(proc);
  return 0;
}
80103a4d:	c9                   	leave  
80103a4e:	c3                   	ret    
80103a4f:	90                   	nop

80103a50 <fork>:
// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int
fork(void)
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	57                   	push   %edi
80103a54:	56                   	push   %esi
80103a55:	53                   	push   %ebx
80103a56:	83 ec 0c             	sub    $0xc,%esp
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
80103a59:	e8 62 fd ff ff       	call   801037c0 <allocproc>
80103a5e:	85 c0                	test   %eax,%eax
80103a60:	0f 84 d6 00 00 00    	je     80103b3c <fork+0xec>
80103a66:	89 c3                	mov    %eax,%ebx
    return -1;
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
80103a68:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103a6e:	83 ec 08             	sub    $0x8,%esp
80103a71:	ff 30                	pushl  (%eax)
80103a73:	ff 70 04             	pushl  0x4(%eax)
80103a76:	e8 85 36 00 00       	call   80107100 <copyuvm>
80103a7b:	83 c4 10             	add    $0x10,%esp
80103a7e:	85 c0                	test   %eax,%eax
80103a80:	89 43 04             	mov    %eax,0x4(%ebx)
80103a83:	0f 84 ba 00 00 00    	je     80103b43 <fork+0xf3>
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
80103a89:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  np->parent = proc;
  *np->tf = *proc->tf;
80103a8f:	8b 7b 18             	mov    0x18(%ebx),%edi
80103a92:	b9 13 00 00 00       	mov    $0x13,%ecx
    kfree(np->kstack);
    np->kstack = 0;
    np->state = UNUSED;
    return -1;
  }
  np->sz = proc->sz;
80103a97:	8b 00                	mov    (%eax),%eax
80103a99:	89 03                	mov    %eax,(%ebx)
  np->parent = proc;
80103a9b:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103aa1:	89 43 14             	mov    %eax,0x14(%ebx)
  *np->tf = *proc->tf;
80103aa4:	8b 70 18             	mov    0x18(%eax),%esi
80103aa7:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103aa9:	31 f6                	xor    %esi,%esi
  np->sz = proc->sz;
  np->parent = proc;
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80103aab:	8b 43 18             	mov    0x18(%ebx),%eax
80103aae:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103ab5:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80103abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  for(i = 0; i < NOFILE; i++)
    if(proc->ofile[i])
80103ac0:	8b 44 b2 28          	mov    0x28(%edx,%esi,4),%eax
80103ac4:	85 c0                	test   %eax,%eax
80103ac6:	74 17                	je     80103adf <fork+0x8f>
      np->ofile[i] = filedup(proc->ofile[i]);
80103ac8:	83 ec 0c             	sub    $0xc,%esp
80103acb:	50                   	push   %eax
80103acc:	e8 ef d2 ff ff       	call   80100dc0 <filedup>
80103ad1:	89 44 b3 28          	mov    %eax,0x28(%ebx,%esi,4)
80103ad5:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103adc:	83 c4 10             	add    $0x10,%esp
  *np->tf = *proc->tf;

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;

  for(i = 0; i < NOFILE; i++)
80103adf:	83 c6 01             	add    $0x1,%esi
80103ae2:	83 fe 10             	cmp    $0x10,%esi
80103ae5:	75 d9                	jne    80103ac0 <fork+0x70>
    if(proc->ofile[i])
      np->ofile[i] = filedup(proc->ofile[i]);
  np->cwd = idup(proc->cwd);
80103ae7:	83 ec 0c             	sub    $0xc,%esp
80103aea:	ff 72 68             	pushl  0x68(%edx)
80103aed:	e8 2e db ff ff       	call   80101620 <idup>
80103af2:	89 43 68             	mov    %eax,0x68(%ebx)

  safestrcpy(np->name, proc->name, sizeof(proc->name));
80103af5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103afb:	83 c4 0c             	add    $0xc,%esp
80103afe:	6a 10                	push   $0x10
80103b00:	83 c0 6c             	add    $0x6c,%eax
80103b03:	50                   	push   %eax
80103b04:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103b07:	50                   	push   %eax
80103b08:	e8 f3 0b 00 00       	call   80104700 <safestrcpy>

  pid = np->pid;
80103b0d:	8b 73 10             	mov    0x10(%ebx),%esi

  acquire(&ptable.lock);
80103b10:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b17:	e8 b4 07 00 00       	call   801042d0 <acquire>

  np->state = RUNNABLE;
80103b1c:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)

  release(&ptable.lock);
80103b23:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103b2a:	e8 81 09 00 00       	call   801044b0 <release>

  return pid;
80103b2f:	83 c4 10             	add    $0x10,%esp
80103b32:	89 f0                	mov    %esi,%eax
}
80103b34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b37:	5b                   	pop    %ebx
80103b38:	5e                   	pop    %esi
80103b39:	5f                   	pop    %edi
80103b3a:	5d                   	pop    %ebp
80103b3b:	c3                   	ret    
  int i, pid;
  struct proc *np;

  // Allocate process.
  if((np = allocproc()) == 0){
    return -1;
80103b3c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b41:	eb f1                	jmp    80103b34 <fork+0xe4>
  }

  // Copy process state from p.
  if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
    kfree(np->kstack);
80103b43:	83 ec 0c             	sub    $0xc,%esp
80103b46:	ff 73 08             	pushl  0x8(%ebx)
80103b49:	e8 f2 e7 ff ff       	call   80102340 <kfree>
    np->kstack = 0;
80103b4e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    np->state = UNUSED;
80103b55:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103b5c:	83 c4 10             	add    $0x10,%esp
80103b5f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b64:	eb ce                	jmp    80103b34 <fork+0xe4>
80103b66:	8d 76 00             	lea    0x0(%esi),%esi
80103b69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103b70 <scheduler>:
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void
scheduler(void)
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	53                   	push   %ebx
80103b74:	83 ec 04             	sub    $0x4,%esp
80103b77:	89 f6                	mov    %esi,%esi
80103b79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}

static inline void
sti(void)
{
  asm volatile("sti");
80103b80:	fb                   	sti    
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b81:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103b84:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
  for(;;){
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80103b89:	68 a0 2d 11 80       	push   $0x80112da0
80103b8e:	e8 3d 07 00 00       	call   801042d0 <acquire>
80103b93:	83 c4 10             	add    $0x10,%esp
80103b96:	eb 13                	jmp    80103bab <scheduler+0x3b>
80103b98:	90                   	nop
80103b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ba0:	83 c3 7c             	add    $0x7c,%ebx
80103ba3:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103ba9:	74 55                	je     80103c00 <scheduler+0x90>
      if(p->state != RUNNABLE)
80103bab:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103baf:	75 ef                	jne    80103ba0 <scheduler+0x30>

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103bb1:	83 ec 0c             	sub    $0xc,%esp
        continue;

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
80103bb4:	65 89 1d 04 00 00 00 	mov    %ebx,%gs:0x4
      switchuvm(p);
80103bbb:	53                   	push   %ebx
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bbc:	83 c3 7c             	add    $0x7c,%ebx

      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
80103bbf:	e8 3c 31 00 00       	call   80106d00 <switchuvm>
      p->state = RUNNING;
      swtch(&cpu->scheduler, p->context);
80103bc4:	58                   	pop    %eax
80103bc5:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
      // Switch to chosen process.  It is the process's job
      // to release ptable.lock and then reacquire it
      // before jumping back to us.
      proc = p;
      switchuvm(p);
      p->state = RUNNING;
80103bcb:	c7 43 90 04 00 00 00 	movl   $0x4,-0x70(%ebx)
      swtch(&cpu->scheduler, p->context);
80103bd2:	5a                   	pop    %edx
80103bd3:	ff 73 a0             	pushl  -0x60(%ebx)
80103bd6:	83 c0 04             	add    $0x4,%eax
80103bd9:	50                   	push   %eax
80103bda:	e8 7c 0b 00 00       	call   8010475b <swtch>
      switchkvm();
80103bdf:	e8 fc 30 00 00       	call   80106ce0 <switchkvm>

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103be4:	83 c4 10             	add    $0x10,%esp
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103be7:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
      swtch(&cpu->scheduler, p->context);
      switchkvm();

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
80103bed:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80103bf4:	00 00 00 00 
    // Enable interrupts on this processor.
    sti();

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103bf8:	75 b1                	jne    80103bab <scheduler+0x3b>
80103bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

      // Process is done running for now.
      // It should have changed its p->state before coming back.
      proc = 0;
    }
    release(&ptable.lock);
80103c00:	83 ec 0c             	sub    $0xc,%esp
80103c03:	68 a0 2d 11 80       	push   $0x80112da0
80103c08:	e8 a3 08 00 00       	call   801044b0 <release>

  }
80103c0d:	83 c4 10             	add    $0x10,%esp
80103c10:	e9 6b ff ff ff       	jmp    80103b80 <scheduler+0x10>
80103c15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103c20 <sched>:
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void
sched(void)
{
80103c20:	55                   	push   %ebp
80103c21:	89 e5                	mov    %esp,%ebp
80103c23:	53                   	push   %ebx
80103c24:	83 ec 10             	sub    $0x10,%esp
  int intena;

  if(!holding(&ptable.lock))
80103c27:	68 a0 2d 11 80       	push   $0x80112da0
80103c2c:	e8 cf 07 00 00       	call   80104400 <holding>
80103c31:	83 c4 10             	add    $0x10,%esp
80103c34:	85 c0                	test   %eax,%eax
80103c36:	74 4c                	je     80103c84 <sched+0x64>
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
80103c38:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80103c3f:	83 ba ac 00 00 00 01 	cmpl   $0x1,0xac(%edx)
80103c46:	75 63                	jne    80103cab <sched+0x8b>
    panic("sched locks");
  if(proc->state == RUNNING)
80103c48:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103c4e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80103c52:	74 4a                	je     80103c9e <sched+0x7e>

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103c54:	9c                   	pushf  
80103c55:	59                   	pop    %ecx
    panic("sched running");
  if(readeflags()&FL_IF)
80103c56:	80 e5 02             	and    $0x2,%ch
80103c59:	75 36                	jne    80103c91 <sched+0x71>
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
80103c5b:	83 ec 08             	sub    $0x8,%esp
80103c5e:	83 c0 1c             	add    $0x1c,%eax
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
80103c61:	8b 9a b0 00 00 00    	mov    0xb0(%edx),%ebx
  swtch(&proc->context, cpu->scheduler);
80103c67:	ff 72 04             	pushl  0x4(%edx)
80103c6a:	50                   	push   %eax
80103c6b:	e8 eb 0a 00 00       	call   8010475b <swtch>
  cpu->intena = intena;
80103c70:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
}
80103c76:	83 c4 10             	add    $0x10,%esp
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
  intena = cpu->intena;
  swtch(&proc->context, cpu->scheduler);
  cpu->intena = intena;
80103c79:	89 98 b0 00 00 00    	mov    %ebx,0xb0(%eax)
}
80103c7f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c82:	c9                   	leave  
80103c83:	c3                   	ret    
sched(void)
{
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
80103c84:	83 ec 0c             	sub    $0xc,%esp
80103c87:	68 98 78 10 80       	push   $0x80107898
80103c8c:	e8 df c6 ff ff       	call   80100370 <panic>
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
  if(readeflags()&FL_IF)
    panic("sched interruptible");
80103c91:	83 ec 0c             	sub    $0xc,%esp
80103c94:	68 c4 78 10 80       	push   $0x801078c4
80103c99:	e8 d2 c6 ff ff       	call   80100370 <panic>
  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
  if(proc->state == RUNNING)
    panic("sched running");
80103c9e:	83 ec 0c             	sub    $0xc,%esp
80103ca1:	68 b6 78 10 80       	push   $0x801078b6
80103ca6:	e8 c5 c6 ff ff       	call   80100370 <panic>
  int intena;

  if(!holding(&ptable.lock))
    panic("sched ptable.lock");
  if(cpu->ncli != 1)
    panic("sched locks");
80103cab:	83 ec 0c             	sub    $0xc,%esp
80103cae:	68 aa 78 10 80       	push   $0x801078aa
80103cb3:	e8 b8 c6 ff ff       	call   80100370 <panic>
80103cb8:	90                   	nop
80103cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103cc0 <exit>:
exit(void)
{
  struct proc *p;
  int fd;

  if(proc == initproc)
80103cc0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103cc7:	3b 15 bc a5 10 80    	cmp    0x8010a5bc,%edx
// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void
exit(void)
{
80103ccd:	55                   	push   %ebp
80103cce:	89 e5                	mov    %esp,%ebp
80103cd0:	56                   	push   %esi
80103cd1:	53                   	push   %ebx
  struct proc *p;
  int fd;

  if(proc == initproc)
80103cd2:	0f 84 1f 01 00 00    	je     80103df7 <exit+0x137>
80103cd8:	31 db                	xor    %ebx,%ebx
80103cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd]){
80103ce0:	8d 73 08             	lea    0x8(%ebx),%esi
80103ce3:	8b 44 b2 08          	mov    0x8(%edx,%esi,4),%eax
80103ce7:	85 c0                	test   %eax,%eax
80103ce9:	74 1b                	je     80103d06 <exit+0x46>
      fileclose(proc->ofile[fd]);
80103ceb:	83 ec 0c             	sub    $0xc,%esp
80103cee:	50                   	push   %eax
80103cef:	e8 1c d1 ff ff       	call   80100e10 <fileclose>
      proc->ofile[fd] = 0;
80103cf4:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80103cfb:	83 c4 10             	add    $0x10,%esp
80103cfe:	c7 44 b2 08 00 00 00 	movl   $0x0,0x8(%edx,%esi,4)
80103d05:	00 

  if(proc == initproc)
    panic("init exiting");

  // Close all open files.
  for(fd = 0; fd < NOFILE; fd++){
80103d06:	83 c3 01             	add    $0x1,%ebx
80103d09:	83 fb 10             	cmp    $0x10,%ebx
80103d0c:	75 d2                	jne    80103ce0 <exit+0x20>
      fileclose(proc->ofile[fd]);
      proc->ofile[fd] = 0;
    }
  }

  begin_op();
80103d0e:	e8 1d ef ff ff       	call   80102c30 <begin_op>
  iput(proc->cwd);
80103d13:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d19:	83 ec 0c             	sub    $0xc,%esp
80103d1c:	ff 70 68             	pushl  0x68(%eax)
80103d1f:	e8 5c da ff ff       	call   80101780 <iput>
  end_op();
80103d24:	e8 77 ef ff ff       	call   80102ca0 <end_op>
  proc->cwd = 0;
80103d29:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103d2f:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80103d36:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103d3d:	e8 8e 05 00 00       	call   801042d0 <acquire>

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103d42:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80103d49:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d4c:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
  proc->cwd = 0;

  acquire(&ptable.lock);

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);
80103d51:	8b 51 14             	mov    0x14(%ecx),%edx
80103d54:	eb 14                	jmp    80103d6a <exit+0xaa>
80103d56:	8d 76 00             	lea    0x0(%esi),%esi
80103d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d60:	83 c0 7c             	add    $0x7c,%eax
80103d63:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103d68:	74 1c                	je     80103d86 <exit+0xc6>
    if(p->state == SLEEPING && p->chan == chan)
80103d6a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103d6e:	75 f0                	jne    80103d60 <exit+0xa0>
80103d70:	3b 50 20             	cmp    0x20(%eax),%edx
80103d73:	75 eb                	jne    80103d60 <exit+0xa0>
      p->state = RUNNABLE;
80103d75:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103d7c:	83 c0 7c             	add    $0x7c,%eax
80103d7f:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103d84:	75 e4                	jne    80103d6a <exit+0xaa>
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103d86:	8b 1d bc a5 10 80    	mov    0x8010a5bc,%ebx
80103d8c:	ba d4 2d 11 80       	mov    $0x80112dd4,%edx
80103d91:	eb 10                	jmp    80103da3 <exit+0xe3>
80103d93:	90                   	nop
80103d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  // Parent might be sleeping in wait().
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d98:	83 c2 7c             	add    $0x7c,%edx
80103d9b:	81 fa d4 4c 11 80    	cmp    $0x80114cd4,%edx
80103da1:	74 3b                	je     80103dde <exit+0x11e>
    if(p->parent == proc){
80103da3:	3b 4a 14             	cmp    0x14(%edx),%ecx
80103da6:	75 f0                	jne    80103d98 <exit+0xd8>
      p->parent = initproc;
      if(p->state == ZOMBIE)
80103da8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
  wakeup1(proc->parent);

  // Pass abandoned children to init.
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->parent == proc){
      p->parent = initproc;
80103dac:	89 5a 14             	mov    %ebx,0x14(%edx)
      if(p->state == ZOMBIE)
80103daf:	75 e7                	jne    80103d98 <exit+0xd8>
80103db1:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
80103db6:	eb 12                	jmp    80103dca <exit+0x10a>
80103db8:	90                   	nop
80103db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103dc0:	83 c0 7c             	add    $0x7c,%eax
80103dc3:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80103dc8:	74 ce                	je     80103d98 <exit+0xd8>
    if(p->state == SLEEPING && p->chan == chan)
80103dca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103dce:	75 f0                	jne    80103dc0 <exit+0x100>
80103dd0:	3b 58 20             	cmp    0x20(%eax),%ebx
80103dd3:	75 eb                	jne    80103dc0 <exit+0x100>
      p->state = RUNNABLE;
80103dd5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103ddc:	eb e2                	jmp    80103dc0 <exit+0x100>
        wakeup1(initproc);
    }
  }

  // Jump into the scheduler, never to return.
  proc->state = ZOMBIE;
80103dde:	c7 41 0c 05 00 00 00 	movl   $0x5,0xc(%ecx)
  sched();
80103de5:	e8 36 fe ff ff       	call   80103c20 <sched>
  panic("zombie exit");
80103dea:	83 ec 0c             	sub    $0xc,%esp
80103ded:	68 e5 78 10 80       	push   $0x801078e5
80103df2:	e8 79 c5 ff ff       	call   80100370 <panic>
{
  struct proc *p;
  int fd;

  if(proc == initproc)
    panic("init exiting");
80103df7:	83 ec 0c             	sub    $0xc,%esp
80103dfa:	68 d8 78 10 80       	push   $0x801078d8
80103dff:	e8 6c c5 ff ff       	call   80100370 <panic>
80103e04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103e10 <yield>:
}

// Give up the CPU for one scheduling round.
void
yield(void)
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	83 ec 14             	sub    $0x14,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103e16:	68 a0 2d 11 80       	push   $0x80112da0
80103e1b:	e8 b0 04 00 00       	call   801042d0 <acquire>
  proc->state = RUNNABLE;
80103e20:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e26:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
80103e2d:	e8 ee fd ff ff       	call   80103c20 <sched>
  release(&ptable.lock);
80103e32:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103e39:	e8 72 06 00 00       	call   801044b0 <release>
}
80103e3e:	83 c4 10             	add    $0x10,%esp
80103e41:	c9                   	leave  
80103e42:	c3                   	ret    
80103e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103e50 <sleep>:
// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
80103e50:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103e56:	55                   	push   %ebp
80103e57:	89 e5                	mov    %esp,%ebp
80103e59:	56                   	push   %esi
80103e5a:	53                   	push   %ebx
  if(proc == 0)
80103e5b:	85 c0                	test   %eax,%eax

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
80103e5d:	8b 75 08             	mov    0x8(%ebp),%esi
80103e60:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(proc == 0)
80103e63:	0f 84 97 00 00 00    	je     80103f00 <sleep+0xb0>
    panic("sleep");

  if(lk == 0)
80103e69:	85 db                	test   %ebx,%ebx
80103e6b:	0f 84 82 00 00 00    	je     80103ef3 <sleep+0xa3>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if(lk != &ptable.lock){  //DOC: sleeplock0
80103e71:	81 fb a0 2d 11 80    	cmp    $0x80112da0,%ebx
80103e77:	74 57                	je     80103ed0 <sleep+0x80>
    acquire(&ptable.lock);  //DOC: sleeplock1
80103e79:	83 ec 0c             	sub    $0xc,%esp
80103e7c:	68 a0 2d 11 80       	push   $0x80112da0
80103e81:	e8 4a 04 00 00       	call   801042d0 <acquire>
    release(lk);
80103e86:	89 1c 24             	mov    %ebx,(%esp)
80103e89:	e8 22 06 00 00       	call   801044b0 <release>
  }

  // Go to sleep.
  proc->chan = chan;
80103e8e:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103e94:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103e97:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103e9e:	e8 7d fd ff ff       	call   80103c20 <sched>

  // Tidy up.
  proc->chan = 0;
80103ea3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ea9:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
80103eb0:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103eb7:	e8 f4 05 00 00       	call   801044b0 <release>
    acquire(lk);
80103ebc:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103ebf:	83 c4 10             	add    $0x10,%esp
  }
}
80103ec2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ec5:	5b                   	pop    %ebx
80103ec6:	5e                   	pop    %esi
80103ec7:	5d                   	pop    %ebp
  proc->chan = 0;

  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
80103ec8:	e9 03 04 00 00       	jmp    801042d0 <acquire>
80103ecd:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&ptable.lock);  //DOC: sleeplock1
    release(lk);
  }

  // Go to sleep.
  proc->chan = chan;
80103ed0:	89 70 20             	mov    %esi,0x20(%eax)
  proc->state = SLEEPING;
80103ed3:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)
  sched();
80103eda:	e8 41 fd ff ff       	call   80103c20 <sched>

  // Tidy up.
  proc->chan = 0;
80103edf:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80103ee5:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
  // Reacquire original lock.
  if(lk != &ptable.lock){  //DOC: sleeplock2
    release(&ptable.lock);
    acquire(lk);
  }
}
80103eec:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103eef:	5b                   	pop    %ebx
80103ef0:	5e                   	pop    %esi
80103ef1:	5d                   	pop    %ebp
80103ef2:	c3                   	ret    
{
  if(proc == 0)
    panic("sleep");

  if(lk == 0)
    panic("sleep without lk");
80103ef3:	83 ec 0c             	sub    $0xc,%esp
80103ef6:	68 f7 78 10 80       	push   $0x801078f7
80103efb:	e8 70 c4 ff ff       	call   80100370 <panic>
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
  if(proc == 0)
    panic("sleep");
80103f00:	83 ec 0c             	sub    $0xc,%esp
80103f03:	68 f1 78 10 80       	push   $0x801078f1
80103f08:	e8 63 c4 ff ff       	call   80100370 <panic>
80103f0d:	8d 76 00             	lea    0x0(%esi),%esi

80103f10 <wait>:

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int
wait(void)
{
80103f10:	55                   	push   %ebp
80103f11:	89 e5                	mov    %esp,%ebp
80103f13:	56                   	push   %esi
80103f14:	53                   	push   %ebx
  struct proc *p;
  int havekids, pid;

  acquire(&ptable.lock);
80103f15:	83 ec 0c             	sub    $0xc,%esp
80103f18:	68 a0 2d 11 80       	push   $0x80112da0
80103f1d:	e8 ae 03 00 00       	call   801042d0 <acquire>
80103f22:	83 c4 10             	add    $0x10,%esp
80103f25:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
80103f2b:	31 d2                	xor    %edx,%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f2d:	bb d4 2d 11 80       	mov    $0x80112dd4,%ebx
80103f32:	eb 0f                	jmp    80103f43 <wait+0x33>
80103f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f38:	83 c3 7c             	add    $0x7c,%ebx
80103f3b:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103f41:	74 1d                	je     80103f60 <wait+0x50>
      if(p->parent != proc)
80103f43:	3b 43 14             	cmp    0x14(%ebx),%eax
80103f46:	75 f0                	jne    80103f38 <wait+0x28>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
80103f48:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103f4c:	74 30                	je     80103f7e <wait+0x6e>

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f4e:	83 c3 7c             	add    $0x7c,%ebx
      if(p->parent != proc)
        continue;
      havekids = 1;
80103f51:	ba 01 00 00 00       	mov    $0x1,%edx

  acquire(&ptable.lock);
  for(;;){
    // Scan through table looking for exited children.
    havekids = 0;
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f56:	81 fb d4 4c 11 80    	cmp    $0x80114cd4,%ebx
80103f5c:	75 e5                	jne    80103f43 <wait+0x33>
80103f5e:	66 90                	xchg   %ax,%ax
        return pid;
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
80103f60:	85 d2                	test   %edx,%edx
80103f62:	74 70                	je     80103fd4 <wait+0xc4>
80103f64:	8b 50 24             	mov    0x24(%eax),%edx
80103f67:	85 d2                	test   %edx,%edx
80103f69:	75 69                	jne    80103fd4 <wait+0xc4>
      release(&ptable.lock);
      return -1;
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
80103f6b:	83 ec 08             	sub    $0x8,%esp
80103f6e:	68 a0 2d 11 80       	push   $0x80112da0
80103f73:	50                   	push   %eax
80103f74:	e8 d7 fe ff ff       	call   80103e50 <sleep>
  }
80103f79:	83 c4 10             	add    $0x10,%esp
80103f7c:	eb a7                	jmp    80103f25 <wait+0x15>
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
80103f7e:	83 ec 0c             	sub    $0xc,%esp
80103f81:	ff 73 08             	pushl  0x8(%ebx)
      if(p->parent != proc)
        continue;
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
80103f84:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80103f87:	e8 b4 e3 ff ff       	call   80102340 <kfree>
        p->kstack = 0;
        freevm(p->pgdir);
80103f8c:	59                   	pop    %ecx
80103f8d:	ff 73 04             	pushl  0x4(%ebx)
      havekids = 1;
      if(p->state == ZOMBIE){
        // Found one.
        pid = p->pid;
        kfree(p->kstack);
        p->kstack = 0;
80103f90:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80103f97:	e8 b4 30 00 00       	call   80107050 <freevm>
        p->pid = 0;
80103f9c:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80103fa3:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80103faa:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80103fae:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80103fb5:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80103fbc:	c7 04 24 a0 2d 11 80 	movl   $0x80112da0,(%esp)
80103fc3:	e8 e8 04 00 00       	call   801044b0 <release>
        return pid;
80103fc8:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103fcb:	8d 65 f8             	lea    -0x8(%ebp),%esp
        p->parent = 0;
        p->name[0] = 0;
        p->killed = 0;
        p->state = UNUSED;
        release(&ptable.lock);
        return pid;
80103fce:	89 f0                	mov    %esi,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103fd0:	5b                   	pop    %ebx
80103fd1:	5e                   	pop    %esi
80103fd2:	5d                   	pop    %ebp
80103fd3:	c3                   	ret    
      }
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
80103fd4:	83 ec 0c             	sub    $0xc,%esp
80103fd7:	68 a0 2d 11 80       	push   $0x80112da0
80103fdc:	e8 cf 04 00 00       	call   801044b0 <release>
      return -1;
80103fe1:	83 c4 10             	add    $0x10,%esp
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103fe4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    }

    // No point waiting if we don't have any children.
    if(!havekids || proc->killed){
      release(&ptable.lock);
      return -1;
80103fe7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(proc, &ptable.lock);  //DOC: wait-sleep
  }
}
80103fec:	5b                   	pop    %ebx
80103fed:	5e                   	pop    %esi
80103fee:	5d                   	pop    %ebp
80103fef:	c3                   	ret    

80103ff0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	53                   	push   %ebx
80103ff4:	83 ec 10             	sub    $0x10,%esp
80103ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80103ffa:	68 a0 2d 11 80       	push   $0x80112da0
80103fff:	e8 cc 02 00 00       	call   801042d0 <acquire>
80104004:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104007:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010400c:	eb 0c                	jmp    8010401a <wakeup+0x2a>
8010400e:	66 90                	xchg   %ax,%ax
80104010:	83 c0 7c             	add    $0x7c,%eax
80104013:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80104018:	74 1c                	je     80104036 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010401a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010401e:	75 f0                	jne    80104010 <wakeup+0x20>
80104020:	3b 58 20             	cmp    0x20(%eax),%ebx
80104023:	75 eb                	jne    80104010 <wakeup+0x20>
      p->state = RUNNABLE;
80104025:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010402c:	83 c0 7c             	add    $0x7c,%eax
8010402f:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80104034:	75 e4                	jne    8010401a <wakeup+0x2a>
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104036:	c7 45 08 a0 2d 11 80 	movl   $0x80112da0,0x8(%ebp)
}
8010403d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104040:	c9                   	leave  
void
wakeup(void *chan)
{
  acquire(&ptable.lock);
  wakeup1(chan);
  release(&ptable.lock);
80104041:	e9 6a 04 00 00       	jmp    801044b0 <release>
80104046:	8d 76 00             	lea    0x0(%esi),%esi
80104049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104050 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	53                   	push   %ebx
80104054:	83 ec 10             	sub    $0x10,%esp
80104057:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010405a:	68 a0 2d 11 80       	push   $0x80112da0
8010405f:	e8 6c 02 00 00       	call   801042d0 <acquire>
80104064:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104067:	b8 d4 2d 11 80       	mov    $0x80112dd4,%eax
8010406c:	eb 0c                	jmp    8010407a <kill+0x2a>
8010406e:	66 90                	xchg   %ax,%ax
80104070:	83 c0 7c             	add    $0x7c,%eax
80104073:	3d d4 4c 11 80       	cmp    $0x80114cd4,%eax
80104078:	74 3e                	je     801040b8 <kill+0x68>
    if(p->pid == pid){
8010407a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010407d:	75 f1                	jne    80104070 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010407f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
  struct proc *p;

  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
80104083:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010408a:	74 1c                	je     801040a8 <kill+0x58>
        p->state = RUNNABLE;
      release(&ptable.lock);
8010408c:	83 ec 0c             	sub    $0xc,%esp
8010408f:	68 a0 2d 11 80       	push   $0x80112da0
80104094:	e8 17 04 00 00       	call   801044b0 <release>
      return 0;
80104099:	83 c4 10             	add    $0x10,%esp
8010409c:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
8010409e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040a1:	c9                   	leave  
801040a2:	c3                   	ret    
801040a3:	90                   	nop
801040a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->pid == pid){
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
        p->state = RUNNABLE;
801040a8:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040af:	eb db                	jmp    8010408c <kill+0x3c>
801040b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&ptable.lock);
      return 0;
    }
  }
  release(&ptable.lock);
801040b8:	83 ec 0c             	sub    $0xc,%esp
801040bb:	68 a0 2d 11 80       	push   $0x80112da0
801040c0:	e8 eb 03 00 00       	call   801044b0 <release>
  return -1;
801040c5:	83 c4 10             	add    $0x10,%esp
801040c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801040cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d0:	c9                   	leave  
801040d1:	c3                   	ret    
801040d2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801040e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801040e0:	55                   	push   %ebp
801040e1:	89 e5                	mov    %esp,%ebp
801040e3:	57                   	push   %edi
801040e4:	56                   	push   %esi
801040e5:	53                   	push   %ebx
801040e6:	8d 75 e8             	lea    -0x18(%ebp),%esi
801040e9:	bb 40 2e 11 80       	mov    $0x80112e40,%ebx
801040ee:	83 ec 3c             	sub    $0x3c,%esp
801040f1:	eb 24                	jmp    80104117 <procdump+0x37>
801040f3:	90                   	nop
801040f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801040f8:	83 ec 0c             	sub    $0xc,%esp
801040fb:	68 46 78 10 80       	push   $0x80107846
80104100:	e8 5b c5 ff ff       	call   80100660 <cprintf>
80104105:	83 c4 10             	add    $0x10,%esp
80104108:	83 c3 7c             	add    $0x7c,%ebx
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010410b:	81 fb 40 4d 11 80    	cmp    $0x80114d40,%ebx
80104111:	0f 84 81 00 00 00    	je     80104198 <procdump+0xb8>
    if(p->state == UNUSED)
80104117:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010411a:	85 c0                	test   %eax,%eax
8010411c:	74 ea                	je     80104108 <procdump+0x28>
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
8010411e:	83 f8 05             	cmp    $0x5,%eax
      state = states[p->state];
    else
      state = "???";
80104121:	ba 08 79 10 80       	mov    $0x80107908,%edx
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104126:	77 11                	ja     80104139 <procdump+0x59>
80104128:	8b 14 85 40 79 10 80 	mov    -0x7fef86c0(,%eax,4),%edx
      state = states[p->state];
    else
      state = "???";
8010412f:	b8 08 79 10 80       	mov    $0x80107908,%eax
80104134:	85 d2                	test   %edx,%edx
80104136:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104139:	53                   	push   %ebx
8010413a:	52                   	push   %edx
8010413b:	ff 73 a4             	pushl  -0x5c(%ebx)
8010413e:	68 0c 79 10 80       	push   $0x8010790c
80104143:	e8 18 c5 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104148:	83 c4 10             	add    $0x10,%esp
8010414b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010414f:	75 a7                	jne    801040f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104151:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104154:	83 ec 08             	sub    $0x8,%esp
80104157:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010415a:	50                   	push   %eax
8010415b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010415e:	8b 40 0c             	mov    0xc(%eax),%eax
80104161:	83 c0 08             	add    $0x8,%eax
80104164:	50                   	push   %eax
80104165:	e8 36 02 00 00       	call   801043a0 <getcallerpcs>
8010416a:	83 c4 10             	add    $0x10,%esp
8010416d:	8d 76 00             	lea    0x0(%esi),%esi
      for(i=0; i<10 && pc[i] != 0; i++)
80104170:	8b 17                	mov    (%edi),%edx
80104172:	85 d2                	test   %edx,%edx
80104174:	74 82                	je     801040f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104176:	83 ec 08             	sub    $0x8,%esp
80104179:	83 c7 04             	add    $0x4,%edi
8010417c:	52                   	push   %edx
8010417d:	68 29 73 10 80       	push   $0x80107329
80104182:	e8 d9 c4 ff ff       	call   80100660 <cprintf>
    else
      state = "???";
    cprintf("%d %s %s", p->pid, state, p->name);
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
80104187:	83 c4 10             	add    $0x10,%esp
8010418a:	39 f7                	cmp    %esi,%edi
8010418c:	75 e2                	jne    80104170 <procdump+0x90>
8010418e:	e9 65 ff ff ff       	jmp    801040f8 <procdump+0x18>
80104193:	90                   	nop
80104194:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
  }
}
80104198:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010419b:	5b                   	pop    %ebx
8010419c:	5e                   	pop    %esi
8010419d:	5f                   	pop    %edi
8010419e:	5d                   	pop    %ebp
8010419f:	c3                   	ret    

801041a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801041a0:	55                   	push   %ebp
801041a1:	89 e5                	mov    %esp,%ebp
801041a3:	53                   	push   %ebx
801041a4:	83 ec 0c             	sub    $0xc,%esp
801041a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801041aa:	68 58 79 10 80       	push   $0x80107958
801041af:	8d 43 04             	lea    0x4(%ebx),%eax
801041b2:	50                   	push   %eax
801041b3:	e8 f8 00 00 00       	call   801042b0 <initlock>
  lk->name = name;
801041b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801041bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801041c1:	83 c4 10             	add    $0x10,%esp
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
  lk->locked = 0;
  lk->pid = 0;
801041c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)

void
initsleeplock(struct sleeplock *lk, char *name)
{
  initlock(&lk->lk, "sleep lock");
  lk->name = name;
801041cb:	89 43 38             	mov    %eax,0x38(%ebx)
  lk->locked = 0;
  lk->pid = 0;
}
801041ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041d1:	c9                   	leave  
801041d2:	c3                   	ret    
801041d3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801041d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801041e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801041e0:	55                   	push   %ebp
801041e1:	89 e5                	mov    %esp,%ebp
801041e3:	56                   	push   %esi
801041e4:	53                   	push   %ebx
801041e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801041e8:	83 ec 0c             	sub    $0xc,%esp
801041eb:	8d 73 04             	lea    0x4(%ebx),%esi
801041ee:	56                   	push   %esi
801041ef:	e8 dc 00 00 00       	call   801042d0 <acquire>
  while (lk->locked) {
801041f4:	8b 13                	mov    (%ebx),%edx
801041f6:	83 c4 10             	add    $0x10,%esp
801041f9:	85 d2                	test   %edx,%edx
801041fb:	74 16                	je     80104213 <acquiresleep+0x33>
801041fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104200:	83 ec 08             	sub    $0x8,%esp
80104203:	56                   	push   %esi
80104204:	53                   	push   %ebx
80104205:	e8 46 fc ff ff       	call   80103e50 <sleep>

void
acquiresleep(struct sleeplock *lk)
{
  acquire(&lk->lk);
  while (lk->locked) {
8010420a:	8b 03                	mov    (%ebx),%eax
8010420c:	83 c4 10             	add    $0x10,%esp
8010420f:	85 c0                	test   %eax,%eax
80104211:	75 ed                	jne    80104200 <acquiresleep+0x20>
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
80104213:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = proc->pid;
80104219:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
8010421f:	8b 40 10             	mov    0x10(%eax),%eax
80104222:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104225:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104228:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010422b:	5b                   	pop    %ebx
8010422c:	5e                   	pop    %esi
8010422d:	5d                   	pop    %ebp
  while (lk->locked) {
    sleep(lk, &lk->lk);
  }
  lk->locked = 1;
  lk->pid = proc->pid;
  release(&lk->lk);
8010422e:	e9 7d 02 00 00       	jmp    801044b0 <release>
80104233:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104240 <releasesleep>:
}

void
releasesleep(struct sleeplock *lk)
{
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	56                   	push   %esi
80104244:	53                   	push   %ebx
80104245:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104248:	83 ec 0c             	sub    $0xc,%esp
8010424b:	8d 73 04             	lea    0x4(%ebx),%esi
8010424e:	56                   	push   %esi
8010424f:	e8 7c 00 00 00       	call   801042d0 <acquire>
  lk->locked = 0;
80104254:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010425a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104261:	89 1c 24             	mov    %ebx,(%esp)
80104264:	e8 87 fd ff ff       	call   80103ff0 <wakeup>
  release(&lk->lk);
80104269:	89 75 08             	mov    %esi,0x8(%ebp)
8010426c:	83 c4 10             	add    $0x10,%esp
}
8010426f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104272:	5b                   	pop    %ebx
80104273:	5e                   	pop    %esi
80104274:	5d                   	pop    %ebp
{
  acquire(&lk->lk);
  lk->locked = 0;
  lk->pid = 0;
  wakeup(lk);
  release(&lk->lk);
80104275:	e9 36 02 00 00       	jmp    801044b0 <release>
8010427a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104280 <holdingsleep>:
}

int
holdingsleep(struct sleeplock *lk)
{
80104280:	55                   	push   %ebp
80104281:	89 e5                	mov    %esp,%ebp
80104283:	56                   	push   %esi
80104284:	53                   	push   %ebx
80104285:	8b 75 08             	mov    0x8(%ebp),%esi
  int r;
  
  acquire(&lk->lk);
80104288:	83 ec 0c             	sub    $0xc,%esp
8010428b:	8d 5e 04             	lea    0x4(%esi),%ebx
8010428e:	53                   	push   %ebx
8010428f:	e8 3c 00 00 00       	call   801042d0 <acquire>
  r = lk->locked;
80104294:	8b 36                	mov    (%esi),%esi
  release(&lk->lk);
80104296:	89 1c 24             	mov    %ebx,(%esp)
80104299:	e8 12 02 00 00       	call   801044b0 <release>
  return r;
}
8010429e:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042a1:	89 f0                	mov    %esi,%eax
801042a3:	5b                   	pop    %ebx
801042a4:	5e                   	pop    %esi
801042a5:	5d                   	pop    %ebp
801042a6:	c3                   	ret    
801042a7:	66 90                	xchg   %ax,%ax
801042a9:	66 90                	xchg   %ax,%ax
801042ab:	66 90                	xchg   %ax,%ax
801042ad:	66 90                	xchg   %ax,%ax
801042af:	90                   	nop

801042b0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801042b0:	55                   	push   %ebp
801042b1:	89 e5                	mov    %esp,%ebp
801042b3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801042b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801042b9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
  lk->name = name;
801042bf:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
  lk->cpu = 0;
801042c2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801042c9:	5d                   	pop    %ebp
801042ca:	c3                   	ret    
801042cb:	90                   	nop
801042cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801042d0 <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
801042d0:	55                   	push   %ebp
801042d1:	89 e5                	mov    %esp,%ebp
801042d3:	53                   	push   %ebx
801042d4:	83 ec 04             	sub    $0x4,%esp
801042d7:	9c                   	pushf  
801042d8:	5a                   	pop    %edx
}

static inline void
cli(void)
{
  asm volatile("cli");
801042d9:	fa                   	cli    
{
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
801042da:	65 8b 0d 00 00 00 00 	mov    %gs:0x0,%ecx
801042e1:	8b 81 ac 00 00 00    	mov    0xac(%ecx),%eax
801042e7:	85 c0                	test   %eax,%eax
801042e9:	75 0c                	jne    801042f7 <acquire+0x27>
    cpu->intena = eflags & FL_IF;
801042eb:	81 e2 00 02 00 00    	and    $0x200,%edx
801042f1:	89 91 b0 00 00 00    	mov    %edx,0xb0(%ecx)
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
801042f7:	8b 55 08             	mov    0x8(%ebp),%edx

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
    cpu->intena = eflags & FL_IF;
  cpu->ncli += 1;
801042fa:	83 c0 01             	add    $0x1,%eax
801042fd:	89 81 ac 00 00 00    	mov    %eax,0xac(%ecx)

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104303:	8b 02                	mov    (%edx),%eax
80104305:	85 c0                	test   %eax,%eax
80104307:	74 05                	je     8010430e <acquire+0x3e>
80104309:	39 4a 08             	cmp    %ecx,0x8(%edx)
8010430c:	74 7a                	je     80104388 <acquire+0xb8>
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010430e:	b9 01 00 00 00       	mov    $0x1,%ecx
80104313:	90                   	nop
80104314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104318:	89 c8                	mov    %ecx,%eax
8010431a:	f0 87 02             	lock xchg %eax,(%edx)
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
8010431d:	85 c0                	test   %eax,%eax
8010431f:	75 f7                	jne    80104318 <acquire+0x48>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80104321:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104326:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104329:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
getcallerpcs(void *v, uint pcs[])
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010432f:	89 ea                	mov    %ebp,%edx
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
80104331:	89 41 08             	mov    %eax,0x8(%ecx)
  getcallerpcs(&lk, lk->pcs);
80104334:	83 c1 0c             	add    $0xc,%ecx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104337:	31 c0                	xor    %eax,%eax
80104339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104340:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104346:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010434c:	77 1a                	ja     80104368 <acquire+0x98>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010434e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104351:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104354:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
80104357:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104359:	83 f8 0a             	cmp    $0xa,%eax
8010435c:	75 e2                	jne    80104340 <acquire+0x70>
  __sync_synchronize();

  // Record info about lock acquisition for debugging.
  lk->cpu = cpu;
  getcallerpcs(&lk, lk->pcs);
}
8010435e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104361:	c9                   	leave  
80104362:	c3                   	ret    
80104363:	90                   	nop
80104364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
80104368:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010436f:	83 c0 01             	add    $0x1,%eax
80104372:	83 f8 0a             	cmp    $0xa,%eax
80104375:	74 e7                	je     8010435e <acquire+0x8e>
    pcs[i] = 0;
80104377:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
8010437e:	83 c0 01             	add    $0x1,%eax
80104381:	83 f8 0a             	cmp    $0xa,%eax
80104384:	75 e2                	jne    80104368 <acquire+0x98>
80104386:	eb d6                	jmp    8010435e <acquire+0x8e>
void
acquire(struct spinlock *lk)
{
  pushcli(); // disable interrupts to avoid deadlock.
  if(holding(lk))
    panic("acquire");
80104388:	83 ec 0c             	sub    $0xc,%esp
8010438b:	68 63 79 10 80       	push   $0x80107963
80104390:	e8 db bf ff ff       	call   80100370 <panic>
80104395:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801043a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	53                   	push   %ebx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043a4:	8b 45 08             	mov    0x8(%ebp),%eax
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801043a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801043aa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
801043ad:	31 c0                	xor    %eax,%eax
801043af:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801043b0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801043b6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801043bc:	77 1a                	ja     801043d8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801043be:	8b 5a 04             	mov    0x4(%edx),%ebx
801043c1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043c4:	83 c0 01             	add    $0x1,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
801043c7:	8b 12                	mov    (%edx),%edx
{
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801043c9:	83 f8 0a             	cmp    $0xa,%eax
801043cc:	75 e2                	jne    801043b0 <getcallerpcs+0x10>
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801043ce:	5b                   	pop    %ebx
801043cf:	5d                   	pop    %ebp
801043d0:	c3                   	ret    
801043d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
    pcs[i] = 0;
801043d8:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801043df:	83 c0 01             	add    $0x1,%eax
801043e2:	83 f8 0a             	cmp    $0xa,%eax
801043e5:	74 e7                	je     801043ce <getcallerpcs+0x2e>
    pcs[i] = 0;
801043e7:	c7 04 81 00 00 00 00 	movl   $0x0,(%ecx,%eax,4)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
      break;
    pcs[i] = ebp[1];     // saved %eip
    ebp = (uint*)ebp[0]; // saved %ebp
  }
  for(; i < 10; i++)
801043ee:	83 c0 01             	add    $0x1,%eax
801043f1:	83 f8 0a             	cmp    $0xa,%eax
801043f4:	75 e2                	jne    801043d8 <getcallerpcs+0x38>
801043f6:	eb d6                	jmp    801043ce <getcallerpcs+0x2e>
801043f8:	90                   	nop
801043f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104400 <holding>:
}

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	8b 55 08             	mov    0x8(%ebp),%edx
  return lock->locked && lock->cpu == cpu;
80104406:	8b 02                	mov    (%edx),%eax
80104408:	85 c0                	test   %eax,%eax
8010440a:	74 14                	je     80104420 <holding+0x20>
8010440c:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80104412:	39 42 08             	cmp    %eax,0x8(%edx)
}
80104415:	5d                   	pop    %ebp

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
80104416:	0f 94 c0             	sete   %al
80104419:	0f b6 c0             	movzbl %al,%eax
}
8010441c:	c3                   	ret    
8010441d:	8d 76 00             	lea    0x0(%esi),%esi
80104420:	31 c0                	xor    %eax,%eax
80104422:	5d                   	pop    %ebp
80104423:	c3                   	ret    
80104424:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010442a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104430 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104433:	9c                   	pushf  
80104434:	59                   	pop    %ecx
}

static inline void
cli(void)
{
  asm volatile("cli");
80104435:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(cpu->ncli == 0)
80104436:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
8010443d:	8b 82 ac 00 00 00    	mov    0xac(%edx),%eax
80104443:	85 c0                	test   %eax,%eax
80104445:	75 0c                	jne    80104453 <pushcli+0x23>
    cpu->intena = eflags & FL_IF;
80104447:	81 e1 00 02 00 00    	and    $0x200,%ecx
8010444d:	89 8a b0 00 00 00    	mov    %ecx,0xb0(%edx)
  cpu->ncli += 1;
80104453:	83 c0 01             	add    $0x1,%eax
80104456:	89 82 ac 00 00 00    	mov    %eax,0xac(%edx)
}
8010445c:	5d                   	pop    %ebp
8010445d:	c3                   	ret    
8010445e:	66 90                	xchg   %ax,%ax

80104460 <popcli>:

void
popcli(void)
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	83 ec 08             	sub    $0x8,%esp

static inline uint
readeflags(void)
{
  uint eflags;
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104466:	9c                   	pushf  
80104467:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104468:	f6 c4 02             	test   $0x2,%ah
8010446b:	75 2c                	jne    80104499 <popcli+0x39>
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
8010446d:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
80104474:	83 aa ac 00 00 00 01 	subl   $0x1,0xac(%edx)
8010447b:	78 0f                	js     8010448c <popcli+0x2c>
    panic("popcli");
  if(cpu->ncli == 0 && cpu->intena)
8010447d:	75 0b                	jne    8010448a <popcli+0x2a>
8010447f:	8b 82 b0 00 00 00    	mov    0xb0(%edx),%eax
80104485:	85 c0                	test   %eax,%eax
80104487:	74 01                	je     8010448a <popcli+0x2a>
}

static inline void
sti(void)
{
  asm volatile("sti");
80104489:	fb                   	sti    
    sti();
}
8010448a:	c9                   	leave  
8010448b:	c3                   	ret    
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
  if(--cpu->ncli < 0)
    panic("popcli");
8010448c:	83 ec 0c             	sub    $0xc,%esp
8010448f:	68 82 79 10 80       	push   $0x80107982
80104494:	e8 d7 be ff ff       	call   80100370 <panic>

void
popcli(void)
{
  if(readeflags()&FL_IF)
    panic("popcli - interruptible");
80104499:	83 ec 0c             	sub    $0xc,%esp
8010449c:	68 6b 79 10 80       	push   $0x8010796b
801044a1:	e8 ca be ff ff       	call   80100370 <panic>
801044a6:	8d 76 00             	lea    0x0(%esi),%esi
801044a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801044b0 <release>:
}

// Release the lock.
void
release(struct spinlock *lk)
{
801044b0:	55                   	push   %ebp
801044b1:	89 e5                	mov    %esp,%ebp
801044b3:	83 ec 08             	sub    $0x8,%esp
801044b6:	8b 45 08             	mov    0x8(%ebp),%eax

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
  return lock->locked && lock->cpu == cpu;
801044b9:	8b 10                	mov    (%eax),%edx
801044bb:	85 d2                	test   %edx,%edx
801044bd:	74 0c                	je     801044cb <release+0x1b>
801044bf:	65 8b 15 00 00 00 00 	mov    %gs:0x0,%edx
801044c6:	39 50 08             	cmp    %edx,0x8(%eax)
801044c9:	74 15                	je     801044e0 <release+0x30>
// Release the lock.
void
release(struct spinlock *lk)
{
  if(!holding(lk))
    panic("release");
801044cb:	83 ec 0c             	sub    $0xc,%esp
801044ce:	68 89 79 10 80       	push   $0x80107989
801044d3:	e8 98 be ff ff       	call   80100370 <panic>
801044d8:	90                   	nop
801044d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  lk->pcs[0] = 0;
801044e0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801044e7:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801044ee:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801044f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
}
801044f9:	c9                   	leave  
  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );

  popcli();
801044fa:	e9 61 ff ff ff       	jmp    80104460 <popcli>
801044ff:	90                   	nop

80104500 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	57                   	push   %edi
80104504:	53                   	push   %ebx
80104505:	8b 55 08             	mov    0x8(%ebp),%edx
80104508:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010450b:	f6 c2 03             	test   $0x3,%dl
8010450e:	75 05                	jne    80104515 <memset+0x15>
80104510:	f6 c1 03             	test   $0x3,%cl
80104513:	74 13                	je     80104528 <memset+0x28>
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
80104515:	89 d7                	mov    %edx,%edi
80104517:	8b 45 0c             	mov    0xc(%ebp),%eax
8010451a:	fc                   	cld    
8010451b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
8010451d:	5b                   	pop    %ebx
8010451e:	89 d0                	mov    %edx,%eax
80104520:	5f                   	pop    %edi
80104521:	5d                   	pop    %ebp
80104522:	c3                   	ret    
80104523:	90                   	nop
80104524:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

void*
memset(void *dst, int c, uint n)
{
  if ((int)dst%4 == 0 && n%4 == 0){
    c &= 0xFF;
80104528:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
}

static inline void
stosl(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosl" :
8010452c:	c1 e9 02             	shr    $0x2,%ecx
8010452f:	89 fb                	mov    %edi,%ebx
80104531:	89 f8                	mov    %edi,%eax
80104533:	c1 e3 18             	shl    $0x18,%ebx
80104536:	c1 e0 10             	shl    $0x10,%eax
80104539:	09 d8                	or     %ebx,%eax
8010453b:	09 f8                	or     %edi,%eax
8010453d:	c1 e7 08             	shl    $0x8,%edi
80104540:	09 f8                	or     %edi,%eax
80104542:	89 d7                	mov    %edx,%edi
80104544:	fc                   	cld    
80104545:	f3 ab                	rep stos %eax,%es:(%edi)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104547:	5b                   	pop    %ebx
80104548:	89 d0                	mov    %edx,%eax
8010454a:	5f                   	pop    %edi
8010454b:	5d                   	pop    %ebp
8010454c:	c3                   	ret    
8010454d:	8d 76 00             	lea    0x0(%esi),%esi

80104550 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	57                   	push   %edi
80104554:	56                   	push   %esi
80104555:	8b 45 10             	mov    0x10(%ebp),%eax
80104558:	53                   	push   %ebx
80104559:	8b 75 0c             	mov    0xc(%ebp),%esi
8010455c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010455f:	85 c0                	test   %eax,%eax
80104561:	74 29                	je     8010458c <memcmp+0x3c>
    if(*s1 != *s2)
80104563:	0f b6 13             	movzbl (%ebx),%edx
80104566:	0f b6 0e             	movzbl (%esi),%ecx
80104569:	38 d1                	cmp    %dl,%cl
8010456b:	75 2b                	jne    80104598 <memcmp+0x48>
8010456d:	8d 78 ff             	lea    -0x1(%eax),%edi
80104570:	31 c0                	xor    %eax,%eax
80104572:	eb 14                	jmp    80104588 <memcmp+0x38>
80104574:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104578:	0f b6 54 03 01       	movzbl 0x1(%ebx,%eax,1),%edx
8010457d:	83 c0 01             	add    $0x1,%eax
80104580:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104584:	38 ca                	cmp    %cl,%dl
80104586:	75 10                	jne    80104598 <memcmp+0x48>
{
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104588:	39 f8                	cmp    %edi,%eax
8010458a:	75 ec                	jne    80104578 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
8010458c:	5b                   	pop    %ebx
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
8010458d:	31 c0                	xor    %eax,%eax
}
8010458f:	5e                   	pop    %esi
80104590:	5f                   	pop    %edi
80104591:	5d                   	pop    %ebp
80104592:	c3                   	ret    
80104593:	90                   	nop
80104594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
80104598:	0f b6 c2             	movzbl %dl,%eax
    s1++, s2++;
  }

  return 0;
}
8010459b:	5b                   	pop    %ebx

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    if(*s1 != *s2)
      return *s1 - *s2;
8010459c:	29 c8                	sub    %ecx,%eax
    s1++, s2++;
  }

  return 0;
}
8010459e:	5e                   	pop    %esi
8010459f:	5f                   	pop    %edi
801045a0:	5d                   	pop    %ebp
801045a1:	c3                   	ret    
801045a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045b0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	56                   	push   %esi
801045b4:	53                   	push   %ebx
801045b5:	8b 45 08             	mov    0x8(%ebp),%eax
801045b8:	8b 75 0c             	mov    0xc(%ebp),%esi
801045bb:	8b 5d 10             	mov    0x10(%ebp),%ebx
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801045be:	39 c6                	cmp    %eax,%esi
801045c0:	73 2e                	jae    801045f0 <memmove+0x40>
801045c2:	8d 0c 1e             	lea    (%esi,%ebx,1),%ecx
801045c5:	39 c8                	cmp    %ecx,%eax
801045c7:	73 27                	jae    801045f0 <memmove+0x40>
    s += n;
    d += n;
    while(n-- > 0)
801045c9:	85 db                	test   %ebx,%ebx
801045cb:	8d 53 ff             	lea    -0x1(%ebx),%edx
801045ce:	74 17                	je     801045e7 <memmove+0x37>
      *--d = *--s;
801045d0:	29 d9                	sub    %ebx,%ecx
801045d2:	89 cb                	mov    %ecx,%ebx
801045d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801045d8:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
801045dc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
  s = src;
  d = dst;
  if(s < d && s + n > d){
    s += n;
    d += n;
    while(n-- > 0)
801045df:	83 ea 01             	sub    $0x1,%edx
801045e2:	83 fa ff             	cmp    $0xffffffff,%edx
801045e5:	75 f1                	jne    801045d8 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801045e7:	5b                   	pop    %ebx
801045e8:	5e                   	pop    %esi
801045e9:	5d                   	pop    %ebp
801045ea:	c3                   	ret    
801045eb:	90                   	nop
801045ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
801045f0:	31 d2                	xor    %edx,%edx
801045f2:	85 db                	test   %ebx,%ebx
801045f4:	74 f1                	je     801045e7 <memmove+0x37>
801045f6:	8d 76 00             	lea    0x0(%esi),%esi
801045f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      *d++ = *s++;
80104600:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
80104604:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104607:	83 c2 01             	add    $0x1,%edx
    s += n;
    d += n;
    while(n-- > 0)
      *--d = *--s;
  } else
    while(n-- > 0)
8010460a:	39 d3                	cmp    %edx,%ebx
8010460c:	75 f2                	jne    80104600 <memmove+0x50>
      *d++ = *s++;

  return dst;
}
8010460e:	5b                   	pop    %ebx
8010460f:	5e                   	pop    %esi
80104610:	5d                   	pop    %ebp
80104611:	c3                   	ret    
80104612:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104620 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104620:	55                   	push   %ebp
80104621:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104623:	5d                   	pop    %ebp

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104624:	eb 8a                	jmp    801045b0 <memmove>
80104626:	8d 76 00             	lea    0x0(%esi),%esi
80104629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104630 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	57                   	push   %edi
80104634:	56                   	push   %esi
80104635:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104638:	53                   	push   %ebx
80104639:	8b 7d 08             	mov    0x8(%ebp),%edi
8010463c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
8010463f:	85 c9                	test   %ecx,%ecx
80104641:	74 37                	je     8010467a <strncmp+0x4a>
80104643:	0f b6 17             	movzbl (%edi),%edx
80104646:	0f b6 1e             	movzbl (%esi),%ebx
80104649:	84 d2                	test   %dl,%dl
8010464b:	74 3f                	je     8010468c <strncmp+0x5c>
8010464d:	38 d3                	cmp    %dl,%bl
8010464f:	75 3b                	jne    8010468c <strncmp+0x5c>
80104651:	8d 47 01             	lea    0x1(%edi),%eax
80104654:	01 cf                	add    %ecx,%edi
80104656:	eb 1b                	jmp    80104673 <strncmp+0x43>
80104658:	90                   	nop
80104659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104660:	0f b6 10             	movzbl (%eax),%edx
80104663:	84 d2                	test   %dl,%dl
80104665:	74 21                	je     80104688 <strncmp+0x58>
80104667:	0f b6 19             	movzbl (%ecx),%ebx
8010466a:	83 c0 01             	add    $0x1,%eax
8010466d:	89 ce                	mov    %ecx,%esi
8010466f:	38 da                	cmp    %bl,%dl
80104671:	75 19                	jne    8010468c <strncmp+0x5c>
80104673:	39 c7                	cmp    %eax,%edi
    n--, p++, q++;
80104675:	8d 4e 01             	lea    0x1(%esi),%ecx
}

int
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
80104678:	75 e6                	jne    80104660 <strncmp+0x30>
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
8010467a:	5b                   	pop    %ebx
strncmp(const char *p, const char *q, uint n)
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
8010467b:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
}
8010467d:	5e                   	pop    %esi
8010467e:	5f                   	pop    %edi
8010467f:	5d                   	pop    %ebp
80104680:	c3                   	ret    
80104681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104688:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
{
  while(n > 0 && *p && *p == *q)
    n--, p++, q++;
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010468c:	0f b6 c2             	movzbl %dl,%eax
8010468f:	29 d8                	sub    %ebx,%eax
}
80104691:	5b                   	pop    %ebx
80104692:	5e                   	pop    %esi
80104693:	5f                   	pop    %edi
80104694:	5d                   	pop    %ebp
80104695:	c3                   	ret    
80104696:	8d 76 00             	lea    0x0(%esi),%esi
80104699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046a0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	56                   	push   %esi
801046a4:	53                   	push   %ebx
801046a5:	8b 45 08             	mov    0x8(%ebp),%eax
801046a8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801046ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801046ae:	89 c2                	mov    %eax,%edx
801046b0:	eb 19                	jmp    801046cb <strncpy+0x2b>
801046b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046b8:	83 c3 01             	add    $0x1,%ebx
801046bb:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
801046bf:	83 c2 01             	add    $0x1,%edx
801046c2:	84 c9                	test   %cl,%cl
801046c4:	88 4a ff             	mov    %cl,-0x1(%edx)
801046c7:	74 09                	je     801046d2 <strncpy+0x32>
801046c9:	89 f1                	mov    %esi,%ecx
801046cb:	85 c9                	test   %ecx,%ecx
801046cd:	8d 71 ff             	lea    -0x1(%ecx),%esi
801046d0:	7f e6                	jg     801046b8 <strncpy+0x18>
    ;
  while(n-- > 0)
801046d2:	31 c9                	xor    %ecx,%ecx
801046d4:	85 f6                	test   %esi,%esi
801046d6:	7e 17                	jle    801046ef <strncpy+0x4f>
801046d8:	90                   	nop
801046d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
801046e0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
801046e4:	89 f3                	mov    %esi,%ebx
801046e6:	83 c1 01             	add    $0x1,%ecx
801046e9:	29 cb                	sub    %ecx,%ebx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    ;
  while(n-- > 0)
801046eb:	85 db                	test   %ebx,%ebx
801046ed:	7f f1                	jg     801046e0 <strncpy+0x40>
    *s++ = 0;
  return os;
}
801046ef:	5b                   	pop    %ebx
801046f0:	5e                   	pop    %esi
801046f1:	5d                   	pop    %ebp
801046f2:	c3                   	ret    
801046f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104700 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104700:	55                   	push   %ebp
80104701:	89 e5                	mov    %esp,%ebp
80104703:	56                   	push   %esi
80104704:	53                   	push   %ebx
80104705:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104708:	8b 45 08             	mov    0x8(%ebp),%eax
8010470b:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
8010470e:	85 c9                	test   %ecx,%ecx
80104710:	7e 26                	jle    80104738 <safestrcpy+0x38>
80104712:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104716:	89 c1                	mov    %eax,%ecx
80104718:	eb 17                	jmp    80104731 <safestrcpy+0x31>
8010471a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104720:	83 c2 01             	add    $0x1,%edx
80104723:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104727:	83 c1 01             	add    $0x1,%ecx
8010472a:	84 db                	test   %bl,%bl
8010472c:	88 59 ff             	mov    %bl,-0x1(%ecx)
8010472f:	74 04                	je     80104735 <safestrcpy+0x35>
80104731:	39 f2                	cmp    %esi,%edx
80104733:	75 eb                	jne    80104720 <safestrcpy+0x20>
    ;
  *s = 0;
80104735:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104738:	5b                   	pop    %ebx
80104739:	5e                   	pop    %esi
8010473a:	5d                   	pop    %ebp
8010473b:	c3                   	ret    
8010473c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104740 <strlen>:

int
strlen(const char *s)
{
80104740:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104741:	31 c0                	xor    %eax,%eax
  return os;
}

int
strlen(const char *s)
{
80104743:	89 e5                	mov    %esp,%ebp
80104745:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
80104748:	80 3a 00             	cmpb   $0x0,(%edx)
8010474b:	74 0c                	je     80104759 <strlen+0x19>
8010474d:	8d 76 00             	lea    0x0(%esi),%esi
80104750:	83 c0 01             	add    $0x1,%eax
80104753:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104757:	75 f7                	jne    80104750 <strlen+0x10>
    ;
  return n;
}
80104759:	5d                   	pop    %ebp
8010475a:	c3                   	ret    

8010475b <swtch>:
# Save current register context in old
# and then load register context from new.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010475b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010475f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-save registers
  pushl %ebp
80104763:	55                   	push   %ebp
  pushl %ebx
80104764:	53                   	push   %ebx
  pushl %esi
80104765:	56                   	push   %esi
  pushl %edi
80104766:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104767:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104769:	89 d4                	mov    %edx,%esp

  # Load new callee-save registers
  popl %edi
8010476b:	5f                   	pop    %edi
  popl %esi
8010476c:	5e                   	pop    %esi
  popl %ebx
8010476d:	5b                   	pop    %ebx
  popl %ebp
8010476e:	5d                   	pop    %ebp
  ret
8010476f:	c3                   	ret    

80104770 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104770:	55                   	push   %ebp
  if(addr >= proc->sz || addr+4 > proc->sz)
80104771:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104778:	89 e5                	mov    %esp,%ebp
8010477a:	8b 45 08             	mov    0x8(%ebp),%eax
  if(addr >= proc->sz || addr+4 > proc->sz)
8010477d:	8b 12                	mov    (%edx),%edx
8010477f:	39 c2                	cmp    %eax,%edx
80104781:	76 15                	jbe    80104798 <fetchint+0x28>
80104783:	8d 48 04             	lea    0x4(%eax),%ecx
80104786:	39 ca                	cmp    %ecx,%edx
80104788:	72 0e                	jb     80104798 <fetchint+0x28>
    return -1;
  *ip = *(int*)(addr);
8010478a:	8b 10                	mov    (%eax),%edx
8010478c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010478f:	89 10                	mov    %edx,(%eax)
  return 0;
80104791:	31 c0                	xor    %eax,%eax
}
80104793:	5d                   	pop    %ebp
80104794:	c3                   	ret    
80104795:	8d 76 00             	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104798:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  *ip = *(int*)(addr);
  return 0;
}
8010479d:	5d                   	pop    %ebp
8010479e:	c3                   	ret    
8010479f:	90                   	nop

801047a0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047a0:	55                   	push   %ebp
  char *s, *ep;

  if(addr >= proc->sz)
801047a1:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801047a7:	89 e5                	mov    %esp,%ebp
801047a9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  char *s, *ep;

  if(addr >= proc->sz)
801047ac:	39 08                	cmp    %ecx,(%eax)
801047ae:	76 2c                	jbe    801047dc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
801047b0:	8b 55 0c             	mov    0xc(%ebp),%edx
801047b3:	89 c8                	mov    %ecx,%eax
801047b5:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801047b7:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801047be:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801047c0:	39 d1                	cmp    %edx,%ecx
801047c2:	73 18                	jae    801047dc <fetchstr+0x3c>
    if(*s == 0)
801047c4:	80 39 00             	cmpb   $0x0,(%ecx)
801047c7:	75 0c                	jne    801047d5 <fetchstr+0x35>
801047c9:	eb 1d                	jmp    801047e8 <fetchstr+0x48>
801047cb:	90                   	nop
801047cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801047d0:	80 38 00             	cmpb   $0x0,(%eax)
801047d3:	74 13                	je     801047e8 <fetchstr+0x48>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801047d5:	83 c0 01             	add    $0x1,%eax
801047d8:	39 c2                	cmp    %eax,%edx
801047da:	77 f4                	ja     801047d0 <fetchstr+0x30>
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
    return -1;
801047dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
  return -1;
}
801047e1:	5d                   	pop    %ebp
801047e2:	c3                   	ret    
801047e3:	90                   	nop
801047e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
    if(*s == 0)
      return s - *pp;
801047e8:	29 c8                	sub    %ecx,%eax
  return -1;
}
801047ea:	5d                   	pop    %ebp
801047eb:	c3                   	ret    
801047ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047f0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801047f0:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
}

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801047f7:	55                   	push   %ebp
801047f8:	89 e5                	mov    %esp,%ebp
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
801047fa:	8b 42 18             	mov    0x18(%edx),%eax
801047fd:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104800:	8b 12                	mov    (%edx),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104802:	8b 40 44             	mov    0x44(%eax),%eax
80104805:	8d 04 88             	lea    (%eax,%ecx,4),%eax
80104808:	8d 48 04             	lea    0x4(%eax),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010480b:	39 d1                	cmp    %edx,%ecx
8010480d:	73 19                	jae    80104828 <argint+0x38>
8010480f:	8d 48 08             	lea    0x8(%eax),%ecx
80104812:	39 ca                	cmp    %ecx,%edx
80104814:	72 12                	jb     80104828 <argint+0x38>
    return -1;
  *ip = *(int*)(addr);
80104816:	8b 50 04             	mov    0x4(%eax),%edx
80104819:	8b 45 0c             	mov    0xc(%ebp),%eax
8010481c:	89 10                	mov    %edx,(%eax)
  return 0;
8010481e:	31 c0                	xor    %eax,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
80104820:	5d                   	pop    %ebp
80104821:	c3                   	ret    
80104822:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
80104828:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
}
8010482d:	5d                   	pop    %ebp
8010482e:	c3                   	ret    
8010482f:	90                   	nop

80104830 <argptr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104830:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104836:	55                   	push   %ebp
80104837:	89 e5                	mov    %esp,%ebp
80104839:	56                   	push   %esi
8010483a:	53                   	push   %ebx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
8010483b:	8b 48 18             	mov    0x18(%eax),%ecx
8010483e:	8b 5d 08             	mov    0x8(%ebp),%ebx
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104841:	8b 55 10             	mov    0x10(%ebp),%edx

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104844:	8b 49 44             	mov    0x44(%ecx),%ecx
80104847:	8d 1c 99             	lea    (%ecx,%ebx,4),%ebx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010484a:	8b 08                	mov    (%eax),%ecx
argptr(int n, char **pp, int size)
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
8010484c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104851:	8d 73 04             	lea    0x4(%ebx),%esi

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
80104854:	39 ce                	cmp    %ecx,%esi
80104856:	73 1f                	jae    80104877 <argptr+0x47>
80104858:	8d 73 08             	lea    0x8(%ebx),%esi
8010485b:	39 f1                	cmp    %esi,%ecx
8010485d:	72 18                	jb     80104877 <argptr+0x47>
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
8010485f:	85 d2                	test   %edx,%edx
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
80104861:	8b 5b 04             	mov    0x4(%ebx),%ebx
{
  int i;

  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= proc->sz || (uint)i+size > proc->sz)
80104864:	78 11                	js     80104877 <argptr+0x47>
80104866:	39 cb                	cmp    %ecx,%ebx
80104868:	73 0d                	jae    80104877 <argptr+0x47>
8010486a:	01 da                	add    %ebx,%edx
8010486c:	39 ca                	cmp    %ecx,%edx
8010486e:	77 07                	ja     80104877 <argptr+0x47>
    return -1;
  *pp = (char*)i;
80104870:	8b 45 0c             	mov    0xc(%ebp),%eax
80104873:	89 18                	mov    %ebx,(%eax)
  return 0;
80104875:	31 c0                	xor    %eax,%eax
}
80104877:	5b                   	pop    %ebx
80104878:	5e                   	pop    %esi
80104879:	5d                   	pop    %ebp
8010487a:	c3                   	ret    
8010487b:	90                   	nop
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104880 <argstr>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104880:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104886:	55                   	push   %ebp
80104887:	89 e5                	mov    %esp,%ebp

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104889:	8b 50 18             	mov    0x18(%eax),%edx
8010488c:	8b 4d 08             	mov    0x8(%ebp),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010488f:	8b 00                	mov    (%eax),%eax

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
  return fetchint(proc->tf->esp + 4 + 4*n, ip);
80104891:	8b 52 44             	mov    0x44(%edx),%edx
80104894:	8d 14 8a             	lea    (%edx,%ecx,4),%edx
80104897:	8d 4a 04             	lea    0x4(%edx),%ecx

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
8010489a:	39 c1                	cmp    %eax,%ecx
8010489c:	73 07                	jae    801048a5 <argstr+0x25>
8010489e:	8d 4a 08             	lea    0x8(%edx),%ecx
801048a1:	39 c8                	cmp    %ecx,%eax
801048a3:	73 0b                	jae    801048b0 <argstr+0x30>
int
argstr(int n, char **pp)
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
801048a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchstr(addr, pp);
}
801048aa:	5d                   	pop    %ebp
801048ab:	c3                   	ret    
801048ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fetchint(uint addr, int *ip)
{
  if(addr >= proc->sz || addr+4 > proc->sz)
    return -1;
  *ip = *(int*)(addr);
801048b0:	8b 4a 04             	mov    0x4(%edx),%ecx
int
fetchstr(uint addr, char **pp)
{
  char *s, *ep;

  if(addr >= proc->sz)
801048b3:	39 c1                	cmp    %eax,%ecx
801048b5:	73 ee                	jae    801048a5 <argstr+0x25>
    return -1;
  *pp = (char*)addr;
801048b7:	8b 55 0c             	mov    0xc(%ebp),%edx
801048ba:	89 c8                	mov    %ecx,%eax
801048bc:	89 0a                	mov    %ecx,(%edx)
  ep = (char*)proc->sz;
801048be:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801048c5:	8b 12                	mov    (%edx),%edx
  for(s = *pp; s < ep; s++)
801048c7:	39 d1                	cmp    %edx,%ecx
801048c9:	73 da                	jae    801048a5 <argstr+0x25>
    if(*s == 0)
801048cb:	80 39 00             	cmpb   $0x0,(%ecx)
801048ce:	75 0d                	jne    801048dd <argstr+0x5d>
801048d0:	eb 1e                	jmp    801048f0 <argstr+0x70>
801048d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048d8:	80 38 00             	cmpb   $0x0,(%eax)
801048db:	74 13                	je     801048f0 <argstr+0x70>

  if(addr >= proc->sz)
    return -1;
  *pp = (char*)addr;
  ep = (char*)proc->sz;
  for(s = *pp; s < ep; s++)
801048dd:	83 c0 01             	add    $0x1,%eax
801048e0:	39 c2                	cmp    %eax,%edx
801048e2:	77 f4                	ja     801048d8 <argstr+0x58>
801048e4:	eb bf                	jmp    801048a5 <argstr+0x25>
801048e6:	8d 76 00             	lea    0x0(%esi),%esi
801048e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    if(*s == 0)
      return s - *pp;
801048f0:	29 c8                	sub    %ecx,%eax
{
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801048f2:	5d                   	pop    %ebp
801048f3:	c3                   	ret    
801048f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801048fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104900 <getcountinit>:

// Check if initialized
int init = 0;

// Initializes data structures for getcount()
void getcountinit() {
80104900:	55                   	push   %ebp
80104901:	89 e5                	mov    %esp,%ebp
80104903:	83 ec 10             	sub    $0x10,%esp
  initlock(&lock, "getcount lock");
80104906:	68 91 79 10 80       	push   $0x80107991
8010490b:	68 e0 4c 11 80       	push   $0x80114ce0
80104910:	e8 9b f9 ff ff       	call   801042b0 <initlock>
  init = 1;
80104915:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
8010491c:	00 00 00 
}
8010491f:	83 c4 10             	add    $0x10,%esp
80104922:	c9                   	leave  
80104923:	c3                   	ret    
80104924:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010492a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104930 <syscall>:
[SYS_mkSmallFilesdir]   sys_mkSmallFilesdir,
};

void
syscall(void)
{
80104930:	55                   	push   %ebp
80104931:	89 e5                	mov    %esp,%ebp
80104933:	53                   	push   %ebx
80104934:	83 ec 04             	sub    $0x4,%esp
  if (init == 0) {
80104937:	a1 c0 a5 10 80       	mov    0x8010a5c0,%eax
8010493c:	85 c0                	test   %eax,%eax
8010493e:	0f 84 8c 00 00 00    	je     801049d0 <syscall+0xa0>
    getcountinit();
    init = 1;
  }
  int num;

  num = proc->tf->eax;
80104944:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  acquire(&lock);
8010494a:	83 ec 0c             	sub    $0xc,%esp
    getcountinit();
    init = 1;
  }
  int num;

  num = proc->tf->eax;
8010494d:	8b 40 18             	mov    0x18(%eax),%eax
80104950:	8b 58 1c             	mov    0x1c(%eax),%ebx
  acquire(&lock);
80104953:	68 e0 4c 11 80       	push   $0x80114ce0
80104958:	e8 73 f9 ff ff       	call   801042d0 <acquire>
  updatecount(num);
8010495d:	89 1c 24             	mov    %ebx,(%esp)
80104960:	e8 2b 0d 00 00       	call   80105690 <updatecount>
  release(&lock);
80104965:	c7 04 24 e0 4c 11 80 	movl   $0x80114ce0,(%esp)
8010496c:	e8 3f fb ff ff       	call   801044b0 <release>
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
80104971:	83 c4 10             	add    $0x10,%esp
80104974:	83 fb 18             	cmp    $0x18,%ebx
80104977:	77 27                	ja     801049a0 <syscall+0x70>
80104979:	8b 04 9d c0 79 10 80 	mov    -0x7fef8640(,%ebx,4),%eax
80104980:	85 c0                	test   %eax,%eax
80104982:	74 1c                	je     801049a0 <syscall+0x70>
    proc->tf->eax = syscalls[num]();
80104984:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
8010498b:	8b 5a 18             	mov    0x18(%edx),%ebx
8010498e:	ff d0                	call   *%eax
80104990:	89 43 1c             	mov    %eax,0x1c(%ebx)
  else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
  }
}
80104993:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104996:	c9                   	leave  
80104997:	c3                   	ret    
80104998:	90                   	nop
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&lock);
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
            proc->pid, proc->name, num);
801049a0:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  updatecount(num);
  release(&lock);
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
801049a6:	53                   	push   %ebx
            proc->pid, proc->name, num);
801049a7:	8d 50 6c             	lea    0x6c(%eax),%edx
  updatecount(num);
  release(&lock);
  if(num >= 0 && num < NELEM(syscalls) && syscalls[num])
    proc->tf->eax = syscalls[num]();
  else {
    cprintf("%d %s: unknown sys call %d\n",
801049aa:	52                   	push   %edx
801049ab:	ff 70 10             	pushl  0x10(%eax)
801049ae:	68 9f 79 10 80       	push   $0x8010799f
801049b3:	e8 a8 bc ff ff       	call   80100660 <cprintf>
            proc->pid, proc->name, num);
    proc->tf->eax = -1;
801049b8:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
801049be:	83 c4 10             	add    $0x10,%esp
801049c1:	8b 40 18             	mov    0x18(%eax),%eax
801049c4:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
801049cb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049ce:	c9                   	leave  
801049cf:	c3                   	ret    
// Check if initialized
int init = 0;

// Initializes data structures for getcount()
void getcountinit() {
  initlock(&lock, "getcount lock");
801049d0:	83 ec 08             	sub    $0x8,%esp
801049d3:	68 91 79 10 80       	push   $0x80107991
801049d8:	68 e0 4c 11 80       	push   $0x80114ce0
801049dd:	e8 ce f8 ff ff       	call   801042b0 <initlock>
  init = 1;
801049e2:	c7 05 c0 a5 10 80 01 	movl   $0x1,0x8010a5c0
801049e9:	00 00 00 
801049ec:	83 c4 10             	add    $0x10,%esp
801049ef:	e9 50 ff ff ff       	jmp    80104944 <syscall+0x14>
801049f4:	66 90                	xchg   %ax,%ax
801049f6:	66 90                	xchg   %ax,%ax
801049f8:	66 90                	xchg   %ax,%ax
801049fa:	66 90                	xchg   %ax,%ax
801049fc:	66 90                	xchg   %ax,%ax
801049fe:	66 90                	xchg   %ax,%ax

80104a00 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	57                   	push   %edi
80104a04:	56                   	push   %esi
80104a05:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a06:	8d 75 da             	lea    -0x26(%ebp),%esi
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a09:	83 ec 44             	sub    $0x44,%esp
80104a0c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104a0f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a12:	56                   	push   %esi
80104a13:	50                   	push   %eax
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104a14:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104a17:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104a1a:	e8 01 d5 ff ff       	call   80101f20 <nameiparent>
80104a1f:	83 c4 10             	add    $0x10,%esp
80104a22:	85 c0                	test   %eax,%eax
80104a24:	0f 84 66 01 00 00    	je     80104b90 <create+0x190>
    return 0;
  ilock(dp);
80104a2a:	83 ec 0c             	sub    $0xc,%esp
80104a2d:	89 c7                	mov    %eax,%edi
80104a2f:	50                   	push   %eax
80104a30:	e8 1b cc ff ff       	call   80101650 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104a35:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104a38:	83 c4 0c             	add    $0xc,%esp
80104a3b:	50                   	push   %eax
80104a3c:	56                   	push   %esi
80104a3d:	57                   	push   %edi
80104a3e:	e8 9d d1 ff ff       	call   80101be0 <dirlookup>
80104a43:	83 c4 10             	add    $0x10,%esp
80104a46:	85 c0                	test   %eax,%eax
80104a48:	89 c3                	mov    %eax,%ebx
80104a4a:	74 5c                	je     80104aa8 <create+0xa8>
    iunlockput(dp);
80104a4c:	83 ec 0c             	sub    $0xc,%esp
80104a4f:	57                   	push   %edi
80104a50:	e8 6b ce ff ff       	call   801018c0 <iunlockput>
    ilock(ip);
80104a55:	89 1c 24             	mov    %ebx,(%esp)
80104a58:	e8 f3 cb ff ff       	call   80101650 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104a5d:	83 c4 10             	add    $0x10,%esp
80104a60:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104a65:	74 19                	je     80104a80 <create+0x80>
      return ip;

    if(type == T_SMALLFILE && ip->type == T_SMALLFILE)
80104a67:	66 83 7d c4 05       	cmpw   $0x5,-0x3c(%ebp)
80104a6c:	75 1d                	jne    80104a8b <create+0x8b>
80104a6e:	66 83 7b 50 05       	cmpw   $0x5,0x50(%ebx)
80104a73:	89 d8                	mov    %ebx,%eax
80104a75:	75 14                	jne    80104a8b <create+0x8b>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a77:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a7a:	5b                   	pop    %ebx
80104a7b:	5e                   	pop    %esi
80104a7c:	5f                   	pop    %edi
80104a7d:	5d                   	pop    %ebp
80104a7e:	c3                   	ret    
80104a7f:	90                   	nop
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
80104a80:	66 83 7b 50 02       	cmpw   $0x2,0x50(%ebx)
80104a85:	0f 84 f5 00 00 00    	je     80104b80 <create+0x180>
      return ip;

    if(type == T_SMALLFILE && ip->type == T_SMALLFILE)
      return ip;
    iunlockput(ip);
80104a8b:	83 ec 0c             	sub    $0xc,%esp
80104a8e:	53                   	push   %ebx
80104a8f:	e8 2c ce ff ff       	call   801018c0 <iunlockput>
    return 0;
80104a94:	83 c4 10             	add    $0x10,%esp
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a97:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return ip;

    if(type == T_SMALLFILE && ip->type == T_SMALLFILE)
      return ip;
    iunlockput(ip);
    return 0;
80104a9a:	31 c0                	xor    %eax,%eax
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104a9c:	5b                   	pop    %ebx
80104a9d:	5e                   	pop    %esi
80104a9e:	5f                   	pop    %edi
80104a9f:	5d                   	pop    %ebp
80104aa0:	c3                   	ret    
80104aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80104aa8:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104aac:	83 ec 08             	sub    $0x8,%esp
80104aaf:	50                   	push   %eax
80104ab0:	ff 37                	pushl  (%edi)
80104ab2:	e8 29 ca ff ff       	call   801014e0 <ialloc>
80104ab7:	83 c4 10             	add    $0x10,%esp
80104aba:	85 c0                	test   %eax,%eax
80104abc:	89 c3                	mov    %eax,%ebx
80104abe:	0f 84 e0 00 00 00    	je     80104ba4 <create+0x1a4>
    panic("create: ialloc");

  ilock(ip);
80104ac4:	83 ec 0c             	sub    $0xc,%esp
80104ac7:	50                   	push   %eax
80104ac8:	e8 83 cb ff ff       	call   80101650 <ilock>
  ip->major = major;
80104acd:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104ad1:	66 89 43 52          	mov    %ax,0x52(%ebx)
  ip->minor = minor;
80104ad5:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104ad9:	66 89 43 54          	mov    %ax,0x54(%ebx)
  ip->nlink = 1;
80104add:	b8 01 00 00 00       	mov    $0x1,%eax
80104ae2:	66 89 43 56          	mov    %ax,0x56(%ebx)
  iupdate(ip);
80104ae6:	89 1c 24             	mov    %ebx,(%esp)
80104ae9:	e8 b2 ca ff ff       	call   801015a0 <iupdate>

  if(type == T_DIR){  // Create . and .. entries.
80104aee:	83 c4 10             	add    $0x10,%esp
80104af1:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104af6:	74 38                	je     80104b30 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(type == T_SMALLDIR){  // Create . and .. entries.
80104af8:	66 83 7d c4 04       	cmpw   $0x4,-0x3c(%ebp)
80104afd:	74 31                	je     80104b30 <create+0x130>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
80104aff:	83 ec 04             	sub    $0x4,%esp
80104b02:	ff 73 04             	pushl  0x4(%ebx)
80104b05:	56                   	push   %esi
80104b06:	57                   	push   %edi
80104b07:	e8 34 d3 ff ff       	call   80101e40 <dirlink>
80104b0c:	83 c4 10             	add    $0x10,%esp
80104b0f:	85 c0                	test   %eax,%eax
80104b11:	0f 88 80 00 00 00    	js     80104b97 <create+0x197>
    panic("create: dirlink");

  iunlockput(dp);
80104b17:	83 ec 0c             	sub    $0xc,%esp
80104b1a:	57                   	push   %edi
80104b1b:	e8 a0 cd ff ff       	call   801018c0 <iunlockput>

  return ip;
80104b20:	83 c4 10             	add    $0x10,%esp
}
80104b23:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
80104b26:	89 d8                	mov    %ebx,%eax
}
80104b28:	5b                   	pop    %ebx
80104b29:	5e                   	pop    %esi
80104b2a:	5f                   	pop    %edi
80104b2b:	5d                   	pop    %ebp
80104b2c:	c3                   	ret    
80104b2d:	8d 76 00             	lea    0x0(%esi),%esi
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
80104b30:	66 83 47 56 01       	addw   $0x1,0x56(%edi)
    iupdate(dp);
80104b35:	83 ec 0c             	sub    $0xc,%esp
80104b38:	57                   	push   %edi
80104b39:	e8 62 ca ff ff       	call   801015a0 <iupdate>
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b3e:	83 c4 0c             	add    $0xc,%esp
80104b41:	ff 73 04             	pushl  0x4(%ebx)
80104b44:	68 40 7a 10 80       	push   $0x80107a40
80104b49:	53                   	push   %ebx
80104b4a:	e8 f1 d2 ff ff       	call   80101e40 <dirlink>
80104b4f:	83 c4 10             	add    $0x10,%esp
80104b52:	85 c0                	test   %eax,%eax
80104b54:	78 18                	js     80104b6e <create+0x16e>

  if(type == T_SMALLDIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104b56:	83 ec 04             	sub    $0x4,%esp
80104b59:	ff 77 04             	pushl  0x4(%edi)
80104b5c:	68 3f 7a 10 80       	push   $0x80107a3f
80104b61:	53                   	push   %ebx
80104b62:	e8 d9 d2 ff ff       	call   80101e40 <dirlink>
80104b67:	83 c4 10             	add    $0x10,%esp
80104b6a:	85 c0                	test   %eax,%eax
80104b6c:	79 91                	jns    80104aff <create+0xff>
  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
80104b6e:	83 ec 0c             	sub    $0xc,%esp
80104b71:	68 33 7a 10 80       	push   $0x80107a33
80104b76:	e8 f5 b7 ff ff       	call   80100370 <panic>
80104b7b:	90                   	nop
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b80:	89 d8                	mov    %ebx,%eax
80104b82:	e9 f0 fe ff ff       	jmp    80104a77 <create+0x77>
80104b87:	89 f6                	mov    %esi,%esi
80104b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
80104b90:	31 c0                	xor    %eax,%eax
80104b92:	e9 e0 fe ff ff       	jmp    80104a77 <create+0x77>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");
80104b97:	83 ec 0c             	sub    $0xc,%esp
80104b9a:	68 42 7a 10 80       	push   $0x80107a42
80104b9f:	e8 cc b7 ff ff       	call   80100370 <panic>
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");
80104ba4:	83 ec 0c             	sub    $0xc,%esp
80104ba7:	68 24 7a 10 80       	push   $0x80107a24
80104bac:	e8 bf b7 ff ff       	call   80100370 <panic>
80104bb1:	eb 0d                	jmp    80104bc0 <argfd.constprop.0>
80104bb3:	90                   	nop
80104bb4:	90                   	nop
80104bb5:	90                   	nop
80104bb6:	90                   	nop
80104bb7:	90                   	nop
80104bb8:	90                   	nop
80104bb9:	90                   	nop
80104bba:	90                   	nop
80104bbb:	90                   	nop
80104bbc:	90                   	nop
80104bbd:	90                   	nop
80104bbe:	90                   	nop
80104bbf:	90                   	nop

80104bc0 <argfd.constprop.0>:


// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104bc0:	55                   	push   %ebp
80104bc1:	89 e5                	mov    %esp,%ebp
80104bc3:	56                   	push   %esi
80104bc4:	53                   	push   %ebx
80104bc5:	89 c6                	mov    %eax,%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104bc7:	8d 45 f4             	lea    -0xc(%ebp),%eax


// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
80104bca:	89 d3                	mov    %edx,%ebx
80104bcc:	83 ec 18             	sub    $0x18,%esp
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
80104bcf:	50                   	push   %eax
80104bd0:	6a 00                	push   $0x0
80104bd2:	e8 19 fc ff ff       	call   801047f0 <argint>
80104bd7:	83 c4 10             	add    $0x10,%esp
80104bda:	85 c0                	test   %eax,%eax
80104bdc:	78 3a                	js     80104c18 <argfd.constprop.0+0x58>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0)
80104bde:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104be1:	83 f8 0f             	cmp    $0xf,%eax
80104be4:	77 32                	ja     80104c18 <argfd.constprop.0+0x58>
80104be6:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
80104bed:	8b 54 82 28          	mov    0x28(%edx,%eax,4),%edx
80104bf1:	85 d2                	test   %edx,%edx
80104bf3:	74 23                	je     80104c18 <argfd.constprop.0+0x58>
    return -1;
  if(pfd)
80104bf5:	85 f6                	test   %esi,%esi
80104bf7:	74 02                	je     80104bfb <argfd.constprop.0+0x3b>
    *pfd = fd;
80104bf9:	89 06                	mov    %eax,(%esi)
  if(pf)
80104bfb:	85 db                	test   %ebx,%ebx
80104bfd:	74 11                	je     80104c10 <argfd.constprop.0+0x50>
    *pf = f;
80104bff:	89 13                	mov    %edx,(%ebx)
  return 0;
80104c01:	31 c0                	xor    %eax,%eax
}
80104c03:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c06:	5b                   	pop    %ebx
80104c07:	5e                   	pop    %esi
80104c08:	5d                   	pop    %ebp
80104c09:	c3                   	ret    
80104c0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
80104c10:	31 c0                	xor    %eax,%eax
80104c12:	eb ef                	jmp    80104c03 <argfd.constprop.0+0x43>
80104c14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
80104c18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c1d:	eb e4                	jmp    80104c03 <argfd.constprop.0+0x43>
80104c1f:	90                   	nop

80104c20 <sys_dup>:
  return -1;
}

int
sys_dup(void)
{
80104c20:	55                   	push   %ebp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c21:	31 c0                	xor    %eax,%eax
  return -1;
}

int
sys_dup(void)
{
80104c23:	89 e5                	mov    %esp,%ebp
80104c25:	53                   	push   %ebx
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c26:	8d 55 f4             	lea    -0xc(%ebp),%edx
  return -1;
}

int
sys_dup(void)
{
80104c29:	83 ec 14             	sub    $0x14,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
80104c2c:	e8 8f ff ff ff       	call   80104bc0 <argfd.constprop.0>
80104c31:	85 c0                	test   %eax,%eax
80104c33:	78 1b                	js     80104c50 <sys_dup+0x30>
    return -1;
  if((fd=fdalloc(f)) < 0)
80104c35:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104c38:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104c3e:	31 db                	xor    %ebx,%ebx
    if(proc->ofile[fd] == 0){
80104c40:	8b 4c 98 28          	mov    0x28(%eax,%ebx,4),%ecx
80104c44:	85 c9                	test   %ecx,%ecx
80104c46:	74 18                	je     80104c60 <sys_dup+0x40>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80104c48:	83 c3 01             	add    $0x1,%ebx
80104c4b:	83 fb 10             	cmp    $0x10,%ebx
80104c4e:	75 f0                	jne    80104c40 <sys_dup+0x20>
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
80104c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}
80104c55:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c58:	c9                   	leave  
80104c59:	c3                   	ret    
80104c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104c60:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80104c63:	89 54 98 28          	mov    %edx,0x28(%eax,%ebx,4)

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
80104c67:	52                   	push   %edx
80104c68:	e8 53 c1 ff ff       	call   80100dc0 <filedup>
  return fd;
80104c6d:	89 d8                	mov    %ebx,%eax
80104c6f:	83 c4 10             	add    $0x10,%esp
}
80104c72:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c75:	c9                   	leave  
80104c76:	c3                   	ret    
80104c77:	89 f6                	mov    %esi,%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c80 <sys_read>:

int
sys_read(void)
{
80104c80:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c81:	31 c0                	xor    %eax,%eax
  return fd;
}

int
sys_read(void)
{
80104c83:	89 e5                	mov    %esp,%ebp
80104c85:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104c88:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104c8b:	e8 30 ff ff ff       	call   80104bc0 <argfd.constprop.0>
80104c90:	85 c0                	test   %eax,%eax
80104c92:	78 4c                	js     80104ce0 <sys_read+0x60>
80104c94:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104c97:	83 ec 08             	sub    $0x8,%esp
80104c9a:	50                   	push   %eax
80104c9b:	6a 02                	push   $0x2
80104c9d:	e8 4e fb ff ff       	call   801047f0 <argint>
80104ca2:	83 c4 10             	add    $0x10,%esp
80104ca5:	85 c0                	test   %eax,%eax
80104ca7:	78 37                	js     80104ce0 <sys_read+0x60>
80104ca9:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104cac:	83 ec 04             	sub    $0x4,%esp
80104caf:	ff 75 f0             	pushl  -0x10(%ebp)
80104cb2:	50                   	push   %eax
80104cb3:	6a 01                	push   $0x1
80104cb5:	e8 76 fb ff ff       	call   80104830 <argptr>
80104cba:	83 c4 10             	add    $0x10,%esp
80104cbd:	85 c0                	test   %eax,%eax
80104cbf:	78 1f                	js     80104ce0 <sys_read+0x60>
    return -1;
  return fileread(f, p, n);
80104cc1:	83 ec 04             	sub    $0x4,%esp
80104cc4:	ff 75 f0             	pushl  -0x10(%ebp)
80104cc7:	ff 75 f4             	pushl  -0xc(%ebp)
80104cca:	ff 75 ec             	pushl  -0x14(%ebp)
80104ccd:	e8 5e c2 ff ff       	call   80100f30 <fileread>
80104cd2:	83 c4 10             	add    $0x10,%esp
}
80104cd5:	c9                   	leave  
80104cd6:	c3                   	ret    
80104cd7:	89 f6                	mov    %esi,%esi
80104cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fileread(f, p, n);
}
80104ce5:	c9                   	leave  
80104ce6:	c3                   	ret    
80104ce7:	89 f6                	mov    %esi,%esi
80104ce9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104cf0 <sys_write>:

int
sys_write(void)
{
80104cf0:	55                   	push   %ebp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cf1:	31 c0                	xor    %eax,%eax
  return fileread(f, p, n);
}

int
sys_write(void)
{
80104cf3:	89 e5                	mov    %esp,%ebp
80104cf5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104cf8:	8d 55 ec             	lea    -0x14(%ebp),%edx
80104cfb:	e8 c0 fe ff ff       	call   80104bc0 <argfd.constprop.0>
80104d00:	85 c0                	test   %eax,%eax
80104d02:	78 4c                	js     80104d50 <sys_write+0x60>
80104d04:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d07:	83 ec 08             	sub    $0x8,%esp
80104d0a:	50                   	push   %eax
80104d0b:	6a 02                	push   $0x2
80104d0d:	e8 de fa ff ff       	call   801047f0 <argint>
80104d12:	83 c4 10             	add    $0x10,%esp
80104d15:	85 c0                	test   %eax,%eax
80104d17:	78 37                	js     80104d50 <sys_write+0x60>
80104d19:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d1c:	83 ec 04             	sub    $0x4,%esp
80104d1f:	ff 75 f0             	pushl  -0x10(%ebp)
80104d22:	50                   	push   %eax
80104d23:	6a 01                	push   $0x1
80104d25:	e8 06 fb ff ff       	call   80104830 <argptr>
80104d2a:	83 c4 10             	add    $0x10,%esp
80104d2d:	85 c0                	test   %eax,%eax
80104d2f:	78 1f                	js     80104d50 <sys_write+0x60>
    return -1;
  return filewrite(f, p, n);
80104d31:	83 ec 04             	sub    $0x4,%esp
80104d34:	ff 75 f0             	pushl  -0x10(%ebp)
80104d37:	ff 75 f4             	pushl  -0xc(%ebp)
80104d3a:	ff 75 ec             	pushl  -0x14(%ebp)
80104d3d:	e8 7e c2 ff ff       	call   80100fc0 <filewrite>
80104d42:	83 c4 10             	add    $0x10,%esp
}
80104d45:	c9                   	leave  
80104d46:	c3                   	ret    
80104d47:	89 f6                	mov    %esi,%esi
80104d49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
80104d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filewrite(f, p, n);
}
80104d55:	c9                   	leave  
80104d56:	c3                   	ret    
80104d57:	89 f6                	mov    %esi,%esi
80104d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d60 <sys_close>:

int
sys_close(void)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
80104d66:	8d 55 f4             	lea    -0xc(%ebp),%edx
80104d69:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104d6c:	e8 4f fe ff ff       	call   80104bc0 <argfd.constprop.0>
80104d71:	85 c0                	test   %eax,%eax
80104d73:	78 2b                	js     80104da0 <sys_close+0x40>
    return -1;
  proc->ofile[fd] = 0;
80104d75:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104d78:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  fileclose(f);
80104d7e:	83 ec 0c             	sub    $0xc,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  proc->ofile[fd] = 0;
80104d81:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
80104d88:	00 
  fileclose(f);
80104d89:	ff 75 f4             	pushl  -0xc(%ebp)
80104d8c:	e8 7f c0 ff ff       	call   80100e10 <fileclose>
  return 0;
80104d91:	83 c4 10             	add    $0x10,%esp
80104d94:	31 c0                	xor    %eax,%eax
}
80104d96:	c9                   	leave  
80104d97:	c3                   	ret    
80104d98:	90                   	nop
80104d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
80104da0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  proc->ofile[fd] = 0;
  fileclose(f);
  return 0;
}
80104da5:	c9                   	leave  
80104da6:	c3                   	ret    
80104da7:	89 f6                	mov    %esi,%esi
80104da9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104db0 <sys_fstat>:

int
sys_fstat(void)
{
80104db0:	55                   	push   %ebp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104db1:	31 c0                	xor    %eax,%eax
  return 0;
}

int
sys_fstat(void)
{
80104db3:	89 e5                	mov    %esp,%ebp
80104db5:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104db8:	8d 55 f0             	lea    -0x10(%ebp),%edx
80104dbb:	e8 00 fe ff ff       	call   80104bc0 <argfd.constprop.0>
80104dc0:	85 c0                	test   %eax,%eax
80104dc2:	78 2c                	js     80104df0 <sys_fstat+0x40>
80104dc4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104dc7:	83 ec 04             	sub    $0x4,%esp
80104dca:	6a 14                	push   $0x14
80104dcc:	50                   	push   %eax
80104dcd:	6a 01                	push   $0x1
80104dcf:	e8 5c fa ff ff       	call   80104830 <argptr>
80104dd4:	83 c4 10             	add    $0x10,%esp
80104dd7:	85 c0                	test   %eax,%eax
80104dd9:	78 15                	js     80104df0 <sys_fstat+0x40>
    return -1;
  return filestat(f, st);
80104ddb:	83 ec 08             	sub    $0x8,%esp
80104dde:	ff 75 f4             	pushl  -0xc(%ebp)
80104de1:	ff 75 f0             	pushl  -0x10(%ebp)
80104de4:	e8 f7 c0 ff ff       	call   80100ee0 <filestat>
80104de9:	83 c4 10             	add    $0x10,%esp
}
80104dec:	c9                   	leave  
80104ded:	c3                   	ret    
80104dee:	66 90                	xchg   %ax,%ax
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
80104df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return filestat(f, st);
}
80104df5:	c9                   	leave  
80104df6:	c3                   	ret    
80104df7:	89 f6                	mov    %esi,%esi
80104df9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104e00 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	56                   	push   %esi
80104e05:	53                   	push   %ebx
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e06:	8d 45 d4             	lea    -0x2c(%ebp),%eax
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
80104e09:	83 ec 34             	sub    $0x34,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104e0c:	50                   	push   %eax
80104e0d:	6a 00                	push   $0x0
80104e0f:	e8 6c fa ff ff       	call   80104880 <argstr>
80104e14:	83 c4 10             	add    $0x10,%esp
80104e17:	85 c0                	test   %eax,%eax
80104e19:	0f 88 03 01 00 00    	js     80104f22 <sys_link+0x122>
80104e1f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104e22:	83 ec 08             	sub    $0x8,%esp
80104e25:	50                   	push   %eax
80104e26:	6a 01                	push   $0x1
80104e28:	e8 53 fa ff ff       	call   80104880 <argstr>
80104e2d:	83 c4 10             	add    $0x10,%esp
80104e30:	85 c0                	test   %eax,%eax
80104e32:	0f 88 ea 00 00 00    	js     80104f22 <sys_link+0x122>
    return -1;

  begin_op();
80104e38:	e8 f3 dd ff ff       	call   80102c30 <begin_op>
  if((ip = namei(old)) == 0){
80104e3d:	83 ec 0c             	sub    $0xc,%esp
80104e40:	ff 75 d4             	pushl  -0x2c(%ebp)
80104e43:	e8 b8 d0 ff ff       	call   80101f00 <namei>
80104e48:	83 c4 10             	add    $0x10,%esp
80104e4b:	85 c0                	test   %eax,%eax
80104e4d:	89 c3                	mov    %eax,%ebx
80104e4f:	0f 84 f3 00 00 00    	je     80104f48 <sys_link+0x148>
    end_op();
    return -1;
  }

  ilock(ip);
80104e55:	83 ec 0c             	sub    $0xc,%esp
80104e58:	50                   	push   %eax
80104e59:	e8 f2 c7 ff ff       	call   80101650 <ilock>
  if(ip->type == T_DIR){
80104e5e:	0f b7 43 50          	movzwl 0x50(%ebx),%eax
80104e62:	83 c4 10             	add    $0x10,%esp
80104e65:	66 83 f8 01          	cmp    $0x1,%ax
80104e69:	0f 84 c1 00 00 00    	je     80104f30 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_SMALLDIR){
80104e6f:	66 83 f8 04          	cmp    $0x4,%ax
80104e73:	0f 84 b7 00 00 00    	je     80104f30 <sys_link+0x130>
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
80104e79:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
80104e7e:	83 ec 0c             	sub    $0xc,%esp
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
80104e81:	8d 7d da             	lea    -0x26(%ebp),%edi
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
80104e84:	53                   	push   %ebx
80104e85:	e8 16 c7 ff ff       	call   801015a0 <iupdate>
  iunlock(ip);
80104e8a:	89 1c 24             	mov    %ebx,(%esp)
80104e8d:	e8 9e c8 ff ff       	call   80101730 <iunlock>

  if((dp = nameiparent(new, name)) == 0)
80104e92:	58                   	pop    %eax
80104e93:	5a                   	pop    %edx
80104e94:	57                   	push   %edi
80104e95:	ff 75 d0             	pushl  -0x30(%ebp)
80104e98:	e8 83 d0 ff ff       	call   80101f20 <nameiparent>
80104e9d:	83 c4 10             	add    $0x10,%esp
80104ea0:	85 c0                	test   %eax,%eax
80104ea2:	89 c6                	mov    %eax,%esi
80104ea4:	74 56                	je     80104efc <sys_link+0xfc>
    goto bad;
  ilock(dp);
80104ea6:	83 ec 0c             	sub    $0xc,%esp
80104ea9:	50                   	push   %eax
80104eaa:	e8 a1 c7 ff ff       	call   80101650 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80104eaf:	83 c4 10             	add    $0x10,%esp
80104eb2:	8b 03                	mov    (%ebx),%eax
80104eb4:	39 06                	cmp    %eax,(%esi)
80104eb6:	75 38                	jne    80104ef0 <sys_link+0xf0>
80104eb8:	83 ec 04             	sub    $0x4,%esp
80104ebb:	ff 73 04             	pushl  0x4(%ebx)
80104ebe:	57                   	push   %edi
80104ebf:	56                   	push   %esi
80104ec0:	e8 7b cf ff ff       	call   80101e40 <dirlink>
80104ec5:	83 c4 10             	add    $0x10,%esp
80104ec8:	85 c0                	test   %eax,%eax
80104eca:	78 24                	js     80104ef0 <sys_link+0xf0>
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
80104ecc:	83 ec 0c             	sub    $0xc,%esp
80104ecf:	56                   	push   %esi
80104ed0:	e8 eb c9 ff ff       	call   801018c0 <iunlockput>
  iput(ip);
80104ed5:	89 1c 24             	mov    %ebx,(%esp)
80104ed8:	e8 a3 c8 ff ff       	call   80101780 <iput>

  end_op();
80104edd:	e8 be dd ff ff       	call   80102ca0 <end_op>

  return 0;
80104ee2:	83 c4 10             	add    $0x10,%esp
80104ee5:	31 c0                	xor    %eax,%eax
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}
80104ee7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104eea:	5b                   	pop    %ebx
80104eeb:	5e                   	pop    %esi
80104eec:	5f                   	pop    %edi
80104eed:	5d                   	pop    %ebp
80104eee:	c3                   	ret    
80104eef:	90                   	nop

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
80104ef0:	83 ec 0c             	sub    $0xc,%esp
80104ef3:	56                   	push   %esi
80104ef4:	e8 c7 c9 ff ff       	call   801018c0 <iunlockput>
    goto bad;
80104ef9:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  ilock(ip);
80104efc:	83 ec 0c             	sub    $0xc,%esp
80104eff:	53                   	push   %ebx
80104f00:	e8 4b c7 ff ff       	call   80101650 <ilock>
  ip->nlink--;
80104f05:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80104f0a:	89 1c 24             	mov    %ebx,(%esp)
80104f0d:	e8 8e c6 ff ff       	call   801015a0 <iupdate>
  iunlockput(ip);
80104f12:	89 1c 24             	mov    %ebx,(%esp)
80104f15:	e8 a6 c9 ff ff       	call   801018c0 <iunlockput>
  end_op();
80104f1a:	e8 81 dd ff ff       	call   80102ca0 <end_op>
  return -1;
80104f1f:	83 c4 10             	add    $0x10,%esp
}
80104f22:	8d 65 f4             	lea    -0xc(%ebp),%esp
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
80104f25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104f2a:	5b                   	pop    %ebx
80104f2b:	5e                   	pop    %esi
80104f2c:	5f                   	pop    %edi
80104f2d:	5d                   	pop    %ebp
80104f2e:	c3                   	ret    
80104f2f:	90                   	nop
    end_op();
    return -1;
  }

  if(ip->type == T_SMALLDIR){
    iunlockput(ip);
80104f30:	83 ec 0c             	sub    $0xc,%esp
80104f33:	53                   	push   %ebx
80104f34:	e8 87 c9 ff ff       	call   801018c0 <iunlockput>
    end_op();
80104f39:	e8 62 dd ff ff       	call   80102ca0 <end_op>
    return -1;
80104f3e:	83 c4 10             	add    $0x10,%esp
80104f41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f46:	eb 9f                	jmp    80104ee7 <sys_link+0xe7>
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
80104f48:	e8 53 dd ff ff       	call   80102ca0 <end_op>
    return -1;
80104f4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f52:	eb 93                	jmp    80104ee7 <sys_link+0xe7>
80104f54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104f5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104f60 <sys_unlink>:
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	57                   	push   %edi
80104f64:	56                   	push   %esi
80104f65:	53                   	push   %ebx
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104f66:	8d 45 c0             	lea    -0x40(%ebp),%eax
}

//PAGEBREAK!
int
sys_unlink(void)
{
80104f69:	83 ec 54             	sub    $0x54,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80104f6c:	50                   	push   %eax
80104f6d:	6a 00                	push   $0x0
80104f6f:	e8 0c f9 ff ff       	call   80104880 <argstr>
80104f74:	83 c4 10             	add    $0x10,%esp
80104f77:	85 c0                	test   %eax,%eax
80104f79:	0f 88 82 01 00 00    	js     80105101 <sys_unlink+0x1a1>
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
80104f7f:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
80104f82:	e8 a9 dc ff ff       	call   80102c30 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80104f87:	83 ec 08             	sub    $0x8,%esp
80104f8a:	53                   	push   %ebx
80104f8b:	ff 75 c0             	pushl  -0x40(%ebp)
80104f8e:	e8 8d cf ff ff       	call   80101f20 <nameiparent>
80104f93:	83 c4 10             	add    $0x10,%esp
80104f96:	85 c0                	test   %eax,%eax
80104f98:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80104f9b:	0f 84 6a 01 00 00    	je     8010510b <sys_unlink+0x1ab>
    end_op();
    return -1;
  }

  ilock(dp);
80104fa1:	8b 75 b4             	mov    -0x4c(%ebp),%esi
80104fa4:	83 ec 0c             	sub    $0xc,%esp
80104fa7:	56                   	push   %esi
80104fa8:	e8 a3 c6 ff ff       	call   80101650 <ilock>

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80104fad:	58                   	pop    %eax
80104fae:	5a                   	pop    %edx
80104faf:	68 40 7a 10 80       	push   $0x80107a40
80104fb4:	53                   	push   %ebx
80104fb5:	e8 06 cc ff ff       	call   80101bc0 <namecmp>
80104fba:	83 c4 10             	add    $0x10,%esp
80104fbd:	85 c0                	test   %eax,%eax
80104fbf:	0f 84 fc 00 00 00    	je     801050c1 <sys_unlink+0x161>
80104fc5:	83 ec 08             	sub    $0x8,%esp
80104fc8:	68 3f 7a 10 80       	push   $0x80107a3f
80104fcd:	53                   	push   %ebx
80104fce:	e8 ed cb ff ff       	call   80101bc0 <namecmp>
80104fd3:	83 c4 10             	add    $0x10,%esp
80104fd6:	85 c0                	test   %eax,%eax
80104fd8:	0f 84 e3 00 00 00    	je     801050c1 <sys_unlink+0x161>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80104fde:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80104fe1:	83 ec 04             	sub    $0x4,%esp
80104fe4:	50                   	push   %eax
80104fe5:	53                   	push   %ebx
80104fe6:	56                   	push   %esi
80104fe7:	e8 f4 cb ff ff       	call   80101be0 <dirlookup>
80104fec:	83 c4 10             	add    $0x10,%esp
80104fef:	85 c0                	test   %eax,%eax
80104ff1:	89 c3                	mov    %eax,%ebx
80104ff3:	0f 84 c8 00 00 00    	je     801050c1 <sys_unlink+0x161>
    goto bad;
  ilock(ip);
80104ff9:	83 ec 0c             	sub    $0xc,%esp
80104ffc:	50                   	push   %eax
80104ffd:	e8 4e c6 ff ff       	call   80101650 <ilock>

  if(ip->nlink < 1)
80105002:	83 c4 10             	add    $0x10,%esp
80105005:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010500a:	0f 8e 24 01 00 00    	jle    80105134 <sys_unlink+0x1d4>
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
80105010:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105015:	8d 75 d8             	lea    -0x28(%ebp),%esi
80105018:	74 66                	je     80105080 <sys_unlink+0x120>
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
8010501a:	83 ec 04             	sub    $0x4,%esp
8010501d:	6a 10                	push   $0x10
8010501f:	6a 00                	push   $0x0
80105021:	56                   	push   %esi
80105022:	e8 d9 f4 ff ff       	call   80104500 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105027:	6a 10                	push   $0x10
80105029:	ff 75 c4             	pushl  -0x3c(%ebp)
8010502c:	56                   	push   %esi
8010502d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105030:	e8 1b ca ff ff       	call   80101a50 <writei>
80105035:	83 c4 20             	add    $0x20,%esp
80105038:	83 f8 10             	cmp    $0x10,%eax
8010503b:	0f 85 e6 00 00 00    	jne    80105127 <sys_unlink+0x1c7>
    panic("unlink: writei");
  if(ip->type == T_DIR){
80105041:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105046:	0f 84 9c 00 00 00    	je     801050e8 <sys_unlink+0x188>
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);
8010504c:	83 ec 0c             	sub    $0xc,%esp
8010504f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105052:	e8 69 c8 ff ff       	call   801018c0 <iunlockput>

  ip->nlink--;
80105057:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010505c:	89 1c 24             	mov    %ebx,(%esp)
8010505f:	e8 3c c5 ff ff       	call   801015a0 <iupdate>
  iunlockput(ip);
80105064:	89 1c 24             	mov    %ebx,(%esp)
80105067:	e8 54 c8 ff ff       	call   801018c0 <iunlockput>

  end_op();
8010506c:	e8 2f dc ff ff       	call   80102ca0 <end_op>

  return 0;
80105071:	83 c4 10             	add    $0x10,%esp
80105074:	31 c0                	xor    %eax,%eax

bad:
  iunlockput(dp);
  end_op();
  return -1;
}
80105076:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105079:	5b                   	pop    %ebx
8010507a:	5e                   	pop    %esi
8010507b:	5f                   	pop    %edi
8010507c:	5d                   	pop    %ebp
8010507d:	c3                   	ret    
8010507e:	66 90                	xchg   %ax,%ax
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105080:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105084:	76 94                	jbe    8010501a <sys_unlink+0xba>
80105086:	bf 20 00 00 00       	mov    $0x20,%edi
8010508b:	eb 0f                	jmp    8010509c <sys_unlink+0x13c>
8010508d:	8d 76 00             	lea    0x0(%esi),%esi
80105090:	83 c7 10             	add    $0x10,%edi
80105093:	3b 7b 58             	cmp    0x58(%ebx),%edi
80105096:	0f 83 7e ff ff ff    	jae    8010501a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010509c:	6a 10                	push   $0x10
8010509e:	57                   	push   %edi
8010509f:	56                   	push   %esi
801050a0:	53                   	push   %ebx
801050a1:	e8 6a c8 ff ff       	call   80101910 <readi>
801050a6:	83 c4 10             	add    $0x10,%esp
801050a9:	83 f8 10             	cmp    $0x10,%eax
801050ac:	75 6c                	jne    8010511a <sys_unlink+0x1ba>
      panic("isdirempty: readi");
    if(de.inum != 0)
801050ae:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801050b3:	74 db                	je     80105090 <sys_unlink+0x130>
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
801050b5:	83 ec 0c             	sub    $0xc,%esp
801050b8:	53                   	push   %ebx
801050b9:	e8 02 c8 ff ff       	call   801018c0 <iunlockput>
    goto bad;
801050be:	83 c4 10             	add    $0x10,%esp
  end_op();

  return 0;

bad:
  iunlockput(dp);
801050c1:	83 ec 0c             	sub    $0xc,%esp
801050c4:	ff 75 b4             	pushl  -0x4c(%ebp)
801050c7:	e8 f4 c7 ff ff       	call   801018c0 <iunlockput>
  end_op();
801050cc:	e8 cf db ff ff       	call   80102ca0 <end_op>
  return -1;
801050d1:	83 c4 10             	add    $0x10,%esp
}
801050d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
801050d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801050dc:	5b                   	pop    %ebx
801050dd:	5e                   	pop    %esi
801050de:	5f                   	pop    %edi
801050df:	5d                   	pop    %ebp
801050e0:	c3                   	ret    
801050e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801050e8:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
801050eb:	83 ec 0c             	sub    $0xc,%esp

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
801050ee:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
801050f3:	50                   	push   %eax
801050f4:	e8 a7 c4 ff ff       	call   801015a0 <iupdate>
801050f9:	83 c4 10             	add    $0x10,%esp
801050fc:	e9 4b ff ff ff       	jmp    8010504c <sys_unlink+0xec>
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;
80105101:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105106:	e9 6b ff ff ff       	jmp    80105076 <sys_unlink+0x116>

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
8010510b:	e8 90 db ff ff       	call   80102ca0 <end_op>
    return -1;
80105110:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105115:	e9 5c ff ff ff       	jmp    80105076 <sys_unlink+0x116>
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
8010511a:	83 ec 0c             	sub    $0xc,%esp
8010511d:	68 64 7a 10 80       	push   $0x80107a64
80105122:	e8 49 b2 ff ff       	call   80100370 <panic>
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
80105127:	83 ec 0c             	sub    $0xc,%esp
8010512a:	68 76 7a 10 80       	push   $0x80107a76
8010512f:	e8 3c b2 ff ff       	call   80100370 <panic>
  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
80105134:	83 ec 0c             	sub    $0xc,%esp
80105137:	68 52 7a 10 80       	push   $0x80107a52
8010513c:	e8 2f b2 ff ff       	call   80100370 <panic>
80105141:	eb 0d                	jmp    80105150 <sys_open>
80105143:	90                   	nop
80105144:	90                   	nop
80105145:	90                   	nop
80105146:	90                   	nop
80105147:	90                   	nop
80105148:	90                   	nop
80105149:	90                   	nop
8010514a:	90                   	nop
8010514b:	90                   	nop
8010514c:	90                   	nop
8010514d:	90                   	nop
8010514e:	90                   	nop
8010514f:	90                   	nop

80105150 <sys_open>:
  return ip;
}

int
sys_open(void)
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	57                   	push   %edi
80105154:	56                   	push   %esi
80105155:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105156:	8d 45 d0             	lea    -0x30(%ebp),%eax
  return ip;
}

int
sys_open(void)
{
80105159:	83 ec 34             	sub    $0x34,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010515c:	50                   	push   %eax
8010515d:	6a 00                	push   $0x0
8010515f:	e8 1c f7 ff ff       	call   80104880 <argstr>
80105164:	83 c4 10             	add    $0x10,%esp
80105167:	85 c0                	test   %eax,%eax
80105169:	0f 88 b6 00 00 00    	js     80105225 <sys_open+0xd5>
8010516f:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105172:	83 ec 08             	sub    $0x8,%esp
80105175:	50                   	push   %eax
80105176:	6a 01                	push   $0x1
80105178:	e8 73 f6 ff ff       	call   801047f0 <argint>
8010517d:	83 c4 10             	add    $0x10,%esp
80105180:	85 c0                	test   %eax,%eax
80105182:	0f 88 9d 00 00 00    	js     80105225 <sys_open+0xd5>
    return -1;

  begin_op();
80105188:	e8 a3 da ff ff       	call   80102c30 <begin_op>

  if(omode & O_CREATE){
8010518d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80105190:	f6 c4 02             	test   $0x2,%ah
80105193:	0f 84 1f 01 00 00    	je     801052b8 <sys_open+0x168>
    if(omode & O_SMALLFILE){
80105199:	f6 c4 04             	test   $0x4,%ah
8010519c:	0f 85 96 00 00 00    	jne    80105238 <sys_open+0xe8>
        return -1;
      }

    } else {
      char name[DIRSIZ];
      struct inode *dp = nameiparent(path, name);
801051a2:	8d 45 da             	lea    -0x26(%ebp),%eax
801051a5:	83 ec 08             	sub    $0x8,%esp
801051a8:	50                   	push   %eax
801051a9:	ff 75 d0             	pushl  -0x30(%ebp)
801051ac:	e8 6f cd ff ff       	call   80101f20 <nameiparent>
      if(dp->type == T_SMALLDIR){
801051b1:	83 c4 10             	add    $0x10,%esp
801051b4:	66 83 78 50 04       	cmpw   $0x4,0x50(%eax)
801051b9:	0f 84 5b 01 00 00    	je     8010531a <sys_open+0x1ca>
        cprintf("nononon");
        end_op();
        return -1;
      }
      ip = create(path, T_FILE, 0, 0);
801051bf:	83 ec 0c             	sub    $0xc,%esp
801051c2:	31 c9                	xor    %ecx,%ecx
801051c4:	ba 02 00 00 00       	mov    $0x2,%edx
801051c9:	6a 00                	push   $0x0
801051cb:	8b 45 d0             	mov    -0x30(%ebp),%eax
801051ce:	e8 2d f8 ff ff       	call   80104a00 <create>
      if(ip == 0){
801051d3:	83 c4 10             	add    $0x10,%esp
801051d6:	85 c0                	test   %eax,%eax
      if(dp->type == T_SMALLDIR){
        cprintf("nononon");
        end_op();
        return -1;
      }
      ip = create(path, T_FILE, 0, 0);
801051d8:	89 c7                	mov    %eax,%edi
      if(ip == 0){
801051da:	0f 84 54 01 00 00    	je     80105334 <sys_open+0x1e4>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801051e0:	e8 6b bb ff ff       	call   80100d50 <filealloc>
801051e5:	85 c0                	test   %eax,%eax
801051e7:	89 c6                	mov    %eax,%esi
801051e9:	74 29                	je     80105214 <sys_open+0xc4>
801051eb:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
801051f2:	31 db                	xor    %ebx,%ebx
801051f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
801051f8:	8b 44 9a 28          	mov    0x28(%edx,%ebx,4),%eax
801051fc:	85 c0                	test   %eax,%eax
801051fe:	74 70                	je     80105270 <sys_open+0x120>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105200:	83 c3 01             	add    $0x1,%ebx
80105203:	83 fb 10             	cmp    $0x10,%ebx
80105206:	75 f0                	jne    801051f8 <sys_open+0xa8>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
80105208:	83 ec 0c             	sub    $0xc,%esp
8010520b:	56                   	push   %esi
8010520c:	e8 ff bb ff ff       	call   80100e10 <fileclose>
80105211:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105214:	83 ec 0c             	sub    $0xc,%esp
80105217:	57                   	push   %edi
80105218:	e8 a3 c6 ff ff       	call   801018c0 <iunlockput>
    end_op();
8010521d:	e8 7e da ff ff       	call   80102ca0 <end_op>
    return -1;
80105222:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
80105225:	8d 65 f4             	lea    -0xc(%ebp),%esp
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
80105228:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
  return fd;
}
8010522d:	5b                   	pop    %ebx
8010522e:	5e                   	pop    %esi
8010522f:	5f                   	pop    %edi
80105230:	5d                   	pop    %ebp
80105231:	c3                   	ret    
80105232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  begin_op();

  if(omode & O_CREATE){
    if(omode & O_SMALLFILE){
      char name[DIRSIZ];
      struct inode *dp = nameiparent(path, name);
80105238:	8d 45 da             	lea    -0x26(%ebp),%eax
8010523b:	83 ec 08             	sub    $0x8,%esp
8010523e:	50                   	push   %eax
8010523f:	ff 75 d0             	pushl  -0x30(%ebp)
80105242:	e8 d9 cc ff ff       	call   80101f20 <nameiparent>
      if(dp->type != T_SMALLDIR){
80105247:	83 c4 10             	add    $0x10,%esp
8010524a:	66 83 78 50 04       	cmpw   $0x4,0x50(%eax)
8010524f:	0f 85 ab 00 00 00    	jne    80105300 <sys_open+0x1b0>
        cprintf("NONONO");
        end_op();
        return -1;
      }
      if((ip = create(path, T_SMALLFILE, 0, 0)) == 0){
80105255:	83 ec 0c             	sub    $0xc,%esp
80105258:	31 c9                	xor    %ecx,%ecx
8010525a:	ba 05 00 00 00       	mov    $0x5,%edx
8010525f:	6a 00                	push   $0x0
80105261:	e9 65 ff ff ff       	jmp    801051cb <sys_open+0x7b>
80105266:	8d 76 00             	lea    0x0(%esi),%esi
80105269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105270:	83 ec 0c             	sub    $0xc,%esp
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105273:	89 74 9a 28          	mov    %esi,0x28(%edx,%ebx,4)
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105277:	57                   	push   %edi
80105278:	e8 b3 c4 ff ff       	call   80101730 <iunlock>
  end_op();
8010527d:	e8 1e da ff ff       	call   80102ca0 <end_op>

  f->type = FD_INODE;
80105282:	c7 06 02 00 00 00    	movl   $0x2,(%esi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105288:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010528b:	83 c4 10             	add    $0x10,%esp
  }
  iunlock(ip);
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
8010528e:	89 7e 10             	mov    %edi,0x10(%esi)
  f->off = 0;
80105291:	c7 46 14 00 00 00 00 	movl   $0x0,0x14(%esi)
  f->readable = !(omode & O_WRONLY);
80105298:	89 d0                	mov    %edx,%eax
8010529a:	83 e0 01             	and    $0x1,%eax
8010529d:	83 f0 01             	xor    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052a0:	83 e2 03             	and    $0x3,%edx
  end_op();

  f->type = FD_INODE;
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801052a3:	88 46 08             	mov    %al,0x8(%esi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801052a6:	0f 95 46 09          	setne  0x9(%esi)
  return fd;
801052aa:	89 d8                	mov    %ebx,%eax
}
801052ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801052af:	5b                   	pop    %ebx
801052b0:	5e                   	pop    %esi
801052b1:	5f                   	pop    %edi
801052b2:	5d                   	pop    %ebp
801052b3:	c3                   	ret    
801052b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        end_op();
        return -1;
      }
    }
  } else {
    if((ip = namei(path)) == 0){
801052b8:	83 ec 0c             	sub    $0xc,%esp
801052bb:	ff 75 d0             	pushl  -0x30(%ebp)
801052be:	e8 3d cc ff ff       	call   80101f00 <namei>
801052c3:	83 c4 10             	add    $0x10,%esp
801052c6:	85 c0                	test   %eax,%eax
801052c8:	89 c7                	mov    %eax,%edi
801052ca:	74 72                	je     8010533e <sys_open+0x1ee>
      end_op();
      return -1;
    }
    ilock(ip);
801052cc:	83 ec 0c             	sub    $0xc,%esp
801052cf:	50                   	push   %eax
801052d0:	e8 7b c3 ff ff       	call   80101650 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801052d5:	0f b7 47 50          	movzwl 0x50(%edi),%eax
801052d9:	83 c4 10             	add    $0x10,%esp
801052dc:	66 83 f8 01          	cmp    $0x1,%ax
801052e0:	74 0a                	je     801052ec <sys_open+0x19c>
      iunlockput(ip);
      end_op();
      return -1;
    }
    if(ip->type == T_SMALLDIR && omode != O_RDONLY){
801052e2:	66 83 f8 04          	cmp    $0x4,%ax
801052e6:	0f 85 f4 fe ff ff    	jne    801051e0 <sys_open+0x90>
801052ec:	8b 55 d4             	mov    -0x2c(%ebp),%edx
801052ef:	85 d2                	test   %edx,%edx
801052f1:	0f 84 e9 fe ff ff    	je     801051e0 <sys_open+0x90>
801052f7:	e9 18 ff ff ff       	jmp    80105214 <sys_open+0xc4>
801052fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(omode & O_CREATE){
    if(omode & O_SMALLFILE){
      char name[DIRSIZ];
      struct inode *dp = nameiparent(path, name);
      if(dp->type != T_SMALLDIR){
        cprintf("NONONO");
80105300:	83 ec 0c             	sub    $0xc,%esp
80105303:	68 85 7a 10 80       	push   $0x80107a85
80105308:	e8 53 b3 ff ff       	call   80100660 <cprintf>
        end_op();
8010530d:	e8 8e d9 ff ff       	call   80102ca0 <end_op>
        return -1;
80105312:	83 c4 10             	add    $0x10,%esp
80105315:	e9 0b ff ff ff       	jmp    80105225 <sys_open+0xd5>

    } else {
      char name[DIRSIZ];
      struct inode *dp = nameiparent(path, name);
      if(dp->type == T_SMALLDIR){
        cprintf("nononon");
8010531a:	83 ec 0c             	sub    $0xc,%esp
8010531d:	68 8c 7a 10 80       	push   $0x80107a8c
80105322:	e8 39 b3 ff ff       	call   80100660 <cprintf>
        end_op();
80105327:	e8 74 d9 ff ff       	call   80102ca0 <end_op>
        return -1;
8010532c:	83 c4 10             	add    $0x10,%esp
8010532f:	e9 f1 fe ff ff       	jmp    80105225 <sys_open+0xd5>
      }
      ip = create(path, T_FILE, 0, 0);
      if(ip == 0){
        end_op();
80105334:	e8 67 d9 ff ff       	call   80102ca0 <end_op>
        return -1;
80105339:	e9 e7 fe ff ff       	jmp    80105225 <sys_open+0xd5>
      }
    }
  } else {
    if((ip = namei(path)) == 0){
      end_op();
8010533e:	e8 5d d9 ff ff       	call   80102ca0 <end_op>
      return -1;
80105343:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105348:	e9 5f ff ff ff       	jmp    801052ac <sys_open+0x15c>
8010534d:	8d 76 00             	lea    0x0(%esi),%esi

80105350 <sys_mkdir>:
  return fd;
}

int
sys_mkdir(void)
{
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105356:	e8 d5 d8 ff ff       	call   80102c30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010535b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010535e:	83 ec 08             	sub    $0x8,%esp
80105361:	50                   	push   %eax
80105362:	6a 00                	push   $0x0
80105364:	e8 17 f5 ff ff       	call   80104880 <argstr>
80105369:	83 c4 10             	add    $0x10,%esp
8010536c:	85 c0                	test   %eax,%eax
8010536e:	78 30                	js     801053a0 <sys_mkdir+0x50>
80105370:	83 ec 0c             	sub    $0xc,%esp
80105373:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105376:	31 c9                	xor    %ecx,%ecx
80105378:	6a 00                	push   $0x0
8010537a:	ba 01 00 00 00       	mov    $0x1,%edx
8010537f:	e8 7c f6 ff ff       	call   80104a00 <create>
80105384:	83 c4 10             	add    $0x10,%esp
80105387:	85 c0                	test   %eax,%eax
80105389:	74 15                	je     801053a0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010538b:	83 ec 0c             	sub    $0xc,%esp
8010538e:	50                   	push   %eax
8010538f:	e8 2c c5 ff ff       	call   801018c0 <iunlockput>
  end_op();
80105394:	e8 07 d9 ff ff       	call   80102ca0 <end_op>
  return 0;
80105399:	83 c4 10             	add    $0x10,%esp
8010539c:	31 c0                	xor    %eax,%eax
}
8010539e:	c9                   	leave  
8010539f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
801053a0:	e8 fb d8 ff ff       	call   80102ca0 <end_op>
    return -1;
801053a5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
801053aa:	c9                   	leave  
801053ab:	c3                   	ret    
801053ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801053b0 <sys_mknod>:


int
sys_mknod(void)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801053b6:	e8 75 d8 ff ff       	call   80102c30 <begin_op>
  if((argstr(0, &path)) < 0 ||
801053bb:	8d 45 ec             	lea    -0x14(%ebp),%eax
801053be:	83 ec 08             	sub    $0x8,%esp
801053c1:	50                   	push   %eax
801053c2:	6a 00                	push   $0x0
801053c4:	e8 b7 f4 ff ff       	call   80104880 <argstr>
801053c9:	83 c4 10             	add    $0x10,%esp
801053cc:	85 c0                	test   %eax,%eax
801053ce:	78 60                	js     80105430 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801053d0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801053d3:	83 ec 08             	sub    $0x8,%esp
801053d6:	50                   	push   %eax
801053d7:	6a 01                	push   $0x1
801053d9:	e8 12 f4 ff ff       	call   801047f0 <argint>
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
801053de:	83 c4 10             	add    $0x10,%esp
801053e1:	85 c0                	test   %eax,%eax
801053e3:	78 4b                	js     80105430 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
801053e5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053e8:	83 ec 08             	sub    $0x8,%esp
801053eb:	50                   	push   %eax
801053ec:	6a 02                	push   $0x2
801053ee:	e8 fd f3 ff ff       	call   801047f0 <argint>
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
801053f3:	83 c4 10             	add    $0x10,%esp
801053f6:	85 c0                	test   %eax,%eax
801053f8:	78 36                	js     80105430 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801053fa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801053fe:	83 ec 0c             	sub    $0xc,%esp
80105401:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105405:	ba 03 00 00 00       	mov    $0x3,%edx
8010540a:	50                   	push   %eax
8010540b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010540e:	e8 ed f5 ff ff       	call   80104a00 <create>
80105413:	83 c4 10             	add    $0x10,%esp
80105416:	85 c0                	test   %eax,%eax
80105418:	74 16                	je     80105430 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
8010541a:	83 ec 0c             	sub    $0xc,%esp
8010541d:	50                   	push   %eax
8010541e:	e8 9d c4 ff ff       	call   801018c0 <iunlockput>
  end_op();
80105423:	e8 78 d8 ff ff       	call   80102ca0 <end_op>
  return 0;
80105428:	83 c4 10             	add    $0x10,%esp
8010542b:	31 c0                	xor    %eax,%eax
}
8010542d:	c9                   	leave  
8010542e:	c3                   	ret    
8010542f:	90                   	nop
  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
80105430:	e8 6b d8 ff ff       	call   80102ca0 <end_op>
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

80105440 <sys_chdir>:

int
sys_chdir(void)
{
80105440:	55                   	push   %ebp
80105441:	89 e5                	mov    %esp,%ebp
80105443:	53                   	push   %ebx
80105444:	83 ec 14             	sub    $0x14,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105447:	e8 e4 d7 ff ff       	call   80102c30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
8010544c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010544f:	83 ec 08             	sub    $0x8,%esp
80105452:	50                   	push   %eax
80105453:	6a 00                	push   $0x0
80105455:	e8 26 f4 ff ff       	call   80104880 <argstr>
8010545a:	83 c4 10             	add    $0x10,%esp
8010545d:	85 c0                	test   %eax,%eax
8010545f:	78 7f                	js     801054e0 <sys_chdir+0xa0>
80105461:	83 ec 0c             	sub    $0xc,%esp
80105464:	ff 75 f4             	pushl  -0xc(%ebp)
80105467:	e8 94 ca ff ff       	call   80101f00 <namei>
8010546c:	83 c4 10             	add    $0x10,%esp
8010546f:	85 c0                	test   %eax,%eax
80105471:	89 c3                	mov    %eax,%ebx
80105473:	74 6b                	je     801054e0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105475:	83 ec 0c             	sub    $0xc,%esp
80105478:	50                   	push   %eax
80105479:	e8 d2 c1 ff ff       	call   80101650 <ilock>
  if(ip->type != T_DIR){
8010547e:	83 c4 10             	add    $0x10,%esp
80105481:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105486:	75 38                	jne    801054c0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105488:	83 ec 0c             	sub    $0xc,%esp
8010548b:	53                   	push   %ebx
8010548c:	e8 9f c2 ff ff       	call   80101730 <iunlock>
  iput(proc->cwd);
80105491:	58                   	pop    %eax
80105492:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105498:	ff 70 68             	pushl  0x68(%eax)
8010549b:	e8 e0 c2 ff ff       	call   80101780 <iput>
  end_op();
801054a0:	e8 fb d7 ff ff       	call   80102ca0 <end_op>
  proc->cwd = ip;
801054a5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return 0;
801054ab:	83 c4 10             	add    $0x10,%esp
    return -1;
  }
  iunlock(ip);
  iput(proc->cwd);
  end_op();
  proc->cwd = ip;
801054ae:	89 58 68             	mov    %ebx,0x68(%eax)
  return 0;
801054b1:	31 c0                	xor    %eax,%eax
}
801054b3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801054b6:	c9                   	leave  
801054b7:	c3                   	ret    
801054b8:	90                   	nop
801054b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
801054c0:	83 ec 0c             	sub    $0xc,%esp
801054c3:	53                   	push   %ebx
801054c4:	e8 f7 c3 ff ff       	call   801018c0 <iunlockput>
    end_op();
801054c9:	e8 d2 d7 ff ff       	call   80102ca0 <end_op>
    return -1;
801054ce:	83 c4 10             	add    $0x10,%esp
801054d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054d6:	eb db                	jmp    801054b3 <sys_chdir+0x73>
801054d8:	90                   	nop
801054d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
801054e0:	e8 bb d7 ff ff       	call   80102ca0 <end_op>
    return -1;
801054e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054ea:	eb c7                	jmp    801054b3 <sys_chdir+0x73>
801054ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054f0 <sys_exec>:
  return 0;
}

int
sys_exec(void)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	57                   	push   %edi
801054f4:	56                   	push   %esi
801054f5:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801054f6:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
  return 0;
}

int
sys_exec(void)
{
801054fc:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105502:	50                   	push   %eax
80105503:	6a 00                	push   $0x0
80105505:	e8 76 f3 ff ff       	call   80104880 <argstr>
8010550a:	83 c4 10             	add    $0x10,%esp
8010550d:	85 c0                	test   %eax,%eax
8010550f:	78 7f                	js     80105590 <sys_exec+0xa0>
80105511:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105517:	83 ec 08             	sub    $0x8,%esp
8010551a:	50                   	push   %eax
8010551b:	6a 01                	push   $0x1
8010551d:	e8 ce f2 ff ff       	call   801047f0 <argint>
80105522:	83 c4 10             	add    $0x10,%esp
80105525:	85 c0                	test   %eax,%eax
80105527:	78 67                	js     80105590 <sys_exec+0xa0>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105529:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
8010552f:	83 ec 04             	sub    $0x4,%esp
80105532:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105538:	68 80 00 00 00       	push   $0x80
8010553d:	6a 00                	push   $0x0
8010553f:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105545:	50                   	push   %eax
80105546:	31 db                	xor    %ebx,%ebx
80105548:	e8 b3 ef ff ff       	call   80104500 <memset>
8010554d:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105550:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105556:	83 ec 08             	sub    $0x8,%esp
80105559:	57                   	push   %edi
8010555a:	8d 04 98             	lea    (%eax,%ebx,4),%eax
8010555d:	50                   	push   %eax
8010555e:	e8 0d f2 ff ff       	call   80104770 <fetchint>
80105563:	83 c4 10             	add    $0x10,%esp
80105566:	85 c0                	test   %eax,%eax
80105568:	78 26                	js     80105590 <sys_exec+0xa0>
      return -1;
    if(uarg == 0){
8010556a:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105570:	85 c0                	test   %eax,%eax
80105572:	74 2c                	je     801055a0 <sys_exec+0xb0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105574:	83 ec 08             	sub    $0x8,%esp
80105577:	56                   	push   %esi
80105578:	50                   	push   %eax
80105579:	e8 22 f2 ff ff       	call   801047a0 <fetchstr>
8010557e:	83 c4 10             	add    $0x10,%esp
80105581:	85 c0                	test   %eax,%eax
80105583:	78 0b                	js     80105590 <sys_exec+0xa0>

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
80105585:	83 c3 01             	add    $0x1,%ebx
80105588:	83 c6 04             	add    $0x4,%esi
    if(i >= NELEM(argv))
8010558b:	83 fb 20             	cmp    $0x20,%ebx
8010558e:	75 c0                	jne    80105550 <sys_exec+0x60>
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105590:	8d 65 f4             	lea    -0xc(%ebp),%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
80105593:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}
80105598:	5b                   	pop    %ebx
80105599:	5e                   	pop    %esi
8010559a:	5f                   	pop    %edi
8010559b:	5d                   	pop    %ebp
8010559c:	c3                   	ret    
8010559d:	8d 76 00             	lea    0x0(%esi),%esi
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801055a0:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801055a6:	83 ec 08             	sub    $0x8,%esp
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
801055a9:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801055b0:	00 00 00 00 
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
801055b4:	50                   	push   %eax
801055b5:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801055bb:	e8 30 b4 ff ff       	call   801009f0 <exec>
801055c0:	83 c4 10             	add    $0x10,%esp
}
801055c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055c6:	5b                   	pop    %ebx
801055c7:	5e                   	pop    %esi
801055c8:	5f                   	pop    %edi
801055c9:	5d                   	pop    %ebp
801055ca:	c3                   	ret    
801055cb:	90                   	nop
801055cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055d0 <sys_pipe>:

int
sys_pipe(void)
{
801055d0:	55                   	push   %ebp
801055d1:	89 e5                	mov    %esp,%ebp
801055d3:	57                   	push   %edi
801055d4:	56                   	push   %esi
801055d5:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055d6:	8d 45 dc             	lea    -0x24(%ebp),%eax
  return exec(path, argv);
}

int
sys_pipe(void)
{
801055d9:	83 ec 20             	sub    $0x20,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801055dc:	6a 08                	push   $0x8
801055de:	50                   	push   %eax
801055df:	6a 00                	push   $0x0
801055e1:	e8 4a f2 ff ff       	call   80104830 <argptr>
801055e6:	83 c4 10             	add    $0x10,%esp
801055e9:	85 c0                	test   %eax,%eax
801055eb:	78 48                	js     80105635 <sys_pipe+0x65>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801055ed:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801055f0:	83 ec 08             	sub    $0x8,%esp
801055f3:	50                   	push   %eax
801055f4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801055f7:	50                   	push   %eax
801055f8:	e8 d3 dd ff ff       	call   801033d0 <pipealloc>
801055fd:	83 c4 10             	add    $0x10,%esp
80105600:	85 c0                	test   %eax,%eax
80105602:	78 31                	js     80105635 <sys_pipe+0x65>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105604:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80105607:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
8010560e:	31 c0                	xor    %eax,%eax
    if(proc->ofile[fd] == 0){
80105610:	8b 54 81 28          	mov    0x28(%ecx,%eax,4),%edx
80105614:	85 d2                	test   %edx,%edx
80105616:	74 28                	je     80105640 <sys_pipe+0x70>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105618:	83 c0 01             	add    $0x1,%eax
8010561b:	83 f8 10             	cmp    $0x10,%eax
8010561e:	75 f0                	jne    80105610 <sys_pipe+0x40>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
    fileclose(rf);
80105620:	83 ec 0c             	sub    $0xc,%esp
80105623:	53                   	push   %ebx
80105624:	e8 e7 b7 ff ff       	call   80100e10 <fileclose>
    fileclose(wf);
80105629:	58                   	pop    %eax
8010562a:	ff 75 e4             	pushl  -0x1c(%ebp)
8010562d:	e8 de b7 ff ff       	call   80100e10 <fileclose>
    return -1;
80105632:	83 c4 10             	add    $0x10,%esp
80105635:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010563a:	eb 45                	jmp    80105681 <sys_pipe+0xb1>
8010563c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105640:	8d 34 81             	lea    (%ecx,%eax,4),%esi
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
    return -1;
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105643:	8b 7d e4             	mov    -0x1c(%ebp),%edi
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105646:	31 d2                	xor    %edx,%edx
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105648:	89 5e 28             	mov    %ebx,0x28(%esi)
8010564b:	90                   	nop
8010564c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
80105650:	83 7c 91 28 00       	cmpl   $0x0,0x28(%ecx,%edx,4)
80105655:	74 19                	je     80105670 <sys_pipe+0xa0>
static int
fdalloc(struct file *f)
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
80105657:	83 c2 01             	add    $0x1,%edx
8010565a:	83 fa 10             	cmp    $0x10,%edx
8010565d:	75 f1                	jne    80105650 <sys_pipe+0x80>
  if(pipealloc(&rf, &wf) < 0)
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      proc->ofile[fd0] = 0;
8010565f:	c7 46 28 00 00 00 00 	movl   $0x0,0x28(%esi)
80105666:	eb b8                	jmp    80105620 <sys_pipe+0x50>
80105668:	90                   	nop
80105669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
  int fd;

  for(fd = 0; fd < NOFILE; fd++){
    if(proc->ofile[fd] == 0){
      proc->ofile[fd] = f;
80105670:	89 7c 91 28          	mov    %edi,0x28(%ecx,%edx,4)
      proc->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  fd[0] = fd0;
80105674:	8b 4d dc             	mov    -0x24(%ebp),%ecx
80105677:	89 01                	mov    %eax,(%ecx)
  fd[1] = fd1;
80105679:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010567c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010567f:	31 c0                	xor    %eax,%eax
}
80105681:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105684:	5b                   	pop    %ebx
80105685:	5e                   	pop    %esi
80105686:	5f                   	pop    %edi
80105687:	5d                   	pop    %ebp
80105688:	c3                   	ret    
80105689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105690 <updatecount>:
int count_array[23];
int inits = 0;

void
updatecount(int syscall) {
  if (inits == 0) {
80105690:	a1 c4 a5 10 80       	mov    0x8010a5c4,%eax

int count_array[23];
int inits = 0;

void
updatecount(int syscall) {
80105695:	55                   	push   %ebp
80105696:	89 e5                	mov    %esp,%ebp
  if (inits == 0) {
80105698:	85 c0                	test   %eax,%eax

int count_array[23];
int inits = 0;

void
updatecount(int syscall) {
8010569a:	8b 55 08             	mov    0x8(%ebp),%edx
  if (inits == 0) {
8010569d:	75 19                	jne    801056b8 <updatecount+0x28>
8010569f:	b8 40 4d 11 80       	mov    $0x80114d40,%eax
801056a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int i;
    for (i = 0; i < 23; i++) {
      count_array[i] = 0;
801056a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801056ae:	83 c0 04             	add    $0x4,%eax

void
updatecount(int syscall) {
  if (inits == 0) {
    int i;
    for (i = 0; i < 23; i++) {
801056b1:	3d 9c 4d 11 80       	cmp    $0x80114d9c,%eax
801056b6:	75 f0                	jne    801056a8 <updatecount+0x18>
      count_array[i] = 0;
     }
  }
  inits = 1;
801056b8:	c7 05 c4 a5 10 80 01 	movl   $0x1,0x8010a5c4
801056bf:	00 00 00 
  count_array[syscall]++;
801056c2:	83 04 95 40 4d 11 80 	addl   $0x1,-0x7feeb2c0(,%edx,4)
801056c9:	01 
}
801056ca:	5d                   	pop    %ebp
801056cb:	c3                   	ret    
801056cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801056d0 <getcount>:

int
getcount(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 20             	sub    $0x20,%esp
  int *counts;
  int size;
  if(argint(1, &size) < 0 || argptr(0, (void*)&counts, size) < 0)
801056d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056d9:	50                   	push   %eax
801056da:	6a 01                	push   $0x1
801056dc:	e8 0f f1 ff ff       	call   801047f0 <argint>
801056e1:	83 c4 10             	add    $0x10,%esp
801056e4:	85 c0                	test   %eax,%eax
801056e6:	78 48                	js     80105730 <getcount+0x60>
801056e8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056eb:	83 ec 04             	sub    $0x4,%esp
801056ee:	ff 75 f4             	pushl  -0xc(%ebp)
801056f1:	50                   	push   %eax
801056f2:	6a 00                	push   $0x0
801056f4:	e8 37 f1 ff ff       	call   80104830 <argptr>
801056f9:	83 c4 10             	add    $0x10,%esp
801056fc:	85 c0                	test   %eax,%eax
801056fe:	78 30                	js     80105730 <getcount+0x60>
    return -1;
  if (size < 23 || counts == 0) {
80105700:	83 7d f4 16          	cmpl   $0x16,-0xc(%ebp)
80105704:	7e 2a                	jle    80105730 <getcount+0x60>
80105706:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105709:	85 d2                	test   %edx,%edx
8010570b:	74 23                	je     80105730 <getcount+0x60>
8010570d:	31 c0                	xor    %eax,%eax
8010570f:	eb 0a                	jmp    8010571b <getcount+0x4b>
80105711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105718:	8b 55 f0             	mov    -0x10(%ebp),%edx
    return -1;
  }
  int i;
  for (i = 0; i < 23; i++) {
    counts[i] = count_array[i];
8010571b:	8b 88 40 4d 11 80    	mov    -0x7feeb2c0(%eax),%ecx
80105721:	89 0c 02             	mov    %ecx,(%edx,%eax,1)
80105724:	83 c0 04             	add    $0x4,%eax
    return -1;
  if (size < 23 || counts == 0) {
    return -1;
  }
  int i;
  for (i = 0; i < 23; i++) {
80105727:	83 f8 5c             	cmp    $0x5c,%eax
8010572a:	75 ec                	jne    80105718 <getcount+0x48>
    counts[i] = count_array[i];
  }
  return 0;
8010572c:	31 c0                	xor    %eax,%eax

}
8010572e:	c9                   	leave  
8010572f:	c3                   	ret    
getcount(void)
{
  int *counts;
  int size;
  if(argint(1, &size) < 0 || argptr(0, (void*)&counts, size) < 0)
    return -1;
80105730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  for (i = 0; i < 23; i++) {
    counts[i] = count_array[i];
  }
  return 0;

}
80105735:	c9                   	leave  
80105736:	c3                   	ret    
80105737:	89 f6                	mov    %esi,%esi
80105739:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105740 <updatem>:

int numberz;
void
updatem(int newsz){
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
	numberz=newsz;
80105743:	8b 45 08             	mov    0x8(%ebp),%eax
}
80105746:	5d                   	pop    %ebp
}

int numberz;
void
updatem(int newsz){
	numberz=newsz;
80105747:	a3 20 4d 11 80       	mov    %eax,0x80114d20
}
8010574c:	c3                   	ret    
8010574d:	8d 76 00             	lea    0x0(%esi),%esi

80105750 <currentm>:

int
currentm(void)
{
80105750:	55                   	push   %ebp
80105751:	89 e5                	mov    %esp,%ebp
80105753:	53                   	push   %ebx
80105754:	83 ec 1c             	sub    $0x1c,%esp
	int pages;
	float num;
	const uint MAXPAGES = 524288;

	num = numberz/PGSIZE;
80105757:	8b 15 20 4d 11 80    	mov    0x80114d20,%edx
	num = num+1;
	pages=(int)num;
8010575d:	d9 7d f6             	fnstcw -0xa(%ebp)
{
	int pages;
	float num;
	const uint MAXPAGES = 524288;

	num = numberz/PGSIZE;
80105760:	8d 82 ff 0f 00 00    	lea    0xfff(%edx),%eax
80105766:	85 d2                	test   %edx,%edx
80105768:	0f 49 c2             	cmovns %edx,%eax
8010576b:	c1 f8 0c             	sar    $0xc,%eax
8010576e:	89 45 ec             	mov    %eax,-0x14(%ebp)
	num = num+1;
	pages=(int)num;
80105771:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
{
	int pages;
	float num;
	const uint MAXPAGES = 524288;

	num = numberz/PGSIZE;
80105775:	db 45 ec             	fildl  -0x14(%ebp)
	num = num+1;
	pages=(int)num;
80105778:	d8 05 dc 7a 10 80    	fadds  0x80107adc
8010577e:	b4 0c                	mov    $0xc,%ah
80105780:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80105784:	d9 6d f4             	fldcw  -0xc(%ebp)
80105787:	db 5d f0             	fistpl -0x10(%ebp)
8010578a:	d9 6d f6             	fldcw  -0xa(%ebp)
8010578d:	8b 5d f0             	mov    -0x10(%ebp),%ebx
	int rempages = MAXPAGES-pages;
	cprintf("# of Pages for Current Process: %d\n", pages);
80105790:	53                   	push   %ebx
80105791:	68 94 7a 10 80       	push   $0x80107a94
80105796:	e8 c5 ae ff ff       	call   80100660 <cprintf>
	cprintf("# of Pages Available for C/P: %d\n", rempages);
8010579b:	58                   	pop    %eax
8010579c:	b8 00 00 08 00       	mov    $0x80000,%eax
801057a1:	5a                   	pop    %edx
801057a2:	29 d8                	sub    %ebx,%eax
801057a4:	50                   	push   %eax
801057a5:	68 b8 7a 10 80       	push   $0x80107ab8
801057aa:	e8 b1 ae ff ff       	call   80100660 <cprintf>
	return 0;
}
801057af:	31 c0                	xor    %eax,%eax
801057b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801057b4:	c9                   	leave  
801057b5:	c3                   	ret    
801057b6:	8d 76 00             	lea    0x0(%esi),%esi
801057b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801057c0 <sys_mkSmallFilesdir>:

int sys_mkSmallFilesdir(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801057c6:	e8 65 d4 ff ff       	call   80102c30 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_SMALLDIR, 0, 0)) == 0){
801057cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057ce:	83 ec 08             	sub    $0x8,%esp
801057d1:	50                   	push   %eax
801057d2:	6a 00                	push   $0x0
801057d4:	e8 a7 f0 ff ff       	call   80104880 <argstr>
801057d9:	83 c4 10             	add    $0x10,%esp
801057dc:	85 c0                	test   %eax,%eax
801057de:	78 30                	js     80105810 <sys_mkSmallFilesdir+0x50>
801057e0:	83 ec 0c             	sub    $0xc,%esp
801057e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801057e6:	31 c9                	xor    %ecx,%ecx
801057e8:	6a 00                	push   $0x0
801057ea:	ba 04 00 00 00       	mov    $0x4,%edx
801057ef:	e8 0c f2 ff ff       	call   80104a00 <create>
801057f4:	83 c4 10             	add    $0x10,%esp
801057f7:	85 c0                	test   %eax,%eax
801057f9:	74 15                	je     80105810 <sys_mkSmallFilesdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801057fb:	83 ec 0c             	sub    $0xc,%esp
801057fe:	50                   	push   %eax
801057ff:	e8 bc c0 ff ff       	call   801018c0 <iunlockput>
  end_op();
80105804:	e8 97 d4 ff ff       	call   80102ca0 <end_op>
  return 0;
80105809:	83 c4 10             	add    $0x10,%esp
8010580c:	31 c0                	xor    %eax,%eax
}
8010580e:	c9                   	leave  
8010580f:	c3                   	ret    
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_SMALLDIR, 0, 0)) == 0){
    end_op();
80105810:	e8 8b d4 ff ff       	call   80102ca0 <end_op>
    return -1;
80105815:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  iunlockput(ip);
  end_op();
  return 0;
}
8010581a:	c9                   	leave  
8010581b:	c3                   	ret    
8010581c:	66 90                	xchg   %ax,%ax
8010581e:	66 90                	xchg   %ax,%ax

80105820 <sys_fork>:
#include "sysfile.h"
#include "stat.h"

int
sys_fork(void)
{
80105820:	55                   	push   %ebp
80105821:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105823:	5d                   	pop    %ebp
#include "stat.h"

int
sys_fork(void)
{
  return fork();
80105824:	e9 27 e2 ff ff       	jmp    80103a50 <fork>
80105829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105830 <sys_exit>:
}

int
sys_exit(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	83 ec 08             	sub    $0x8,%esp
  exit();
80105836:	e8 85 e4 ff ff       	call   80103cc0 <exit>
  return 0;  // not reached
}
8010583b:	31 c0                	xor    %eax,%eax
8010583d:	c9                   	leave  
8010583e:	c3                   	ret    
8010583f:	90                   	nop

80105840 <sys_wait>:

int
sys_wait(void)
{
80105840:	55                   	push   %ebp
80105841:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105843:	5d                   	pop    %ebp
}

int
sys_wait(void)
{
  return wait();
80105844:	e9 c7 e6 ff ff       	jmp    80103f10 <wait>
80105849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105850 <sys_kill>:
}

int
sys_kill(void)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105856:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105859:	50                   	push   %eax
8010585a:	6a 00                	push   $0x0
8010585c:	e8 8f ef ff ff       	call   801047f0 <argint>
80105861:	83 c4 10             	add    $0x10,%esp
80105864:	85 c0                	test   %eax,%eax
80105866:	78 18                	js     80105880 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105868:	83 ec 0c             	sub    $0xc,%esp
8010586b:	ff 75 f4             	pushl  -0xc(%ebp)
8010586e:	e8 dd e7 ff ff       	call   80104050 <kill>
80105873:	83 c4 10             	add    $0x10,%esp
}
80105876:	c9                   	leave  
80105877:	c3                   	ret    
80105878:	90                   	nop
80105879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
80105880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return kill(pid);
}
80105885:	c9                   	leave  
80105886:	c3                   	ret    
80105887:	89 f6                	mov    %esi,%esi
80105889:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105890 <sys_getpid>:

int
sys_getpid(void)
{
  return proc->pid;
80105890:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  return kill(pid);
}

int
sys_getpid(void)
{
80105896:	55                   	push   %ebp
80105897:	89 e5                	mov    %esp,%ebp
  return proc->pid;
80105899:	8b 40 10             	mov    0x10(%eax),%eax
}
8010589c:	5d                   	pop    %ebp
8010589d:	c3                   	ret    
8010589e:	66 90                	xchg   %ax,%ax

801058a0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return proc->pid;
}

int
sys_sbrk(void)
{
801058a7:	83 ec 1c             	sub    $0x1c,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058aa:	50                   	push   %eax
801058ab:	6a 00                	push   $0x0
801058ad:	e8 3e ef ff ff       	call   801047f0 <argint>
801058b2:	83 c4 10             	add    $0x10,%esp
801058b5:	85 c0                	test   %eax,%eax
801058b7:	78 27                	js     801058e0 <sys_sbrk+0x40>
    return -1;
  addr = proc->sz;
801058b9:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
  if(growproc(n) < 0)
801058bf:	83 ec 0c             	sub    $0xc,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
801058c2:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801058c4:	ff 75 f4             	pushl  -0xc(%ebp)
801058c7:	e8 14 e1 ff ff       	call   801039e0 <growproc>
801058cc:	83 c4 10             	add    $0x10,%esp
801058cf:	85 c0                	test   %eax,%eax
801058d1:	78 0d                	js     801058e0 <sys_sbrk+0x40>
    return -1;
  return addr;
801058d3:	89 d8                	mov    %ebx,%eax
}
801058d5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801058d8:	c9                   	leave  
801058d9:	c3                   	ret    
801058da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
801058e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058e5:	eb ee                	jmp    801058d5 <sys_sbrk+0x35>
801058e7:	89 f6                	mov    %esi,%esi
801058e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801058f0 <sys_sleep>:
  return addr;
}

int
sys_sleep(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801058f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
  return addr;
}

int
sys_sleep(void)
{
801058f7:	83 ec 1c             	sub    $0x1c,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801058fa:	50                   	push   %eax
801058fb:	6a 00                	push   $0x0
801058fd:	e8 ee ee ff ff       	call   801047f0 <argint>
80105902:	83 c4 10             	add    $0x10,%esp
80105905:	85 c0                	test   %eax,%eax
80105907:	0f 88 8a 00 00 00    	js     80105997 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
8010590d:	83 ec 0c             	sub    $0xc,%esp
80105910:	68 a0 4d 11 80       	push   $0x80114da0
80105915:	e8 b6 e9 ff ff       	call   801042d0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
8010591a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010591d:	83 c4 10             	add    $0x10,%esp
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
80105920:	8b 1d e0 55 11 80    	mov    0x801155e0,%ebx
  while(ticks - ticks0 < n){
80105926:	85 d2                	test   %edx,%edx
80105928:	75 27                	jne    80105951 <sys_sleep+0x61>
8010592a:	eb 54                	jmp    80105980 <sys_sleep+0x90>
8010592c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105930:	83 ec 08             	sub    $0x8,%esp
80105933:	68 a0 4d 11 80       	push   $0x80114da0
80105938:	68 e0 55 11 80       	push   $0x801155e0
8010593d:	e8 0e e5 ff ff       	call   80103e50 <sleep>

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105942:	a1 e0 55 11 80       	mov    0x801155e0,%eax
80105947:	83 c4 10             	add    $0x10,%esp
8010594a:	29 d8                	sub    %ebx,%eax
8010594c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010594f:	73 2f                	jae    80105980 <sys_sleep+0x90>
    if(proc->killed){
80105951:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105957:	8b 40 24             	mov    0x24(%eax),%eax
8010595a:	85 c0                	test   %eax,%eax
8010595c:	74 d2                	je     80105930 <sys_sleep+0x40>
      release(&tickslock);
8010595e:	83 ec 0c             	sub    $0xc,%esp
80105961:	68 a0 4d 11 80       	push   $0x80114da0
80105966:	e8 45 eb ff ff       	call   801044b0 <release>
      return -1;
8010596b:	83 c4 10             	add    $0x10,%esp
8010596e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}
80105973:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105976:	c9                   	leave  
80105977:	c3                   	ret    
80105978:	90                   	nop
80105979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
80105980:	83 ec 0c             	sub    $0xc,%esp
80105983:	68 a0 4d 11 80       	push   $0x80114da0
80105988:	e8 23 eb ff ff       	call   801044b0 <release>
  return 0;
8010598d:	83 c4 10             	add    $0x10,%esp
80105990:	31 c0                	xor    %eax,%eax
}
80105992:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105995:	c9                   	leave  
80105996:	c3                   	ret    
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
80105997:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010599c:	eb d5                	jmp    80105973 <sys_sleep+0x83>
8010599e:	66 90                	xchg   %ax,%ax

801059a0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059a0:	55                   	push   %ebp
801059a1:	89 e5                	mov    %esp,%ebp
801059a3:	53                   	push   %ebx
801059a4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059a7:	68 a0 4d 11 80       	push   $0x80114da0
801059ac:	e8 1f e9 ff ff       	call   801042d0 <acquire>
  xticks = ticks;
801059b1:	8b 1d e0 55 11 80    	mov    0x801155e0,%ebx
  release(&tickslock);
801059b7:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
801059be:	e8 ed ea ff ff       	call   801044b0 <release>
  return xticks;
}
801059c3:	89 d8                	mov    %ebx,%eax
801059c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059c8:	c9                   	leave  
801059c9:	c3                   	ret    
801059ca:	66 90                	xchg   %ax,%ax
801059cc:	66 90                	xchg   %ax,%ax
801059ce:	66 90                	xchg   %ax,%ax

801059d0 <timerinit>:
#define TIMER_RATEGEN   0x04    // mode 2, rate generator
#define TIMER_16BIT     0x30    // r/w counter 16 bits, LSB first

void
timerinit(void)
{
801059d0:	55                   	push   %ebp
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801059d1:	ba 43 00 00 00       	mov    $0x43,%edx
801059d6:	b8 34 00 00 00       	mov    $0x34,%eax
801059db:	89 e5                	mov    %esp,%ebp
801059dd:	83 ec 14             	sub    $0x14,%esp
801059e0:	ee                   	out    %al,(%dx)
801059e1:	ba 40 00 00 00       	mov    $0x40,%edx
801059e6:	b8 9c ff ff ff       	mov    $0xffffff9c,%eax
801059eb:	ee                   	out    %al,(%dx)
801059ec:	b8 2e 00 00 00       	mov    $0x2e,%eax
801059f1:	ee                   	out    %al,(%dx)
  // Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
  outb(IO_TIMER1, TIMER_DIV(100) % 256);
  outb(IO_TIMER1, TIMER_DIV(100) / 256);
  picenable(IRQ_TIMER);
801059f2:	6a 00                	push   $0x0
801059f4:	e8 07 d9 ff ff       	call   80103300 <picenable>
}
801059f9:	83 c4 10             	add    $0x10,%esp
801059fc:	c9                   	leave  
801059fd:	c3                   	ret    

801059fe <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
801059fe:	1e                   	push   %ds
  pushl %es
801059ff:	06                   	push   %es
  pushl %fs
80105a00:	0f a0                	push   %fs
  pushl %gs
80105a02:	0f a8                	push   %gs
  pushal
80105a04:	60                   	pusha  
  
  # Set up data and per-cpu segments.
  movw $(SEG_KDATA<<3), %ax
80105a05:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105a09:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105a0b:	8e c0                	mov    %eax,%es
  movw $(SEG_KCPU<<3), %ax
80105a0d:	66 b8 18 00          	mov    $0x18,%ax
  movw %ax, %fs
80105a11:	8e e0                	mov    %eax,%fs
  movw %ax, %gs
80105a13:	8e e8                	mov    %eax,%gs

  # Call trap(tf), where tf=%esp
  pushl %esp
80105a15:	54                   	push   %esp
  call trap
80105a16:	e8 e5 00 00 00       	call   80105b00 <trap>
  addl $4, %esp
80105a1b:	83 c4 04             	add    $0x4,%esp

80105a1e <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105a1e:	61                   	popa   
  popl %gs
80105a1f:	0f a9                	pop    %gs
  popl %fs
80105a21:	0f a1                	pop    %fs
  popl %es
80105a23:	07                   	pop    %es
  popl %ds
80105a24:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105a25:	83 c4 08             	add    $0x8,%esp
  iret
80105a28:	cf                   	iret   
80105a29:	66 90                	xchg   %ax,%ax
80105a2b:	66 90                	xchg   %ax,%ax
80105a2d:	66 90                	xchg   %ax,%ax
80105a2f:	90                   	nop

80105a30 <tvinit>:
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105a30:	31 c0                	xor    %eax,%eax
80105a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a38:	8b 14 85 0c a0 10 80 	mov    -0x7fef5ff4(,%eax,4),%edx
80105a3f:	b9 08 00 00 00       	mov    $0x8,%ecx
80105a44:	c6 04 c5 e4 4d 11 80 	movb   $0x0,-0x7feeb21c(,%eax,8)
80105a4b:	00 
80105a4c:	66 89 0c c5 e2 4d 11 	mov    %cx,-0x7feeb21e(,%eax,8)
80105a53:	80 
80105a54:	c6 04 c5 e5 4d 11 80 	movb   $0x8e,-0x7feeb21b(,%eax,8)
80105a5b:	8e 
80105a5c:	66 89 14 c5 e0 4d 11 	mov    %dx,-0x7feeb220(,%eax,8)
80105a63:	80 
80105a64:	c1 ea 10             	shr    $0x10,%edx
80105a67:	66 89 14 c5 e6 4d 11 	mov    %dx,-0x7feeb21a(,%eax,8)
80105a6e:	80 
void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
80105a6f:	83 c0 01             	add    $0x1,%eax
80105a72:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a77:	75 bf                	jne    80105a38 <tvinit+0x8>
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a79:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a7a:	ba 08 00 00 00       	mov    $0x8,%edx
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a7f:	89 e5                	mov    %esp,%ebp
80105a81:	83 ec 10             	sub    $0x10,%esp
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a84:	a1 0c a1 10 80       	mov    0x8010a10c,%eax

  initlock(&tickslock, "time");
80105a89:	68 e0 7a 10 80       	push   $0x80107ae0
80105a8e:	68 a0 4d 11 80       	push   $0x80114da0
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a93:	66 89 15 e2 4f 11 80 	mov    %dx,0x80114fe2
80105a9a:	c6 05 e4 4f 11 80 00 	movb   $0x0,0x80114fe4
80105aa1:	66 a3 e0 4f 11 80    	mov    %ax,0x80114fe0
80105aa7:	c1 e8 10             	shr    $0x10,%eax
80105aaa:	c6 05 e5 4f 11 80 ef 	movb   $0xef,0x80114fe5
80105ab1:	66 a3 e6 4f 11 80    	mov    %ax,0x80114fe6

  initlock(&tickslock, "time");
80105ab7:	e8 f4 e7 ff ff       	call   801042b0 <initlock>
}
80105abc:	83 c4 10             	add    $0x10,%esp
80105abf:	c9                   	leave  
80105ac0:	c3                   	ret    
80105ac1:	eb 0d                	jmp    80105ad0 <idtinit>
80105ac3:	90                   	nop
80105ac4:	90                   	nop
80105ac5:	90                   	nop
80105ac6:	90                   	nop
80105ac7:	90                   	nop
80105ac8:	90                   	nop
80105ac9:	90                   	nop
80105aca:	90                   	nop
80105acb:	90                   	nop
80105acc:	90                   	nop
80105acd:	90                   	nop
80105ace:	90                   	nop
80105acf:	90                   	nop

80105ad0 <idtinit>:

void
idtinit(void)
{
80105ad0:	55                   	push   %ebp
static inline void
lidt(struct gatedesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80105ad1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105ad6:	89 e5                	mov    %esp,%ebp
80105ad8:	83 ec 10             	sub    $0x10,%esp
80105adb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105adf:	b8 e0 4d 11 80       	mov    $0x80114de0,%eax
80105ae4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105ae8:	c1 e8 10             	shr    $0x10,%eax
80105aeb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)

  asm volatile("lidt (%0)" : : "r" (pd));
80105aef:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105af2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105af5:	c9                   	leave  
80105af6:	c3                   	ret    
80105af7:	89 f6                	mov    %esi,%esi
80105af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b00 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	57                   	push   %edi
80105b04:	56                   	push   %esi
80105b05:	53                   	push   %ebx
80105b06:	83 ec 0c             	sub    $0xc,%esp
80105b09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105b0c:	8b 43 30             	mov    0x30(%ebx),%eax
80105b0f:	83 f8 40             	cmp    $0x40,%eax
80105b12:	0f 84 f8 00 00 00    	je     80105c10 <trap+0x110>
    if(proc->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105b18:	83 e8 20             	sub    $0x20,%eax
80105b1b:	83 f8 1f             	cmp    $0x1f,%eax
80105b1e:	77 68                	ja     80105b88 <trap+0x88>
80105b20:	ff 24 85 88 7b 10 80 	jmp    *-0x7fef8478(,%eax,4)
80105b27:	89 f6                	mov    %esi,%esi
80105b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
80105b30:	e8 1b cc ff ff       	call   80102750 <cpunum>
80105b35:	85 c0                	test   %eax,%eax
80105b37:	0f 84 b3 01 00 00    	je     80105cf0 <trap+0x1f0>
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
80105b3d:	e8 ae cc ff ff       	call   801027f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b42:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105b48:	85 c0                	test   %eax,%eax
80105b4a:	74 2d                	je     80105b79 <trap+0x79>
80105b4c:	8b 50 24             	mov    0x24(%eax),%edx
80105b4f:	85 d2                	test   %edx,%edx
80105b51:	0f 85 86 00 00 00    	jne    80105bdd <trap+0xdd>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105b57:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b5b:	0f 84 ef 00 00 00    	je     80105c50 <trap+0x150>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105b61:	8b 40 24             	mov    0x24(%eax),%eax
80105b64:	85 c0                	test   %eax,%eax
80105b66:	74 11                	je     80105b79 <trap+0x79>
80105b68:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105b6c:	83 e0 03             	and    $0x3,%eax
80105b6f:	66 83 f8 03          	cmp    $0x3,%ax
80105b73:	0f 84 c1 00 00 00    	je     80105c3a <trap+0x13a>
    exit();
}
80105b79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b7c:	5b                   	pop    %ebx
80105b7d:	5e                   	pop    %esi
80105b7e:	5f                   	pop    %edi
80105b7f:	5d                   	pop    %ebp
80105b80:	c3                   	ret    
80105b81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
80105b88:	65 8b 0d 04 00 00 00 	mov    %gs:0x4,%ecx
80105b8f:	85 c9                	test   %ecx,%ecx
80105b91:	0f 84 8d 01 00 00    	je     80105d24 <trap+0x224>
80105b97:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105b9b:	0f 84 83 01 00 00    	je     80105d24 <trap+0x224>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105ba1:	0f 20 d7             	mov    %cr2,%edi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ba4:	8b 73 38             	mov    0x38(%ebx),%esi
80105ba7:	e8 a4 cb ff ff       	call   80102750 <cpunum>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bac:	65 8b 15 04 00 00 00 	mov    %gs:0x4,%edx
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bb3:	57                   	push   %edi
80105bb4:	56                   	push   %esi
80105bb5:	50                   	push   %eax
80105bb6:	ff 73 34             	pushl  0x34(%ebx)
80105bb9:	ff 73 30             	pushl  0x30(%ebx)
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
80105bbc:	8d 42 6c             	lea    0x6c(%edx),%eax
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bbf:	50                   	push   %eax
80105bc0:	ff 72 10             	pushl  0x10(%edx)
80105bc3:	68 44 7b 10 80       	push   $0x80107b44
80105bc8:	e8 93 aa ff ff       	call   80100660 <cprintf>
            "eip 0x%x addr 0x%x--kill proc\n",
            proc->pid, proc->name, tf->trapno, tf->err, cpunum(), tf->eip,
            rcr2());
    proc->killed = 1;
80105bcd:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105bd3:	83 c4 20             	add    $0x20,%esp
80105bd6:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105bdd:	0f b7 53 3c          	movzwl 0x3c(%ebx),%edx
80105be1:	83 e2 03             	and    $0x3,%edx
80105be4:	66 83 fa 03          	cmp    $0x3,%dx
80105be8:	0f 85 69 ff ff ff    	jne    80105b57 <trap+0x57>
    exit();
80105bee:	e8 cd e0 ff ff       	call   80103cc0 <exit>
80105bf3:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105bf9:	85 c0                	test   %eax,%eax
80105bfb:	0f 85 56 ff ff ff    	jne    80105b57 <trap+0x57>
80105c01:	e9 73 ff ff ff       	jmp    80105b79 <trap+0x79>
80105c06:	8d 76 00             	lea    0x0(%esi),%esi
80105c09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
80105c10:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c16:	8b 70 24             	mov    0x24(%eax),%esi
80105c19:	85 f6                	test   %esi,%esi
80105c1b:	0f 85 bf 00 00 00    	jne    80105ce0 <trap+0x1e0>
      exit();
    proc->tf = tf;
80105c21:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105c24:	e8 07 ed ff ff       	call   80104930 <syscall>
    if(proc->killed)
80105c29:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105c2f:	8b 58 24             	mov    0x24(%eax),%ebx
80105c32:	85 db                	test   %ebx,%ebx
80105c34:	0f 84 3f ff ff ff    	je     80105b79 <trap+0x79>
    yield();

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();
}
80105c3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c3d:	5b                   	pop    %ebx
80105c3e:	5e                   	pop    %esi
80105c3f:	5f                   	pop    %edi
80105c40:	5d                   	pop    %ebp
    if(proc->killed)
      exit();
    proc->tf = tf;
    syscall();
    if(proc->killed)
      exit();
80105c41:	e9 7a e0 ff ff       	jmp    80103cc0 <exit>
80105c46:	8d 76 00             	lea    0x0(%esi),%esi
80105c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(proc && proc->state == RUNNING && tf->trapno == T_IRQ0+IRQ_TIMER)
80105c50:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105c54:	0f 85 07 ff ff ff    	jne    80105b61 <trap+0x61>
    yield();
80105c5a:	e8 b1 e1 ff ff       	call   80103e10 <yield>
80105c5f:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax

  // Check if the process has been killed since we yielded
  if(proc && proc->killed && (tf->cs&3) == DPL_USER)
80105c65:	85 c0                	test   %eax,%eax
80105c67:	0f 85 f4 fe ff ff    	jne    80105b61 <trap+0x61>
80105c6d:	e9 07 ff ff ff       	jmp    80105b79 <trap+0x79>
80105c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80105c78:	e8 b3 c9 ff ff       	call   80102630 <kbdintr>
    lapiceoi();
80105c7d:	e8 6e cb ff ff       	call   801027f0 <lapiceoi>
    break;
80105c82:	e9 bb fe ff ff       	jmp    80105b42 <trap+0x42>
80105c87:	89 f6                	mov    %esi,%esi
80105c89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80105c90:	e8 2b 02 00 00       	call   80105ec0 <uartintr>
80105c95:	e9 a3 fe ff ff       	jmp    80105b3d <trap+0x3d>
80105c9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105ca0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105ca4:	8b 7b 38             	mov    0x38(%ebx),%edi
80105ca7:	e8 a4 ca ff ff       	call   80102750 <cpunum>
80105cac:	57                   	push   %edi
80105cad:	56                   	push   %esi
80105cae:	50                   	push   %eax
80105caf:	68 ec 7a 10 80       	push   $0x80107aec
80105cb4:	e8 a7 a9 ff ff       	call   80100660 <cprintf>
            cpunum(), tf->cs, tf->eip);
    lapiceoi();
80105cb9:	e8 32 cb ff ff       	call   801027f0 <lapiceoi>
    break;
80105cbe:	83 c4 10             	add    $0x10,%esp
80105cc1:	e9 7c fe ff ff       	jmp    80105b42 <trap+0x42>
80105cc6:	8d 76 00             	lea    0x0(%esi),%esi
80105cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105cd0:	e8 cb c3 ff ff       	call   801020a0 <ideintr>
    lapiceoi();
80105cd5:	e8 16 cb ff ff       	call   801027f0 <lapiceoi>
    break;
80105cda:	e9 63 fe ff ff       	jmp    80105b42 <trap+0x42>
80105cdf:	90                   	nop
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(proc->killed)
      exit();
80105ce0:	e8 db df ff ff       	call   80103cc0 <exit>
80105ce5:	65 a1 04 00 00 00    	mov    %gs:0x4,%eax
80105ceb:	e9 31 ff ff ff       	jmp    80105c21 <trap+0x121>
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
80105cf0:	83 ec 0c             	sub    $0xc,%esp
80105cf3:	68 a0 4d 11 80       	push   $0x80114da0
80105cf8:	e8 d3 e5 ff ff       	call   801042d0 <acquire>
      ticks++;
      wakeup(&ticks);
80105cfd:	c7 04 24 e0 55 11 80 	movl   $0x801155e0,(%esp)

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpunum() == 0){
      acquire(&tickslock);
      ticks++;
80105d04:	83 05 e0 55 11 80 01 	addl   $0x1,0x801155e0
      wakeup(&ticks);
80105d0b:	e8 e0 e2 ff ff       	call   80103ff0 <wakeup>
      release(&tickslock);
80105d10:	c7 04 24 a0 4d 11 80 	movl   $0x80114da0,(%esp)
80105d17:	e8 94 e7 ff ff       	call   801044b0 <release>
80105d1c:	83 c4 10             	add    $0x10,%esp
80105d1f:	e9 19 fe ff ff       	jmp    80105b3d <trap+0x3d>
80105d24:	0f 20 d7             	mov    %cr2,%edi

  //PAGEBREAK: 13
  default:
    if(proc == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d27:	8b 73 38             	mov    0x38(%ebx),%esi
80105d2a:	e8 21 ca ff ff       	call   80102750 <cpunum>
80105d2f:	83 ec 0c             	sub    $0xc,%esp
80105d32:	57                   	push   %edi
80105d33:	56                   	push   %esi
80105d34:	50                   	push   %eax
80105d35:	ff 73 30             	pushl  0x30(%ebx)
80105d38:	68 10 7b 10 80       	push   $0x80107b10
80105d3d:	e8 1e a9 ff ff       	call   80100660 <cprintf>
              tf->trapno, cpunum(), tf->eip, rcr2());
      panic("trap");
80105d42:	83 c4 14             	add    $0x14,%esp
80105d45:	68 e5 7a 10 80       	push   $0x80107ae5
80105d4a:	e8 21 a6 ff ff       	call   80100370 <panic>
80105d4f:	90                   	nop

80105d50 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d50:	a1 c8 a5 10 80       	mov    0x8010a5c8,%eax
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80105d55:	55                   	push   %ebp
80105d56:	89 e5                	mov    %esp,%ebp
  if(!uart)
80105d58:	85 c0                	test   %eax,%eax
80105d5a:	74 1c                	je     80105d78 <uartgetc+0x28>
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d5c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d61:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d62:	a8 01                	test   $0x1,%al
80105d64:	74 12                	je     80105d78 <uartgetc+0x28>
80105d66:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d6b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d6c:	0f b6 c0             	movzbl %al,%eax
}
80105d6f:	5d                   	pop    %ebp
80105d70:	c3                   	ret    
80105d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

static int
uartgetc(void)
{
  if(!uart)
    return -1;
80105d78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  if(!(inb(COM1+5) & 0x01))
    return -1;
  return inb(COM1+0);
}
80105d7d:	5d                   	pop    %ebp
80105d7e:	c3                   	ret    
80105d7f:	90                   	nop

80105d80 <uartputc.part.0>:
  for(p="xv6...\n"; *p; p++)
    uartputc(*p);
}

void
uartputc(int c)
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	57                   	push   %edi
80105d84:	56                   	push   %esi
80105d85:	53                   	push   %ebx
80105d86:	89 c7                	mov    %eax,%edi
80105d88:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d8d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105d92:	83 ec 0c             	sub    $0xc,%esp
80105d95:	eb 1b                	jmp    80105db2 <uartputc.part.0+0x32>
80105d97:	89 f6                	mov    %esi,%esi
80105d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
80105da0:	83 ec 0c             	sub    $0xc,%esp
80105da3:	6a 0a                	push   $0xa
80105da5:	e8 66 ca ff ff       	call   80102810 <microdelay>
{
  int i;

  if(!uart)
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105daa:	83 c4 10             	add    $0x10,%esp
80105dad:	83 eb 01             	sub    $0x1,%ebx
80105db0:	74 07                	je     80105db9 <uartputc.part.0+0x39>
80105db2:	89 f2                	mov    %esi,%edx
80105db4:	ec                   	in     (%dx),%al
80105db5:	a8 20                	test   $0x20,%al
80105db7:	74 e7                	je     80105da0 <uartputc.part.0+0x20>
}

static inline void
outb(ushort port, uchar data)
{
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105db9:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dbe:	89 f8                	mov    %edi,%eax
80105dc0:	ee                   	out    %al,(%dx)
    microdelay(10);
  outb(COM1+0, c);
}
80105dc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dc4:	5b                   	pop    %ebx
80105dc5:	5e                   	pop    %esi
80105dc6:	5f                   	pop    %edi
80105dc7:	5d                   	pop    %ebp
80105dc8:	c3                   	ret    
80105dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105dd0 <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80105dd0:	55                   	push   %ebp
80105dd1:	31 c9                	xor    %ecx,%ecx
80105dd3:	89 c8                	mov    %ecx,%eax
80105dd5:	89 e5                	mov    %esp,%ebp
80105dd7:	57                   	push   %edi
80105dd8:	56                   	push   %esi
80105dd9:	53                   	push   %ebx
80105dda:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80105ddf:	89 da                	mov    %ebx,%edx
80105de1:	83 ec 0c             	sub    $0xc,%esp
80105de4:	ee                   	out    %al,(%dx)
80105de5:	bf fb 03 00 00       	mov    $0x3fb,%edi
80105dea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105def:	89 fa                	mov    %edi,%edx
80105df1:	ee                   	out    %al,(%dx)
80105df2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105df7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dfc:	ee                   	out    %al,(%dx)
80105dfd:	be f9 03 00 00       	mov    $0x3f9,%esi
80105e02:	89 c8                	mov    %ecx,%eax
80105e04:	89 f2                	mov    %esi,%edx
80105e06:	ee                   	out    %al,(%dx)
80105e07:	b8 03 00 00 00       	mov    $0x3,%eax
80105e0c:	89 fa                	mov    %edi,%edx
80105e0e:	ee                   	out    %al,(%dx)
80105e0f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105e14:	89 c8                	mov    %ecx,%eax
80105e16:	ee                   	out    %al,(%dx)
80105e17:	b8 01 00 00 00       	mov    $0x1,%eax
80105e1c:	89 f2                	mov    %esi,%edx
80105e1e:	ee                   	out    %al,(%dx)
static inline uchar
inb(ushort port)
{
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e1f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e24:	ec                   	in     (%dx),%al
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
  outb(COM1+4, 0);
  outb(COM1+1, 0x01);    // Enable receive interrupts.

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80105e25:	3c ff                	cmp    $0xff,%al
80105e27:	74 5a                	je     80105e83 <uartinit+0xb3>
    return;
  uart = 1;
80105e29:	c7 05 c8 a5 10 80 01 	movl   $0x1,0x8010a5c8
80105e30:	00 00 00 
80105e33:	89 da                	mov    %ebx,%edx
80105e35:	ec                   	in     (%dx),%al
80105e36:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e3b:	ec                   	in     (%dx),%al

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
  inb(COM1+0);
  picenable(IRQ_COM1);
80105e3c:	83 ec 0c             	sub    $0xc,%esp
80105e3f:	6a 04                	push   $0x4
80105e41:	e8 ba d4 ff ff       	call   80103300 <picenable>
  ioapicenable(IRQ_COM1, 0);
80105e46:	59                   	pop    %ecx
80105e47:	5b                   	pop    %ebx
80105e48:	6a 00                	push   $0x0
80105e4a:	6a 04                	push   $0x4
80105e4c:	bb 08 7c 10 80       	mov    $0x80107c08,%ebx
80105e51:	e8 aa c4 ff ff       	call   80102300 <ioapicenable>
80105e56:	83 c4 10             	add    $0x10,%esp
80105e59:	b8 78 00 00 00       	mov    $0x78,%eax
80105e5e:	eb 0a                	jmp    80105e6a <uartinit+0x9a>

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105e60:	83 c3 01             	add    $0x1,%ebx
80105e63:	0f be 03             	movsbl (%ebx),%eax
80105e66:	84 c0                	test   %al,%al
80105e68:	74 19                	je     80105e83 <uartinit+0xb3>
void
uartputc(int c)
{
  int i;

  if(!uart)
80105e6a:	8b 15 c8 a5 10 80    	mov    0x8010a5c8,%edx
80105e70:	85 d2                	test   %edx,%edx
80105e72:	74 ec                	je     80105e60 <uartinit+0x90>
  inb(COM1+0);
  picenable(IRQ_COM1);
  ioapicenable(IRQ_COM1, 0);

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80105e74:	83 c3 01             	add    $0x1,%ebx
80105e77:	e8 04 ff ff ff       	call   80105d80 <uartputc.part.0>
80105e7c:	0f be 03             	movsbl (%ebx),%eax
80105e7f:	84 c0                	test   %al,%al
80105e81:	75 e7                	jne    80105e6a <uartinit+0x9a>
    uartputc(*p);
}
80105e83:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e86:	5b                   	pop    %ebx
80105e87:	5e                   	pop    %esi
80105e88:	5f                   	pop    %edi
80105e89:	5d                   	pop    %ebp
80105e8a:	c3                   	ret    
80105e8b:	90                   	nop
80105e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e90 <uartputc>:
void
uartputc(int c)
{
  int i;

  if(!uart)
80105e90:	8b 15 c8 a5 10 80    	mov    0x8010a5c8,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105e96:	55                   	push   %ebp
80105e97:	89 e5                	mov    %esp,%ebp
  int i;

  if(!uart)
80105e99:	85 d2                	test   %edx,%edx
    uartputc(*p);
}

void
uartputc(int c)
{
80105e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  int i;

  if(!uart)
80105e9e:	74 10                	je     80105eb0 <uartputc+0x20>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
    microdelay(10);
  outb(COM1+0, c);
}
80105ea0:	5d                   	pop    %ebp
80105ea1:	e9 da fe ff ff       	jmp    80105d80 <uartputc.part.0>
80105ea6:	8d 76 00             	lea    0x0(%esi),%esi
80105ea9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80105eb0:	5d                   	pop    %ebp
80105eb1:	c3                   	ret    
80105eb2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105ec0 <uartintr>:
  return inb(COM1+0);
}

void
uartintr(void)
{
80105ec0:	55                   	push   %ebp
80105ec1:	89 e5                	mov    %esp,%ebp
80105ec3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105ec6:	68 50 5d 10 80       	push   $0x80105d50
80105ecb:	e8 20 a9 ff ff       	call   801007f0 <consoleintr>
}
80105ed0:	83 c4 10             	add    $0x10,%esp
80105ed3:	c9                   	leave  
80105ed4:	c3                   	ret    

80105ed5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105ed5:	6a 00                	push   $0x0
  pushl $0
80105ed7:	6a 00                	push   $0x0
  jmp alltraps
80105ed9:	e9 20 fb ff ff       	jmp    801059fe <alltraps>

80105ede <vector1>:
.globl vector1
vector1:
  pushl $0
80105ede:	6a 00                	push   $0x0
  pushl $1
80105ee0:	6a 01                	push   $0x1
  jmp alltraps
80105ee2:	e9 17 fb ff ff       	jmp    801059fe <alltraps>

80105ee7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105ee7:	6a 00                	push   $0x0
  pushl $2
80105ee9:	6a 02                	push   $0x2
  jmp alltraps
80105eeb:	e9 0e fb ff ff       	jmp    801059fe <alltraps>

80105ef0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105ef0:	6a 00                	push   $0x0
  pushl $3
80105ef2:	6a 03                	push   $0x3
  jmp alltraps
80105ef4:	e9 05 fb ff ff       	jmp    801059fe <alltraps>

80105ef9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105ef9:	6a 00                	push   $0x0
  pushl $4
80105efb:	6a 04                	push   $0x4
  jmp alltraps
80105efd:	e9 fc fa ff ff       	jmp    801059fe <alltraps>

80105f02 <vector5>:
.globl vector5
vector5:
  pushl $0
80105f02:	6a 00                	push   $0x0
  pushl $5
80105f04:	6a 05                	push   $0x5
  jmp alltraps
80105f06:	e9 f3 fa ff ff       	jmp    801059fe <alltraps>

80105f0b <vector6>:
.globl vector6
vector6:
  pushl $0
80105f0b:	6a 00                	push   $0x0
  pushl $6
80105f0d:	6a 06                	push   $0x6
  jmp alltraps
80105f0f:	e9 ea fa ff ff       	jmp    801059fe <alltraps>

80105f14 <vector7>:
.globl vector7
vector7:
  pushl $0
80105f14:	6a 00                	push   $0x0
  pushl $7
80105f16:	6a 07                	push   $0x7
  jmp alltraps
80105f18:	e9 e1 fa ff ff       	jmp    801059fe <alltraps>

80105f1d <vector8>:
.globl vector8
vector8:
  pushl $8
80105f1d:	6a 08                	push   $0x8
  jmp alltraps
80105f1f:	e9 da fa ff ff       	jmp    801059fe <alltraps>

80105f24 <vector9>:
.globl vector9
vector9:
  pushl $0
80105f24:	6a 00                	push   $0x0
  pushl $9
80105f26:	6a 09                	push   $0x9
  jmp alltraps
80105f28:	e9 d1 fa ff ff       	jmp    801059fe <alltraps>

80105f2d <vector10>:
.globl vector10
vector10:
  pushl $10
80105f2d:	6a 0a                	push   $0xa
  jmp alltraps
80105f2f:	e9 ca fa ff ff       	jmp    801059fe <alltraps>

80105f34 <vector11>:
.globl vector11
vector11:
  pushl $11
80105f34:	6a 0b                	push   $0xb
  jmp alltraps
80105f36:	e9 c3 fa ff ff       	jmp    801059fe <alltraps>

80105f3b <vector12>:
.globl vector12
vector12:
  pushl $12
80105f3b:	6a 0c                	push   $0xc
  jmp alltraps
80105f3d:	e9 bc fa ff ff       	jmp    801059fe <alltraps>

80105f42 <vector13>:
.globl vector13
vector13:
  pushl $13
80105f42:	6a 0d                	push   $0xd
  jmp alltraps
80105f44:	e9 b5 fa ff ff       	jmp    801059fe <alltraps>

80105f49 <vector14>:
.globl vector14
vector14:
  pushl $14
80105f49:	6a 0e                	push   $0xe
  jmp alltraps
80105f4b:	e9 ae fa ff ff       	jmp    801059fe <alltraps>

80105f50 <vector15>:
.globl vector15
vector15:
  pushl $0
80105f50:	6a 00                	push   $0x0
  pushl $15
80105f52:	6a 0f                	push   $0xf
  jmp alltraps
80105f54:	e9 a5 fa ff ff       	jmp    801059fe <alltraps>

80105f59 <vector16>:
.globl vector16
vector16:
  pushl $0
80105f59:	6a 00                	push   $0x0
  pushl $16
80105f5b:	6a 10                	push   $0x10
  jmp alltraps
80105f5d:	e9 9c fa ff ff       	jmp    801059fe <alltraps>

80105f62 <vector17>:
.globl vector17
vector17:
  pushl $17
80105f62:	6a 11                	push   $0x11
  jmp alltraps
80105f64:	e9 95 fa ff ff       	jmp    801059fe <alltraps>

80105f69 <vector18>:
.globl vector18
vector18:
  pushl $0
80105f69:	6a 00                	push   $0x0
  pushl $18
80105f6b:	6a 12                	push   $0x12
  jmp alltraps
80105f6d:	e9 8c fa ff ff       	jmp    801059fe <alltraps>

80105f72 <vector19>:
.globl vector19
vector19:
  pushl $0
80105f72:	6a 00                	push   $0x0
  pushl $19
80105f74:	6a 13                	push   $0x13
  jmp alltraps
80105f76:	e9 83 fa ff ff       	jmp    801059fe <alltraps>

80105f7b <vector20>:
.globl vector20
vector20:
  pushl $0
80105f7b:	6a 00                	push   $0x0
  pushl $20
80105f7d:	6a 14                	push   $0x14
  jmp alltraps
80105f7f:	e9 7a fa ff ff       	jmp    801059fe <alltraps>

80105f84 <vector21>:
.globl vector21
vector21:
  pushl $0
80105f84:	6a 00                	push   $0x0
  pushl $21
80105f86:	6a 15                	push   $0x15
  jmp alltraps
80105f88:	e9 71 fa ff ff       	jmp    801059fe <alltraps>

80105f8d <vector22>:
.globl vector22
vector22:
  pushl $0
80105f8d:	6a 00                	push   $0x0
  pushl $22
80105f8f:	6a 16                	push   $0x16
  jmp alltraps
80105f91:	e9 68 fa ff ff       	jmp    801059fe <alltraps>

80105f96 <vector23>:
.globl vector23
vector23:
  pushl $0
80105f96:	6a 00                	push   $0x0
  pushl $23
80105f98:	6a 17                	push   $0x17
  jmp alltraps
80105f9a:	e9 5f fa ff ff       	jmp    801059fe <alltraps>

80105f9f <vector24>:
.globl vector24
vector24:
  pushl $0
80105f9f:	6a 00                	push   $0x0
  pushl $24
80105fa1:	6a 18                	push   $0x18
  jmp alltraps
80105fa3:	e9 56 fa ff ff       	jmp    801059fe <alltraps>

80105fa8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105fa8:	6a 00                	push   $0x0
  pushl $25
80105faa:	6a 19                	push   $0x19
  jmp alltraps
80105fac:	e9 4d fa ff ff       	jmp    801059fe <alltraps>

80105fb1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105fb1:	6a 00                	push   $0x0
  pushl $26
80105fb3:	6a 1a                	push   $0x1a
  jmp alltraps
80105fb5:	e9 44 fa ff ff       	jmp    801059fe <alltraps>

80105fba <vector27>:
.globl vector27
vector27:
  pushl $0
80105fba:	6a 00                	push   $0x0
  pushl $27
80105fbc:	6a 1b                	push   $0x1b
  jmp alltraps
80105fbe:	e9 3b fa ff ff       	jmp    801059fe <alltraps>

80105fc3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105fc3:	6a 00                	push   $0x0
  pushl $28
80105fc5:	6a 1c                	push   $0x1c
  jmp alltraps
80105fc7:	e9 32 fa ff ff       	jmp    801059fe <alltraps>

80105fcc <vector29>:
.globl vector29
vector29:
  pushl $0
80105fcc:	6a 00                	push   $0x0
  pushl $29
80105fce:	6a 1d                	push   $0x1d
  jmp alltraps
80105fd0:	e9 29 fa ff ff       	jmp    801059fe <alltraps>

80105fd5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105fd5:	6a 00                	push   $0x0
  pushl $30
80105fd7:	6a 1e                	push   $0x1e
  jmp alltraps
80105fd9:	e9 20 fa ff ff       	jmp    801059fe <alltraps>

80105fde <vector31>:
.globl vector31
vector31:
  pushl $0
80105fde:	6a 00                	push   $0x0
  pushl $31
80105fe0:	6a 1f                	push   $0x1f
  jmp alltraps
80105fe2:	e9 17 fa ff ff       	jmp    801059fe <alltraps>

80105fe7 <vector32>:
.globl vector32
vector32:
  pushl $0
80105fe7:	6a 00                	push   $0x0
  pushl $32
80105fe9:	6a 20                	push   $0x20
  jmp alltraps
80105feb:	e9 0e fa ff ff       	jmp    801059fe <alltraps>

80105ff0 <vector33>:
.globl vector33
vector33:
  pushl $0
80105ff0:	6a 00                	push   $0x0
  pushl $33
80105ff2:	6a 21                	push   $0x21
  jmp alltraps
80105ff4:	e9 05 fa ff ff       	jmp    801059fe <alltraps>

80105ff9 <vector34>:
.globl vector34
vector34:
  pushl $0
80105ff9:	6a 00                	push   $0x0
  pushl $34
80105ffb:	6a 22                	push   $0x22
  jmp alltraps
80105ffd:	e9 fc f9 ff ff       	jmp    801059fe <alltraps>

80106002 <vector35>:
.globl vector35
vector35:
  pushl $0
80106002:	6a 00                	push   $0x0
  pushl $35
80106004:	6a 23                	push   $0x23
  jmp alltraps
80106006:	e9 f3 f9 ff ff       	jmp    801059fe <alltraps>

8010600b <vector36>:
.globl vector36
vector36:
  pushl $0
8010600b:	6a 00                	push   $0x0
  pushl $36
8010600d:	6a 24                	push   $0x24
  jmp alltraps
8010600f:	e9 ea f9 ff ff       	jmp    801059fe <alltraps>

80106014 <vector37>:
.globl vector37
vector37:
  pushl $0
80106014:	6a 00                	push   $0x0
  pushl $37
80106016:	6a 25                	push   $0x25
  jmp alltraps
80106018:	e9 e1 f9 ff ff       	jmp    801059fe <alltraps>

8010601d <vector38>:
.globl vector38
vector38:
  pushl $0
8010601d:	6a 00                	push   $0x0
  pushl $38
8010601f:	6a 26                	push   $0x26
  jmp alltraps
80106021:	e9 d8 f9 ff ff       	jmp    801059fe <alltraps>

80106026 <vector39>:
.globl vector39
vector39:
  pushl $0
80106026:	6a 00                	push   $0x0
  pushl $39
80106028:	6a 27                	push   $0x27
  jmp alltraps
8010602a:	e9 cf f9 ff ff       	jmp    801059fe <alltraps>

8010602f <vector40>:
.globl vector40
vector40:
  pushl $0
8010602f:	6a 00                	push   $0x0
  pushl $40
80106031:	6a 28                	push   $0x28
  jmp alltraps
80106033:	e9 c6 f9 ff ff       	jmp    801059fe <alltraps>

80106038 <vector41>:
.globl vector41
vector41:
  pushl $0
80106038:	6a 00                	push   $0x0
  pushl $41
8010603a:	6a 29                	push   $0x29
  jmp alltraps
8010603c:	e9 bd f9 ff ff       	jmp    801059fe <alltraps>

80106041 <vector42>:
.globl vector42
vector42:
  pushl $0
80106041:	6a 00                	push   $0x0
  pushl $42
80106043:	6a 2a                	push   $0x2a
  jmp alltraps
80106045:	e9 b4 f9 ff ff       	jmp    801059fe <alltraps>

8010604a <vector43>:
.globl vector43
vector43:
  pushl $0
8010604a:	6a 00                	push   $0x0
  pushl $43
8010604c:	6a 2b                	push   $0x2b
  jmp alltraps
8010604e:	e9 ab f9 ff ff       	jmp    801059fe <alltraps>

80106053 <vector44>:
.globl vector44
vector44:
  pushl $0
80106053:	6a 00                	push   $0x0
  pushl $44
80106055:	6a 2c                	push   $0x2c
  jmp alltraps
80106057:	e9 a2 f9 ff ff       	jmp    801059fe <alltraps>

8010605c <vector45>:
.globl vector45
vector45:
  pushl $0
8010605c:	6a 00                	push   $0x0
  pushl $45
8010605e:	6a 2d                	push   $0x2d
  jmp alltraps
80106060:	e9 99 f9 ff ff       	jmp    801059fe <alltraps>

80106065 <vector46>:
.globl vector46
vector46:
  pushl $0
80106065:	6a 00                	push   $0x0
  pushl $46
80106067:	6a 2e                	push   $0x2e
  jmp alltraps
80106069:	e9 90 f9 ff ff       	jmp    801059fe <alltraps>

8010606e <vector47>:
.globl vector47
vector47:
  pushl $0
8010606e:	6a 00                	push   $0x0
  pushl $47
80106070:	6a 2f                	push   $0x2f
  jmp alltraps
80106072:	e9 87 f9 ff ff       	jmp    801059fe <alltraps>

80106077 <vector48>:
.globl vector48
vector48:
  pushl $0
80106077:	6a 00                	push   $0x0
  pushl $48
80106079:	6a 30                	push   $0x30
  jmp alltraps
8010607b:	e9 7e f9 ff ff       	jmp    801059fe <alltraps>

80106080 <vector49>:
.globl vector49
vector49:
  pushl $0
80106080:	6a 00                	push   $0x0
  pushl $49
80106082:	6a 31                	push   $0x31
  jmp alltraps
80106084:	e9 75 f9 ff ff       	jmp    801059fe <alltraps>

80106089 <vector50>:
.globl vector50
vector50:
  pushl $0
80106089:	6a 00                	push   $0x0
  pushl $50
8010608b:	6a 32                	push   $0x32
  jmp alltraps
8010608d:	e9 6c f9 ff ff       	jmp    801059fe <alltraps>

80106092 <vector51>:
.globl vector51
vector51:
  pushl $0
80106092:	6a 00                	push   $0x0
  pushl $51
80106094:	6a 33                	push   $0x33
  jmp alltraps
80106096:	e9 63 f9 ff ff       	jmp    801059fe <alltraps>

8010609b <vector52>:
.globl vector52
vector52:
  pushl $0
8010609b:	6a 00                	push   $0x0
  pushl $52
8010609d:	6a 34                	push   $0x34
  jmp alltraps
8010609f:	e9 5a f9 ff ff       	jmp    801059fe <alltraps>

801060a4 <vector53>:
.globl vector53
vector53:
  pushl $0
801060a4:	6a 00                	push   $0x0
  pushl $53
801060a6:	6a 35                	push   $0x35
  jmp alltraps
801060a8:	e9 51 f9 ff ff       	jmp    801059fe <alltraps>

801060ad <vector54>:
.globl vector54
vector54:
  pushl $0
801060ad:	6a 00                	push   $0x0
  pushl $54
801060af:	6a 36                	push   $0x36
  jmp alltraps
801060b1:	e9 48 f9 ff ff       	jmp    801059fe <alltraps>

801060b6 <vector55>:
.globl vector55
vector55:
  pushl $0
801060b6:	6a 00                	push   $0x0
  pushl $55
801060b8:	6a 37                	push   $0x37
  jmp alltraps
801060ba:	e9 3f f9 ff ff       	jmp    801059fe <alltraps>

801060bf <vector56>:
.globl vector56
vector56:
  pushl $0
801060bf:	6a 00                	push   $0x0
  pushl $56
801060c1:	6a 38                	push   $0x38
  jmp alltraps
801060c3:	e9 36 f9 ff ff       	jmp    801059fe <alltraps>

801060c8 <vector57>:
.globl vector57
vector57:
  pushl $0
801060c8:	6a 00                	push   $0x0
  pushl $57
801060ca:	6a 39                	push   $0x39
  jmp alltraps
801060cc:	e9 2d f9 ff ff       	jmp    801059fe <alltraps>

801060d1 <vector58>:
.globl vector58
vector58:
  pushl $0
801060d1:	6a 00                	push   $0x0
  pushl $58
801060d3:	6a 3a                	push   $0x3a
  jmp alltraps
801060d5:	e9 24 f9 ff ff       	jmp    801059fe <alltraps>

801060da <vector59>:
.globl vector59
vector59:
  pushl $0
801060da:	6a 00                	push   $0x0
  pushl $59
801060dc:	6a 3b                	push   $0x3b
  jmp alltraps
801060de:	e9 1b f9 ff ff       	jmp    801059fe <alltraps>

801060e3 <vector60>:
.globl vector60
vector60:
  pushl $0
801060e3:	6a 00                	push   $0x0
  pushl $60
801060e5:	6a 3c                	push   $0x3c
  jmp alltraps
801060e7:	e9 12 f9 ff ff       	jmp    801059fe <alltraps>

801060ec <vector61>:
.globl vector61
vector61:
  pushl $0
801060ec:	6a 00                	push   $0x0
  pushl $61
801060ee:	6a 3d                	push   $0x3d
  jmp alltraps
801060f0:	e9 09 f9 ff ff       	jmp    801059fe <alltraps>

801060f5 <vector62>:
.globl vector62
vector62:
  pushl $0
801060f5:	6a 00                	push   $0x0
  pushl $62
801060f7:	6a 3e                	push   $0x3e
  jmp alltraps
801060f9:	e9 00 f9 ff ff       	jmp    801059fe <alltraps>

801060fe <vector63>:
.globl vector63
vector63:
  pushl $0
801060fe:	6a 00                	push   $0x0
  pushl $63
80106100:	6a 3f                	push   $0x3f
  jmp alltraps
80106102:	e9 f7 f8 ff ff       	jmp    801059fe <alltraps>

80106107 <vector64>:
.globl vector64
vector64:
  pushl $0
80106107:	6a 00                	push   $0x0
  pushl $64
80106109:	6a 40                	push   $0x40
  jmp alltraps
8010610b:	e9 ee f8 ff ff       	jmp    801059fe <alltraps>

80106110 <vector65>:
.globl vector65
vector65:
  pushl $0
80106110:	6a 00                	push   $0x0
  pushl $65
80106112:	6a 41                	push   $0x41
  jmp alltraps
80106114:	e9 e5 f8 ff ff       	jmp    801059fe <alltraps>

80106119 <vector66>:
.globl vector66
vector66:
  pushl $0
80106119:	6a 00                	push   $0x0
  pushl $66
8010611b:	6a 42                	push   $0x42
  jmp alltraps
8010611d:	e9 dc f8 ff ff       	jmp    801059fe <alltraps>

80106122 <vector67>:
.globl vector67
vector67:
  pushl $0
80106122:	6a 00                	push   $0x0
  pushl $67
80106124:	6a 43                	push   $0x43
  jmp alltraps
80106126:	e9 d3 f8 ff ff       	jmp    801059fe <alltraps>

8010612b <vector68>:
.globl vector68
vector68:
  pushl $0
8010612b:	6a 00                	push   $0x0
  pushl $68
8010612d:	6a 44                	push   $0x44
  jmp alltraps
8010612f:	e9 ca f8 ff ff       	jmp    801059fe <alltraps>

80106134 <vector69>:
.globl vector69
vector69:
  pushl $0
80106134:	6a 00                	push   $0x0
  pushl $69
80106136:	6a 45                	push   $0x45
  jmp alltraps
80106138:	e9 c1 f8 ff ff       	jmp    801059fe <alltraps>

8010613d <vector70>:
.globl vector70
vector70:
  pushl $0
8010613d:	6a 00                	push   $0x0
  pushl $70
8010613f:	6a 46                	push   $0x46
  jmp alltraps
80106141:	e9 b8 f8 ff ff       	jmp    801059fe <alltraps>

80106146 <vector71>:
.globl vector71
vector71:
  pushl $0
80106146:	6a 00                	push   $0x0
  pushl $71
80106148:	6a 47                	push   $0x47
  jmp alltraps
8010614a:	e9 af f8 ff ff       	jmp    801059fe <alltraps>

8010614f <vector72>:
.globl vector72
vector72:
  pushl $0
8010614f:	6a 00                	push   $0x0
  pushl $72
80106151:	6a 48                	push   $0x48
  jmp alltraps
80106153:	e9 a6 f8 ff ff       	jmp    801059fe <alltraps>

80106158 <vector73>:
.globl vector73
vector73:
  pushl $0
80106158:	6a 00                	push   $0x0
  pushl $73
8010615a:	6a 49                	push   $0x49
  jmp alltraps
8010615c:	e9 9d f8 ff ff       	jmp    801059fe <alltraps>

80106161 <vector74>:
.globl vector74
vector74:
  pushl $0
80106161:	6a 00                	push   $0x0
  pushl $74
80106163:	6a 4a                	push   $0x4a
  jmp alltraps
80106165:	e9 94 f8 ff ff       	jmp    801059fe <alltraps>

8010616a <vector75>:
.globl vector75
vector75:
  pushl $0
8010616a:	6a 00                	push   $0x0
  pushl $75
8010616c:	6a 4b                	push   $0x4b
  jmp alltraps
8010616e:	e9 8b f8 ff ff       	jmp    801059fe <alltraps>

80106173 <vector76>:
.globl vector76
vector76:
  pushl $0
80106173:	6a 00                	push   $0x0
  pushl $76
80106175:	6a 4c                	push   $0x4c
  jmp alltraps
80106177:	e9 82 f8 ff ff       	jmp    801059fe <alltraps>

8010617c <vector77>:
.globl vector77
vector77:
  pushl $0
8010617c:	6a 00                	push   $0x0
  pushl $77
8010617e:	6a 4d                	push   $0x4d
  jmp alltraps
80106180:	e9 79 f8 ff ff       	jmp    801059fe <alltraps>

80106185 <vector78>:
.globl vector78
vector78:
  pushl $0
80106185:	6a 00                	push   $0x0
  pushl $78
80106187:	6a 4e                	push   $0x4e
  jmp alltraps
80106189:	e9 70 f8 ff ff       	jmp    801059fe <alltraps>

8010618e <vector79>:
.globl vector79
vector79:
  pushl $0
8010618e:	6a 00                	push   $0x0
  pushl $79
80106190:	6a 4f                	push   $0x4f
  jmp alltraps
80106192:	e9 67 f8 ff ff       	jmp    801059fe <alltraps>

80106197 <vector80>:
.globl vector80
vector80:
  pushl $0
80106197:	6a 00                	push   $0x0
  pushl $80
80106199:	6a 50                	push   $0x50
  jmp alltraps
8010619b:	e9 5e f8 ff ff       	jmp    801059fe <alltraps>

801061a0 <vector81>:
.globl vector81
vector81:
  pushl $0
801061a0:	6a 00                	push   $0x0
  pushl $81
801061a2:	6a 51                	push   $0x51
  jmp alltraps
801061a4:	e9 55 f8 ff ff       	jmp    801059fe <alltraps>

801061a9 <vector82>:
.globl vector82
vector82:
  pushl $0
801061a9:	6a 00                	push   $0x0
  pushl $82
801061ab:	6a 52                	push   $0x52
  jmp alltraps
801061ad:	e9 4c f8 ff ff       	jmp    801059fe <alltraps>

801061b2 <vector83>:
.globl vector83
vector83:
  pushl $0
801061b2:	6a 00                	push   $0x0
  pushl $83
801061b4:	6a 53                	push   $0x53
  jmp alltraps
801061b6:	e9 43 f8 ff ff       	jmp    801059fe <alltraps>

801061bb <vector84>:
.globl vector84
vector84:
  pushl $0
801061bb:	6a 00                	push   $0x0
  pushl $84
801061bd:	6a 54                	push   $0x54
  jmp alltraps
801061bf:	e9 3a f8 ff ff       	jmp    801059fe <alltraps>

801061c4 <vector85>:
.globl vector85
vector85:
  pushl $0
801061c4:	6a 00                	push   $0x0
  pushl $85
801061c6:	6a 55                	push   $0x55
  jmp alltraps
801061c8:	e9 31 f8 ff ff       	jmp    801059fe <alltraps>

801061cd <vector86>:
.globl vector86
vector86:
  pushl $0
801061cd:	6a 00                	push   $0x0
  pushl $86
801061cf:	6a 56                	push   $0x56
  jmp alltraps
801061d1:	e9 28 f8 ff ff       	jmp    801059fe <alltraps>

801061d6 <vector87>:
.globl vector87
vector87:
  pushl $0
801061d6:	6a 00                	push   $0x0
  pushl $87
801061d8:	6a 57                	push   $0x57
  jmp alltraps
801061da:	e9 1f f8 ff ff       	jmp    801059fe <alltraps>

801061df <vector88>:
.globl vector88
vector88:
  pushl $0
801061df:	6a 00                	push   $0x0
  pushl $88
801061e1:	6a 58                	push   $0x58
  jmp alltraps
801061e3:	e9 16 f8 ff ff       	jmp    801059fe <alltraps>

801061e8 <vector89>:
.globl vector89
vector89:
  pushl $0
801061e8:	6a 00                	push   $0x0
  pushl $89
801061ea:	6a 59                	push   $0x59
  jmp alltraps
801061ec:	e9 0d f8 ff ff       	jmp    801059fe <alltraps>

801061f1 <vector90>:
.globl vector90
vector90:
  pushl $0
801061f1:	6a 00                	push   $0x0
  pushl $90
801061f3:	6a 5a                	push   $0x5a
  jmp alltraps
801061f5:	e9 04 f8 ff ff       	jmp    801059fe <alltraps>

801061fa <vector91>:
.globl vector91
vector91:
  pushl $0
801061fa:	6a 00                	push   $0x0
  pushl $91
801061fc:	6a 5b                	push   $0x5b
  jmp alltraps
801061fe:	e9 fb f7 ff ff       	jmp    801059fe <alltraps>

80106203 <vector92>:
.globl vector92
vector92:
  pushl $0
80106203:	6a 00                	push   $0x0
  pushl $92
80106205:	6a 5c                	push   $0x5c
  jmp alltraps
80106207:	e9 f2 f7 ff ff       	jmp    801059fe <alltraps>

8010620c <vector93>:
.globl vector93
vector93:
  pushl $0
8010620c:	6a 00                	push   $0x0
  pushl $93
8010620e:	6a 5d                	push   $0x5d
  jmp alltraps
80106210:	e9 e9 f7 ff ff       	jmp    801059fe <alltraps>

80106215 <vector94>:
.globl vector94
vector94:
  pushl $0
80106215:	6a 00                	push   $0x0
  pushl $94
80106217:	6a 5e                	push   $0x5e
  jmp alltraps
80106219:	e9 e0 f7 ff ff       	jmp    801059fe <alltraps>

8010621e <vector95>:
.globl vector95
vector95:
  pushl $0
8010621e:	6a 00                	push   $0x0
  pushl $95
80106220:	6a 5f                	push   $0x5f
  jmp alltraps
80106222:	e9 d7 f7 ff ff       	jmp    801059fe <alltraps>

80106227 <vector96>:
.globl vector96
vector96:
  pushl $0
80106227:	6a 00                	push   $0x0
  pushl $96
80106229:	6a 60                	push   $0x60
  jmp alltraps
8010622b:	e9 ce f7 ff ff       	jmp    801059fe <alltraps>

80106230 <vector97>:
.globl vector97
vector97:
  pushl $0
80106230:	6a 00                	push   $0x0
  pushl $97
80106232:	6a 61                	push   $0x61
  jmp alltraps
80106234:	e9 c5 f7 ff ff       	jmp    801059fe <alltraps>

80106239 <vector98>:
.globl vector98
vector98:
  pushl $0
80106239:	6a 00                	push   $0x0
  pushl $98
8010623b:	6a 62                	push   $0x62
  jmp alltraps
8010623d:	e9 bc f7 ff ff       	jmp    801059fe <alltraps>

80106242 <vector99>:
.globl vector99
vector99:
  pushl $0
80106242:	6a 00                	push   $0x0
  pushl $99
80106244:	6a 63                	push   $0x63
  jmp alltraps
80106246:	e9 b3 f7 ff ff       	jmp    801059fe <alltraps>

8010624b <vector100>:
.globl vector100
vector100:
  pushl $0
8010624b:	6a 00                	push   $0x0
  pushl $100
8010624d:	6a 64                	push   $0x64
  jmp alltraps
8010624f:	e9 aa f7 ff ff       	jmp    801059fe <alltraps>

80106254 <vector101>:
.globl vector101
vector101:
  pushl $0
80106254:	6a 00                	push   $0x0
  pushl $101
80106256:	6a 65                	push   $0x65
  jmp alltraps
80106258:	e9 a1 f7 ff ff       	jmp    801059fe <alltraps>

8010625d <vector102>:
.globl vector102
vector102:
  pushl $0
8010625d:	6a 00                	push   $0x0
  pushl $102
8010625f:	6a 66                	push   $0x66
  jmp alltraps
80106261:	e9 98 f7 ff ff       	jmp    801059fe <alltraps>

80106266 <vector103>:
.globl vector103
vector103:
  pushl $0
80106266:	6a 00                	push   $0x0
  pushl $103
80106268:	6a 67                	push   $0x67
  jmp alltraps
8010626a:	e9 8f f7 ff ff       	jmp    801059fe <alltraps>

8010626f <vector104>:
.globl vector104
vector104:
  pushl $0
8010626f:	6a 00                	push   $0x0
  pushl $104
80106271:	6a 68                	push   $0x68
  jmp alltraps
80106273:	e9 86 f7 ff ff       	jmp    801059fe <alltraps>

80106278 <vector105>:
.globl vector105
vector105:
  pushl $0
80106278:	6a 00                	push   $0x0
  pushl $105
8010627a:	6a 69                	push   $0x69
  jmp alltraps
8010627c:	e9 7d f7 ff ff       	jmp    801059fe <alltraps>

80106281 <vector106>:
.globl vector106
vector106:
  pushl $0
80106281:	6a 00                	push   $0x0
  pushl $106
80106283:	6a 6a                	push   $0x6a
  jmp alltraps
80106285:	e9 74 f7 ff ff       	jmp    801059fe <alltraps>

8010628a <vector107>:
.globl vector107
vector107:
  pushl $0
8010628a:	6a 00                	push   $0x0
  pushl $107
8010628c:	6a 6b                	push   $0x6b
  jmp alltraps
8010628e:	e9 6b f7 ff ff       	jmp    801059fe <alltraps>

80106293 <vector108>:
.globl vector108
vector108:
  pushl $0
80106293:	6a 00                	push   $0x0
  pushl $108
80106295:	6a 6c                	push   $0x6c
  jmp alltraps
80106297:	e9 62 f7 ff ff       	jmp    801059fe <alltraps>

8010629c <vector109>:
.globl vector109
vector109:
  pushl $0
8010629c:	6a 00                	push   $0x0
  pushl $109
8010629e:	6a 6d                	push   $0x6d
  jmp alltraps
801062a0:	e9 59 f7 ff ff       	jmp    801059fe <alltraps>

801062a5 <vector110>:
.globl vector110
vector110:
  pushl $0
801062a5:	6a 00                	push   $0x0
  pushl $110
801062a7:	6a 6e                	push   $0x6e
  jmp alltraps
801062a9:	e9 50 f7 ff ff       	jmp    801059fe <alltraps>

801062ae <vector111>:
.globl vector111
vector111:
  pushl $0
801062ae:	6a 00                	push   $0x0
  pushl $111
801062b0:	6a 6f                	push   $0x6f
  jmp alltraps
801062b2:	e9 47 f7 ff ff       	jmp    801059fe <alltraps>

801062b7 <vector112>:
.globl vector112
vector112:
  pushl $0
801062b7:	6a 00                	push   $0x0
  pushl $112
801062b9:	6a 70                	push   $0x70
  jmp alltraps
801062bb:	e9 3e f7 ff ff       	jmp    801059fe <alltraps>

801062c0 <vector113>:
.globl vector113
vector113:
  pushl $0
801062c0:	6a 00                	push   $0x0
  pushl $113
801062c2:	6a 71                	push   $0x71
  jmp alltraps
801062c4:	e9 35 f7 ff ff       	jmp    801059fe <alltraps>

801062c9 <vector114>:
.globl vector114
vector114:
  pushl $0
801062c9:	6a 00                	push   $0x0
  pushl $114
801062cb:	6a 72                	push   $0x72
  jmp alltraps
801062cd:	e9 2c f7 ff ff       	jmp    801059fe <alltraps>

801062d2 <vector115>:
.globl vector115
vector115:
  pushl $0
801062d2:	6a 00                	push   $0x0
  pushl $115
801062d4:	6a 73                	push   $0x73
  jmp alltraps
801062d6:	e9 23 f7 ff ff       	jmp    801059fe <alltraps>

801062db <vector116>:
.globl vector116
vector116:
  pushl $0
801062db:	6a 00                	push   $0x0
  pushl $116
801062dd:	6a 74                	push   $0x74
  jmp alltraps
801062df:	e9 1a f7 ff ff       	jmp    801059fe <alltraps>

801062e4 <vector117>:
.globl vector117
vector117:
  pushl $0
801062e4:	6a 00                	push   $0x0
  pushl $117
801062e6:	6a 75                	push   $0x75
  jmp alltraps
801062e8:	e9 11 f7 ff ff       	jmp    801059fe <alltraps>

801062ed <vector118>:
.globl vector118
vector118:
  pushl $0
801062ed:	6a 00                	push   $0x0
  pushl $118
801062ef:	6a 76                	push   $0x76
  jmp alltraps
801062f1:	e9 08 f7 ff ff       	jmp    801059fe <alltraps>

801062f6 <vector119>:
.globl vector119
vector119:
  pushl $0
801062f6:	6a 00                	push   $0x0
  pushl $119
801062f8:	6a 77                	push   $0x77
  jmp alltraps
801062fa:	e9 ff f6 ff ff       	jmp    801059fe <alltraps>

801062ff <vector120>:
.globl vector120
vector120:
  pushl $0
801062ff:	6a 00                	push   $0x0
  pushl $120
80106301:	6a 78                	push   $0x78
  jmp alltraps
80106303:	e9 f6 f6 ff ff       	jmp    801059fe <alltraps>

80106308 <vector121>:
.globl vector121
vector121:
  pushl $0
80106308:	6a 00                	push   $0x0
  pushl $121
8010630a:	6a 79                	push   $0x79
  jmp alltraps
8010630c:	e9 ed f6 ff ff       	jmp    801059fe <alltraps>

80106311 <vector122>:
.globl vector122
vector122:
  pushl $0
80106311:	6a 00                	push   $0x0
  pushl $122
80106313:	6a 7a                	push   $0x7a
  jmp alltraps
80106315:	e9 e4 f6 ff ff       	jmp    801059fe <alltraps>

8010631a <vector123>:
.globl vector123
vector123:
  pushl $0
8010631a:	6a 00                	push   $0x0
  pushl $123
8010631c:	6a 7b                	push   $0x7b
  jmp alltraps
8010631e:	e9 db f6 ff ff       	jmp    801059fe <alltraps>

80106323 <vector124>:
.globl vector124
vector124:
  pushl $0
80106323:	6a 00                	push   $0x0
  pushl $124
80106325:	6a 7c                	push   $0x7c
  jmp alltraps
80106327:	e9 d2 f6 ff ff       	jmp    801059fe <alltraps>

8010632c <vector125>:
.globl vector125
vector125:
  pushl $0
8010632c:	6a 00                	push   $0x0
  pushl $125
8010632e:	6a 7d                	push   $0x7d
  jmp alltraps
80106330:	e9 c9 f6 ff ff       	jmp    801059fe <alltraps>

80106335 <vector126>:
.globl vector126
vector126:
  pushl $0
80106335:	6a 00                	push   $0x0
  pushl $126
80106337:	6a 7e                	push   $0x7e
  jmp alltraps
80106339:	e9 c0 f6 ff ff       	jmp    801059fe <alltraps>

8010633e <vector127>:
.globl vector127
vector127:
  pushl $0
8010633e:	6a 00                	push   $0x0
  pushl $127
80106340:	6a 7f                	push   $0x7f
  jmp alltraps
80106342:	e9 b7 f6 ff ff       	jmp    801059fe <alltraps>

80106347 <vector128>:
.globl vector128
vector128:
  pushl $0
80106347:	6a 00                	push   $0x0
  pushl $128
80106349:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010634e:	e9 ab f6 ff ff       	jmp    801059fe <alltraps>

80106353 <vector129>:
.globl vector129
vector129:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $129
80106355:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010635a:	e9 9f f6 ff ff       	jmp    801059fe <alltraps>

8010635f <vector130>:
.globl vector130
vector130:
  pushl $0
8010635f:	6a 00                	push   $0x0
  pushl $130
80106361:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106366:	e9 93 f6 ff ff       	jmp    801059fe <alltraps>

8010636b <vector131>:
.globl vector131
vector131:
  pushl $0
8010636b:	6a 00                	push   $0x0
  pushl $131
8010636d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106372:	e9 87 f6 ff ff       	jmp    801059fe <alltraps>

80106377 <vector132>:
.globl vector132
vector132:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $132
80106379:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010637e:	e9 7b f6 ff ff       	jmp    801059fe <alltraps>

80106383 <vector133>:
.globl vector133
vector133:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $133
80106385:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010638a:	e9 6f f6 ff ff       	jmp    801059fe <alltraps>

8010638f <vector134>:
.globl vector134
vector134:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $134
80106391:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106396:	e9 63 f6 ff ff       	jmp    801059fe <alltraps>

8010639b <vector135>:
.globl vector135
vector135:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $135
8010639d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801063a2:	e9 57 f6 ff ff       	jmp    801059fe <alltraps>

801063a7 <vector136>:
.globl vector136
vector136:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $136
801063a9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801063ae:	e9 4b f6 ff ff       	jmp    801059fe <alltraps>

801063b3 <vector137>:
.globl vector137
vector137:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $137
801063b5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801063ba:	e9 3f f6 ff ff       	jmp    801059fe <alltraps>

801063bf <vector138>:
.globl vector138
vector138:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $138
801063c1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801063c6:	e9 33 f6 ff ff       	jmp    801059fe <alltraps>

801063cb <vector139>:
.globl vector139
vector139:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $139
801063cd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801063d2:	e9 27 f6 ff ff       	jmp    801059fe <alltraps>

801063d7 <vector140>:
.globl vector140
vector140:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $140
801063d9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801063de:	e9 1b f6 ff ff       	jmp    801059fe <alltraps>

801063e3 <vector141>:
.globl vector141
vector141:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $141
801063e5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801063ea:	e9 0f f6 ff ff       	jmp    801059fe <alltraps>

801063ef <vector142>:
.globl vector142
vector142:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $142
801063f1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801063f6:	e9 03 f6 ff ff       	jmp    801059fe <alltraps>

801063fb <vector143>:
.globl vector143
vector143:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $143
801063fd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106402:	e9 f7 f5 ff ff       	jmp    801059fe <alltraps>

80106407 <vector144>:
.globl vector144
vector144:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $144
80106409:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010640e:	e9 eb f5 ff ff       	jmp    801059fe <alltraps>

80106413 <vector145>:
.globl vector145
vector145:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $145
80106415:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010641a:	e9 df f5 ff ff       	jmp    801059fe <alltraps>

8010641f <vector146>:
.globl vector146
vector146:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $146
80106421:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106426:	e9 d3 f5 ff ff       	jmp    801059fe <alltraps>

8010642b <vector147>:
.globl vector147
vector147:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $147
8010642d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106432:	e9 c7 f5 ff ff       	jmp    801059fe <alltraps>

80106437 <vector148>:
.globl vector148
vector148:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $148
80106439:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010643e:	e9 bb f5 ff ff       	jmp    801059fe <alltraps>

80106443 <vector149>:
.globl vector149
vector149:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $149
80106445:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010644a:	e9 af f5 ff ff       	jmp    801059fe <alltraps>

8010644f <vector150>:
.globl vector150
vector150:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $150
80106451:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106456:	e9 a3 f5 ff ff       	jmp    801059fe <alltraps>

8010645b <vector151>:
.globl vector151
vector151:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $151
8010645d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106462:	e9 97 f5 ff ff       	jmp    801059fe <alltraps>

80106467 <vector152>:
.globl vector152
vector152:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $152
80106469:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010646e:	e9 8b f5 ff ff       	jmp    801059fe <alltraps>

80106473 <vector153>:
.globl vector153
vector153:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $153
80106475:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010647a:	e9 7f f5 ff ff       	jmp    801059fe <alltraps>

8010647f <vector154>:
.globl vector154
vector154:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $154
80106481:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106486:	e9 73 f5 ff ff       	jmp    801059fe <alltraps>

8010648b <vector155>:
.globl vector155
vector155:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $155
8010648d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106492:	e9 67 f5 ff ff       	jmp    801059fe <alltraps>

80106497 <vector156>:
.globl vector156
vector156:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $156
80106499:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010649e:	e9 5b f5 ff ff       	jmp    801059fe <alltraps>

801064a3 <vector157>:
.globl vector157
vector157:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $157
801064a5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801064aa:	e9 4f f5 ff ff       	jmp    801059fe <alltraps>

801064af <vector158>:
.globl vector158
vector158:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $158
801064b1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801064b6:	e9 43 f5 ff ff       	jmp    801059fe <alltraps>

801064bb <vector159>:
.globl vector159
vector159:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $159
801064bd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801064c2:	e9 37 f5 ff ff       	jmp    801059fe <alltraps>

801064c7 <vector160>:
.globl vector160
vector160:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $160
801064c9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801064ce:	e9 2b f5 ff ff       	jmp    801059fe <alltraps>

801064d3 <vector161>:
.globl vector161
vector161:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $161
801064d5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801064da:	e9 1f f5 ff ff       	jmp    801059fe <alltraps>

801064df <vector162>:
.globl vector162
vector162:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $162
801064e1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801064e6:	e9 13 f5 ff ff       	jmp    801059fe <alltraps>

801064eb <vector163>:
.globl vector163
vector163:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $163
801064ed:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801064f2:	e9 07 f5 ff ff       	jmp    801059fe <alltraps>

801064f7 <vector164>:
.globl vector164
vector164:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $164
801064f9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801064fe:	e9 fb f4 ff ff       	jmp    801059fe <alltraps>

80106503 <vector165>:
.globl vector165
vector165:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $165
80106505:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010650a:	e9 ef f4 ff ff       	jmp    801059fe <alltraps>

8010650f <vector166>:
.globl vector166
vector166:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $166
80106511:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106516:	e9 e3 f4 ff ff       	jmp    801059fe <alltraps>

8010651b <vector167>:
.globl vector167
vector167:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $167
8010651d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106522:	e9 d7 f4 ff ff       	jmp    801059fe <alltraps>

80106527 <vector168>:
.globl vector168
vector168:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $168
80106529:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010652e:	e9 cb f4 ff ff       	jmp    801059fe <alltraps>

80106533 <vector169>:
.globl vector169
vector169:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $169
80106535:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010653a:	e9 bf f4 ff ff       	jmp    801059fe <alltraps>

8010653f <vector170>:
.globl vector170
vector170:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $170
80106541:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106546:	e9 b3 f4 ff ff       	jmp    801059fe <alltraps>

8010654b <vector171>:
.globl vector171
vector171:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $171
8010654d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106552:	e9 a7 f4 ff ff       	jmp    801059fe <alltraps>

80106557 <vector172>:
.globl vector172
vector172:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $172
80106559:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010655e:	e9 9b f4 ff ff       	jmp    801059fe <alltraps>

80106563 <vector173>:
.globl vector173
vector173:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $173
80106565:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010656a:	e9 8f f4 ff ff       	jmp    801059fe <alltraps>

8010656f <vector174>:
.globl vector174
vector174:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $174
80106571:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106576:	e9 83 f4 ff ff       	jmp    801059fe <alltraps>

8010657b <vector175>:
.globl vector175
vector175:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $175
8010657d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106582:	e9 77 f4 ff ff       	jmp    801059fe <alltraps>

80106587 <vector176>:
.globl vector176
vector176:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $176
80106589:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010658e:	e9 6b f4 ff ff       	jmp    801059fe <alltraps>

80106593 <vector177>:
.globl vector177
vector177:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $177
80106595:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010659a:	e9 5f f4 ff ff       	jmp    801059fe <alltraps>

8010659f <vector178>:
.globl vector178
vector178:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $178
801065a1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801065a6:	e9 53 f4 ff ff       	jmp    801059fe <alltraps>

801065ab <vector179>:
.globl vector179
vector179:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $179
801065ad:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801065b2:	e9 47 f4 ff ff       	jmp    801059fe <alltraps>

801065b7 <vector180>:
.globl vector180
vector180:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $180
801065b9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801065be:	e9 3b f4 ff ff       	jmp    801059fe <alltraps>

801065c3 <vector181>:
.globl vector181
vector181:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $181
801065c5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801065ca:	e9 2f f4 ff ff       	jmp    801059fe <alltraps>

801065cf <vector182>:
.globl vector182
vector182:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $182
801065d1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801065d6:	e9 23 f4 ff ff       	jmp    801059fe <alltraps>

801065db <vector183>:
.globl vector183
vector183:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $183
801065dd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801065e2:	e9 17 f4 ff ff       	jmp    801059fe <alltraps>

801065e7 <vector184>:
.globl vector184
vector184:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $184
801065e9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801065ee:	e9 0b f4 ff ff       	jmp    801059fe <alltraps>

801065f3 <vector185>:
.globl vector185
vector185:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $185
801065f5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801065fa:	e9 ff f3 ff ff       	jmp    801059fe <alltraps>

801065ff <vector186>:
.globl vector186
vector186:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $186
80106601:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106606:	e9 f3 f3 ff ff       	jmp    801059fe <alltraps>

8010660b <vector187>:
.globl vector187
vector187:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $187
8010660d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106612:	e9 e7 f3 ff ff       	jmp    801059fe <alltraps>

80106617 <vector188>:
.globl vector188
vector188:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $188
80106619:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010661e:	e9 db f3 ff ff       	jmp    801059fe <alltraps>

80106623 <vector189>:
.globl vector189
vector189:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $189
80106625:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010662a:	e9 cf f3 ff ff       	jmp    801059fe <alltraps>

8010662f <vector190>:
.globl vector190
vector190:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $190
80106631:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106636:	e9 c3 f3 ff ff       	jmp    801059fe <alltraps>

8010663b <vector191>:
.globl vector191
vector191:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $191
8010663d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106642:	e9 b7 f3 ff ff       	jmp    801059fe <alltraps>

80106647 <vector192>:
.globl vector192
vector192:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $192
80106649:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010664e:	e9 ab f3 ff ff       	jmp    801059fe <alltraps>

80106653 <vector193>:
.globl vector193
vector193:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $193
80106655:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010665a:	e9 9f f3 ff ff       	jmp    801059fe <alltraps>

8010665f <vector194>:
.globl vector194
vector194:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $194
80106661:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106666:	e9 93 f3 ff ff       	jmp    801059fe <alltraps>

8010666b <vector195>:
.globl vector195
vector195:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $195
8010666d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106672:	e9 87 f3 ff ff       	jmp    801059fe <alltraps>

80106677 <vector196>:
.globl vector196
vector196:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $196
80106679:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010667e:	e9 7b f3 ff ff       	jmp    801059fe <alltraps>

80106683 <vector197>:
.globl vector197
vector197:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $197
80106685:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010668a:	e9 6f f3 ff ff       	jmp    801059fe <alltraps>

8010668f <vector198>:
.globl vector198
vector198:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $198
80106691:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106696:	e9 63 f3 ff ff       	jmp    801059fe <alltraps>

8010669b <vector199>:
.globl vector199
vector199:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $199
8010669d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801066a2:	e9 57 f3 ff ff       	jmp    801059fe <alltraps>

801066a7 <vector200>:
.globl vector200
vector200:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $200
801066a9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801066ae:	e9 4b f3 ff ff       	jmp    801059fe <alltraps>

801066b3 <vector201>:
.globl vector201
vector201:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $201
801066b5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801066ba:	e9 3f f3 ff ff       	jmp    801059fe <alltraps>

801066bf <vector202>:
.globl vector202
vector202:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $202
801066c1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801066c6:	e9 33 f3 ff ff       	jmp    801059fe <alltraps>

801066cb <vector203>:
.globl vector203
vector203:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $203
801066cd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801066d2:	e9 27 f3 ff ff       	jmp    801059fe <alltraps>

801066d7 <vector204>:
.globl vector204
vector204:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $204
801066d9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801066de:	e9 1b f3 ff ff       	jmp    801059fe <alltraps>

801066e3 <vector205>:
.globl vector205
vector205:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $205
801066e5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801066ea:	e9 0f f3 ff ff       	jmp    801059fe <alltraps>

801066ef <vector206>:
.globl vector206
vector206:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $206
801066f1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801066f6:	e9 03 f3 ff ff       	jmp    801059fe <alltraps>

801066fb <vector207>:
.globl vector207
vector207:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $207
801066fd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106702:	e9 f7 f2 ff ff       	jmp    801059fe <alltraps>

80106707 <vector208>:
.globl vector208
vector208:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $208
80106709:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010670e:	e9 eb f2 ff ff       	jmp    801059fe <alltraps>

80106713 <vector209>:
.globl vector209
vector209:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $209
80106715:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010671a:	e9 df f2 ff ff       	jmp    801059fe <alltraps>

8010671f <vector210>:
.globl vector210
vector210:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $210
80106721:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106726:	e9 d3 f2 ff ff       	jmp    801059fe <alltraps>

8010672b <vector211>:
.globl vector211
vector211:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $211
8010672d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106732:	e9 c7 f2 ff ff       	jmp    801059fe <alltraps>

80106737 <vector212>:
.globl vector212
vector212:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $212
80106739:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010673e:	e9 bb f2 ff ff       	jmp    801059fe <alltraps>

80106743 <vector213>:
.globl vector213
vector213:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $213
80106745:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010674a:	e9 af f2 ff ff       	jmp    801059fe <alltraps>

8010674f <vector214>:
.globl vector214
vector214:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $214
80106751:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106756:	e9 a3 f2 ff ff       	jmp    801059fe <alltraps>

8010675b <vector215>:
.globl vector215
vector215:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $215
8010675d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106762:	e9 97 f2 ff ff       	jmp    801059fe <alltraps>

80106767 <vector216>:
.globl vector216
vector216:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $216
80106769:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010676e:	e9 8b f2 ff ff       	jmp    801059fe <alltraps>

80106773 <vector217>:
.globl vector217
vector217:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $217
80106775:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010677a:	e9 7f f2 ff ff       	jmp    801059fe <alltraps>

8010677f <vector218>:
.globl vector218
vector218:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $218
80106781:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106786:	e9 73 f2 ff ff       	jmp    801059fe <alltraps>

8010678b <vector219>:
.globl vector219
vector219:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $219
8010678d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106792:	e9 67 f2 ff ff       	jmp    801059fe <alltraps>

80106797 <vector220>:
.globl vector220
vector220:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $220
80106799:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010679e:	e9 5b f2 ff ff       	jmp    801059fe <alltraps>

801067a3 <vector221>:
.globl vector221
vector221:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $221
801067a5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801067aa:	e9 4f f2 ff ff       	jmp    801059fe <alltraps>

801067af <vector222>:
.globl vector222
vector222:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $222
801067b1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801067b6:	e9 43 f2 ff ff       	jmp    801059fe <alltraps>

801067bb <vector223>:
.globl vector223
vector223:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $223
801067bd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801067c2:	e9 37 f2 ff ff       	jmp    801059fe <alltraps>

801067c7 <vector224>:
.globl vector224
vector224:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $224
801067c9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801067ce:	e9 2b f2 ff ff       	jmp    801059fe <alltraps>

801067d3 <vector225>:
.globl vector225
vector225:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $225
801067d5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801067da:	e9 1f f2 ff ff       	jmp    801059fe <alltraps>

801067df <vector226>:
.globl vector226
vector226:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $226
801067e1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801067e6:	e9 13 f2 ff ff       	jmp    801059fe <alltraps>

801067eb <vector227>:
.globl vector227
vector227:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $227
801067ed:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801067f2:	e9 07 f2 ff ff       	jmp    801059fe <alltraps>

801067f7 <vector228>:
.globl vector228
vector228:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $228
801067f9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801067fe:	e9 fb f1 ff ff       	jmp    801059fe <alltraps>

80106803 <vector229>:
.globl vector229
vector229:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $229
80106805:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010680a:	e9 ef f1 ff ff       	jmp    801059fe <alltraps>

8010680f <vector230>:
.globl vector230
vector230:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $230
80106811:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106816:	e9 e3 f1 ff ff       	jmp    801059fe <alltraps>

8010681b <vector231>:
.globl vector231
vector231:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $231
8010681d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106822:	e9 d7 f1 ff ff       	jmp    801059fe <alltraps>

80106827 <vector232>:
.globl vector232
vector232:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $232
80106829:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010682e:	e9 cb f1 ff ff       	jmp    801059fe <alltraps>

80106833 <vector233>:
.globl vector233
vector233:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $233
80106835:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010683a:	e9 bf f1 ff ff       	jmp    801059fe <alltraps>

8010683f <vector234>:
.globl vector234
vector234:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $234
80106841:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106846:	e9 b3 f1 ff ff       	jmp    801059fe <alltraps>

8010684b <vector235>:
.globl vector235
vector235:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $235
8010684d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106852:	e9 a7 f1 ff ff       	jmp    801059fe <alltraps>

80106857 <vector236>:
.globl vector236
vector236:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $236
80106859:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010685e:	e9 9b f1 ff ff       	jmp    801059fe <alltraps>

80106863 <vector237>:
.globl vector237
vector237:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $237
80106865:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010686a:	e9 8f f1 ff ff       	jmp    801059fe <alltraps>

8010686f <vector238>:
.globl vector238
vector238:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $238
80106871:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106876:	e9 83 f1 ff ff       	jmp    801059fe <alltraps>

8010687b <vector239>:
.globl vector239
vector239:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $239
8010687d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106882:	e9 77 f1 ff ff       	jmp    801059fe <alltraps>

80106887 <vector240>:
.globl vector240
vector240:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $240
80106889:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010688e:	e9 6b f1 ff ff       	jmp    801059fe <alltraps>

80106893 <vector241>:
.globl vector241
vector241:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $241
80106895:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010689a:	e9 5f f1 ff ff       	jmp    801059fe <alltraps>

8010689f <vector242>:
.globl vector242
vector242:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $242
801068a1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801068a6:	e9 53 f1 ff ff       	jmp    801059fe <alltraps>

801068ab <vector243>:
.globl vector243
vector243:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $243
801068ad:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801068b2:	e9 47 f1 ff ff       	jmp    801059fe <alltraps>

801068b7 <vector244>:
.globl vector244
vector244:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $244
801068b9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801068be:	e9 3b f1 ff ff       	jmp    801059fe <alltraps>

801068c3 <vector245>:
.globl vector245
vector245:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $245
801068c5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801068ca:	e9 2f f1 ff ff       	jmp    801059fe <alltraps>

801068cf <vector246>:
.globl vector246
vector246:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $246
801068d1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801068d6:	e9 23 f1 ff ff       	jmp    801059fe <alltraps>

801068db <vector247>:
.globl vector247
vector247:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $247
801068dd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801068e2:	e9 17 f1 ff ff       	jmp    801059fe <alltraps>

801068e7 <vector248>:
.globl vector248
vector248:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $248
801068e9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801068ee:	e9 0b f1 ff ff       	jmp    801059fe <alltraps>

801068f3 <vector249>:
.globl vector249
vector249:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $249
801068f5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801068fa:	e9 ff f0 ff ff       	jmp    801059fe <alltraps>

801068ff <vector250>:
.globl vector250
vector250:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $250
80106901:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106906:	e9 f3 f0 ff ff       	jmp    801059fe <alltraps>

8010690b <vector251>:
.globl vector251
vector251:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $251
8010690d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106912:	e9 e7 f0 ff ff       	jmp    801059fe <alltraps>

80106917 <vector252>:
.globl vector252
vector252:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $252
80106919:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010691e:	e9 db f0 ff ff       	jmp    801059fe <alltraps>

80106923 <vector253>:
.globl vector253
vector253:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $253
80106925:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010692a:	e9 cf f0 ff ff       	jmp    801059fe <alltraps>

8010692f <vector254>:
.globl vector254
vector254:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $254
80106931:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106936:	e9 c3 f0 ff ff       	jmp    801059fe <alltraps>

8010693b <vector255>:
.globl vector255
vector255:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $255
8010693d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106942:	e9 b7 f0 ff ff       	jmp    801059fe <alltraps>
80106947:	66 90                	xchg   %ax,%ax
80106949:	66 90                	xchg   %ax,%ax
8010694b:	66 90                	xchg   %ax,%ax
8010694d:	66 90                	xchg   %ax,%ax
8010694f:	90                   	nop

80106950 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106950:	55                   	push   %ebp
80106951:	89 e5                	mov    %esp,%ebp
80106953:	57                   	push   %edi
80106954:	56                   	push   %esi
80106955:	53                   	push   %ebx
80106956:	89 d3                	mov    %edx,%ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106958:	c1 ea 16             	shr    $0x16,%edx
8010695b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
8010695e:	83 ec 0c             	sub    $0xc,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
80106961:	8b 07                	mov    (%edi),%eax
80106963:	a8 01                	test   $0x1,%al
80106965:	74 29                	je     80106990 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106967:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010696c:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
80106972:	8d 65 f4             	lea    -0xc(%ebp),%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106975:	c1 eb 0a             	shr    $0xa,%ebx
80106978:	81 e3 fc 0f 00 00    	and    $0xffc,%ebx
8010697e:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
}
80106981:	5b                   	pop    %ebx
80106982:	5e                   	pop    %esi
80106983:	5f                   	pop    %edi
80106984:	5d                   	pop    %ebp
80106985:	c3                   	ret    
80106986:	8d 76 00             	lea    0x0(%esi),%esi
80106989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106990:	85 c9                	test   %ecx,%ecx
80106992:	74 2c                	je     801069c0 <walkpgdir+0x70>
80106994:	e8 57 bb ff ff       	call   801024f0 <kalloc>
80106999:	85 c0                	test   %eax,%eax
8010699b:	89 c6                	mov    %eax,%esi
8010699d:	74 21                	je     801069c0 <walkpgdir+0x70>
      return 0;
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
8010699f:	83 ec 04             	sub    $0x4,%esp
801069a2:	68 00 10 00 00       	push   $0x1000
801069a7:	6a 00                	push   $0x0
801069a9:	50                   	push   %eax
801069aa:	e8 51 db ff ff       	call   80104500 <memset>
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069af:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801069b5:	83 c4 10             	add    $0x10,%esp
801069b8:	83 c8 07             	or     $0x7,%eax
801069bb:	89 07                	mov    %eax,(%edi)
801069bd:	eb b3                	jmp    80106972 <walkpgdir+0x22>
801069bf:	90                   	nop
  }
  return &pgtab[PTX(va)];
}
801069c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  pde = &pgdir[PDX(va)];
  if(*pde & PTE_P){
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
      return 0;
801069c3:	31 c0                	xor    %eax,%eax
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
}
801069c5:	5b                   	pop    %ebx
801069c6:	5e                   	pop    %esi
801069c7:	5f                   	pop    %edi
801069c8:	5d                   	pop    %ebp
801069c9:	c3                   	ret    
801069ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801069d0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801069d0:	55                   	push   %ebp
801069d1:	89 e5                	mov    %esp,%ebp
801069d3:	57                   	push   %edi
801069d4:	56                   	push   %esi
801069d5:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
801069d6:	89 d3                	mov    %edx,%ebx
801069d8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801069de:	83 ec 1c             	sub    $0x1c,%esp
801069e1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801069e4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801069e8:	8b 7d 08             	mov    0x8(%ebp),%edi
801069eb:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801069f0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
801069f3:	8b 45 0c             	mov    0xc(%ebp),%eax
801069f6:	29 df                	sub    %ebx,%edi
801069f8:	83 c8 01             	or     $0x1,%eax
801069fb:	89 45 dc             	mov    %eax,-0x24(%ebp)
801069fe:	eb 15                	jmp    80106a15 <mappages+0x45>
  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80106a00:	f6 00 01             	testb  $0x1,(%eax)
80106a03:	75 45                	jne    80106a4a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a05:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106a08:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106a0b:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106a0d:	74 31                	je     80106a40 <mappages+0x70>
      break;
    a += PGSIZE;
80106a0f:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a15:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106a18:	b9 01 00 00 00       	mov    $0x1,%ecx
80106a1d:	89 da                	mov    %ebx,%edx
80106a1f:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106a22:	e8 29 ff ff ff       	call   80106950 <walkpgdir>
80106a27:	85 c0                	test   %eax,%eax
80106a29:	75 d5                	jne    80106a00 <mappages+0x30>
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a2b:	8d 65 f4             	lea    -0xc(%ebp),%esp

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
80106a2e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
}
80106a33:	5b                   	pop    %ebx
80106a34:	5e                   	pop    %esi
80106a35:	5f                   	pop    %edi
80106a36:	5d                   	pop    %ebp
80106a37:	c3                   	ret    
80106a38:	90                   	nop
80106a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a40:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(a == last)
      break;
    a += PGSIZE;
    pa += PGSIZE;
  }
  return 0;
80106a43:	31 c0                	xor    %eax,%eax
}
80106a45:	5b                   	pop    %ebx
80106a46:	5e                   	pop    %esi
80106a47:	5f                   	pop    %edi
80106a48:	5d                   	pop    %ebp
80106a49:	c3                   	ret    
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
80106a4a:	83 ec 0c             	sub    $0xc,%esp
80106a4d:	68 10 7c 10 80       	push   $0x80107c10
80106a52:	e8 19 99 ff ff       	call   80100370 <panic>
80106a57:	89 f6                	mov    %esi,%esi
80106a59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106a60 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a60:	55                   	push   %ebp
80106a61:	89 e5                	mov    %esp,%ebp
80106a63:	57                   	push   %edi
80106a64:	56                   	push   %esi
80106a65:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a66:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a6c:	89 c7                	mov    %eax,%edi
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a6e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a74:	83 ec 1c             	sub    $0x1c,%esp
80106a77:	89 4d e0             	mov    %ecx,-0x20(%ebp)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106a7a:	39 d3                	cmp    %edx,%ebx
80106a7c:	73 66                	jae    80106ae4 <deallocuvm.part.0+0x84>
80106a7e:	89 d6                	mov    %edx,%esi
80106a80:	eb 3d                	jmp    80106abf <deallocuvm.part.0+0x5f>
80106a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80106a88:	8b 10                	mov    (%eax),%edx
80106a8a:	f6 c2 01             	test   $0x1,%dl
80106a8d:	74 26                	je     80106ab5 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80106a8f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a95:	74 58                	je     80106aef <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80106a97:	83 ec 0c             	sub    $0xc,%esp
80106a9a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106aa0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106aa3:	52                   	push   %edx
80106aa4:	e8 97 b8 ff ff       	call   80102340 <kfree>
      *pte = 0;
80106aa9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106aac:	83 c4 10             	add    $0x10,%esp
80106aaf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106ab5:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106abb:	39 f3                	cmp    %esi,%ebx
80106abd:	73 25                	jae    80106ae4 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
80106abf:	31 c9                	xor    %ecx,%ecx
80106ac1:	89 da                	mov    %ebx,%edx
80106ac3:	89 f8                	mov    %edi,%eax
80106ac5:	e8 86 fe ff ff       	call   80106950 <walkpgdir>
    if(!pte)
80106aca:	85 c0                	test   %eax,%eax
80106acc:	75 ba                	jne    80106a88 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106ace:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80106ad4:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
  for(; a  < oldsz; a += PGSIZE){
80106ada:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106ae0:	39 f3                	cmp    %esi,%ebx
80106ae2:	72 db                	jb     80106abf <deallocuvm.part.0+0x5f>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106ae4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80106ae7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106aea:	5b                   	pop    %ebx
80106aeb:	5e                   	pop    %esi
80106aec:	5f                   	pop    %edi
80106aed:	5d                   	pop    %ebp
80106aee:	c3                   	ret    
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
      pa = PTE_ADDR(*pte);
      if(pa == 0)
        panic("kfree");
80106aef:	83 ec 0c             	sub    $0xc,%esp
80106af2:	68 56 75 10 80       	push   $0x80107556
80106af7:	e8 74 98 ff ff       	call   80100370 <panic>
80106afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106b00 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	53                   	push   %ebx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b04:	31 db                	xor    %ebx,%ebx

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80106b06:	83 ec 14             	sub    $0x14,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80106b09:	e8 42 bc ff ff       	call   80102750 <cpunum>
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b0e:	69 c0 bc 00 00 00    	imul   $0xbc,%eax,%eax
80106b14:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106b19:	8d 90 a0 27 11 80    	lea    -0x7feed860(%eax),%edx
80106b1f:	c6 80 1d 28 11 80 9a 	movb   $0x9a,-0x7feed7e3(%eax)
80106b26:	c6 80 1e 28 11 80 cf 	movb   $0xcf,-0x7feed7e2(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b2d:	c6 80 25 28 11 80 92 	movb   $0x92,-0x7feed7db(%eax)
80106b34:	c6 80 26 28 11 80 cf 	movb   $0xcf,-0x7feed7da(%eax)
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b3b:	66 89 4a 78          	mov    %cx,0x78(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b3f:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b44:	66 89 5a 7a          	mov    %bx,0x7a(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b48:	66 89 8a 80 00 00 00 	mov    %cx,0x80(%edx)
80106b4f:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b51:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b56:	66 89 9a 82 00 00 00 	mov    %bx,0x82(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b5d:	66 89 8a 90 00 00 00 	mov    %cx,0x90(%edx)
80106b64:	31 db                	xor    %ebx,%ebx
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b66:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b6b:	66 89 9a 92 00 00 00 	mov    %bx,0x92(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b72:	31 db                	xor    %ebx,%ebx
80106b74:	66 89 8a 98 00 00 00 	mov    %cx,0x98(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106b7b:	8d 88 54 28 11 80    	lea    -0x7feed7ac(%eax),%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b81:	66 89 9a 9a 00 00 00 	mov    %bx,0x9a(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106b88:	31 db                	xor    %ebx,%ebx
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b8a:	c6 80 35 28 11 80 fa 	movb   $0xfa,-0x7feed7cb(%eax)
80106b91:	c6 80 36 28 11 80 cf 	movb   $0xcf,-0x7feed7ca(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106b98:	66 89 9a 88 00 00 00 	mov    %bx,0x88(%edx)
80106b9f:	66 89 8a 8a 00 00 00 	mov    %cx,0x8a(%edx)
80106ba6:	89 cb                	mov    %ecx,%ebx
80106ba8:	c1 e9 18             	shr    $0x18,%ecx
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106bab:	c6 80 3d 28 11 80 f2 	movb   $0xf2,-0x7feed7c3(%eax)
80106bb2:	c6 80 3e 28 11 80 cf 	movb   $0xcf,-0x7feed7c2(%eax)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106bb9:	88 8a 8f 00 00 00    	mov    %cl,0x8f(%edx)
80106bbf:	c6 80 2d 28 11 80 92 	movb   $0x92,-0x7feed7d3(%eax)
static inline void
lgdt(struct segdesc *p, int size)
{
  volatile ushort pd[3];

  pd[0] = size-1;
80106bc6:	b9 37 00 00 00       	mov    $0x37,%ecx
80106bcb:	c6 80 2e 28 11 80 c0 	movb   $0xc0,-0x7feed7d2(%eax)

  lgdt(c->gdt, sizeof(c->gdt));
80106bd2:	05 10 28 11 80       	add    $0x80112810,%eax
80106bd7:	66 89 4d f2          	mov    %cx,-0xe(%ebp)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106bdb:	c1 eb 10             	shr    $0x10,%ebx
  pd[1] = (uint)p;
80106bde:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106be2:	c1 e8 10             	shr    $0x10,%eax
  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106be5:	c6 42 7c 00          	movb   $0x0,0x7c(%edx)
80106be9:	c6 42 7f 00          	movb   $0x0,0x7f(%edx)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106bed:	c6 82 84 00 00 00 00 	movb   $0x0,0x84(%edx)
80106bf4:	c6 82 87 00 00 00 00 	movb   $0x0,0x87(%edx)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106bfb:	c6 82 94 00 00 00 00 	movb   $0x0,0x94(%edx)
80106c02:	c6 82 97 00 00 00 00 	movb   $0x0,0x97(%edx)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c09:	c6 82 9c 00 00 00 00 	movb   $0x0,0x9c(%edx)
80106c10:	c6 82 9f 00 00 00 00 	movb   $0x0,0x9f(%edx)

  // Map cpu and proc -- these are private per cpu.
  c->gdt[SEG_KCPU] = SEG(STA_W, &c->cpu, 8, 0);
80106c17:	88 9a 8c 00 00 00    	mov    %bl,0x8c(%edx)
80106c1d:	66 89 45 f6          	mov    %ax,-0xa(%ebp)

  asm volatile("lgdt (%0)" : : "r" (pd));
80106c21:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c24:	0f 01 10             	lgdtl  (%eax)
}

static inline void
loadgs(ushort v)
{
  asm volatile("movw %0, %%gs" : : "r" (v));
80106c27:	b8 18 00 00 00       	mov    $0x18,%eax
80106c2c:	8e e8                	mov    %eax,%gs
  lgdt(c->gdt, sizeof(c->gdt));
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
80106c2e:	65 c7 05 04 00 00 00 	movl   $0x0,%gs:0x4
80106c35:	00 00 00 00 

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpunum()];
80106c39:	65 89 15 00 00 00 00 	mov    %edx,%gs:0x0
  loadgs(SEG_KCPU << 3);

  // Initialize cpu-local storage.
  cpu = c;
  proc = 0;
}
80106c40:	83 c4 14             	add    $0x14,%esp
80106c43:	5b                   	pop    %ebx
80106c44:	5d                   	pop    %ebp
80106c45:	c3                   	ret    
80106c46:	8d 76 00             	lea    0x0(%esi),%esi
80106c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106c50 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	56                   	push   %esi
80106c54:	53                   	push   %ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80106c55:	e8 96 b8 ff ff       	call   801024f0 <kalloc>
80106c5a:	85 c0                	test   %eax,%eax
80106c5c:	74 52                	je     80106cb0 <setupkvm+0x60>
    return 0;
  memset(pgdir, 0, PGSIZE);
80106c5e:	83 ec 04             	sub    $0x4,%esp
80106c61:	89 c6                	mov    %eax,%esi
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106c63:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
80106c68:	68 00 10 00 00       	push   $0x1000
80106c6d:	6a 00                	push   $0x0
80106c6f:	50                   	push   %eax
80106c70:	e8 8b d8 ff ff       	call   80104500 <memset>
80106c75:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106c78:	8b 43 04             	mov    0x4(%ebx),%eax
80106c7b:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106c7e:	83 ec 08             	sub    $0x8,%esp
80106c81:	8b 13                	mov    (%ebx),%edx
80106c83:	ff 73 0c             	pushl  0xc(%ebx)
80106c86:	50                   	push   %eax
80106c87:	29 c1                	sub    %eax,%ecx
80106c89:	89 f0                	mov    %esi,%eax
80106c8b:	e8 40 fd ff ff       	call   801069d0 <mappages>
80106c90:	83 c4 10             	add    $0x10,%esp
80106c93:	85 c0                	test   %eax,%eax
80106c95:	78 19                	js     80106cb0 <setupkvm+0x60>
  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
  memset(pgdir, 0, PGSIZE);
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106c97:	83 c3 10             	add    $0x10,%ebx
80106c9a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106ca0:	75 d6                	jne    80106c78 <setupkvm+0x28>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106ca2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106ca5:	89 f0                	mov    %esi,%eax
80106ca7:	5b                   	pop    %ebx
80106ca8:	5e                   	pop    %esi
80106ca9:	5d                   	pop    %ebp
80106caa:	c3                   	ret    
80106cab:	90                   	nop
80106cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106cb0:	8d 65 f8             	lea    -0x8(%ebp),%esp
{
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
    return 0;
80106cb3:	31 c0                	xor    %eax,%eax
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
                (uint)k->phys_start, k->perm) < 0)
      return 0;
  return pgdir;
}
80106cb5:	5b                   	pop    %ebx
80106cb6:	5e                   	pop    %esi
80106cb7:	5d                   	pop    %ebp
80106cb8:	c3                   	ret    
80106cb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106cc0 <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80106cc0:	55                   	push   %ebp
80106cc1:	89 e5                	mov    %esp,%ebp
80106cc3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106cc6:	e8 85 ff ff ff       	call   80106c50 <setupkvm>
80106ccb:	a3 e4 55 11 80       	mov    %eax,0x801155e4
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106cd0:	05 00 00 00 80       	add    $0x80000000,%eax
80106cd5:	0f 22 d8             	mov    %eax,%cr3
  switchkvm();
}
80106cd8:	c9                   	leave  
80106cd9:	c3                   	ret    
80106cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ce0 <switchkvm>:
80106ce0:	a1 e4 55 11 80       	mov    0x801155e4,%eax

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80106ce5:	55                   	push   %ebp
80106ce6:	89 e5                	mov    %esp,%ebp
80106ce8:	05 00 00 00 80       	add    $0x80000000,%eax
80106ced:	0f 22 d8             	mov    %eax,%cr3
  lcr3(V2P(kpgdir));   // switch to the kernel page table
}
80106cf0:	5d                   	pop    %ebp
80106cf1:	c3                   	ret    
80106cf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106d00 <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80106d00:	55                   	push   %ebp
80106d01:	89 e5                	mov    %esp,%ebp
80106d03:	53                   	push   %ebx
80106d04:	83 ec 04             	sub    $0x4,%esp
80106d07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
80106d0a:	85 db                	test   %ebx,%ebx
80106d0c:	0f 84 93 00 00 00    	je     80106da5 <switchuvm+0xa5>
    panic("switchuvm: no process");
  if(p->kstack == 0)
80106d12:	8b 43 08             	mov    0x8(%ebx),%eax
80106d15:	85 c0                	test   %eax,%eax
80106d17:	0f 84 a2 00 00 00    	je     80106dbf <switchuvm+0xbf>
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
80106d1d:	8b 43 04             	mov    0x4(%ebx),%eax
80106d20:	85 c0                	test   %eax,%eax
80106d22:	0f 84 8a 00 00 00    	je     80106db2 <switchuvm+0xb2>
    panic("switchuvm: no pgdir");

  pushcli();
80106d28:	e8 03 d7 ff ff       	call   80104430 <pushcli>
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106d2d:	65 a1 00 00 00 00    	mov    %gs:0x0,%eax
80106d33:	b9 67 00 00 00       	mov    $0x67,%ecx
80106d38:	8d 50 08             	lea    0x8(%eax),%edx
80106d3b:	66 89 88 a0 00 00 00 	mov    %cx,0xa0(%eax)
80106d42:	c6 80 a6 00 00 00 40 	movb   $0x40,0xa6(%eax)
  cpu->gdt[SEG_TSS].s = 0;
80106d49:	c6 80 a5 00 00 00 89 	movb   $0x89,0xa5(%eax)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106d50:	66 89 90 a2 00 00 00 	mov    %dx,0xa2(%eax)
80106d57:	89 d1                	mov    %edx,%ecx
80106d59:	c1 ea 18             	shr    $0x18,%edx
80106d5c:	88 90 a7 00 00 00    	mov    %dl,0xa7(%eax)
80106d62:	c1 e9 10             	shr    $0x10,%ecx
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
80106d65:	ba 10 00 00 00       	mov    $0x10,%edx
80106d6a:	66 89 50 10          	mov    %dx,0x10(%eax)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
80106d6e:	88 88 a4 00 00 00    	mov    %cl,0xa4(%eax)
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106d74:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106d77:	8d 91 00 10 00 00    	lea    0x1000(%ecx),%edx
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
80106d7d:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
80106d82:	66 89 48 6e          	mov    %cx,0x6e(%eax)

  pushcli();
  cpu->gdt[SEG_TSS] = SEG16(STS_T32A, &cpu->ts, sizeof(cpu->ts)-1, 0);
  cpu->gdt[SEG_TSS].s = 0;
  cpu->ts.ss0 = SEG_KDATA << 3;
  cpu->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106d86:	89 50 0c             	mov    %edx,0xc(%eax)
}

static inline void
ltr(ushort sel)
{
  asm volatile("ltr %0" : : "r" (sel));
80106d89:	b8 30 00 00 00       	mov    $0x30,%eax
80106d8e:	0f 00 d8             	ltr    %ax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d91:	8b 43 04             	mov    0x4(%ebx),%eax
80106d94:	05 00 00 00 80       	add    $0x80000000,%eax
80106d99:	0f 22 d8             	mov    %eax,%cr3
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
}
80106d9c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106d9f:	c9                   	leave  
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  cpu->ts.iomb = (ushort) 0xFFFF;
  ltr(SEG_TSS << 3);
  lcr3(V2P(p->pgdir));  // switch to process's address space
  popcli();
80106da0:	e9 bb d6 ff ff       	jmp    80104460 <popcli>
// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
80106da5:	83 ec 0c             	sub    $0xc,%esp
80106da8:	68 16 7c 10 80       	push   $0x80107c16
80106dad:	e8 be 95 ff ff       	call   80100370 <panic>
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
  if(p->pgdir == 0)
    panic("switchuvm: no pgdir");
80106db2:	83 ec 0c             	sub    $0xc,%esp
80106db5:	68 41 7c 10 80       	push   $0x80107c41
80106dba:	e8 b1 95 ff ff       	call   80100370 <panic>
switchuvm(struct proc *p)
{
  if(p == 0)
    panic("switchuvm: no process");
  if(p->kstack == 0)
    panic("switchuvm: no kstack");
80106dbf:	83 ec 0c             	sub    $0xc,%esp
80106dc2:	68 2c 7c 10 80       	push   $0x80107c2c
80106dc7:	e8 a4 95 ff ff       	call   80100370 <panic>
80106dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106dd0 <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106dd0:	55                   	push   %ebp
80106dd1:	89 e5                	mov    %esp,%ebp
80106dd3:	57                   	push   %edi
80106dd4:	56                   	push   %esi
80106dd5:	53                   	push   %ebx
80106dd6:	83 ec 1c             	sub    $0x1c,%esp
80106dd9:	8b 75 10             	mov    0x10(%ebp),%esi
80106ddc:	8b 45 08             	mov    0x8(%ebp),%eax
80106ddf:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *mem;

  if(sz >= PGSIZE)
80106de2:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
80106de8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  char *mem;

  if(sz >= PGSIZE)
80106deb:	77 49                	ja     80106e36 <inituvm+0x66>
    panic("inituvm: more than a page");
  mem = kalloc();
80106ded:	e8 fe b6 ff ff       	call   801024f0 <kalloc>
  memset(mem, 0, PGSIZE);
80106df2:	83 ec 04             	sub    $0x4,%esp
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
80106df5:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106df7:	68 00 10 00 00       	push   $0x1000
80106dfc:	6a 00                	push   $0x0
80106dfe:	50                   	push   %eax
80106dff:	e8 fc d6 ff ff       	call   80104500 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106e04:	58                   	pop    %eax
80106e05:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e0b:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e10:	5a                   	pop    %edx
80106e11:	6a 06                	push   $0x6
80106e13:	50                   	push   %eax
80106e14:	31 d2                	xor    %edx,%edx
80106e16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106e19:	e8 b2 fb ff ff       	call   801069d0 <mappages>
  memmove(mem, init, sz);
80106e1e:	89 75 10             	mov    %esi,0x10(%ebp)
80106e21:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106e24:	83 c4 10             	add    $0x10,%esp
80106e27:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106e2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e2d:	5b                   	pop    %ebx
80106e2e:	5e                   	pop    %esi
80106e2f:	5f                   	pop    %edi
80106e30:	5d                   	pop    %ebp
  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
  mem = kalloc();
  memset(mem, 0, PGSIZE);
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
  memmove(mem, init, sz);
80106e31:	e9 7a d7 ff ff       	jmp    801045b0 <memmove>
inituvm(pde_t *pgdir, char *init, uint sz)
{
  char *mem;

  if(sz >= PGSIZE)
    panic("inituvm: more than a page");
80106e36:	83 ec 0c             	sub    $0xc,%esp
80106e39:	68 55 7c 10 80       	push   $0x80107c55
80106e3e:	e8 2d 95 ff ff       	call   80100370 <panic>
80106e43:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106e50 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
80106e50:	55                   	push   %ebp
80106e51:	89 e5                	mov    %esp,%ebp
80106e53:	57                   	push   %edi
80106e54:	56                   	push   %esi
80106e55:	53                   	push   %ebx
80106e56:	83 ec 0c             	sub    $0xc,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80106e59:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80106e60:	0f 85 91 00 00 00    	jne    80106ef7 <loaduvm+0xa7>
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
80106e66:	8b 75 18             	mov    0x18(%ebp),%esi
80106e69:	31 db                	xor    %ebx,%ebx
80106e6b:	85 f6                	test   %esi,%esi
80106e6d:	75 1a                	jne    80106e89 <loaduvm+0x39>
80106e6f:	eb 6f                	jmp    80106ee0 <loaduvm+0x90>
80106e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106e78:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106e7e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80106e84:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80106e87:	76 57                	jbe    80106ee0 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106e89:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e8c:	8b 45 08             	mov    0x8(%ebp),%eax
80106e8f:	31 c9                	xor    %ecx,%ecx
80106e91:	01 da                	add    %ebx,%edx
80106e93:	e8 b8 fa ff ff       	call   80106950 <walkpgdir>
80106e98:	85 c0                	test   %eax,%eax
80106e9a:	74 4e                	je     80106eea <loaduvm+0x9a>
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106e9c:	8b 00                	mov    (%eax),%eax
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e9e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
    if(sz - i < PGSIZE)
80106ea1:	bf 00 10 00 00       	mov    $0x1000,%edi
  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
    pa = PTE_ADDR(*pte);
80106ea6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80106eab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106eb1:	0f 46 fe             	cmovbe %esi,%edi
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106eb4:	01 d9                	add    %ebx,%ecx
80106eb6:	05 00 00 00 80       	add    $0x80000000,%eax
80106ebb:	57                   	push   %edi
80106ebc:	51                   	push   %ecx
80106ebd:	50                   	push   %eax
80106ebe:	ff 75 10             	pushl  0x10(%ebp)
80106ec1:	e8 4a aa ff ff       	call   80101910 <readi>
80106ec6:	83 c4 10             	add    $0x10,%esp
80106ec9:	39 c7                	cmp    %eax,%edi
80106ecb:	74 ab                	je     80106e78 <loaduvm+0x28>
      return -1;
  }
  return 0;
}
80106ecd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
80106ed0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return 0;
}
80106ed5:	5b                   	pop    %ebx
80106ed6:	5e                   	pop    %esi
80106ed7:	5f                   	pop    %edi
80106ed8:	5d                   	pop    %ebp
80106ed9:	c3                   	ret    
80106eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ee0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    else
      n = PGSIZE;
    if(readi(ip, P2V(pa), offset+i, n) != n)
      return -1;
  }
  return 0;
80106ee3:	31 c0                	xor    %eax,%eax
}
80106ee5:	5b                   	pop    %ebx
80106ee6:	5e                   	pop    %esi
80106ee7:	5f                   	pop    %edi
80106ee8:	5d                   	pop    %ebp
80106ee9:	c3                   	ret    

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
      panic("loaduvm: address should exist");
80106eea:	83 ec 0c             	sub    $0xc,%esp
80106eed:	68 6f 7c 10 80       	push   $0x80107c6f
80106ef2:	e8 79 94 ff ff       	call   80100370 <panic>
{
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
    panic("loaduvm: addr must be page aligned");
80106ef7:	83 ec 0c             	sub    $0xc,%esp
80106efa:	68 10 7d 10 80       	push   $0x80107d10
80106eff:	e8 6c 94 ff ff       	call   80100370 <panic>
80106f04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106f10 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80106f10:	55                   	push   %ebp
80106f11:	89 e5                	mov    %esp,%ebp
80106f13:	57                   	push   %edi
80106f14:	56                   	push   %esi
80106f15:	53                   	push   %ebx
80106f16:	83 ec 0c             	sub    $0xc,%esp
80106f19:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
80106f1c:	85 ff                	test   %edi,%edi
80106f1e:	0f 88 8c 00 00 00    	js     80106fb0 <allocuvm+0xa0>
    return 0;
  if(newsz < oldsz)
80106f24:	3b 7d 0c             	cmp    0xc(%ebp),%edi
    return oldsz;
80106f27:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
    return 0;
  if(newsz < oldsz)
80106f2a:	0f 82 82 00 00 00    	jb     80106fb2 <allocuvm+0xa2>
    return oldsz;

  a = PGROUNDUP(oldsz);
80106f30:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80106f36:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
80106f3c:	39 df                	cmp    %ebx,%edi
80106f3e:	77 43                	ja     80106f83 <allocuvm+0x73>
80106f40:	eb 7e                	jmp    80106fc0 <allocuvm+0xb0>
80106f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
80106f48:	83 ec 04             	sub    $0x4,%esp
80106f4b:	68 00 10 00 00       	push   $0x1000
80106f50:	6a 00                	push   $0x0
80106f52:	50                   	push   %eax
80106f53:	e8 a8 d5 ff ff       	call   80104500 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106f58:	58                   	pop    %eax
80106f59:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80106f5f:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f64:	5a                   	pop    %edx
80106f65:	6a 06                	push   $0x6
80106f67:	50                   	push   %eax
80106f68:	89 da                	mov    %ebx,%edx
80106f6a:	8b 45 08             	mov    0x8(%ebp),%eax
80106f6d:	e8 5e fa ff ff       	call   801069d0 <mappages>
80106f72:	83 c4 10             	add    $0x10,%esp
80106f75:	85 c0                	test   %eax,%eax
80106f77:	78 67                	js     80106fe0 <allocuvm+0xd0>
    return 0;
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
80106f79:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106f7f:	39 df                	cmp    %ebx,%edi
80106f81:	76 3d                	jbe    80106fc0 <allocuvm+0xb0>
    mem = kalloc();
80106f83:	e8 68 b5 ff ff       	call   801024f0 <kalloc>
    if(mem == 0){
80106f88:	85 c0                	test   %eax,%eax
  if(newsz < oldsz)
    return oldsz;

  a = PGROUNDUP(oldsz);
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
80106f8a:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80106f8c:	75 ba                	jne    80106f48 <allocuvm+0x38>
      cprintf("allocuvm out of memory\n");
80106f8e:	83 ec 0c             	sub    $0xc,%esp
80106f91:	68 8d 7c 10 80       	push   $0x80107c8d
80106f96:	e8 c5 96 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106f9b:	83 c4 10             	add    $0x10,%esp
80106f9e:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106fa1:	76 0d                	jbe    80106fb0 <allocuvm+0xa0>
80106fa3:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106fa6:	8b 45 08             	mov    0x8(%ebp),%eax
80106fa9:	89 fa                	mov    %edi,%edx
80106fab:	e8 b0 fa ff ff       	call   80106a60 <deallocuvm.part.0>
  for(; a < newsz; a += PGSIZE){
    mem = kalloc();
    if(mem == 0){
      cprintf("allocuvm out of memory\n");
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
80106fb0:	31 c0                	xor    %eax,%eax
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
  return newsz;
}
80106fb2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fb5:	5b                   	pop    %ebx
80106fb6:	5e                   	pop    %esi
80106fb7:	5f                   	pop    %edi
80106fb8:	5d                   	pop    %ebp
80106fb9:	c3                   	ret    
80106fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      kfree(mem);
      return 0;
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
80106fc0:	83 ec 0c             	sub    $0xc,%esp
80106fc3:	57                   	push   %edi
80106fc4:	e8 77 e7 ff ff       	call   80105740 <updatem>
  return newsz;
80106fc9:	83 c4 10             	add    $0x10,%esp
}
80106fcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
  return newsz;
80106fcf:	89 f8                	mov    %edi,%eax
}
80106fd1:	5b                   	pop    %ebx
80106fd2:	5e                   	pop    %esi
80106fd3:	5f                   	pop    %edi
80106fd4:	5d                   	pop    %ebp
80106fd5:	c3                   	ret    
80106fd6:	8d 76 00             	lea    0x0(%esi),%esi
80106fd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      deallocuvm(pgdir, newsz, oldsz);
      return 0;
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
80106fe0:	83 ec 0c             	sub    $0xc,%esp
80106fe3:	68 a5 7c 10 80       	push   $0x80107ca5
80106fe8:	e8 73 96 ff ff       	call   80100660 <cprintf>
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80106fed:	83 c4 10             	add    $0x10,%esp
80106ff0:	3b 7d 0c             	cmp    0xc(%ebp),%edi
80106ff3:	76 0d                	jbe    80107002 <allocuvm+0xf2>
80106ff5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ff8:	8b 45 08             	mov    0x8(%ebp),%eax
80106ffb:	89 fa                	mov    %edi,%edx
80106ffd:	e8 5e fa ff ff       	call   80106a60 <deallocuvm.part.0>
    }
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
80107002:	83 ec 0c             	sub    $0xc,%esp
80107005:	56                   	push   %esi
80107006:	e8 35 b3 ff ff       	call   80102340 <kfree>
      return 0;
8010700b:	83 c4 10             	add    $0x10,%esp
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
  return newsz;
}
8010700e:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memset(mem, 0, PGSIZE);
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
      cprintf("allocuvm out of memory (2)\n");
      deallocuvm(pgdir, newsz, oldsz);
      kfree(mem);
      return 0;
80107011:	31 c0                	xor    %eax,%eax
    }
  }
	//cprintf("pgdir:%d | oldsz:%d | newsz:%d\n",(int)&pgdir,oldsz,newsz);
	updatem(newsz);
  return newsz;
}
80107013:	5b                   	pop    %ebx
80107014:	5e                   	pop    %esi
80107015:	5f                   	pop    %edi
80107016:	5d                   	pop    %ebp
80107017:	c3                   	ret    
80107018:	90                   	nop
80107019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107020 <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	8b 55 0c             	mov    0xc(%ebp),%edx
80107026:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107029:	8b 45 08             	mov    0x8(%ebp),%eax
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
8010702c:	39 d1                	cmp    %edx,%ecx
8010702e:	73 10                	jae    80107040 <deallocuvm+0x20>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107030:	5d                   	pop    %ebp
80107031:	e9 2a fa ff ff       	jmp    80106a60 <deallocuvm.part.0>
80107036:	8d 76 00             	lea    0x0(%esi),%esi
80107039:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107040:	89 d0                	mov    %edx,%eax
80107042:	5d                   	pop    %ebp
80107043:	c3                   	ret    
80107044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010704a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107050 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107050:	55                   	push   %ebp
80107051:	89 e5                	mov    %esp,%ebp
80107053:	57                   	push   %edi
80107054:	56                   	push   %esi
80107055:	53                   	push   %ebx
80107056:	83 ec 0c             	sub    $0xc,%esp
80107059:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010705c:	85 f6                	test   %esi,%esi
8010705e:	74 59                	je     801070b9 <freevm+0x69>
80107060:	31 c9                	xor    %ecx,%ecx
80107062:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107067:	89 f0                	mov    %esi,%eax
80107069:	e8 f2 f9 ff ff       	call   80106a60 <deallocuvm.part.0>
8010706e:	89 f3                	mov    %esi,%ebx
80107070:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107076:	eb 0f                	jmp    80107087 <freevm+0x37>
80107078:	90                   	nop
80107079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107080:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107083:	39 fb                	cmp    %edi,%ebx
80107085:	74 23                	je     801070aa <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107087:	8b 03                	mov    (%ebx),%eax
80107089:	a8 01                	test   $0x1,%al
8010708b:	74 f3                	je     80107080 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
8010708d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107092:	83 ec 0c             	sub    $0xc,%esp
80107095:	83 c3 04             	add    $0x4,%ebx
80107098:	05 00 00 00 80       	add    $0x80000000,%eax
8010709d:	50                   	push   %eax
8010709e:	e8 9d b2 ff ff       	call   80102340 <kfree>
801070a3:	83 c4 10             	add    $0x10,%esp
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
801070a6:	39 fb                	cmp    %edi,%ebx
801070a8:	75 dd                	jne    80107087 <freevm+0x37>
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801070aa:	89 75 08             	mov    %esi,0x8(%ebp)
}
801070ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070b0:	5b                   	pop    %ebx
801070b1:	5e                   	pop    %esi
801070b2:	5f                   	pop    %edi
801070b3:	5d                   	pop    %ebp
    if(pgdir[i] & PTE_P){
      char * v = P2V(PTE_ADDR(pgdir[i]));
      kfree(v);
    }
  }
  kfree((char*)pgdir);
801070b4:	e9 87 b2 ff ff       	jmp    80102340 <kfree>
freevm(pde_t *pgdir)
{
  uint i;

  if(pgdir == 0)
    panic("freevm: no pgdir");
801070b9:	83 ec 0c             	sub    $0xc,%esp
801070bc:	68 c1 7c 10 80       	push   $0x80107cc1
801070c1:	e8 aa 92 ff ff       	call   80100370 <panic>
801070c6:	8d 76 00             	lea    0x0(%esi),%esi
801070c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801070d0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801070d0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801070d1:	31 c9                	xor    %ecx,%ecx

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801070d3:	89 e5                	mov    %esp,%ebp
801070d5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801070d8:	8b 55 0c             	mov    0xc(%ebp),%edx
801070db:	8b 45 08             	mov    0x8(%ebp),%eax
801070de:	e8 6d f8 ff ff       	call   80106950 <walkpgdir>
  if(pte == 0)
801070e3:	85 c0                	test   %eax,%eax
801070e5:	74 05                	je     801070ec <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
801070e7:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801070ea:	c9                   	leave  
801070eb:	c3                   	ret    
{
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801070ec:	83 ec 0c             	sub    $0xc,%esp
801070ef:	68 d2 7c 10 80       	push   $0x80107cd2
801070f4:	e8 77 92 ff ff       	call   80100370 <panic>
801070f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107100 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107100:	55                   	push   %ebp
80107101:	89 e5                	mov    %esp,%ebp
80107103:	57                   	push   %edi
80107104:	56                   	push   %esi
80107105:	53                   	push   %ebx
80107106:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107109:	e8 42 fb ff ff       	call   80106c50 <setupkvm>
8010710e:	85 c0                	test   %eax,%eax
80107110:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107113:	0f 84 b2 00 00 00    	je     801071cb <copyuvm+0xcb>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107119:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010711c:	85 c9                	test   %ecx,%ecx
8010711e:	0f 84 9c 00 00 00    	je     801071c0 <copyuvm+0xc0>
80107124:	31 f6                	xor    %esi,%esi
80107126:	eb 4a                	jmp    80107172 <copyuvm+0x72>
80107128:	90                   	nop
80107129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107130:	83 ec 04             	sub    $0x4,%esp
80107133:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107139:	68 00 10 00 00       	push   $0x1000
8010713e:	57                   	push   %edi
8010713f:	50                   	push   %eax
80107140:	e8 6b d4 ff ff       	call   801045b0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0)
80107145:	58                   	pop    %eax
80107146:	5a                   	pop    %edx
80107147:	8d 93 00 00 00 80    	lea    -0x80000000(%ebx),%edx
8010714d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107150:	ff 75 e4             	pushl  -0x1c(%ebp)
80107153:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107158:	52                   	push   %edx
80107159:	89 f2                	mov    %esi,%edx
8010715b:	e8 70 f8 ff ff       	call   801069d0 <mappages>
80107160:	83 c4 10             	add    $0x10,%esp
80107163:	85 c0                	test   %eax,%eax
80107165:	78 3e                	js     801071a5 <copyuvm+0xa5>
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107167:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010716d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107170:	76 4e                	jbe    801071c0 <copyuvm+0xc0>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107172:	8b 45 08             	mov    0x8(%ebp),%eax
80107175:	31 c9                	xor    %ecx,%ecx
80107177:	89 f2                	mov    %esi,%edx
80107179:	e8 d2 f7 ff ff       	call   80106950 <walkpgdir>
8010717e:	85 c0                	test   %eax,%eax
80107180:	74 5a                	je     801071dc <copyuvm+0xdc>
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
80107182:	8b 18                	mov    (%eax),%ebx
80107184:	f6 c3 01             	test   $0x1,%bl
80107187:	74 46                	je     801071cf <copyuvm+0xcf>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107189:	89 df                	mov    %ebx,%edi
    flags = PTE_FLAGS(*pte);
8010718b:	81 e3 ff 0f 00 00    	and    $0xfff,%ebx
80107191:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107194:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
8010719a:	e8 51 b3 ff ff       	call   801024f0 <kalloc>
8010719f:	85 c0                	test   %eax,%eax
801071a1:	89 c3                	mov    %eax,%ebx
801071a3:	75 8b                	jne    80107130 <copyuvm+0x30>
      goto bad;
  }
  return d;

bad:
  freevm(d);
801071a5:	83 ec 0c             	sub    $0xc,%esp
801071a8:	ff 75 e0             	pushl  -0x20(%ebp)
801071ab:	e8 a0 fe ff ff       	call   80107050 <freevm>
  return 0;
801071b0:	83 c4 10             	add    $0x10,%esp
801071b3:	31 c0                	xor    %eax,%eax
}
801071b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071b8:	5b                   	pop    %ebx
801071b9:	5e                   	pop    %esi
801071ba:	5f                   	pop    %edi
801071bb:	5d                   	pop    %ebp
801071bc:	c3                   	ret    
801071bd:	8d 76 00             	lea    0x0(%esi),%esi
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  return d;

bad:
  freevm(d);
  return 0;
}
801071c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071c6:	5b                   	pop    %ebx
801071c7:	5e                   	pop    %esi
801071c8:	5f                   	pop    %edi
801071c9:	5d                   	pop    %ebp
801071ca:	c3                   	ret    
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
    return 0;
801071cb:	31 c0                	xor    %eax,%eax
801071cd:	eb e6                	jmp    801071b5 <copyuvm+0xb5>
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
    if(!(*pte & PTE_P))
      panic("copyuvm: page not present");
801071cf:	83 ec 0c             	sub    $0xc,%esp
801071d2:	68 f6 7c 10 80       	push   $0x80107cf6
801071d7:	e8 94 91 ff ff       	call   80100370 <panic>

  if((d = setupkvm()) == 0)
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801071dc:	83 ec 0c             	sub    $0xc,%esp
801071df:	68 dc 7c 10 80       	push   $0x80107cdc
801071e4:	e8 87 91 ff ff       	call   80100370 <panic>
801071e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801071f0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801071f0:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801071f1:	31 c9                	xor    %ecx,%ecx

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801071f3:	89 e5                	mov    %esp,%ebp
801071f5:	83 ec 08             	sub    $0x8,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801071f8:	8b 55 0c             	mov    0xc(%ebp),%edx
801071fb:	8b 45 08             	mov    0x8(%ebp),%eax
801071fe:	e8 4d f7 ff ff       	call   80106950 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107203:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
80107205:	89 c2                	mov    %eax,%edx
80107207:	83 e2 05             	and    $0x5,%edx
8010720a:	83 fa 05             	cmp    $0x5,%edx
8010720d:	75 11                	jne    80107220 <uva2ka+0x30>
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
8010720f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
}
80107214:	c9                   	leave  
  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
80107215:	05 00 00 00 80       	add    $0x80000000,%eax
}
8010721a:	c3                   	ret    
8010721b:	90                   	nop
8010721c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

  pte = walkpgdir(pgdir, uva, 0);
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
80107220:	31 c0                	xor    %eax,%eax
  return (char*)P2V(PTE_ADDR(*pte));
}
80107222:	c9                   	leave  
80107223:	c3                   	ret    
80107224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010722a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107230 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107230:	55                   	push   %ebp
80107231:	89 e5                	mov    %esp,%ebp
80107233:	57                   	push   %edi
80107234:	56                   	push   %esi
80107235:	53                   	push   %ebx
80107236:	83 ec 1c             	sub    $0x1c,%esp
80107239:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010723c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010723f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107242:	85 db                	test   %ebx,%ebx
80107244:	75 40                	jne    80107286 <copyout+0x56>
80107246:	eb 70                	jmp    801072b8 <copyout+0x88>
80107248:	90                   	nop
80107249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107250:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107253:	89 f1                	mov    %esi,%ecx
80107255:	29 d1                	sub    %edx,%ecx
80107257:	81 c1 00 10 00 00    	add    $0x1000,%ecx
8010725d:	39 d9                	cmp    %ebx,%ecx
8010725f:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107262:	29 f2                	sub    %esi,%edx
80107264:	83 ec 04             	sub    $0x4,%esp
80107267:	01 d0                	add    %edx,%eax
80107269:	51                   	push   %ecx
8010726a:	57                   	push   %edi
8010726b:	50                   	push   %eax
8010726c:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010726f:	e8 3c d3 ff ff       	call   801045b0 <memmove>
    len -= n;
    buf += n;
80107274:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107277:	83 c4 10             	add    $0x10,%esp
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
8010727a:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    n = PGSIZE - (va - va0);
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
80107280:	01 cf                	add    %ecx,%edi
{
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107282:	29 cb                	sub    %ecx,%ebx
80107284:	74 32                	je     801072b8 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
80107286:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107288:	83 ec 08             	sub    $0x8,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
8010728b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010728e:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
80107294:	56                   	push   %esi
80107295:	ff 75 08             	pushl  0x8(%ebp)
80107298:	e8 53 ff ff ff       	call   801071f0 <uva2ka>
    if(pa0 == 0)
8010729d:	83 c4 10             	add    $0x10,%esp
801072a0:	85 c0                	test   %eax,%eax
801072a2:	75 ac                	jne    80107250 <copyout+0x20>
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801072a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  buf = (char*)p;
  while(len > 0){
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
801072a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
}
801072ac:	5b                   	pop    %ebx
801072ad:	5e                   	pop    %esi
801072ae:	5f                   	pop    %edi
801072af:	5d                   	pop    %ebp
801072b0:	c3                   	ret    
801072b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
    memmove(pa0 + (va - va0), buf, n);
    len -= n;
    buf += n;
    va = va0 + PGSIZE;
  }
  return 0;
801072bb:	31 c0                	xor    %eax,%eax
}
801072bd:	5b                   	pop    %ebx
801072be:	5e                   	pop    %esi
801072bf:	5f                   	pop    %edi
801072c0:	5d                   	pop    %ebp
801072c1:	c3                   	ret    
