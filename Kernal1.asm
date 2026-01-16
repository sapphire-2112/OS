BITS 16
ORG 0x1000

start:
    cli                     ; safety: stop interrupts

    xor ax, ax
    mov ss, ax              ; stack segment = 0
    mov sp, 0x9000          ; stack top

    sti                     ; stack is safe now

    ; ---- Kernel logic ----
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

times 2048-($-$$) db 0      ; match multi-sector load
