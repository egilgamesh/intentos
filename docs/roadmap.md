# Development roadmap

These are research stages, not delivery commitments.

## M0 — Repository foundation
- [x] Architecture overview and initial ADR
- [x] Project structure and contribution guidance
- [ ] Select build toolchain and QEMU/UEFI target

## M1 — Bootable x86-64 prototype
- [ ] UEFI loader and kernel handoff
- [ ] Serial logging and panic handling
- [ ] Page tables, memory allocator, interrupts
- [ ] Preemptive threads and IPC
- [ ] Minimal user-space supervisor
- [ ] QEMU smoke test in CI

## M2 — General-purpose foundations
- [ ] Device manager, storage and filesystem
- [ ] Network stack and input
- [ ] Framebuffer compositor and shell
- [ ] Native executable loader and permissions

## M3 — Intent runtime
- [ ] Typed capability contracts and broker
- [ ] Sandboxed AI runtime
- [ ] Auditable workflow state and approvals
- [ ] Adaptive UI schema

## M4 — ARM64 and reference mobile hardware
- [ ] ARM64 kernel port
- [ ] Reference board boot and power management
- [ ] Touch, GPU, audio, wireless
- [ ] Telephony feasibility and device-specific integration

## M5 — Compatibility and hardening
- [ ] App SDK and packaging
- [ ] Compatibility environments
- [ ] Verified updates and recovery
- [ ] Security testing and performance benchmarks
