(**Module pour l'apprentissage*)

(** chemin du fichier de sauvegarde *)
val saveFileName : string

(** fonction permettant de sauvegarder l'apprentissage*)
val saveToFile : string -> unit

(** fonction permettant de charger un fichier d'apprentissage*)
val loadFromFile :string -> unit

(** fonction rendant le meilleur coup selon l'apprentissage dans la situation donn�e en param�tre*)
val bestPolitic : MorpionMechanism.situation -> MorpionMechanism.move

(** fonction apprenant une strat�gie sur le nombre plac� en param�tre de partie *)
val learnGames : int -> unit 