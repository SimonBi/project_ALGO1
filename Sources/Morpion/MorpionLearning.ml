let saveFileName = "C:\\Users\\prannou\\Desktop\\apprentissage.txt" (*indiquer le chemin du fichier de sauvegarde de votre apprentissage*)

let epsilon = 0.9

let alpha = 0.2

let gamma = 0.5

let hashTable : (MorpionMechanism.situation, (MorpionMechanism.move,float) Hashtbl.t) Hashtbl.t = Hashtbl.create 120

let getConfigStringRepresentation situation =
	let res = ref("")
	in
		for i = 0 to (Array.length situation)-1 do
			for j=0 to (Array.length situation.(0))-1 do
				if situation.(i).(j) = (MorpionMechanism.Player(0)) then
					res:=!res^"0"
				else if situation.(i).(j) = (MorpionMechanism.Player(1)) then
					res:=!res^"1"
				else res:=!res^"_"
			done
		done;
	!res
	
let getMoveStringRepresentation move =
	match move with
	MorpionMechanism.Move(i,j)->(" "^string_of_int(i)^" "^string_of_int(j))
	
let getTableRepresentation table =
	let res = ref("(")
	in let f x y = res:=(!res^(getMoveStringRepresentation x)^" "^string_of_float(y))
	in Hashtbl.iter f table;
	(!res^")")
	
let getRepresentation () =
	let res=ref("")
	in let f x y = res:=(!res^(getConfigStringRepresentation x)^" "^(getTableRepresentation y)^"\n")
	in Hashtbl.iter f hashTable;
	!res

let saveToFile fileName =
	let channel = open_out fileName
	in
		output_string channel (getRepresentation());
		close_out channel

let getConfig s situation=
	let c = ref(' ') in
	for i = 0 to (Array.length situation)-1 do
		for j=0 to (Array.length situation.(0))-1 do
			c:=String.get s (i*(Array.length situation.(0))+j);
			if(!c = '0') then situation.(i).(j) <- MorpionMechanism.Player(0)
			else if (!c = '1') then situation.(i).(j) <- MorpionMechanism.Player(1)
			else situation.(i).(j) <- MorpionMechanism.NOPLAYER;
		done;
	done

let copyConfig situation =
	let a = Array.create_matrix (Array.length situation) (Array.length situation.(0)) MorpionMechanism.NOPLAYER
	in for i = 0 to (Array.length situation)-1 do
		for j=0 to (Array.length situation.(0))-1 do
			a.(i).(j) <- situation.(i).(j)
		done
	   done;
	   a

let getNextInt s =
	let i = String.index !s ' '
	in let a = int_of_string (String.sub !s 0 i)
	in s := (String.sub !s (i+1) ((String.length !s)-i-1));
	a

let getNextFloat s =
	let i = ref(-1)
	in
	begin 
		try 
			i := String.index !s ' '
		with Not_found -> i:= String.index !s ')'
	end;
	let a = float_of_string (String.sub !s 0 !i)
	in s := (String.sub !s (!i+1) ((String.length !s)-(!i)-1));
	a

let loadFromFile fileName =
	let channel = open_in fileName
	and situation = MorpionMechanism.getInitialSituation()
	and a = ref(0) and b = ref(0) and c=ref(0.)
	and table = Hashtbl.create 9
	in let configSize = (Array.length situation.(0))*(Array.length situation)
	and s = ref("")
	in
	begin
	try
		Hashtbl.clear hashTable;
		while(true) do
			s:=input_line channel;
			getConfig !s situation;
			s:=String.sub !s (configSize+3) ((String.length !s)-configSize-3);
			Hashtbl.clear table;
			while (String.length !s)>0 do
				a:=getNextInt s;
				b:=getNextInt s;
				c:=getNextFloat s;
				Hashtbl.add table (MorpionMechanism.Move(!a,!b)) (!c)
			done;
			Hashtbl.add hashTable (copyConfig situation) (Hashtbl.copy table);
		done
	with End_of_file -> ();
	end;
	close_in channel


let getValue situation move =
	try 
		let b = Hashtbl.find hashTable situation
		in 
		try
			Hashtbl.find b move
		with Not_found -> 0.
	with Not_found -> 0.
	
let getBestValue situation =
	let a = ref(-2.)
	in
	try 
		let b = Hashtbl.find hashTable situation
		and f x y = if y > !a then a := y;
		in Hashtbl.iter f b;
		!a
	with Not_found -> 0.

let getBestMove situation =
	let a = ref(MorpionMechanism.Move(-1,-1))
	and v = ref(-2.); (*we assume that value are between -1 and 1*)
	in
	try 
		let b = Hashtbl.find hashTable situation
		and f x y = if y > !v then begin a:=x;v:=y end;
		in Hashtbl.iter f b;
		!a
	with Not_found -> !a

let addValue situation move value =
	if (Hashtbl.mem hashTable situation) 
	then
	begin
		let a = Hashtbl.find hashTable situation
		in if not(Hashtbl.mem a move)
			then 
			 begin 
				Hashtbl.add a move value;
				Hashtbl.replace hashTable situation a
			 end
	end
	else
	begin
		let b = Hashtbl.create 9
		in Hashtbl.add b move value;
		Hashtbl.add hashTable situation b
	end

let updateTable situation move newValue =
	try
		let a = Hashtbl.find hashTable situation
		in Hashtbl.replace a move newValue;
		Hashtbl.replace hashTable situation a
	with Not_found ->
			begin
				let b = Hashtbl.create 9
				in Hashtbl.add b move newValue;
				Hashtbl.add hashTable situation b
			end

let politic situation = (*renvoie le meilleur coup avec proba 1-epsilon, un coup aléatoire sinon : pour l'apprentissage*)
	MorpionMechanism.Move(0,0)
	(*à compléter*)

let bestPolitic situation = (*renvoie le meilleur coup : pour le jeu*)
	MorpionMechanism.Move(0,0)
	(*à compléter*)

let updateCaseWinning situation move reward = 
	()
	(*à compléter*)
	
let updateCaseTie situation move = 
	()
	(*à compléter*)

let updateNoSpecialCase situation move nextConfig = 
	()
	(*à compléter*)

let learnOneGame () = 
	()
	(*à compléter*) 
	

	
let learnGames n =
	for i = 0 to n-1 do
		learnOneGame()
	done
