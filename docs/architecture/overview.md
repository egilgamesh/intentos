# IntentOS architecture v0.1

## Trust boundaries
Firmware -> IntentBoot -> IntentCore -> system supervisor -> isolated services -> applications and AI agents.

Only IntentCore executes in kernel mode. The kernel provides threads, address spaces, scheduling, IPC, interrupt routing, and kernel-enforced capabilities. Drivers, networking, filesystems, graphics, and AI execute in isolated user-space services.

## Core services
- Supervisor: service lifecycle, crash recovery, dependency graph.
- Device manager: discovery, resource grants, driver isolation, IOMMU where supported.
- Storage: encrypted volumes, filesystem service, quotas, A/B updates.
- Network: network stack, firewall, DNS, wireless and mobile-data services.
- Graphics: compositor, display/input service, adaptive UI.
- Capability broker: typed action registry, grants, policy evaluation, audit.
- IntentMind: perception, intent resolution, planning, model routing, task state.
- Compatibility: future Linux/Android environments isolated from native services.

## Safety invariants
1. An LLM never holds unrestricted kernel or device privileges.
2. Data retrieved from documents or websites never becomes authorization.
3. High-impact operations require trusted UI approval and are audited.
4. System services and ordinary apps work offline without AI.
5. Capability grants are scoped, revocable, and default-deny.

## Hardware targets
First: QEMU x86-64 with UEFI. Next: QEMU ARM64 and a documented reference board. Smartphones require device-specific boot, modem, GPU, camera, power, and regulatory support.

## Open questions
- Microkernel ABI and IPC transport
- Verified boot trust roots
- User-space driver model
- Graphics acceleration and compositor protocol
- Package format and signing
- Compatibility boundary and ABI strategy
