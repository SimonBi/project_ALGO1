let game strategiesArray playersArray =
	let vainqueur = ref(-1)
	and n = Array.length strategiesArray
	and currentSituation = ref(Align4Mechanism.getInitialSituation())
	in
	let nextPlayer i = (i+1) mod n
	in
	let rec boucle currentPlayer =
		let player = playersArray.(currentPlayer)
		and strategy = strategiesArray.(currentPlayer)
		in
		if Align4Mechanism.tie !currentSituation
		then 
			Align4GUI.displayTie ()
		else
			begin
			Align4GUI.displayGame !currentSituation;
			currentSituation := Align4Mechanism.play player !currentSituation (strategy player !currentSituation);
			Align4GUI.displayGame !currentSituation;
			if (Align4Mechanism.hasWin player !currentSituation) 
			then 
				begin
				Align4GUI.displayPlayerWin player ;
				vainqueur := currentPlayer
				end
			else
				boucle (nextPlayer currentPlayer)
			end
	in boucle 0 ;
(*	print_newline();
	for i = 0 to lGrid-1 do
		for j = 0 to cGrid-1 do
			match grid.(i).(j) with
			| Player(k) -> print_string (" "^(string_of_int k))
			| _ -> print_string "  "
		done;
		print_newline();
	done;*)
	let w_n_e = Graphics.wait_next_event [Graphics.Key_pressed]
	in if (w_n_e.Graphics.keypressed) then (print_string "exit");
	!vainqueur;
;;