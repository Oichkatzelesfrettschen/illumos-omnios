# x86 Hardware Capability Libraries

OmniOS provides hardware-optimised variants of certain libraries. On x86 these
variants live alongside the generic version and are selected by the runtime
linker based on the processor's instruction set support.

## Instruction Set Variants

The libc makefiles define three hardware capability libraries for i386. The
capabilities recorded in each `mapfile` describe the required CPU features.

### hwcap1
* Mapfile capability: `hw += fpu cmov sep mmx sse`
* Build flags: `-D_CMOV_INSN -D_SSE_INSN -D_MMX_INSN -D_SEP_INSN`
* Uses the `sysenter` instruction for system calls and optimised SSE routines.

### hwcap2
* Mapfile capability: `hw += fpu cmov amd_sysc mmx sse sse2`
* Build flags: `-D_CMOV_INSN -D_SSE_INSN -D_SSE2_INSN -D_MMX_INSN -D_SYSC_INSN`
* Switches to the `syscall` instruction and enables SSE2 implementations.

### hwcap3
* Mapfile capability: `hw += fpu cmov mmx sse`
* Build flags: `-D_CMOV_INSN -D_SSE_INSN -D_MMX_INSN`
* Falls back to the legacy `int 0x91` system-call entry sequence.

## Runtime Detection

During startup the kernel places hardware capability bits into the process
auxiliary vector (`AT_SUN_HWCAP`, `AT_SUN_HWCAP2` and `AT_SUN_HWCAP3`).  The
[`getisax()`](../usr/src/lib/libc/port/gen/getisax.c) function reads these
values and returns the supported instruction set flags.

The runtime linker compares these bits with the capabilities recorded in each
library. When a library has multiple hardware specific versions, the linker
chooses the best match for the running CPU.  For example, on a processor with
`syscall` and SSE2 support the linker will load `libc_hwcap2.so.1` instead of
`libc.so.1`.
