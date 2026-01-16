;Writitng code to be comfortable with loops

BITS 16
ORG 0x7C00

start:
mov ah , 0x0E
mov si , mess

print_loop:
lodsb
cmp al,0
je hang
int 0x10
jmp print_loop
hang:
jmp hang

mess:
db 'P' , 'a' ,'r','k' ,'h','i ','h','i' ,0

times 510-($-$$) db 0
dw 0xAA55
