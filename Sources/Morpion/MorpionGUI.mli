(**Module d'affichage graphique*)

(** fonction affichant la situation *)
val displayGame : MorpionMechanism.situation -> unit

(** fonction affichant le joueur du tour courant*)
val displayMove : MorpionMechanism.player -> unit

(** fonction permettant de récupérer un coup joué à la souris*)
val getNearestMove : MorpionMechanism.player -> MorpionMechanism.situation -> MorpionMechanism.move

(** fonction affichant le vainqueur lorsque la partie est terminée par un match non-nul*)
val displayPlayerWin : MorpionMechanism.player -> unit

(** fonction affichant le match nul*)
val displayTie : unit -> unit 