let squareSize = 100;;
let chipSize = 40;;

Graphics.open_graph (string_of_int((MorpionMechanism.cGrid+2)*squareSize)^"x"^string_of_int((MorpionMechanism.lGrid+1)*squareSize));;
Graphics.clear_graph();;

let displayGame situation = 
	Graphics.clear_graph();
	Graphics.set_color(Graphics.black);
	for i = 0 to MorpionMechanism.lGrid do
		Graphics.moveto 0 (i*squareSize);
		Graphics.lineto (MorpionMechanism.cGrid*squareSize) (i*squareSize);
	done;
	for j = 0 to MorpionMechanism.cGrid do
		Graphics.moveto (j*squareSize) 0;
		Graphics.lineto (j*squareSize) (MorpionMechanism.lGrid*squareSize);
	done;
	for i = 0 to MorpionMechanism.lGrid-1 do
		for j = 0 to MorpionMechanism.cGrid-1 do
			if(situation.(i).(j) = MorpionMechanism.Player(0)) 
			then
				begin
					Graphics.set_color(Graphics.red);
					Graphics.fill_circle (j*squareSize+squareSize/2) (i*squareSize+squareSize/2) chipSize
				end
			else 
			if (situation.(i).(j) = MorpionMechanism.Player(1))
			then 
				begin
					Graphics.set_color(Graphics.yellow);
					Graphics.fill_circle (j*squareSize+squareSize/2) (i*squareSize+squareSize/2) chipSize
				end;
		done
	done


let displayMove player = 
	Graphics.moveto (MorpionMechanism.cGrid*squareSize+squareSize/2) (2*squareSize);
	Graphics.set_color(Graphics.black);
	Graphics.draw_string("Move ?");
	Graphics.moveto (MorpionMechanism.cGrid*squareSize+squareSize/2) (squareSize);
	match player with
	 MorpionMechanism.Player(0) -> Graphics.draw_string("Player 0 : red")
	|MorpionMechanism.Player(1) -> Graphics.draw_string("Player 1 : yellow")
	|_ -> ()

let rec getNearestMove player situation =
	let w_n_e = Graphics.wait_next_event [Graphics.Button_down]
	in
	let a = w_n_e.Graphics.mouse_y/squareSize
	and b = w_n_e.Graphics.mouse_x/squareSize
	and m = ref(MorpionMechanism.Move(-1,-1))
	in if (a < 0) 
		then if (b < 0) 
			 then m := MorpionMechanism.Move(0,0)
			 else if (b > MorpionMechanism.lGrid-1) then m := MorpionMechanism.Move(0,MorpionMechanism.lGrid-1)
			 else m := MorpionMechanism.Move(0,b)
		else if (a > (MorpionMechanism.cGrid-1)) 
		then if (b < 0) 
			 then m := MorpionMechanism.Move(MorpionMechanism.cGrid-1,0)
			 else if (b > MorpionMechanism.lGrid-1) then m := MorpionMechanism.Move(MorpionMechanism.cGrid-1,MorpionMechanism.lGrid-1)
			 else m := MorpionMechanism.Move(MorpionMechanism.cGrid-1,b)
		else if (b < 0) 
			 then m := MorpionMechanism.Move(a,0)
			 else if (b > MorpionMechanism.lGrid-1) then m := MorpionMechanism.Move(a,MorpionMechanism.lGrid-1)
			 else m := MorpionMechanism.Move(a,b)
		;
		if MorpionMechanism.validMove player situation !m 
		then !m
		else getNearestMove player situation

let displayPlayerWin player =
	let a = ref("") in
	(match player with
	 MorpionMechanism.Player(0) -> a := "red"
	|MorpionMechanism.Player(1) -> a := "yellow"
	|_ -> a := "NOPLAYER"
	);
	Graphics.moveto ((MorpionMechanism.cGrid+2)*squareSize/2) ((MorpionMechanism.lGrid+2)*squareSize/2);
	Graphics.set_color(Graphics.black);
	Graphics.draw_string ("Player "^(!a)^" wins !!");
	Graphics.moveto ((MorpionMechanism.cGrid+2)*squareSize/2) ((MorpionMechanism.lGrid+2)*squareSize/2-20);
	Graphics.draw_string ("(Press any key to quit)")
	
let displayTie () =
	Graphics.moveto ((MorpionMechanism.cGrid+2)*squareSize/2) ((MorpionMechanism.lGrid+2)*squareSize/2);
	Graphics.set_color(Graphics.black);
	Graphics.draw_string ("Tie");
	Graphics.moveto ((MorpionMechanism.cGrid+2)*squareSize/2) ((MorpionMechanism.lGrid+2)*squareSize/2-20);
	Graphics.draw_string ("(Press any key to quit)")