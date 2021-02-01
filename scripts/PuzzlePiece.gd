extends Area2D


onready var puzzle_pieces = get_node("..")
onready var levels = puzzle_pieces.get_node("..")

var situation_array
var is_start_piece: bool = false
var is_wall_piece: bool = false
var level_position: Array
var bop_speed: float = 0.1


func initialize_form():
	var normalized_situation_array = situation_array
	
	for i in [0, 1, 2]:
		for j in [0, 1, 2]:
			if normalized_situation_array[i][j] == 2:
				normalized_situation_array[i][j] = 1
	
	normalized_situation_array[1][1] = 0
				
	match normalized_situation_array:
		[[0, 0, 0], [0, 0, 1], [0, 1, 0]]:
			$Sprite.frame = 0
		[[0, 0, 0], [1, 0, 1], [0, 1, 0]]:
			$Sprite.frame = 1
		[[0, 0, 0], [1, 0, 0], [0, 1, 0]]:
			$Sprite.frame = 2
		[[0, 1, 0], [0, 0, 1], [0, 1, 0]]:
			$Sprite.frame = 3
		[[0, 1, 0], [1, 0, 1], [0, 1, 0]]:
			$Sprite.frame = 4
		[[0, 1, 0], [1, 0, 0], [0, 1, 0]]:
			$Sprite.frame = 5
		[[0, 1, 0], [0, 0, 1], [0, 0, 0]]:
			$Sprite.frame = 6
		[[0, 1, 0], [1, 0, 1], [0, 0, 0]]:
			$Sprite.frame = 7
		[[0, 1, 0], [1, 0, 0], [0, 0, 0]]:
			$Sprite.frame = 8
		[[0, 0, 0], [0, 0, 1], [0, 0, 0]]:
			$Sprite.frame = 9
		[[0, 0, 0], [0, 0, 0], [0, 1, 0]]:
			$Sprite.frame = 10
		[[0, 0, 0], [1, 0, 0], [0, 0, 0]]:
			$Sprite.frame = 11
		[[0, 1, 0], [0, 0, 0], [0, 0, 0]]:
			$Sprite.frame = 12
		[[0, 0, 0], [0, 0, 0], [0, 0, 0]]:
			$Sprite.frame = 13
		[[0, 1, 0], [0, 0, 0], [0, 1, 0]]:
			$Sprite.frame = 14
		[[0, 0, 0], [1, 0, 1], [0, 0, 0]]:
			$Sprite.frame = 15


func initialize_type():
	is_start_piece = situation_array[1][1] == 3
	if is_start_piece:
		set_start_piece()
	
	is_wall_piece = situation_array[1][1] == 4
	if is_wall_piece:
		set_wall_piece()
		


func _on_PuzzlePiece_mouse_entered():
	Global.mouse_hovering_count += 1
	if not is_start_piece:
		modulate = Global.COLOR_HIGHLIGHT
	if (is_under_last_gotten_piece(false) or is_above_last_gotten_piece(false) 
		or is_left_of_last_gotten_piece(false) or is_right_of_last_gotten_piece(false)):
		modulate = Color(0.1, 3, 0.1, 1)


func _on_PuzzlePiece_mouse_exited():
	if Global.mouse_hovering_count > 0:
		Global.mouse_hovering_count -= 1
	if not is_start_piece and modulate in [Global.COLOR_HIGHLIGHT, Color(0.1, 3, 0.1, 1)] :
		modulate = Global.COLOR_DEFAULT


func set_default():
	get_node("BopSounds/Bop_" + str(randi() % 8 + 1)).play()
	if is_start_piece:
		levels.current_level_array[level_position[0]][level_position[1]] = 3
	else:
		levels.current_level_array[level_position[0]][level_position[1]] = 1
	$Sprite.frame -= 18
	$CollisionShape2D.disabled = false
	modulate = Color(1, 1, 1, 1)
	situation_array[1][1] = 1


func get_piece():
	set_gotten()
	get_node("BopSounds/Bop_" + str(randi() % 8 + 1)).play()
	


func set_gotten():
	if situation_array[1][1] == 1:
		levels.current_level_array[level_position[0]][level_position[1]] = 2
		puzzle_pieces.historic.append(level_position)
		$CollisionShape2D.disabled = true
		situation_array[1][1] = 2
		puzzle_pieces.set_last_piece_gotten(level_position)
		$Sprite.frame += 18
#		modulate = Color(1, 1, 1, 0.8)
		levels.is_level_complete()


func set_start_piece():
	$Sprite.frame += 18
	$CollisionShape2D.disabled = true
	puzzle_pieces.set_last_piece_gotten(level_position)
	puzzle_pieces.start_piece = level_position


func set_wall_piece():
	$Sprite.frame += 18
	$CollisionShape2D.disabled = true


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_PuzzlePiece_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed and not levels.is_searching:
			is_under_last_gotten_piece(true)
			if situation_array[1][1] == 1:
				is_above_last_gotten_piece(true)
				if situation_array[1][1] == 1:
					is_left_of_last_gotten_piece(true)
					if situation_array[1][1] == 1:
						is_right_of_last_gotten_piece(true)


func is_under_last_gotten_piece(sudo):
	if level_position[0] > 0 and situation_array[1][1] == 1:
		if puzzle_pieces.last_piece_gotten[0] + 1 == level_position[0] and puzzle_pieces.last_piece_gotten[1] == level_position[1]:
			if sudo:
				get_piece()
				yield(get_tree().create_timer(bop_speed), "timeout")
				levels.check_under()
			return true
		else:
			return false


func is_above_last_gotten_piece(sudo):
	if level_position[0] < 4 and situation_array[1][1] == 1:
		if puzzle_pieces.last_piece_gotten[0] - 1 == level_position[0] and puzzle_pieces.last_piece_gotten[1] == level_position[1]:
			if sudo:
				get_piece()
				yield(get_tree().create_timer(bop_speed), "timeout")
				levels.check_above()
			return true
		else:
			return false


func is_left_of_last_gotten_piece(sudo):
	if level_position[1] < 10 and situation_array[1][1] == 1:
		if puzzle_pieces.last_piece_gotten[1] + 1 == level_position[1] and puzzle_pieces.last_piece_gotten[0] == level_position[0]:
			if sudo:
				get_piece()
				yield(get_tree().create_timer(bop_speed), "timeout")
				levels.check_left_of()
			return true
		else:
			return false


func is_right_of_last_gotten_piece(sudo):
	if level_position[1] > -1 and situation_array[1][1] == 1:
		if puzzle_pieces.last_piece_gotten[1] - 1 == level_position[1] and puzzle_pieces.last_piece_gotten[0] == level_position[0]:
			if sudo:
				get_piece()
				yield(get_tree().create_timer(bop_speed), "timeout")
				levels.check_right_of()
			return true
		else:
			return false
