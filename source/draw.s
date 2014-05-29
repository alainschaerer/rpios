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

.globl drawpixel
drawpixel:
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

