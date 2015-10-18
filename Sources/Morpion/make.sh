ocamlc -c MorpionMechanism.mli
ocamlc -c MorpionMechanism.ml
ocamlc -c MorpionLearning.mli
ocamlc -c MorpionLearning.ml
ocamlc -c MorpionGUI.mli
ocamlc -c MorpionGUI.ml
ocamlc -c MorpionStrategy.mli
ocamlc -c MorpionStrategy.ml
ocamlc -c MorpionGame.mli
ocamlc -c MorpionGame.ml
ocamlc -c MorpionMain.ml
ocamlc -c MorpionLearningMain.ml

ocamlc -c graphics.cma MorpionMechanism.cmo MorpionLearning.cmo MorpionGUI.cmo MorpionStrategy.cmo MorpionGame.cmo MorpionMain.ml
ocamlc -o MorpionMain.exe graphics.cma MorpionMechanism.cmo MorpionLearning.cmo MorpionGUI.cmo MorpionStrategy.cmo MorpionGame.cmo MorpionMain.cmo
ocamlc -o MorpionLearning.exe MorpionMechanism.cmo MorpionLearning.cmo MorpionLearningMain.cmo

rm -rf doc/*

ocamldoc -html -d doc *.mli

