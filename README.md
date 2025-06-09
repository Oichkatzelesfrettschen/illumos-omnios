# illumos-omnios

This is the OmniOS fork of the core [illumos](https://illumos.org) source tree.

## Building

In general, and for least surprise, OmniOS must be built on an OmniOS system of
the same version. See the
[build instructions](https://omnios.org/dev/build_instructions) for further
information.

For documentation builds, run `./rootsetup` to install additional tooling such
as Doxygen and Sphinx. Continuous integration environments can invoke
`tools/check_docs.sh` to generate documentation and report warnings.

## Contributing

The OmniOS fork is regularly updated with changes from the upstream
[illumos-gate](https://github.com/illumos/illumos-gate). Contributions to
OmniOS are also welcome via Github pull requests.

## Contact

Contact details for OmniOS can be found on
[our web site](https://omnios.org/about/contact).

## Community

The illumos community is small but active. We welcome everybody who would like
to use the software and participate in the community -- whether you have
decades of experience in systems software, or you're just getting started;
whether you work for a company that uses illumos, or you just find it
personally interesting.

The [Community guide](https://illumos.org/docs/community/) includes details
about Mailing Lists and IRC channels.

## License

This project uses the Common Development and Distribution License (CDDL).
The complete license text is available in
[`usr/src/OPENSOLARIS.LICENSE`](usr/src/OPENSOLARIS.LICENSE).

Most of the existing code is licensed under the
[CDDL](https://illumos.org/license/CDDL) and we expect new code will generally
be under this license as well. Modifications of existing code may not alter
the original license terms. Integrations of code from upstream sources that
use another open source license are generally permissible.

## libc policies

OmniOS maintains its own policies for the standard C library.  All changes to
libc must follow the locking and memory allocation rules documented in
[`usr/src/lib/libc/README`](usr/src/lib/libc/README).

libc code must be written so that it remains async-signal-safe and
fork-safe.  When holding the `l*` locking primitives, any required memory
allocations must use the internal `lmalloc()` or `libc_malloc()` family.

## Hardware variants

Some libraries ship hardware-optimised variants that the runtime linker
chooses based on CPU capabilities.  The i386 libc Makefiles under
[`usr/src/lib/libc/i386_hwcap1`](usr/src/lib/libc/i386_hwcap1/Makefile),
[`i386_hwcap2`](usr/src/lib/libc/i386_hwcap2/Makefile) and
[`i386_hwcap3`](usr/src/lib/libc/i386_hwcap3/Makefile) illustrate this
approach. Further details are provided in
[`docs/hwcap.md`](docs/hwcap.md).


## Exokernel Prototype

A minimal kernel derived from the traditional `uts` sources lives under
`usr/src/exokernel` with supporting subsystems in `usr/src/modules`.
To build the prototype exokernel:

```
cd usr/src/exokernel
make
```

More information about the layout and goals can be found in
[`docs/exokernel/README.md`](docs/exokernel/README.md).
