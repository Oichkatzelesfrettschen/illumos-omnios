# Metrics and Benchmarking

This document explains how to gather cyclomatic complexity information using
`pmccabe` and `lizard` as well as how to measure the performance impact of
different runtime linker configurations.  The examples assume you are running on
an OmniOS system with the repository checked out under `/workspace/illumos-omnios`.

## Cyclomatic Complexity with `pmccabe`

`pmccabe` is available in the standard build tools.  To collect metrics across
a subsystem, run something like:

```bash
cd /workspace/illumos-omnios/usr/src
find lib -name '*.c' | xargs pmccabe > /tmp/lib_pmccabe.txt
```

The output lists each function with its complexity score.  Sort or graph the
results as needed to track changes over time.

## Cyclomatic Complexity with `lizard`

`lizard` is a third-party tool that provides similar metrics and supports
multiple languages.  If it is installed in your `PATH`, you can run:

```bash
cd /workspace/illumos-omnios/usr/src
lizard lib > /tmp/lib_lizard.txt
```

Both tools can be incorporated into continuous integration jobs to watch for
regressions in complexity.

## Benchmarking Direct Binding vs. PLT Resolution

The existing `usr/src/test` framework can be used for performance experiments.
Create a new test under `usr/src/test/libc-tests` that builds a small benchmark
binary twice: once with direct binding enabled and once using the traditional
Procedure Linkage Table (PLT) mechanism.  Use the `run` script to execute the
binary in a tight loop under `time(1)` or `dtrace` and record the elapsed time
and CPU usage.

A simple approach is:

```bash
cd usr/src/test/libc-tests
./runtest.sh -c direct_binding
./runtest.sh -c plt
```

Where `runtest.sh` is your wrapper that compiles and times the benchmark.

## Expected Performance Impact

Direct binding avoids the indirection through the PLT on every function call,
so calls into shared libraries resolve directly to the target address after the
initial relocation pass.  This typically improves call performance by a few
percent, especially in hot code paths that make frequent library calls.  The
trade‑off is reduced flexibility for interposition and potentially larger
binaries if more relocations are emitted.  Measure with your workload to decide
whether the benefits outweigh the costs.
