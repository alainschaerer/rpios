.globl getgpioaddress
getgpioaddress:
ldr r0,=0x20200000
mov pc,lr

.globl setgpiofunc
setgpiofunc:
pinnum .req r0
pinfunc .req r1
cmp pinnum,#53
cmpls pinfunc,#7
movhi pc,lr

push {lr}
mov r2,pinnum /* r0 = pinnumber |r2 = pin number*/
.unreq pinnum
pinnum .req r2
bl getgpioaddress /* r0 = gpio controller address*/
gpioaddr .req r0

 functionLoop$:

cmp pinnum,#9
subhi pinnum,#10
addhi gpioaddr,#4
bhi functionLoop$

/* r2 = Pin Nummer/10 Also die wievielte Sektion von 10 pins (= 4 bytes)*/
/*r2 = 5 | r0 = 16 */
/*r1 = 6*/
add pinnum, pinnum,lsl #1 /*r2 * 3 = r2 * 2 + r 2 | lsl weil wenn 1 mal nach links kommt das doppelte raus*/
/*r2 = 15*/
lsl pinfunc,pinnum /*"16tes und 17tes" bit setzen für die richtigen funktionen*/


	mask .req r3
	mov mask,#7	
	lsl mask,pinnum	
	.unreq pinnum

	mvn mask,mask			
	oldfunc .req r2
	ldr oldfunc,[gpioaddr]		
	and oldfunc,mask			
	.unreq mask

	orr pinfunc,oldfunc			
	.unreq oldfunc

str pinfunc,[gpioaddr]
.unreq pinfunc
.unreq gpioaddr
pop {pc}


.globl setgpio
setgpio:
pinnum .req r0
pinval .req r1

cmp pinnum, #53
movhi pc, lr
push {lr}
mov r2, pinnum
.unreq pinnum
pinnum .req r2
bl getgpioaddress
/*"The GPIO controller has two sets of 4 bytes each for turning pins on and off""The first controlls the first 32 bits and the second the other 22 pins"*/

gpioaddr .req r0
pinbank .req r3
lsr pinbank,pinnum,#5
lsl pinbank,#2
add gpioaddr,pinbank
.unreq pinbank

and pinnum,#31 /*Rest weil wir nicht eine volle Division oben gemacht haben brauchen wir den noch. Wir haben erst ob es im ersten oder zweitem Sektor ist*/
setbit .req r3
mov setbit,#1 
lsl setbit,pinnum /*Wir setzen das bit soweit nach links, wie der Rest ist um das richtige bit zu setzen*/
.unreq pinnum

teq pinval,#0 /*test equal pinval = an oder aus*/
.unreq pinval
streq setbit,[gpioaddr,#40]
strne setbit,[gpioaddr,#28]
.unreq setbit
.unreq gpioaddr
pop {pc}


