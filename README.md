# IntentOS

**IntentOS** is an experimental, AI-native, general-purpose operating system for PCs and smartphones.

> Status: architecture and early kernel research. Not bootable yet.

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

See [architecture](docs/architecture/overview.md), [ADR 0001](docs/adr/0001-microkernel.md), and [roadmap](docs/roadmap.md).

## First milestone
Boot a minimal x86-64 kernel in QEMU through UEFI, initialize memory and interrupts, start a user-space supervisor, and print a verified boot message. This repository does **not** yet contain a working kernel.

## Contributing
Read [CONTRIBUTING.md](CONTRIBUTING.md). Security issues should be reported privately; see [SECURITY.md](SECURITY.md).

## License
No open-source license has been selected yet. Public visibility does not grant permission to reuse or redistribute the code.
