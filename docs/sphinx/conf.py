"""Sphinx configuration for Illumos documentation.

This setup reads the XML produced by Doxygen through the Breathe extension
and renders HTML using the Read the Docs theme.
"""

from __future__ import annotations

import pathlib


def _breathe_xml_dir() -> str:
    """Return the absolute path to the Doxygen XML directory.

    Returns:
        str: Path to ``doxygen/xml`` within the repository.
    """
    return str(pathlib.Path(__file__).resolve().parent.parent / "doxygen" / "xml")


# Basic project information
project = "Illumos"

# Extensions to load by Sphinx
extensions = ["breathe"]

# Breathe configuration
breathe_projects = {"Illumos": _breathe_xml_dir()}
breathe_default_project = "Illumos"

# HTML theme configuration
html_theme = "sphinx_rtd_theme"
