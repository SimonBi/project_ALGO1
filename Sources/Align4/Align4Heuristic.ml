let nullHeuristic s p =
	if Align4Mechanism.hasWin p s 
	then 10000.
	else if Align4Mechanism.hasWin (Align4Mechanism.otherPlayer p) s 
	then -10000.
	else 0.