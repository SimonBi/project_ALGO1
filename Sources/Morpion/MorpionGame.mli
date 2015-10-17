(** Module g�n�ral pour le jeu*)

(** fonction de jeu prenant en param�tre un tableau de strat�gies (qui � un joueur et une situation renvoie un coup � jouer) et un tableau de joueur (typiquement [\[|Player(0);Player(1)|\]])*)
val game : (MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move) array -> MorpionMechanism.player array -> int