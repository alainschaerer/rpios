.section .data


.globl device
device:
.int 0
.int 0
.int 0
.int 0


.align 4
.globl mousecounts
mousecount:
.int mousecount 0

.globl mouseaddresses
mouseaddresses:
.int 0
.int 0
.int 0
.int 0


.globl mousedevice
mousedevice:
.int 0
.int 0
.int 0
.int 0



.section .text
.globl getmousecount
getcount:
ldr r0, =mousecount
mov pc, lr
.globl getx
getx:$
push {r0, r1, r2, lr}
bl index
mousenum .req r1
mov mousenum, r0
pop {r0}
cmp mousenum, #0
moveq r0, #0
popeq {r0, r1, r2, pc}
ldr r2, =mousedevice
str r0, [r2, #1]
pop {r0, r1, r2, pc}
 .globl gety
getx:$
push {r0, r1, r2, lr}
bl index
mousenum .req r1
mov mousenum, r0
pop {r0}
cmp mousenum, #0
moveq r0, #0
popeq {r0, r1, r2, pc}
ldr r2, =mousedevice
str r0, [r2, #2]
pop {r0, r1, r2, pc}


.globl getaddress
getaddress:
index .req r0
cmp index, #4
movhi r0, #0
movhi pc, lr
push {r1, r2, r3, r4, r5, r6, lr}
row .req r1
addresses .req r2
ldr addresses, =mouseaddresses$
str r3, [addresses, #0]
str r4, [addresses, #4]
str r5, [addresses, #8]
str r6, [addresses, #12]
for$:
cmp index, #0
movhs r0, #0
pophs{r1, r2, r3, r4, r5, r6, pc}
cmp row, #4
movlo r0, #0
poplo{r1, r2, r3, r4, r5, r6, pc}
add row, #1
sub index, #1
cmp index, #0
cmpeq row, #1
moveq r0, r3
popeq{r1, r2, r3, r4, r5, r6, pc}
cmp index, #0
cmpeq row, #2
moveq r0, r4
popeq{r1, r2, r3, r4, r5, r6, pc}
cmp index, #0
cmpeq row, #3
moveq r0, r5
popeq{r1, r2, r3, r4, r5, r6, pc}
cmp index, #0
cmpeq row, #4
moveq r0, r6
popeq{r1, r2, r3, r4, r5, r6, pc}
b for$
.unreq inedx
.unreq row
.unreq addresses
mov r0, #0
pop{r1, r2, r3, r4, r5, r6, pc}
.globl getwheel
getwheel:
push {r0, r1, r2, lr}
bl index
mousenum .req r1
mov mousenum, r0
pop {r0}
cmp mousenum, #0
moveq r0, #0
popeq {r0, r1, r2, pc}
ldr r2, =mousedevice
str r0, [r2, #3]
pop {r0, r1, r2, pc}



.globl index
index:
address .req r0
push{r1, r2, r3, r4, r5 r6, r7, lr}
row .req r1
addresses .req r2
ldr addresses, =mouseaddresses$
str r3, [addresses, #0]
str r4, [addresses, #4]
str r5, [addresses, #8]
str r6, [addresses, #12]
count .req r7
for$:
ldr r7, =mousecount
cmp row, count
poplo {r1, r2, r3, r4, r5 r6, r7, pc}
cmp row, #1
cmpeq r3, address
moveq r0, row
popeq{r1, r2, r3, r4, r5, r6, pc}
cmp row, #2
cmpeq r4, address
moveq r0, row
popeq{r1, r2, r3, r4, r5, r6, pc}
cmp row, #3
cmpeq r5, address
moveq r0, row
popeq{r1, r2, r3, r4, r5, r6, pc}
cmp row, #4
cmpeq r6, address
moveq r0, row
popeq{r1, r2, r3, r4, r5, r6, pc}
b for$
mov r0, #0
.unreq row
.unreq addresses
.unreq address
pop{r1, r2, r3, r4, r5, r6, pc}

.globl poll /*0=disconnected*/
poll:
push {r0, r1, r2, lr}
bl index
mousenum .req r1
mov mousenum, r0
pop {r0}
cmp mousenum, #0
moveq r0, #0
popeq {r1, r2, pc}
.globl mousegtkeydoqncnt
mousegtkeydoqncnt:
push {r0, r1,r2,lr}
bl index
mousenum .req r1
mov mousenum, r0
pop {r0}
cmp mousenum, #0
moveq r0, #0

ldr r2, =device
str r0 [r2, #4]
pop {r1, r2, pc}
.globl mousegtkeyisdwn
mousegtkeyisdwn:
push {r0, r1,r2,lr}
bl index
mousenum .req r1
mov mousenum, r0
pop {r0}
cmp mousenum, #0
moveq r0, #0

ldr r2, =device
str r0 [r2, #3]
pop {r1, r2, pc}

.globl mousegtkeydwn
mousegtkeyisdwn:

push {r0, r1
