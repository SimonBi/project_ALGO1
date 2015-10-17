(** Module de fonctionnement interne du jeu *)

(** type joueur*)
type player = Player of int | NOPLAYER

(** type situation*)
type situation = player array array

(** type coup*)
type move = Move of int

(** nombre de ligne de la grille *)
val lGrid : int

(** nombre de colonne de la grille *)
val cGrid : int

(** nombre de pion � aligner *)
val toAlign : int

(** fonction g�n�rant la grille initiale vide *)
val getInitialSituation : unit -> situation

(** fonction rendant le joueur adverse au joueur plac� en param�tre*)
val otherPlayer : player -> player

(** fonction rendant la liste des coups possibles dans la situation pass�e en param�tre*)
val getPossibleMoves : situation -> move list

(** fonction rendant vrai le coup est possible pour le joueur dans la situation *)
val validMove : player -> situation -> move -> bool

(** fonction jouant le coup pour le joueur dans la situation donn�e en param�tre et renvoyant la nouvelle situation *)
val play : player -> situation -> move -> situation

(** fonction renvoyant vrai si le situation plac�e en param�tre est terminale*)
val gameEnded : situation -> bool

(** fonction renvoyant vrai si le joueur a gagn� dans la situation*)
val hasWin : player -> situation -> bool

(** fonction renvoyant vrai s'il n'y a plus de coups possibles (si personne n'a gagn� alors c'est un match nul)*)
val tie : situation -> bool
