(** Module de strat�gie*)

(** Strat�gie random : �tant donn� un joueur et une situation, retourne un coup (possible) al�atoire*)
val randomStrategy : Align4Mechanism.player -> Align4Mechanism.situation -> Align4Mechanism.move

(** Strat�gie pour le joueur humain : �tant donn� un joueur et une situation, retourne un coup r�cup�r� � la souris*)
val humanPlayerStrategy : Align4Mechanism.player -> Align4Mechanism.situation -> Align4Mechanism.move

(** profondeur de recherche maximale pour l'algorithme minimax*)
val maxDepth : int

(** Strat�gie minimax (� compl�ter) : �tant donn� une heuristique, un joueur et une situation, retourne le meilleur coup possible selon l'algorithme minimax*)
val minimaxStrategy : (Align4Mechanism.situation -> Align4Mechanism.player -> float) -> Align4Mechanism.player -> Align4Mechanism.situation -> Align4Mechanism.move
