(** Module pour les heuristiques *)

(** heuristique renvoyant une grande valeur lors d'une victoire, une valeur fortement négative dans le cas d'une situation perdante et 0. dans les autres cas*)
val nullHeuristic : Align4Mechanism.situation -> Align4Mechanism.player -> float