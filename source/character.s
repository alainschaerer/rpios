
.section .data
.align 4
font:
.incbin "monospace.bin"
/*safe that bitches lol*/
push {r4, r5, r6, r7, r8 , lr}
ycord .req r2
xcord .req r1
char .req r3
cmp char, #127
pophi {r4, r5 , r6, r7, r8, pc}
movhi pc, lr
charaddr .req r4
ldr charaddr, =font
add charaddr, char, lsl #4
row .req r5
bits .req r6
mov row, #15
bit .req r7
loop$:
ldrb bits, [charaddr]
mov bit, #8
loop2$:
lsl bits, #1
sub bit, #1
tst bits, #256

addeq r8, xcord, bit

push {xcord}
mov r1, r8
bleq dpixel
pop {xcord}
cmp bit, #0
bne loop2$
/*new line: */
end$:
add ycord, #1
add charaddr, #1
tst charaddr, #0b1111
bne loop$
.unreq xcord
.unreq ycord
.unreq charaddr
.unreq bit
.unreq bits
mov r0, #8
mov r1, #16
pop {r4, r5, r6, r7, r8, pc}

/*
ALGORITHM 
 function drawCharacter(r0 is character, r1 is x, r2 is y)

if character > 127 then exit
set charAddress to font + character << 4
loop

set bits to readByte(charAddress)
set bit to 8
loop

set bits to bits << 1
set bit to bit - 1
if test(bits, 0x100)
then setPixel(x + bit, y)

until bit = 0
set y to y + 1
set chadAddress to chadAddress + 1

until charAddress AND 0b1111 = 0
return r0 = 8, r1 = 16

end function
*/