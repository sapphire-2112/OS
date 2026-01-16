;Now i am writing bootloader code to load kernal 
;Step 1 is as normal just the BIOS will jump to bootloader

BITS 16
ORG 0x7C00

Hello:   
cli           ;cli is used to stop interrupts  because we will modify the stack 
xor ax,ax
mov ds,ax
mov es,ax
mov ss,ax     ;initializing segment registers

mov sp,0x7C00

sti  ;re-enable interuppts.

mov bx , 0x1000 ;  kernal's physical memory
mov ah , 0x02
mov al ,1
mov cl , 2
mov dh ,0
mov dl, 0x00
int 0x13

jc disk_error

jmp 0x0000:0x1000
disk_error:
	jmp disk_error

times 510-($-$$) db 0
dw 0xAA55 
