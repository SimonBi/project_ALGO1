exception Sprune of (Align4Mechanism.move * float)

let randomStrategy player s =
	let l = Align4Mechanism.getPossibleMoves s
	in 
		let a = Random.int(List.length l)
		in (List.nth l a)

let humanPlayerStrategy player s =
	Align4GUI.displayMove player;
	Align4GUI.getNearestMove player s
	
let maxDepth = 7

type state={situation : Align4Mechanism.situation;depth : int;player : Align4Mechanism.player}


let alphabeta evalSituation player situation = 
  let rec alpbet s a b depth player' = 
    let a' = ref a
    and b' = ref b in
    let bst_mv = ref (Align4Mechanism.Move (-1)) in
    if Align4Mechanism.gameEnded s || depth = 0 then 
      ( !bst_mv, evalSituation s player)
    else ( try (
      let l = Align4Mechanism.getPossibleMoves s in
      bst_mv := List.hd l;
      if player <> player' then (
        let v = ref infinity in
        for i = 0 to ((List.length l)-1)
        do
          let s' = Align4Mechanism.play player' s (List.nth l i)
          and mv = (List.nth l i) in
          v := min !v (snd (alpbet s' !a' !b' (depth-1) (Align4Mechanism.otherPlayer player')));
          if !v <= !a' then raise (Sprune (mv, !v));
          if !b' > !v then bst_mv := mv;
          b' := min !b' !v
        done;
        ( !bst_mv, !v) 
        )
      else (
        let v = ref neg_infinity in
        for i = 0 to ((List.length l)-1)
        do
          let s' = Align4Mechanism.play player' s (List.nth l i)
          and mv = (List.nth l i) in
          v := max !v (snd (alpbet s' !a' !b' (depth-1) (Align4Mechanism.otherPlayer player')));
          if !v >= !b' then raise (Sprune (mv, !v));
          if !a' < !v then bst_mv := mv;
          a' := max !a' !v
        done;
        ( !bst_mv, !v)
        )
      )
      with | Sprune res -> res )
  in
  fst (alpbet situation neg_infinity infinity maxDepth player)


let minimaxStrategy heuristic player s =
  alphabeta heuristic player s
