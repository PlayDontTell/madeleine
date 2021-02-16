extends Node2D


signal clicked_on_postcard


onready var puzzle_piece = preload("res://scripts/PuzzlePiece.tscn")
var current_level: int = Global.last_level
var is_searching: bool = false
const puzzle_offset: Vector2 = Vector2(16, 10)
var current_level_array: Array
const levels: Array = [
	
[[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #0
 [0, 0, 0, 3, 1, 1, 0, 0, 0, 0],
 [0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
 [0, 0, 0, 1, 1, 1, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],

[[0, 0, 0, 1, 1, 1, 1, 0, 0, 0], #1
 [0, 0, 0, 1, 3, 1, 1, 0, 0, 0],
 [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
 [0, 0, 0, 1, 1, 1, 1, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
	
[[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #2
 [0, 0, 1, 1, 1, 1, 1, 0, 0, 0],
 [0, 0, 1, 1, 1, 4, 1, 0, 0, 0],
 [0, 0, 1, 3, 1, 1, 1, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],

[[0, 0, 1, 1, 1, 4, 3, 1, 0, 0], #3
 [0, 0, 1, 4, 1, 1, 1, 1, 0, 0],
 [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
 [0, 0, 4, 1, 1, 1, 1, 1, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],

[[0, 0, 4, 1, 1, 3, 1, 1, 0, 0], #4
 [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
 [0, 0, 1, 4, 1, 1, 4, 1, 0, 0],
 [0, 0, 1, 4, 1, 1, 1, 1, 0, 0],
 [0, 0, 1, 1, 1, 1, 1, 4, 0, 0]],

[[0, 1, 1, 1, 1, 0, 0, 0, 0, 0], #5
 [0, 1, 1, 1, 1, 0, 0, 1, 1, 0],
 [0, 1, 3, 1, 1, 1, 1, 1, 1, 0],
 [0, 1, 1, 1, 4, 0, 0, 0, 0, 0],
 [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],

[[0, 0, 0, 0, 1, 1, 1, 1, 0, 0], #6
 [0, 0, 1, 1, 1, 1, 1, 1, 0, 0],
 [0, 0, 1, 3, 1, 1, 4, 1, 0, 0],
 [0, 0, 1, 1, 1, 4, 1, 1, 0, 0],
 [0, 0, 0, 0, 1, 1, 1, 4, 0, 0]],

[[0, 0, 1, 1, 1, 1, 1, 4, 0, 0], #7
 [0, 0, 1, 1, 1, 3, 1, 4, 0, 0],
 [0, 0, 1, 4, 1, 1, 1, 1, 0, 0],
 [0, 0, 1, 1, 4, 4, 4, 1, 0, 0],
 [0, 0, 4, 1, 1, 1, 1, 1, 0, 0]],

[[0, 1, 1, 1, 1, 1, 1, 1, 1, 0], #8
 [0, 1, 1, 1, 1, 1, 1, 4, 1, 0],
 [0, 1, 1, 4, 1, 3, 1, 4, 1, 0],
 [0, 1, 1, 1, 1, 1, 1, 4, 1, 0],
 [0, 1, 1, 1, 4, 1, 1, 1, 1, 0]],

#[[0, 0, 0, 0, 0, 0, 0, 0, 0, 0], #0
# [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
# [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
# [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
# [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]],
]


func _ready():
	yield(get_tree().create_timer(0.1),"timeout")
	$Fade/AnimationPlayer.play("fade_in")
	
	draw_puzzle(0)


func draw_puzzle(level):
	$Tween.interpolate_property($TinyTrain, "position", $TinyTrain.position, 
		Vector2(-400 + 192 / (levels.size() - 0) * (level + 1), 98), 1, Tween.TRANS_SINE)
	$Tween.start()
	
	if level == 9:
		$Postcard.visible = false
		$PuzzlePieces.visible = false
		yield(get_tree().create_timer(0.1),"timeout")
		$Tween.interpolate_property($TinyTrain, "position", $TinyTrain.position, 
		$TinyTrain.position + Vector2(200, 0), 2, Tween.TRANS_LINEAR, Tween.EASE_IN)
		$Tween.start()
		yield(get_tree().create_timer(1.5),"timeout")
		$Fade/AnimationPlayer.play("fade_out")
		$Tween.interpolate_property($Cursor, "modulate", Global.COLOR_DEFAULT, 
		Global.COLOR_TRANPARENT, 0.5)
		$Tween.start()
		yield(get_tree().create_timer(0.6),"timeout")
		get_node("..").load_scene(get_node("..").end_screen)
	else:
		$Postcard.play("level_" + str(level))
		current_level = level
		current_level_array = levels[level]
		Global.last_level = level
		
		for row in [0, 1, 2, 3, 4]:
			for piece in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]:
				
				var x_pos = piece
				var y_pos = row
				var situation_array = [[0, 0, 0], [0, 0, 0], [0, 0, 0]]
				
				if levels[level][row][piece] >= 1:
					var puzzle_piece_instance = puzzle_piece.instance()
					$PuzzlePieces.add_child(puzzle_piece_instance)
					
					puzzle_piece_instance.position = Vector2(x_pos * 16, y_pos * 16) + puzzle_offset
					puzzle_piece_instance.level_position = [y_pos, x_pos]
					
					if has_top_piece([y_pos, x_pos], level):
						situation_array[0][1] = 1
					if has_bottom_piece([y_pos, x_pos], level):
						situation_array[2][1] = 1
					if has_left_piece([y_pos, x_pos], level):
						situation_array[1][0] = 1
					if has_right_piece([y_pos, x_pos], level):
						situation_array[1][2] = 1
					
					puzzle_piece_instance.situation_array = situation_array
					puzzle_piece_instance.initialize_form()
					situation_array[1][1] = levels[level][row][piece]
					puzzle_piece_instance.initialize_type()



func clear_puzzle():
	$PuzzlePieces.historic = []
	for puzzle_pieces in $PuzzlePieces.get_children():
		$PuzzlePieces.remove_child(puzzle_pieces)
		puzzle_pieces.queue_free()


# warning-ignore:unused_argument
func has_top_piece(piece, level):
	if piece[0] == 0:
		return 0
	else:
		return current_level_array[piece[0] - 1][piece[1]]


# warning-ignore:unused_argument
func has_bottom_piece(piece, level):
	if piece[0] == 4:
		return 0
	else:
		return current_level_array[piece[0] + 1][piece[1]]


# warning-ignore:unused_argument
func has_left_piece(piece, level):
	if piece[1] == 0:
		return 0
	else:
		return current_level_array[piece[0]][piece[1] - 1]


# warning-ignore:unused_argument
func has_right_piece(piece, level):
	if piece[1] == 9:
		return 0
	else:
		return current_level_array[piece[0]][piece[1] + 1]


func check_under():
	is_searching = true
	for i in $PuzzlePieces.get_children():
		if not i.level_position == $PuzzlePieces.last_piece_gotten and not i.situation_array[1][1] == 2:
			i.is_under_last_gotten_piece(true)
			if i.situation_array[1][1] == 2:
				yield(get_tree().create_timer(i.bop_speed), "timeout")
	is_searching = false


func check_above():
	is_searching = true
	for i in $PuzzlePieces.get_children():
		if not i.level_position == $PuzzlePieces.last_piece_gotten and not i.situation_array[1][1] == 2:
			i.is_above_last_gotten_piece(true)
	is_searching = false


func check_left_of():
	is_searching = true
	for i in $PuzzlePieces.get_children():
		if not i.level_position == $PuzzlePieces.last_piece_gotten and not i.situation_array[1][1] == 2:
			i.is_left_of_last_gotten_piece(true)
			if i.situation_array[1][1] == 2:
				yield(get_tree().create_timer(i.bop_speed), "timeout")
	is_searching = false


func check_right_of():
	is_searching = true
	for i in $PuzzlePieces.get_children():
		if not i.level_position == $PuzzlePieces.last_piece_gotten and not i.situation_array[1][1] == 2:
			i.is_right_of_last_gotten_piece(true)
	is_searching = false


func is_level_complete():
	for i in $PuzzlePieces.get_children():
		if i.situation_array[1][1] == 1:
			var current_piece_neighbours = []
			current_piece_neighbours.append(has_bottom_piece($PuzzlePieces.last_piece_gotten, current_level))
			current_piece_neighbours.append(has_top_piece($PuzzlePieces.last_piece_gotten, current_level))
			current_piece_neighbours.append(has_left_piece($PuzzlePieces.last_piece_gotten, current_level))
			current_piece_neighbours.append(has_right_piece($PuzzlePieces.last_piece_gotten, current_level))
			if not current_piece_neighbours.has(1):
				yield(get_tree().create_timer(0.3), "timeout")
				$Errorsound.play()
				yield(get_tree().create_timer(0.8), "timeout")
				restart()
			return
	for i in $PuzzlePieces.get_children():
		i.modulate = Global.COLOR_DEFAULT
	yield(get_tree().create_timer(1), "timeout")
	transition()


func restart():
	var pieces_to_reset = $PuzzlePieces.historic
	pieces_to_reset.invert()
	
	is_searching = true
	for i in pieces_to_reset:
		yield(get_tree().create_timer(0.04), "timeout")
		find_piece(i).set_default()
	$PuzzlePieces.historic = []
	current_level_array = levels[current_level]
	$PuzzlePieces.set_last_piece_gotten($PuzzlePieces.start_piece)
	is_searching = false


func find_piece(level_position_to_find):
	for i in $PuzzlePieces.get_children():
		if i.level_position == level_position_to_find:
			return i


func transition():
	$FlashSound.play()
	yield(get_tree().create_timer(0.1), "timeout")
	$Illumination/AnimationPlayer.play("flash")
	yield(get_tree(), "idle_frame")
	clear_puzzle()
	yield(get_tree().create_timer(1), "timeout")
	$PostcardArea/CollisionShape2D.disabled = false


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_PostcardArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			$PostcardArea/CollisionShape2D.disabled = true
			emit_signal("clicked_on_postcard")
			
			$Tween.interpolate_property($Postcard, "offset", Vector2(96, 50), Vector2(-96, 50), 1, Tween.TRANS_EXPO)
			$Tween.start()
			yield(get_tree().create_timer(1), "timeout")
			$Tween.interpolate_property($Postcard, "offset", Vector2(288, 50), Vector2(96, 50), 1.5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
			$Tween.interpolate_property($PuzzlePieces, "position", Vector2(192, 0), Vector2(0, 0), 1.5, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
			$Tween.start()
			yield(get_tree().create_timer(0.1), "timeout")
			draw_puzzle(current_level + 1)
			yield(get_tree().create_timer(0.9), "timeout")


func _on_PostcardArea_mouse_entered():
	Global.mouse_hovering_count += 1


func _on_PostcardArea_mouse_exited():
	if Global.mouse_hovering_count > 0:
		Global.mouse_hovering_count -= 1
