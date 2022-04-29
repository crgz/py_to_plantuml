:- use_module('../prolog/py_to_plantuml').

term_expansion(Query -> Result, (Head :- Test)) :-
   format(atom(Head), '~w -> ~w', [Query, Result]),
   Test = (
      call(Query),
      call(Result),
      !
   ),
   tap:register_test(Head).

:- use_module(library(tap)).

% Use Cases 	█

phrase(digraph(C),`digraph dig {\n\n graph [gra=aph];\n "Clas" [clas="clas"];\n "Rela" -> "tion" [rel=ati];\n }`)
->  C = digraph(`dig`,
   [
      graph([attribute(`gra`, `aph`)]), 
      class(`Clas`, [attribute(`clas`, `clas`)]), 
      relationship(`Rela`, `tion`, [attribute(`rel`, `ati`)])
   ]
).

phrase(py_to_plantuml:entry_list(C), `{ graph [gra=aph];\n "Clas" [clas="clas"];\n "Rela" -> "tion" [rel=ati];\n }`)
-> C = 
[
   graph([attribute(`gra`, `aph`)]), 
   class(`Clas`, [attribute(`clas`, `clas`)]), 
   relationship(`Rela`, `tion`, [attribute(`rel`, `ati`)])
].

phrase(py_to_plantuml:entries(C), ` graph [gra=aph];\n "Clas" [clas="clas"];\n "Rela" -> "tion" [rel=ati];\n`)
-> C =
[
   graph([attribute(`gra`, `aph`)]), 
   class(`Clas`, [attribute(`clas`, `clas`)]), 
   relationship(`Rela`, `tion`, [attribute(`rel`, `ati`)])
].

phrase(py_to_plantuml:entry(C), ` "Clas" [clas=clas];\n`) -> C = class(`Clas`, [attribute(`clas`, `clas`)]).

phrase(py_to_plantuml:attribute_list(S),`[cat=dog]`) -> S = [attribute(`cat`, `dog`)] .

phrase(py_to_plantuml:attributes(S),`cat=dog,cat=dog`) -> S = [attribute(`cat`, `dog`), attribute(`cat`, `dog`)].

phrase(py_to_plantuml:attribute(S),`cat=dog`) -> S = attribute(`cat`, `dog`) .