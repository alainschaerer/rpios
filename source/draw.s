.section .data
.align 1
forecolor:
.hword 0xFFFF

.align 2
gaddress
.int 0

.section .text

.globl setforecolor
setforecolor:
cmp r0, #0x10000
movhs pc, lr
ldr r1, =forecolor
str r0, [r1]
mov pc, lr

.globl setgaddress
setgaddress:
ldr r1, =gaddress
str r0, [r1]
mov pc, lr

.globl dpixel
dpixel
xcord .req r0
ycord .req r1
ldr r2, =gaddress
addr .req r2
width .req r3
height .req r4
ldr width, [addr, #0]
ldr height, [addr, #4]
cmp xcord,  sub width, #1
movhi pc, lr
cmp ycord, sub height, #1
movhi pc, lr
add width, #1
add height, #1

mla xcord,ycord,width,xcord
.unreq width
.unreq ycord
add addr, xcord,lsl #1
.unreq xcord

fcolor .req r3
ldr fcolor,=forecolor
ldrh fcolor,[fcolor]


strh fcolor,[addr]
.unreq fcolor
.unreq addr
mov pc,lr

/*
if x1 > x0 then

set deltax to x1 - x0
set stepx to +1

otherwise

set deltax to x0 - x1
set stepx to -1

end if

set error to deltax - deltay
until x0 = x1 + stepx or y0 = y1 + stepy

setPixel(x0, y0)
if error × 2 ≥ -deltay then

set x0 to x0 + stepx
set error to error - deltay

end if
if error × 2 ≤ deltax then

set y0 to y0 + stepy
set error to error + deltax

end if

repeat
*/
.globl dline
dline:
push {r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
x0 .req r9
x1 .req r10
y0 .req r11
y1 .req r12

mov x0,r0
mov x1,r2
mov y0,r1
mov y1,r3

deltax .req r4
deltay .req r5 
stepx .req r6
stepy .req r7
error .req r8

cmp x0, x1
subhi deltax, x0, x1
movhi stepx, #-1

sub error, deltax, deltay
loop$:
add r0, x1, stepx
add r1, y1, stepy
cmp x0, r0
popeq {r4,r5,r6,r7,r8,r9,r10,r11,r12,pc}
cmp y0, r1
popeq {r4,r5,r6,r7,r8,r9,r10,r11,r12,pc}

mov r0, x0
mov r1, y0
bl dpixel
error2 .req r0
lsl error2, error, #1
cmp deltay, error2
addle x0, stepx
suble error, deltay

cmp deltax, error2
addle y0, stepy
suble error, deltax

b loop$

.unreq error2
.unreq x0
.unreq y0
.unreq x1
.unreq y1
.unreq deltax
.unreq stepx
.unreq deltay
.unreq deltax
.unreq error










