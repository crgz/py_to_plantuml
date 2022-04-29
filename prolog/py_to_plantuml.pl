/* - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    digraph_to_plantuml -- Creates UML class diagrams from Python pylint's pyreverse generated .dot files.
    Written Apr. 29th, 2022 by Conrado M. Rodriguez <Conrado.Rgz@gmail.com>
    Public domain code.        https://github.com/crgz
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - */
:-module(py_to_plantuml, [digraph_to_plantuml/1, digraph/3]).
:- use_module(library(dcg/basics)).
:- set_portray_text(enabled, true).

%!  digraph_to_plantuml(+Files)
%   
%   True if UML class diagrams can be parsed from Python pylint's pyreverse generated .dot files.
%
%   ==
%   digraph_to_plantuml(Files).
%   ==
digraph_to_plantuml([]).
digraph_to_plantuml([Head|Tail]) :- write_plantuml(Head), digraph_to_plantuml(Tail).

write_plantuml(File):-
   phrase_from_file(digraph(digraph(GraphNameCodes, Entries)), File),
   atom_codes(GraphName, GraphNameCodes), %print_term(digraph(GraphName,Entries), []),
   atom_concat(GraphName, '.plantuml', OutputFileName),
   open(OutputFileName, write, Out),
   format(Out, '@startuml ~w\n', [GraphName]),
   write_lines(Out, Entries),
   format(Out, '@enduml\n', []),
   close(Out),!.

write_lines(_,[]).
write_lines(Out,[Head|Tail]) :- write_line(Out,Head), write_lines(Out,Tail).

write_line(Out,relationship(Super, Sub, Options)):-
   atom_codes(AtomicSuper, Super),
   atom_codes(AtomicSub, Sub),
   arrow(Options, Arrow),
   format(Out, '~w ~w ~w\n', [AtomicSuper, Arrow, AtomicSub]).
write_line(_,_).

arrow(Options, ' <|-- '):-member(attribute(`arrowhead`,`empty`), Options).
arrow(Options, ' *-- '):-member(attribute(`arrowhead`,`diamond`), Options).

digraph(digraph(FileName,Digraph)) --> "digraph", blanks, nonblanks(FileName), blanks, entry_list(Digraph).

entry_list(Options) --> "{", empty_lines, entries(Options), "}", (empty_lines|eos).

entries([]) --> [].
entries([W|Ws]) --> entry(W), !, entries(Ws).

entry(graph(Options)) -->  
   blanks, "graph", 
   attribute_list(Options), ";", empty_lines.
entry(class(R, Options)) --> 
   blanks, class(R), 
   attribute_list(Options), ";", empty_lines.
entry(relationship(Super,Sub, Options)) --> 
   blanks, relationship(Super,Sub), 
   attribute_list(Options), ";", empty_lines.

relationship(Super,Sub) --> class(Super), blanks, "->", blanks, class(Sub).

class(Class) --> quoted_identifier(Class).

attribute_list(Options) --> blanks, "[", attributes(Options), "]".

attributes([]) --> [].
attributes([W]) --> attribute(W).
attributes([W|Ws]) --> attribute(W), ",", attributes(Ws).

attribute(attribute(K, V)) --> maybe_quoted_identifier( K), "=", maybe_quoted_identifier(V).

empty_lines --> blank, empty_lines, !.
empty_lines --> blank.

maybe_quoted_identifier(Identifier) --> quoted_identifier(Identifier) | identifier(Identifier).

quoted_identifier(Identifier) --> "\"", identifier(Identifier), "\"".

identifier([A|As]) --> [A],
   { char_type(A, alpha) },
   symbol_r(As).

symbol_r([A|As]) --> [A], 
   { valid_char(A) ; char_type(A, alnum) }, 
   symbol_r(As).
symbol_r([])     --> [].

valid_char(0'-).
