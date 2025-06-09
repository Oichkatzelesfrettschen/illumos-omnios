import os
import sys

project = 'Illumos'
extensions = ['breathe']
breathe_projects = {'Illumos': os.path.join(os.path.dirname(__file__), '..', 'doxygen', 'xml')}
breathe_default_project = 'Illumos'
html_theme = 'sphinx_rtd_theme'
