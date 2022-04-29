
<img src="https://user-images.githubusercontent.com/5125929/166006937-ce554b54-bc54-433e-96b6-735114619bd3.svg" width="50%" align="right" style="border:20px solid white">

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
digraph_to_plantuml/1.  % Creates UML class diagrams from Python pylint's pyreverse generated .dot files.
```

For further details have a look at the [implementation](prolog/py_to_plantuml.pl). In addition, the [defined
tests](test/test.pl) might give an impression on how to use this library.
