extends Node2D


var stuff_eaten: int = 0


# warning-ignore:unused_argument
# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Clickable_input_event(viewport, event, shape_idx):
	pass # Replace with function body.


func new_stuff_eaten():
	stuff_eaten += 1
	if stuff_eaten == 3:
		yield(get_tree().create_timer(2),"timeout")
		get_node("../Fade/AnimationPlayer").play("fade_out")
		yield(get_tree().create_timer(0.5),"timeout")
		get_node("../TrainInteriorScene").visible = true
		get_node("../TrainInteriorScene/Madeleines").visible = false
		get_node("../Fade/AnimationPlayer").play("fade_in")
		yield(get_tree().create_timer(2),"timeout")
		get_node("../TrainInteriorScene").turn_head()
