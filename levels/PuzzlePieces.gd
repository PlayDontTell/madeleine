extends Node2D


var last_piece_gotten: Array
var start_piece: Array
var historic: Array = []

func set_last_piece_gotten(value):
	last_piece_gotten = value
	for i in get_children():
		i.modulate = Global.COLOR_DEFAULT
	get_node("..").find_piece(value).modulate = Color(0.1, 2, 0.1, 1)
	
