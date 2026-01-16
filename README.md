# x86 BIOS Bootloader & Kernel (Learning Project)

This repository contains a simple 16-bit x86 BIOS bootloader
and a minimal kernel written in assembly.

## What this project does
- Boots using BIOS (real mode)
- Loads a kernel from disk (single-sector & multi-sector)
- Uses BIOS int 0x13 for disk I/O
- Transfers control from bootloader to kernel
- Kernel initializes its own stack

## Memory layout
- Bootloader: 0x7C00
- Kernel:     0x1000
- Stack:      0x9000

## Build & Run
```bash
nasm -f bin bootload.asm -o bootload.bin
nasm -f bin kernal.asm -o kernal.bin
cat bootload.bin kernel.bin > os.bin
qemu-system-x86_64 -fda os.bin
