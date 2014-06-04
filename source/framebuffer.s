.section .data
.align 4
.globl fbufferinfo
fbufferinfo:
.int 1024 /* #0 breite des bildschirms */
.int 768 /* #4 höhe des bildschirms */
.int 1024 /* #8 breite des bildes */
.int 768 /* #12 höhe des bildes */
.int 0 /* #16 pitch */
.int 16 /* #20 high color */
.int 0 /* #24 X */
.int 0 /* #28 Y */
.int 0
.int 0 



.section .text
.globl InitialiseFrameBuffer
InitialiseFrameBuffer:
width .req r0
height .req r1
pitch .req r2
cmp width,#4096
cmpls height,#4096
cmpls pitch,#32
result .req r0
movhi result,#0
movhi pc,lr

info .req r4
push {r4,lr}
ldr info,=fbufferinfo
str width,[r4,#0]
str height,[r4,#4]
str width,[r4,#8]
str height,[r4,#12]
str pitch,[r4,#20]
.unreq width
.unreq height
.unreq pitch

mov r0,info
add r0,#0x40000000
mov r1,#1
bl boxwrite

 mov r0,#1
bl boxread

teq result,#0
movne result,#0
popne {r4,pc}

mov result,info
pop {r4,pc}
.unreq result
.unreq info