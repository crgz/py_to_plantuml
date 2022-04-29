# py_to_plantuml

Creates UML class diagrams from Python pylint's pyreverse generated .dot files.

## Installation

This pack is available from the [add-on registry of SWI-Prolog](http://www.swi-prolog.org/pack/list).

It can be installed with `pack_install/1`:

```prolog
?- pack_install(py_to_plantuml).
```

Then, you can use it by simply calling `use_module(library(py_to_plantuml))`.

## Requirements

Only for development purposes the [`tap` pack](http://www.swi-prolog.org/pack/list?p=tap) is needed:

```prolog
?- pack_install(tap).
```

## Provided Predicates

```prolog
parse/4.  % parse an abbreviated incomplete date in multiple languages (today, tomorrow, etc).
```

For further details have a look at the [implementation](prolog/py_to_plantuml.pl). In addition, the [defined
tests](test/test.pl) might give an impression on how to use this library.
