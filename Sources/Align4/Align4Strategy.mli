(** Module de stratégie*)

(** Stratégie random : étant donné un joueur et une situation, retourne un coup (possible) aléatoire*)
val randomStrategy : Align4Mechanism.player -> Align4Mechanism.situation -> Align4Mechanism.move

(** Stratégie pour le joueur humain : étant donné un joueur et une situation, retourne un coup récupéré à la souris*)
val humanPlayerStrategy : Align4Mechanism.player -> Align4Mechanism.situation -> Align4Mechanism.move

(** profondeur de recherche maximale pour l'algorithme minimax*)
val maxDepth : int

(** Stratégie minimax (à compléter) : étant donné une heuristique, un joueur et une situation, retourne le meilleur coup possible selon l'algorithme minimax*)
val minimaxStrategy : (Align4Mechanism.situation -> Align4Mechanism.player -> float) -> Align4Mechanism.player -> Align4Mechanism.situation -> Align4Mechanism.move
