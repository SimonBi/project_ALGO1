type player = Player of int | NOPLAYER

type situation = player array array

type move = Move of int

exception HasWin of player
exception BadMove
exception Found of int

let lGrid = 6 and cGrid = 7 and toAlign = 4

let getInitialSituation () =
	let grid = Array.create_matrix lGrid cGrid NOPLAYER
	in grid
	
let getPossibleMoves s =
	let res = ref([]) 
	in
	for i = 0 to cGrid-1 do
		if s.(lGrid-1).(i) = NOPLAYER then res := Move(i) :: !res;
	done;
	!res
	
let otherPlayer p =
	match p with
	Player(i) -> Player(1-i)
	|_ -> NOPLAYER

let validMove p s m =
	match m with
	Move(i) -> s.(lGrid-1).(i) = NOPLAYER

let copySituation s = 
	let newSituation = Array.create_matrix lGrid cGrid NOPLAYER
	in for i = 0 to lGrid-1 do
		for j = 0 to cGrid-1 do
			newSituation.(i).(j) <- s.(i).(j)
		done;
	done;
	newSituation
	
let getFirstFreeLine s c = 
	try
		for i = 0 to lGrid-1 do
			if s.(i).(c) = NOPLAYER then raise (Found i);
		done;
		lGrid
	with Found(i) -> i
	
	
let play p s m =
	if validMove p s m then
		match m with
		Move(i) ->
			begin
				let newSituation = copySituation s
				in newSituation.(getFirstFreeLine newSituation i).(i) <- p;
				newSituation
			end
	else raise BadMove
	
let hasWinV player s =
	let rec aux lig col nb player =
		match nb with
		 0 -> true
		|_ -> s.(lig).(col) = player && aux (lig+1) col (nb-1) player
	in
	try
		for i = 0 to lGrid-toAlign do
			for j = 0 to cGrid-1 do
				if aux i j toAlign player then raise (HasWin player);
			done;
		done;
		false
	with HasWin _ -> true

let hasWinH player s =
	let rec aux lig col nb player =
		match nb with
		 0 -> true
		|_ -> s.(lig).(col) = player && aux lig (col+1) (nb-1) player
	in
	try
		for i = 0 to lGrid-1 do
			for j = 0 to cGrid-toAlign do
				if aux i j toAlign player then raise (HasWin player);
			done;
		done;
		false
	with HasWin _ -> true

let hasWinD1 player s =
	let rec aux lig col nb player =
		match nb with
		 0 -> true
		|_ -> s.(lig).(col) = player && aux (lig+1) (col+1) (nb-1) player
	in
	try
		for i = 0 to lGrid-toAlign do
			for j = 0 to cGrid-toAlign do
				if aux i j toAlign player then raise (HasWin player);
			done;
		done;
		false
	with HasWin _ -> true

let hasWinD2 player s =
	let rec aux lig col nb player =
		match nb with
		 0 -> true
		|_ -> s.(lig).(col) = player && aux (lig-1) (col+1) (nb-1) player
	in
	try
		for i = toAlign-1 to lGrid-1 do
			for j = 0 to cGrid-toAlign do
				if aux i j toAlign player then raise (HasWin player);
			done;
		done;
		false
	with HasWin _ -> true

let tie s = 
	getPossibleMoves s = []

let hasWin player s =
	hasWinH player s || hasWinV player s || hasWinD1 player s || hasWinD2 player s

let gameEnded s =
	tie s  || hasWin (Player 0) s || hasWin (Player 1) s