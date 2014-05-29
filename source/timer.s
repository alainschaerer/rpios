.globl gettimerbase
gettimerbase:
ldr r0, =0x20003000
mov pc, lr

.globl gettimestamp
gettimestamp:
push {lr}
bl gettimerbase
ldrd r0, r1, [r0, #4]
pop {pc}

.globl wait
wait:
timetowait .req r2
mov timetowait, r0
push {lr}
bl gettimestamp
start .req r3
mov start, r0

loop$:
bl gettimestamp
buffer .req r1
sub buffer, r0, start
cmp buffer, timetowait
.unreq buffer
bls loop$

.unreq timetowait
.unreq start

pop {pc}
