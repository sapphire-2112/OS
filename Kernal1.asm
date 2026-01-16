BITS 16
ORG 0x1000

global kernel_start
BOOT_INFO_ADDR equ 0x0500

kernel_start:
    cli

    xor ax, ax
    mov ss, ax
    mov sp, 0x9000
    sti

    ; read boot drive passed by bootloader
    mov al, [BOOT_INFO_ADDR]

    mov ah, 0x0E
    mov si, msg

print:
    lodsb
    cmp al, 0
    je hang
    int 0x10
    jmp print

hang:
    jmp hang

msg db "Kernel stack initialized!", 0

times 2048-($-$$) db 0
