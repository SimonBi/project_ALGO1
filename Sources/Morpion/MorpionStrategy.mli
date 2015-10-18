(** Module de strat�gie*)

(** Strat�gie random : �tant donn� un joueur et une situation, retourne un coup (possible) al�atoire*)
val randomStrategy : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move

(** Strat�gie pour le joueur humain : �tant donn� un joueur et une situation, retourne un coup r�cup�r� � la souris*)
val humanPlayerStrategy : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move

(** Strategie alphabeta *)
val alphabeta : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move

(** Strat�gie apprise : �tant donn� un joueur et une situation, retourne le meilleur coup appris*)
val learningStrategy : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move
