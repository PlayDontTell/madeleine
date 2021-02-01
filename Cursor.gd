extends Sprite


var mouse_pressed: bool = false
var mouse_arrow: bool = false
var mouse_on_ui: bool = false


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	z_index = 64


func _input(event):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT:
		if event.pressed:
			if Global.mouse_hovering_count > 0:
				get_node("BopSounds/Bop_" + str(randi() % 8 + 1)).play()
		else:
			pass
		mouse_pressed = event.pressed

# warning-ignore:unused_argument
func _process(delta):
	position = get_global_mouse_position() - Vector2(2, 2)
	
	# Animation of the mouse cursor.
	var special_cursor = ""
	
	if Global.force_hand_cursor:
		special_cursor = "_hand"
		
	else:
		change_cursor_animation("default" + special_cursor)
		if Global.mouse_hovering_count > 0:
			change_cursor_animation("hover" + special_cursor)
			if mouse_pressed:
				change_cursor_animation("pressed" + special_cursor)
	
	if Global.force_eye_cursor:
		change_cursor_animation("eye")
	
	if Global.force_hidden_cursor:
		change_cursor_animation("hidden")


func change_cursor_animation(animation):
	$AnimationPlayer.play(animation)
	
	
func _on_Area2D_area_entered(area):
	if area.is_in_group("cursor_hover"):
		Global.mouse_hovering_count += 1
	
	elif area.is_in_group("ui"):
		mouse_on_ui = true
		
	if area.is_in_group("cursor_eye"):
		Global.force_eye_cursor = true
		
	if area.is_in_group("cursor_hand"):
		Global.force_hand_cursor = true
	
	if area.is_in_group("cursor_menu"):
		Global.force_menu_cursor = true


func _on_Area2D_area_exited(area):
	if area.is_in_group("cursor_hover") and Global.mouse_hovering_count > 0:
		Global.mouse_hovering_count -= 1
	
	elif area.is_in_group("ui"):
		mouse_on_ui = false
	
	if area.is_in_group("cursor_eye"):
		Global.force_eye_cursor = false
	
	if area.is_in_group("cursor_hand"):
		Global.force_hand_cursor = false
		
	if area.is_in_group("cursor_menu"):
		Global.force_menu_cursor = false
