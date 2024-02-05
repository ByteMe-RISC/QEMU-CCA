#!/usr/bin/bash

qemu-system-aarch64 \
    -machine virt \
    -accel tcg \
    -cpu max \
    -smp 4 \
    -m 8G \
    -drive file=/usr/share/AAVMF/AAVMF_CODE.fd,if=pflash,format=raw,readonly=on \
    -drive file=qemu-aarch64-efivars,if=pflash,format=raw \
    -device virtio-scsi-pci \
    -device virtio-blk,drive=hda,bootindex=1\
    -drive file=debian-aarch64.qcow2,if=none,format=qcow2,media=disk,id=hda \
    -nic user,hostfwd=tcp::2222-:22,model=virtio \
    -serial mon:stdio \
    -display none \
    -nographic \
    -no-reboot
