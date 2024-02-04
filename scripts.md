# Scripts

## Pre-requisites

### Fedora

- wget
- qemu-system-aarch64
- edk2-aarch64

## Get Debian image

### ISO

```bash
wget http://ftp.debian.org/debian/dists/stable/main/installer-arm64/current/images/netboot/mini.iso
```

### initramfs

```bash
wget http://ftp.debian.org/debian/dists/stable/main/installer-arm64/current/images/netboot/debian-installer/arm64/initrd.gz
```

### Linux kernel

```bash
wget http://ftp.debian.org/debian/dists/stable/main/installer-arm64/current/images/netboot/debian-installer/arm64/linux
```

## Disk creation

```bash
qemu-img create -f qcow2 debian-arm.sda.qcow2 2G
```

## QEMU launch

```bash
qemu-system-aarch64 -name Debian-qemu-aarch64 -M virt,virtualization=on,secure=on,gic-version=max -cpu max,x-rme=on -accel tcg -smp 2 -m 2G -bios /usr/share/edk2/aarch64/QEMU_EFI.fd -kernel linux -initrd initrd.gz -drive file=mini.iso,format=raw,index=0,media=cdrom,if=virtio -drive file=debian-arm.sda.qcow2,format=qcow2,index=1,media=disk,if=virtio -device virtio-net-device,netdev=net0 -netdev user,id=net0 -nographic
```

### UEFI

See: https://packages.fedoraproject.org/pkgs/edk2/edk2-aarch64/
