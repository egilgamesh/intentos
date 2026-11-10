# ADR 0001: Capability-based microkernel

Status: Proposed

## Context
IntentOS aims to isolate hardware drivers, native apps, and autonomous AI workloads. A monolithic kernel offers driver compatibility but expands the privileged trusted computing base.

## Decision
Research a small Rust-based capability microkernel. Kernel responsibilities: scheduling, memory mapping, IPC, interrupt delivery, and capability enforcement. Keep AI and drivers in user space.

## Consequences
Benefits: narrow privilege boundaries, service restartability, explicit resource grants. Costs: driver porting, IPC overhead, platform bring-up, compatibility complexity, and substantial verification work.

## Alternatives
Linux-based system with hardened isolation; seL4-based architecture; hybrid kernel. Re-evaluate after performance and driver feasibility prototypes.

## Non-goals
This ADR does not claim formal verification or production-grade security.
