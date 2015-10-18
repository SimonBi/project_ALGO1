let squareSize = 100
let chipSize = 40;;

Graphics.open_graph (" "^string_of_int((Align4Mechanism.cGrid+2)*squareSize)^"x"^string_of_int((Align4Mechanism.lGrid+1)*squareSize));;
Graphics.clear_graph();;

let displayGame s =
	Graphics.clear_graph();
	Graphics.set_color(Graphics.black);
	for i = 0 to Align4Mechanism.lGrid do
		Graphics.moveto 0 (i*squareSize);
		Graphics.lineto (Align4Mechanism.cGrid*squareSize) (i*squareSize);
	done;
	for j = 0 to Align4Mechanism.cGrid do
		Graphics.moveto (j*squareSize) 0;
		Graphics.lineto (j*squareSize) (Align4Mechanism.lGrid*squareSize);
	done;
	for i = 0 to Align4Mechanism.lGrid-1 do
		for j = 0 to Align4Mechanism.cGrid-1 do
			if(s.(i).(j) = Align4Mechanism.Player(0)) 
			then
				begin
					Graphics.set_color(Graphics.red);
					Graphics.fill_circle (j*squareSize+squareSize/2) (i*squareSize+squareSize/2) chipSize
				end
			else 
			if (s.(i).(j) = Align4Mechanism.Player(1))
			then 
				begin
					Graphics.set_color(Graphics.yellow);
					Graphics.fill_circle (j*squareSize+squareSize/2) (i*squareSize+squareSize/2) chipSize
				end;
		done
	done


let displayMove player =
	Graphics.moveto (Align4Mechanism.cGrid*squareSize+squareSize/2) (2*squareSize);
	Graphics.set_color(Graphics.black);
	Graphics.draw_string("Move ?");
	Graphics.moveto (Align4Mechanism.cGrid*squareSize+squareSize/2) (squareSize);
	match player with
	 Align4Mechanism.Player(0) -> Graphics.draw_string("Player 0 : red")
	|Align4Mechanism.Player(1) -> Graphics.draw_string("Player 1 : yellow")
	|_ -> ()

let rec getNearestMove player s =
	let w_n_e = Graphics.wait_next_event [Graphics.Button_down]
	in
	let a = w_n_e.Graphics.mouse_x/squareSize
	and m = ref(Align4Mechanism.Move(-1))
	in if (a < 0) 
		then m := Align4Mechanism.Move(0)
		else if (a > (Align4Mechanism.cGrid-1)) then m:=Align4Mechanism.Move(Align4Mechanism.cGrid-1)
		else m:=Align4Mechanism.Move(a)
	   ;
	if Align4Mechanism.validMove player s !m 
	then !m
	else getNearestMove player s

let displayPlayerWin player =
	let a = ref("") in
	(match player with
	 Align4Mechanism.Player(0) -> a := "red"
	|Align4Mechanism.Player(1) -> a := "yellow"
	|_ -> a := "NOPLAYER"
	);
	Graphics.moveto ((Align4Mechanism.cGrid+2)*squareSize/2) ((Align4Mechanism.lGrid+2)*squareSize/2);
	Graphics.set_color(Graphics.black);
	Graphics.draw_string ("Player "^(!a)^" wins !!");
	Graphics.moveto ((Align4Mechanism.cGrid+2)*squareSize/2) ((Align4Mechanism.lGrid+2)*squareSize/2-20);
	Graphics.draw_string ("(Press any key to quit)")
	
let displayTie () =
	Graphics.moveto ((Align4Mechanism.cGrid+2)*squareSize/2) ((Align4Mechanism.lGrid+2)*squareSize/2);
	Graphics.set_color(Graphics.black);
	Graphics.draw_string ("Tie");
	Graphics.moveto ((Align4Mechanism.cGrid+2)*squareSize/2) ((Align4Mechanism.lGrid+2)*squareSize/2-20);
	Graphics.draw_string ("(Press any key to quit)")
