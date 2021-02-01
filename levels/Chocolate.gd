extends Sprite


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Clickable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if not event.pressed:
				$Clickable/CollisionShape2D.disabled = true
				$DrinkingSound.play()
				$Tween.interpolate_property(self, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 1, Tween.EASE_OUT)
				$Tween.start()
				get_node("..").new_stuff_eaten()
