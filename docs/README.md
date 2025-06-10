# Documentation

This repository uses Doxygen to build API references and Sphinx for prose manuals.
After installing the dependencies via `./setup.sh`, generate the XML output:

```sh
doxygen docs/Doxyfile
```

Once Doxygen completes, build the HTML documentation via Sphinx:

The repository also provides a helper script that runs Doxygen and
reports any warnings while quantifying documentation coverage. Execute:

```sh
tools/check_docs.sh
```

After Doxygen generates XML output, build the Sphinx documentation:


```sh
cd docs/sphinx
make html
```

The configuration in `docs/sphinx/conf.py` integrates the Breathe extension and
selects the Read the Docs theme for a uniform appearance.
