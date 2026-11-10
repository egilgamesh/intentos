# Booting IntentOS 0.1

IntentOS 0.1 is an experimental Linux-kernel-based boot prototype, not a newly implemented kernel.

## Build on Ubuntu
Install GCC, static glibc development files, cpio, QEMU, GRUB ISO tools and xorriso. Then:

```sh
bash tools/build-bootable-prototype.sh
bash tools/run-qemu-x86_64.sh
```

## Produce a bootable ISO
```sh
bash tools/build-iso.sh
qemu-system-x86_64 -m 512M -cdrom build/bootable/intentos-0.1-x86_64.iso -boot d -serial mon:stdio -display none
```

The ISO uses GRUB to boot the Linux kernel and IntentOS initramfs. It is not a graphical desktop. QEMU direct-kernel boot and ISO boot are separate test paths.

## Expected serial console
```text
INTENTOS_BOOT_OK
IntentOS 0.1 - bootable Linux kernel developer preview
intentos> status
IntentOS kernel running; IntentMind not installed
```

## Limitations
The system is ephemeral and runs entirely from RAM. No persistent storage, verified boot, authentication, networking, GPU acceleration, or telephony. Do not install on physical machines or rely on it for security.
