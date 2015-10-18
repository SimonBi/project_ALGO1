let randomStrategy player s =
	let l = Align4Mechanism.getPossibleMoves s
	in 
		let a = Random.int(List.length l)
		in (List.nth l a)

let humanPlayerStrategy player s =
	Align4GUI.displayMove player;
	Align4GUI.getNearestMove player s
	
let maxDepth = 6

type state={situation : Align4Mechanism.situation;depth : int;player : Align4Mechanism.player}

let minimaxStrategy heuristic player s =
	randomStrategy player s