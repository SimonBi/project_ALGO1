exception ImpossibleAction
exception Sprune of (MorpionMechanism.move * float)

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


let evalSituation player situation = 
  if MorpionMechanism.gameEnded situation then (
    if MorpionMechanism.hasWin player situation then infinity
    else (
        if MorpionMechanism.tie situation then 0.
        else neg_infinity
      )
    )
  else 0.


let alphabeta player situation = 
  let rec alpbet s a b depth player' = 
    let a' = ref a
    and b' = ref b in
    let bst_mv = ref (MorpionMechanism.Move(-1,-1)) in
    if MorpionMechanism.gameEnded s || depth = 0 then 
      ( !bst_mv, evalSituation player s)
    else ( try ( 
      let l = MorpionMechanism.getPossibleMoves s in
      if player <> player' then (
        let v = ref infinity in
        for i = 0 to ((List.length l)-1)
        do
          let s' = MorpionMechanism.play player' s (List.nth l i)
          and mv = (List.nth l i) in
          v := min !v (snd (alpbet s' !a' !b' (depth-1) (MorpionMechanism.otherPlayer player')));
          if !v <= !a' then raise (Sprune ( !bst_mv, !v));
          if !b' > !v then bst_mv := mv;
          b' := min !b' !v
        done;
        ( !bst_mv, !v) 
        )
      else (
        let v = ref neg_infinity in
        for i = 0 to ((List.length l)-1)
        do
          let s' = MorpionMechanism.play player' s (List.nth l i)
          and mv = (List.nth l i) in
          v := max !v (snd (alpbet s' !a' !b' (depth-1) (MorpionMechanism.otherPlayer player')));
          if !v >= !b' then raise (Sprune ( !bst_mv, !v));
          if !a' < !v then bst_mv := mv;
          a' := max !a' !v
        done;
        ( !bst_mv, !v)
        )
      )
      with | Sprune res -> res )
  in
  fst (alpbet situation neg_infinity infinity 100 player)


let learningStrategy player situation =
(*	if not(!learningStrategyInitialized)
	then 
		begin 
		initializeLearningStrategy MorpionLearning.saveFileName;
		learningStrategyInitialized := true
		end;
	MorpionLearning.bestPolitic situation*)
	(* randomStrategy player situation *)
	alphabeta player situation
