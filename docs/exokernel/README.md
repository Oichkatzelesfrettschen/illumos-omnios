# Exokernel Overview

This repository experiments with running as little code in the kernel as possible.  Kernel services are factored out into user-space components so that most of the traditional subsystems live outside of the kernel proper.  Only the minimal core needed to multiplex hardware and provide protection remains in the kernel.

## Directory Layout

```
exokernel/  - user-space implementations of kernel subsystems
modules/    - supporting libraries and daemons used by exokernel components
```

The `exokernel/` tree contains replacements for portions of the kernel that can run in user land.  New functionality should be added here instead of in the traditional kernel source.  The `modules/` directory collects reusable pieces that multiple exokernel components depend on.

## Migrating Kernel Subsystems

When moving code from the kernel into user space, keep the following in mind:

* Follow the locking and memory allocation rules described in [`usr/src/lib/libc/README`](../../usr/src/lib/libc/README).  User-space replacements must remain MT-safe, fork-safe and, where possible, async-signal-safe.  Use `lmutex_lock()`/`lrw_*()` and the `lmalloc`/`libc_malloc` families when locks are held.
* Replace direct calls into kernel facilities with IPC interfaces or library abstractions located under `modules/`.
* Keep each subsystem independent.  Services that must communicate should do so using stable, versioned interfaces.

The long term goal is for most existing kernel facilities to be hosted from the `exokernel/` tree while the kernel itself is reduced to process management and hardware multiplexing.
