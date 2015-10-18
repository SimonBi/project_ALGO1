exception ImpossibleAction

let learningStrategyInitialized = ref(false)

let randomStrategy player situation =
	let l = MorpionMechanism.getPossibleMoves situation
	in 
		let a = Random.int(List.length l)
		in (List.nth l a)


let humanPlayerStrategy player situation =
	MorpionGUI.displayMove player;
	MorpionGUI.getNearestMove player situation

let initializeLearningStrategy fileName =
	MorpionLearning.loadFromFile fileName
		
let learningStrategy player situation =
(*	if not(!learningStrategyInitialized)
	then 
		begin 
		initializeLearningStrategy MorpionLearning.saveFileName;
		learningStrategyInitialized := true
		end;
	MorpionLearning.bestPolitic situation*)
	randomStrategy player situation