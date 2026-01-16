; ===============================
; BIOS Bootloader (16-bit)
; Loads multi-sector kernel
; ===============================

BITS 16
ORG 0x7C00

; -------------------------------
; Constants
; -------------------------------
KERNEL_OFFSET  equ 0x1000
KERNEL_SECTORS equ 4

start:
    cli                     ; disable interrupts

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax
    mov sp, 0x7C00           ; stack below bootloader

    sti                     ; re-enable interrupts

    mov bx, KERNEL_OFFSET   ; ES:BX = load address
    mov cl, 2               ; kernel starts at sector 2

load_kernel:
    mov ah, 0x02            ; BIOS read sectors
    mov al, 1               ; read 1 sector
    mov ch, 0               ; cylinder 0
    mov dh, 0               ; head 0
    mov dl, 0x00            ; boot disk (floppy)
    int 0x13

    jc disk_error           ; halt if read failed

    add bx, 512             ; next memory location
    inc cl                  ; next disk sector
    dec byte [sector_count]
    jnz load_kernel

    ; jump to kernel
    jmp 0x0000:KERNEL_OFFSET

disk_error:
    jmp disk_error          ; infinite loop on error

sector_count:
    db KERNEL_SECTORS

; -------------------------------
; Boot sector padding & signature
; -------------------------------
times 510-($-$$) db 0
dw 0xAA55
