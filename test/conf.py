# -*- coding: utf-8 -*-
import sys
import os
import shlex
import datetime
import time
import json
import sphinx_typlog_theme
html_theme_path = [sphinx_typlog_theme.get_path()]
html_theme = 'sphinx_typlog_theme'
html_theme_options = {
        'color': '#E8371A',
        'logo': 'linux.svg',
        'logo_name': 'tux',
        'description': 'Your project description'
        }


thisfile = os.path.abspath(__file__)
thisdir = os.path.dirname(thisfile)
projectdir = os.path.dirname(thisdir)
extensions = list()
extensions.append('sphinx.ext.autodoc')
extensions.append('sphinx.ext.todo')
templates_path = ['book_templates']
source_suffix = '.rst'
master_doc = 'index'
project = u'foobar'
copyright = u'2017, John van Zantvoort'
author = u'John van Zantvoort'
version = '0.1'
release = '1'
language = 'en'
today_fmt = '%B %d, %Y'
exclude_patterns = []
pygments_style = 'sphinx'
todo_include_todos = True
html_title = "van Zantvoort"
html_static_path = ['_static']
html_extra_path = ['book_extra']
html_sidebars = {
    '**': [
        'logo.html',
        'localtoc.html',
        'globaltoc.html',
        'searchbox.html',
    ]
}

html_show_sourcelink = True
show_source = True
htmlhelp_basename = 'bookdoc'
latex_elements = {
}
latex_documents = [
  (master_doc, 'book.tex', u'foobar(.org) Documentation',
   u'John van Zantvoort', 'manual'),
]
man_pages = [
    (master_doc, 'book', u'foobar(.org) Documentation',
     [author], 1)
]
texinfo_documents = [
  (master_doc, 'book', u'foobar(.org) Documentation',
   author, 'book', 'One line description of project.',
   'Miscellaneous'),
]
html_context = {}
