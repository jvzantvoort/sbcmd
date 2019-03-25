
.. index:: simple;index

.. _a link: https://domain.invalid/

Foo Bar Design
==============

subsections
-----------

subsubsections
^^^^^^^^^^^^^^

paragraphs
""""""""""

theme: **bootstrap**

Example *emphasis*.

Example **strong emphasis**

Example ``code example``

* This is a bulleted list.
* It has two items, the second
  item uses two lines.

1. This is a numbered list.
2. It has two items too.

#. This is a numbered list.
#. It has two items too.

* this is
* a list

  * with a nested list
  * and some subitems

* and here the parent list continues

.. todo:: lala

term (up to a line of text)
   Definition of the term, which must be indented

   and can even consist of multiple paragraphs

next term
   Description.


| These lines are
| broken exactly like in
| the source file.

This is a normal text paragraph. The next paragraph is a code sample::

   It is not processed in any way, except
   that the indentation is removed.

   It can span multiple lines.

This is a normal text paragraph again.

+------------------------+------------+----------+----------+
| Header row, column 1   | Header 2   | Header 3 | Header 4 |
| (header rows optional) |            |          |          |
+========================+============+==========+==========+
| body row 1, column 1   | column 2   | column 3 | column 4 |
+------------------------+------------+----------+----------+
| body row 2             | ...        | ...      |          |
+------------------------+------------+----------+----------+

This is a paragraph that contains `a link`_.



.. math::

    n_{\mathrm{offset}} = \sum_{k=0}^{N-1} s_k n_k

Headings
--------

.. raw:: html

   <h1>H1: Lorem ipsum dolor sit amet</h1>

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

.. raw:: html

   <h2>H2: Lorem ipsum dolor sit amet</h2>

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

.. raw:: html

   <h3>H3: Lorem ipsum dolor sit amet</h3>

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

.. raw:: html

   <h4>H4: Lorem ipsum dolor sit amet</h4>

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

.. raw:: html

   <h5>H5: Lorem ipsum dolor sit amet</h5>

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.

.. raw:: html

   <h6>H6: Lorem ipsum dolor sit amet</h6>

Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.


.. index::
   single: Paragraphs

Paragraphs
----------

Duis **aute irure dolor** in `reprehenderit` in voluptate velit esse cillum
dolore eu fugiat nulla pariatur.  Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.

`Lorem ipsum`_ dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua.  Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat.  Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur.  Excepteur sint occaecat `cupidatat`_
non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.



.. _footnotes:

Footnotes
---------

.. target-notes::

.. _Lorem ipsum: http://www.google.com
.. _`cupidatat`: http://docutils.sourceforge.net/rst.html


.. index::
   single: Tables

Tables
------

+----------------------+------------------------------------------------+
| Header row, column 1 | Header row, column 2                           |
+======================+================================================+
| body row 1           | Second column of row 1                         |
+----------------------+------------------------------------------------+
| body row 2           | Second column of row 2                         |
|                      |                                                |
|                      | Second line of paragraph                       |
+----------------------+------------------------------------------------+
| body row 3           | Unordered list:                                |
|                      |                                                |
|                      | * Second column of row 3                       |
|                      | * Second item in bullet list (row 3, column 2) |
+----------------------+------------------------------------------------+
| \                    | Row 4; column 1 will be empty                  |
+----------------------+------------------------------------------------+


.. index::
   single: Lists

Lists
-----

Unordered list
^^^^^^^^^^^^^^

* Lorem ipsum
* Dolor sit amet

  * Dolor
  * Sit
  * Amet

* Consectetur adipiscing elit

Ordered list
^^^^^^^^^^^^

#. Lorem ipsum
#. Dolor sit amet

   #. Dolor
   #. Sit
   #. Amet

#. Consectetur adipiscing elit

Definition Lists
^^^^^^^^^^^^^^^^

Lorem
    Lorem ipsum dolor sit amet.
Ipsum
    Ipsum dolor amet sit.
Dolor : classifier
    Dolor lorem ipsum.
Sit amet : classifier one : classifier two
    Sit amet consectetur adipiscing elit.


.. index::
   single: Topics

.. _topic:

Topics
------

.. topic:: Lorem ipsum

   Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
   tempor incididunt ut labore et dolore magna aliqua.


.. index::
   single: Admonitions

.. _admonitions:

Admonitions
-----------

.. admonition:: Admonition title

   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. attention::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. caution::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. danger::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. error::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. hint::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. important::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. note::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. seealso::

   Module :py:mod:`zipfile`
      Documentation of the :py:mod:`zipfile` standard module.

   `GNU tar manual, Basic Tar Format <http://link>`_
      Documentation for tar archive files, including GNU tar extensions.

.. tip::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.

.. warning::
   Lorem ipsum dolor sit amet, consectetur adipisicing elit.


.. index::
   single: Code

Code
----

.. code-block:: python

  """An example module docstring to show Pygments style."""

  # Some comment.

  import datetime
  from functools import partial

  number = 123
  word = 'foo'


  class ExampleClass(object):

      """An example class docstring to show Pygments style."""

      def __init__(self, arg1, arg2=None, *args, **kwargs):
          self.attr1 = attr1
          self.attr2 = attr2 or datetime.datetime.now()
          for arg in args:
              print('Argument: '.format(arg))
          for k, v in kwargs.iteritems():
              print('Keyword argument named {}: {}'.format(k, v))

      def call_method(self, arg):
          """An example method docstring."""
          if not isinstance(arg, int):
              raise ValueError('Only ints allowed.')
          self.attr1 = arg

      @property
      def example_property(self):
          """An example property docstring."""
          return self.attr1 * 2


  def example_function(arg1, arg2=None, *args, **kwargs):
      """An example function docstring to show Pygments style."""
      raise NotImplementedError()


.. index::
   single: Autodoc

TODO
----

.. todolist::

Indices and tables
------------------

* :ref:`genindex`
* :ref:`search`

