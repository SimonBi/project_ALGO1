(**Module pour l'apprentissage*)

(** chemin du fichier de sauvegarde *)
val saveFileName : string

(** fonction permettant de sauvegarder l'apprentissage*)
val saveToFile : string -> unit

(** fonction permettant de charger un fichier d'apprentissage*)
val loadFromFile :string -> unit

(** fonction rendant le meilleur coup selon l'apprentissage dans la situation donnée en paramètre*)
val bestPolitic : MorpionMechanism.situation -> MorpionMechanism.move

(** fonction apprenant une stratégie sur le nombre placé en paramètre de partie *)
val learnGames : int -> unit 