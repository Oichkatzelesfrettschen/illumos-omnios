# Documentation

This repository uses Doxygen to build API references and Sphinx for prose manuals.
After installing the dependencies listed in `rootsetup`, generate the XML output:

```sh
doxygen docs/Doxyfile
```

Once Doxygen completes, build the HTML documentation via Sphinx:

```sh
cd docs/sphinx
make html
```

The configuration in `docs/sphinx/conf.py` integrates the Breathe extension and
selects the Read the Docs theme for a uniform appearance.
