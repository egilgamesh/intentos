# x86-64 bootable developer image

First prototype uses Buildroot's upstream QEMU x86-64 configuration and a minimal IntentOS root filesystem overlay. This is a **Linux-based boot prototype**, not a complete IntentOS shell or new kernel.

## Prerequisites
Linux build host, git, make, gcc/g++, standard Buildroot dependencies, and QEMU x86-64. Allow several GB of disk and compilation time.

## Build
From the repository root:

```sh
bash tools/build-qemu-x86_64.sh
```

The script currently pins Buildroot 2025.02.8; the pin and Buildroot board compatibility must be validated in CI before treating this as reproducible.

## Run
Check `build/buildroot/output/images/` for the generated images and launch script:

```sh
cd build/buildroot/output/images
./start-qemu.sh
```

If a launch script is not generated, use the QEMU command from the selected Buildroot board configuration.

## Expected result
A minimal Linux console with the IntentOS developer-preview boot banner. The build has not yet been executed or verified by CI.
