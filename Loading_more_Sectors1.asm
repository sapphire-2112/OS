BITS 16
ORG 0x7C00

KERNEL_OFFSET  equ 0x1000
KERNEL_SECTORS equ 4
BOOT_INFO_ADDR equ 0x0500

start:
    cli
    mov [BOOT_INFO_ADDR], dl   ; save BIOS boot drive

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00
    sti

    mov bx, KERNEL_OFFSET
    mov cl, 2                  ; kernel starts at sector 2

load_kernel:
    mov ah, 0x02
    mov al, 1
    mov ch, 0
    mov dh, 0
    mov dl, [BOOT_INFO_ADDR]   ; restore correct drive
    int 0x13

    jc disk_error

    add bx, 512                ; advance memory by 1 sector
    inc cl                     ; next disk sector
    dec byte [sector_count]
    jnz load_kernel

    jmp 0x0000:KERNEL_OFFSET

disk_error:
    jmp disk_error

sector_count:
    db KERNEL_SECTORS

times 510-($-$$) db 0
dw 0xAA55
