# Documentation

This repository uses Doxygen to generate API references and Sphinx for prose documentation. Run the following after installing the dependencies listed in `rootsetup`:

```sh
doxygen docs/Doxyfile
```

After Doxygen generates XML output, build the Sphinx documentation:

```sh
cd docs/sphinx
make html
```

The configuration in `docs/sphinx/conf.py` integrates the Breathe extension
and targets the Read the Docs theme for a uniform appearance.
