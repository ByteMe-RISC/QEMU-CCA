# Scripts

## Pre-requisites

### Fedora

- wget
- qemu
- qemu-system-aarch64
- edk2-aarch64

## Get Debian image

### ISO

```bash
wget https://cdimage.debian.org/debian-cd/current/arm64/iso-cd/debian-12.4.0-arm64-netinst.iso
```

## Disk creation

```bash
qemu-img create -f qcow2 debian-arm.sda.qcow2 2G
```

## UEFI launch

```bash
qemu-system-aarch64 \
    -machine virt \
    -accel tcg \
    -cpu max \
    -smp 4 \
    -m 8G \
    -drive file=/usr/share/AAVMF/AAVMF_CODE.fd,if=pflash,format=raw,readonly=on \
    -drive file=qemu-aarch64-efivars,if=pflash,format=raw \
    -serial mon:stdio \
    -display none \
    -nographic \
    -no-reboot
```

## Debian install launch

```bash
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
```

## Debian launch

```bash
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
```

### UEFI

See: https://packages.fedoraproject.org/pkgs/edk2/edk2-aarch64/
