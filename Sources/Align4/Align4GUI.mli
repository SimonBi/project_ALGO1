(**Module d'affichage graphique*)

(** fonction affichant la situation *)
val displayGame : Align4Mechanism.situation -> unit

(** fonction affichant le joueur du tour courant*)
val displayMove : Align4Mechanism.player -> unit

(** fonction permettant de r�cup�rer un coup jou� � la souris*)
val getNearestMove : Align4Mechanism.player -> Align4Mechanism.situation -> Align4Mechanism.move

(** fonction affichant le vainqueur lorsque la partie est termin�e par un match non-nul*)
val displayPlayerWin : Align4Mechanism.player -> unit

(** fonction affichant le match nul*)
val displayTie : unit -> unit 