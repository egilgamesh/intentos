# ADR 0002: Linux-first, kernel-independent IntentOS platform

Status: Accepted for v1 (2026-11-10)

## Decision
Ship IntentOS v1 as a bootable Linux-based operating system image for x86-64 first, then ARM64. Build a new shell, capability broker, intent runtime, and user-space services. Retain IntentCore as a separate experimental microkernel research track.

## Rationale
Hardware drivers, GPU acceleration, Wi-Fi, battery, suspend/resume, and mobile modem support dominate feasibility. Linux provides a mature base without requiring traditional Linux desktop UX. AI-native semantics belong primarily in user space.

## Boundaries
- IntentMind never runs in kernel mode.
- Core APIs should not expose Linux syscalls directly to applications.
- The platform adapter translates process, storage, device, and security primitives.
- Linux remains an implementation detail, not an app-facing contract.
- Avoid claiming that replacing Linux is a drop-in operation.

## Revisit criteria
Consider an alternative kernel only if measured Linux limitations (security isolation, latency, resource controls, or certification needs) outweigh the driver and ecosystem cost.

## Consequences
Pros: rapid bootable prototypes, broad PC support, practical path to ARM64. Cons: inherited Linux kernel attack surface, GPL obligations, dependence on Linux driver availability, especially on phones.
