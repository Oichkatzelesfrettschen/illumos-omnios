Coding Conventions
------------------
- All modified files must use modern idiomatic style and be fully commented for Doxygen.
- Decompose, unroll, flatten, and factor logic where practical during edits.
- Document purpose, parameters, returns, and globals for each function using `///` or `/** */`.
- Ensure build scripts list dependencies for Doxygen, Sphinx, Breathe, CLOC, qemu, and tmux.
- Always modernize and refactor any code touched, flattening control structures where reasonable and applying mathematically guided simplifications.
- Sphinx documentation must use the Read the Docs theme and integrate Breathe so that Doxygen XML is consumed by Sphinx automatically.
