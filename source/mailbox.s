/*tst in normales compare umwandeln für eigenartigkeit*/
.globl getbase
GetMailboxBase:
ldr r0,=0x2000B880
mov pc,lr

.globl boxwrite
boxwrite:
tst r0, 0b1111
movne pc, lr
cmp r1, #15
movhi pc, lr
chan .req r1
value .req r2

mov value, r1
push {lr}
bl getbase
box .req r0

wait$:
status .req r3
ldr status, [box, #0x18]
tst status,#0x80000000
.unreq status
bne wait$
 add value,chan
.unreq chan
str value,[box,#0x20]
.unreq value
.unreq box
pop {pc}


.globl boxread
boxread:
cmp r0,#15
movhi pc,lr
chan .req r1
mov chan,r0
push {lr}
bl getbase
box .req R0
rightmail$:
wait2$:
status .req r2
ldr status,[box,#0x18]
tst status,#0x40000000
.unreq status
bne wait2$
mail .req r2
ldr mail,[box,#0]
 inchan .req r3
and inchan,mail,#0b1111
teq inchan,chan
.unreq inchan
bne rightmail$
.unreq box
.unreq chan
and r0,mail,#0xfffffff0
.unreq mail
pop {pc}