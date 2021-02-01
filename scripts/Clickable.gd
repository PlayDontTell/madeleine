extends Area2D


func _on_Clickable_mouse_entered():
	Global.mouse_hovering_count += 1


func _on_Clickable_mouse_exited():
	if Global.mouse_hovering_count > 0:
		Global.mouse_hovering_count -= 1
