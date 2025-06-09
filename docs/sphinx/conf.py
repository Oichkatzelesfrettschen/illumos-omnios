import os
import sys

sys.path.insert(0, os.path.abspath('..'))

project = 'Illumos'
extensions = ['breathe']

breathe_projects = {
    'Illumos': os.path.join(os.path.dirname(__file__), '..', 'doxygen', 'xml')
}

breathe_default_project = 'Illumos'
html_theme = 'sphinx_rtd_theme'
