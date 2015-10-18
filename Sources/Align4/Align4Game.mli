(** Module général pour le jeu*)

(** fonction de jeu prenant en paramètre un tableau de stratégies (qui à un joueur et une situation renvoie un coup à jouer) et un tableau de joueur (typiquement [\[|Player(0);Player(1)|\]])*)
val game : (Align4Mechanism.player -> Align4Mechanism.situation -> Align4Mechanism.move) array -> Align4Mechanism.player array -> int