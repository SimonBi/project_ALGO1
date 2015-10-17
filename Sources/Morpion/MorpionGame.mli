(** Module général pour le jeu*)

(** fonction de jeu prenant en paramètre un tableau de stratégies (qui à un joueur et une situation renvoie un coup à jouer) et un tableau de joueur (typiquement [\[|Player(0);Player(1)|\]])*)
val game : (MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move) array -> MorpionMechanism.player array -> int