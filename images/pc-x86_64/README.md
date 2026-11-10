# x86-64 bootable developer image

First prototype uses Buildroot's upstream QEMU x86-64 board configuration and a minimal IntentOS root filesystem overlay. It is a **Linux-based boot prototype**, not a complete IntentOS shell or an independently written kernel.

## Prerequisites
Linux build host, git, make, gcc/g++, standard Buildroot host dependencies, and QEMU x86-64. Allow several GB of disk and time for compilation.

## Build
From the repository root:

```sh
./tools/build-qemu-x86_64.sh
```

The script checks out Buildroot 2026.02.1 and builds its QEMU x86-64 image with our rootfs overlay. Buildroot release and board config availability should be verified before relying on this script; if the tag is unavailable, update the pinned version after testing.

## Run
Check `build/buildroot/output/images/` for the generated image and QEMU launch script. On supported Buildroot board configurations:

```sh
cd build/buildroot/output/images
./start-qemu.sh
```

If no launch script is generated, use the QEMU command documented by the chosen Buildroot board configuration.

## Expected result
Linux boots into a minimal console; the IntentOS boot banner appears. This is a foundational smoke test only.
