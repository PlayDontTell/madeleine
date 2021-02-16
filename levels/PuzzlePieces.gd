extends Node2D


var last_piece_gotten: Array
var start_piece: Array
var historic: Array = []

func set_last_piece_gotten(value):
	last_piece_gotten = value
	for i in get_children():
		i.set_not_last_piece_gotten()
	get_node("..").find_piece(value).set_last_piece_gotten()
	
