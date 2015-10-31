let nullHeuristic s p =
	if Align4Mechanism.hasWin p s 
	then 10000.
	else if Align4Mechanism.hasWin (Align4Mechanism.otherPlayer p) s 
	then -10000.
	else 0.


let evaluate_situation situation player =
  if Align4Mechanism.hasWin player situation then infinity
  else if Align4Mechanism.hasWin (Align4Mechanism.otherPlayer player) situation then neg_infinity
  else if Align4Mechanism.tie situation then 0.
  else (

    let couldWinV player s =
      let evaluationV = ref(0.) in
      let rec aux lig col nb player aligned =
	match nb with
	  0 -> evaluationV := !evaluationV +. aligned
	| _ -> if s.(lig).(col) = player then aux (lig+1) col (nb-1) player (aligned +. 1.)
	else if s.(lig).(col) = Align4Mechanism.NOPLAYER then aux (lig+1) col (nb-1) player aligned
	else ()
      in
      for i = 0 to Align4Mechanism.lGrid-Align4Mechanism.toAlign do
	for j = 0 to Align4Mechanism.cGrid-1 do
	  aux i j Align4Mechanism.toAlign player 0.
	done;
      done;
      !evaluationV 
    in

    
    let couldWinH player s =
      let evaluationH = ref(0.) in
      let rec aux lig col nb player aligned =
	match nb with
	  0 -> evaluationH := !evaluationH +. aligned
	| _ -> if s.(lig).(col) = player then aux lig (col+1) (nb-1) player (aligned +. 1.)
	else if s.(lig).(col) = Align4Mechanism.NOPLAYER then aux lig (col+1) (nb-1) player aligned
	else ()
      in
      for i = 0 to Align4Mechanism.lGrid-1 do
	for j = 0 to Align4Mechanism.cGrid-Align4Mechanism.toAlign do
	  aux i j Align4Mechanism.toAlign player 0.
	done;
      done;
      !evaluationH
    in
    

    let couldWinD1 player s =
      let evaluationD1 = ref(0.) in
      let rec aux lig col nb player aligned =
	match nb with
	  0 -> evaluationD1 := !evaluationD1 +. aligned 
	| _ -> if s.(lig).(col) = player then aux (lig+1) (col+1) (nb-1) player (aligned +. 1.)
	else if s.(lig).(col) = Align4Mechanism.NOPLAYER then aux (lig+1) (col+1) (nb-1) player aligned
	else ()
      in
      
      for i = 0 to Align4Mechanism.lGrid-Align4Mechanism.toAlign do
	for j = 0 to Align4Mechanism.cGrid-Align4Mechanism.toAlign do
	  aux i j Align4Mechanism.toAlign player 0.
	done;
      done;
      !evaluationD1
    in

    let couldWinD2 player s =
      let evaluationD2 = ref(0.) in
      let rec aux lig col nb player aligned =
	match nb with
	  0 -> evaluationD2 := !evaluationD2 +. aligned 
	| _ -> if s.(lig).(col) = player then aux (lig-1) (col+1) (nb-1) player (aligned +. 1.)
	else if s.(lig).(col) = Align4Mechanism.NOPLAYER then aux (lig-1) (col+1) (nb-1) player aligned
	else ()
      in
      
      for i = Align4Mechanism.toAlign-1 to Align4Mechanism.lGrid-1 do
	for j = 0 to Align4Mechanism.cGrid-Align4Mechanism.toAlign do
	  aux i j Align4Mechanism.toAlign player 0.
	done;
      done;
      !evaluationD2
    in
    let player' = Align4Mechanism.otherPlayer player in
    let total = couldWinV player situation +. couldWinH player situation +. couldWinD1 player situation +. couldWinD2 player situation
	-. (couldWinV player' situation +. couldWinH player' situation +. couldWinD1 player' situation +. couldWinD2 player' situation) in
    total );;
