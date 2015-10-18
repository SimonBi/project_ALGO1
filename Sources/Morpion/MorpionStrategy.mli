(** Module de stratégie*)

(** Stratégie random : étant donné un joueur et une situation, retourne un coup (possible) aléatoire*)
val randomStrategy : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move

(** Stratégie pour le joueur humain : étant donné un joueur et une situation, retourne un coup récupéré à la souris*)
val humanPlayerStrategy : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move

(** Strategie alphabeta *)
val alphabeta : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move

(** Stratégie apprise : étant donné un joueur et une situation, retourne le meilleur coup appris*)
val learningStrategy : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move
