;My First BootLoader

BITS 16

ORG 0x7C00

start:

mov ah, 0x0E
mov al, 'P'
int 0x10
mov al, 'a'
int 0x10
mov al, 'r'
int 0x10
mov al , 'k'
int 0x10
mov al ,'h'
int 0x10
mov al, 'i'
int 0x10
hang : 
 jmp hang

times 510-($-$$) db 0

dw 0xAA55
