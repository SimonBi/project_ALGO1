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
    0.
  )
