# Platform abstraction

The system abstraction boundary keeps IntentOS user-space contracts independent of a particular kernel. Initial backend: Linux. Experimental backend: IntentCore. Kernel interchangeability is a design goal, not an existing feature.

Core contracts should cover process lifecycle, resource budgets, device handles, IPC, file access, and permission grants. Avoid leaking Linux-specific types into application SDKs.
