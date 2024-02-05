#!/usr/bin/bash

# Get Debian netinstall image
wget https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.4.0-arm64-netinst.iso

# Create storage drive
qemu-img create -f qcow2 debian-aarch64.qcow2 4G

# Copy UEFI variables from edk2-aarch64
cp /usr/share/AAVMF/AAVMF_VARS.fd ./qemu-aarch64-efivars

qemu-system-aarch64 \
    -machine virt \
    -accel tcg \
    -cpu max \
    -smp 4 \
    -m 8G \
    -drive file=/usr/share/AAVMF/AAVMF_CODE.fd,if=pflash,format=raw,readonly=on \
    -drive file=qemu-aarch64-efivars,if=pflash,format=raw \
    -device virtio-scsi-pci \
    -device scsi-cd,drive=cdrom,bootindex=0 \
    -drive file=debian-12.4.0-arm64-netinst.iso,if=none,format=raw,readonly=on,media=cdrom,id=cdrom \
    -device virtio-blk,drive=hda,bootindex=1\
    -drive file=debian-aarch64.qcow2,if=none,format=qcow2,media=disk,id=hda \
    -nic user,hostfwd=tcp::2222-:22,model=virtio \
    -nographic \
    -no-reboot
