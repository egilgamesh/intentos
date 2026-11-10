# IntentOS

**IntentOS** is an experimental, AI-native, general-purpose operating system for PCs and smartphones.

> Status: experimental Linux-based boot prototype with kernel/initramfs and GRUB ISO build paths. End-to-end QEMU boot verification is still pending.

## Principles
- The OS works without AI; AI is a user-space system service.
- Capability-based security, least privilege, and explicit approvals.
- One platform across x86-64 and ARM64.
- Native apps, web apps, and eventually isolated compatibility environments.
- Adaptive interfaces for touch, voice, keyboard, and mouse.
- Local-first personal context and auditable agent execution.

## Architecture
- **IntentCore** — proposed Rust microkernel: scheduling, address spaces, IPC, capabilities, interrupts.
- **IntentBoot** — platform-specific boot and measured/verified startup.
- **IntentHAL** — device discovery and isolated drivers.
- **IntentRuntime** — native application ABI, capability broker, sandboxed workloads.
- **IntentMind** — unprivileged AI inference, planning, and workflow execution.
- **IntentUI** — adaptive compositor and shell.

See [architecture](docs/architecture/overview.md), [ADR 0002: Linux first](docs/adr/0002-linux-first.md), [ADR 0001: microkernel research](docs/adr/0001-microkernel.md), and [roadmap](docs/roadmap.md).

## First milestone: IntentOS 0.1 boot prototype
IntentOS v1 uses an existing Linux kernel and our own minimal PID 1. This is a bootable-image prototype, not a newly written kernel, and is not yet a released OS.

On a supported Linux build host:

```sh
bash tools/build-bootable-prototype.sh
bash tools/run-qemu-x86_64.sh
# To package an ISO (requires grub-mkrescue and xorriso):
bash tools/build-iso.sh
```

See [boot guide](docs/boot.md) and [release gates](docs/releases/0.1.0.md).

## Contributing
Read [CONTRIBUTING.md](CONTRIBUTING.md). Security issues should be reported privately; see [SECURITY.md](SECURITY.md).

## License
No open-source license has been selected yet. Public visibility does not grant permission to reuse or redistribute the code.
