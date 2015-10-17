@echo off

:Compilation
echo compilation...

ocamlc -c Align4Mechanism.mli
ocamlc -c Align4Mechanism.ml
ocamlc -c Align4GUI.mli
ocamlc -c Align4GUI.ml
ocamlc -c Align4Heuristic.mli
ocamlc -c Align4Heuristic.ml
ocamlc -c Align4Strategy.mli
ocamlc -c Align4Strategy.ml
ocamlc -c Align4Game.mli
ocamlc -c Align4Game.ml
ocamlc -c Align4Main.ml

echo generation des executables...

ocamlc -c graphics.cma Align4Mechanism.cmo Align4GUI.cmo Align4Heuristic.cmo Align4Strategy.cmo Align4Game.cmo Align4Main.ml
ocamlc -o Align4Main.exe graphics.cma Align4Mechanism.cmo Align4GUI.cmo Align4Heuristic.cmo Align4Strategy.cmo Align4Game.cmo Align4Main.cmo

if exist doc (goto GenerateDoc) else md doc

:GenerateDoc
del /Q doc

echo generation de la doc...

ocamldoc -html -d doc *.mli

goto :Suppress

:Suppress

echo suppression des fichiers temporaires...

del *.cm*

:End

