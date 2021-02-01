extends Node2D


func _ready():
	wink()


func wink():
	yield(get_tree().create_timer(2 + randi() % 2),"timeout")
	$ClosedEyes.visible = true
	yield(get_tree().create_timer(0.1),"timeout")
	$ClosedEyes.visible = false
	wink()


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Clickable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if not event.pressed:
				get_node("../Fade/AnimationPlayer").play("fade_out")
				yield(get_tree().create_timer(0.5),"timeout")
				visible = false
				get_node("../Fade/AnimationPlayer").play("fade_in")
				yield(get_tree().create_timer(0.5),"timeout")
				get_node("../TableScene/Madeleine_1/Clickable/CollisionShape2D").disabled = false
				get_node("../TableScene/Madeleine_2/Clickable/CollisionShape2D").disabled = false
				get_node("../TableScene/Chocolate/Clickable/CollisionShape2D").disabled = false
		


func turn_head():
	$Head.frame = 1
	yield(get_tree().create_timer(0.2),"timeout")
	$Head.frame = 2
	yield(get_tree().create_timer(1),"timeout")
	get_node("../Fade/AnimationPlayer").play("fade_out")
	yield(get_tree().create_timer(1),"timeout")
	get_node("../..").load_scene(get_node("../..").puzzles)
