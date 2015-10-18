type player = Player of int | NOPLAYER

type situation = player array array

type move = Move of int * int

exception HasWin of player
exception BadMove

let lGrid = 3 and cGrid = 3 and toAlign = 3

let getInitialSituation () =
	let situation = Array.make_matrix lGrid cGrid NOPLAYER
	in situation

let getPossibleMoves situation =
	let l = ref([]) in
	for i = 0 to (Array.length situation)-1 do
		for j = 0 to (Array.length situation.(0))-1 do
			if situation.(i).(j) = NOPLAYER then l := Move(i,j) :: !l;
		done
	done;
	!l
	
let otherPlayer  player =
	match player with
	Player(i) -> Player(1-i)
	|_ -> failwith "otherplayer"
	
let validMove p situation m = 
	match m with
	Move(i,j) -> situation.(i).(j) = NOPLAYER
	
let copySituation situation =
	let a = Array.make_matrix lGrid cGrid NOPLAYER
	in for i = 0 to lGrid-1 do
		for j = 0 to cGrid-1 do
			a.(i).(j) <- situation.(i).(j)
		done
	   done;
	   a

let play p s m =
	if validMove p s m then
		match m with
		Move(i,j) ->
			begin
				let newSituation = copySituation s
				in newSituation.(i).(j) <- p;
				newSituation
			end
	else raise BadMove

let hasWinV player situation =
	let rec aux lig col nb player =
		match nb with
		 0 -> true
		|_ -> situation.(lig).(col) = player && aux (lig+1) col (nb-1) player
	in
	try
		for i = 0 to lGrid-toAlign do
			for j = 0 to cGrid-1 do
				if aux i j toAlign player then raise (HasWin player);
			done;
		done;
		false
	with HasWin _ -> true


let hasWinH player situation=
	let rec aux lig col nb player =
		match nb with
		 0 -> true
		|_ -> situation.(lig).(col) = player && aux lig (col+1) (nb-1) player
	in
	try
		for i = 0 to lGrid-1 do
			for j = 0 to cGrid-toAlign do
				if aux i j toAlign player then raise (HasWin player);
			done;
		done;
		false
	with HasWin _ -> true


let hasWinD1 player situation=
	let rec aux lig col nb player =
		match nb with
		 0 -> true
		|_ -> situation.(lig).(col) = player && aux (lig+1) (col+1) (nb-1) player
	in
	try
		for i = 0 to lGrid-toAlign do
			for j = 0 to cGrid-toAlign do
				if aux i j toAlign player then raise (HasWin player);
			done;
		done;
		false
	with HasWin _ -> true


let hasWinD2 player situation=
	let rec aux lig col nb player =
		match nb with
		 0 -> true
		|_ -> situation.(lig).(col) = player && aux (lig-1) (col+1) (nb-1) player
	in
	try
		for i = toAlign-1 to lGrid-1 do
			for j = 0 to cGrid-toAlign do
				if aux i j toAlign player then raise (HasWin player);
			done;
		done;
		false
	with HasWin _ -> true


let tie situation = 
	getPossibleMoves situation = []

let hasWin player situation =
	hasWinH player situation || hasWinV player situation || hasWinD1 player situation || hasWinD2 player situation

let gameEnded situation =
	hasWin (Player(0)) situation || hasWin (Player(1)) situation|| tie situation
