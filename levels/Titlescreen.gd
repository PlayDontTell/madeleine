extends Node2D


func _ready():
	$TrainPassing/Title1. modulate = Global.COLOR_TRANPARENT
	$TrainPassing/Title2. modulate = Global.COLOR_TRANPARENT
	yield(get_tree().create_timer(0.1),"timeout")
	$Fade/AnimationPlayer.play("fade_in")
	
	$Tween.interpolate_property($TrainPassing/NatureSound, "volume_db", -60, -12, 1, Tween.EASE_IN_OUT)
	$Tween.start()
	$TrainPassing/NatureSound.play()
	$TrainPassing.animate_butterfly()
	
	yield(get_tree().create_timer(1),"timeout")
	$TrainPassing/WindSound.play()
	$Tween.interpolate_property($TrainPassing/Title1, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 3, Tween.EASE_OUT)
	$Tween.interpolate_property($TrainPassing/Title2, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 3, Tween.EASE_OUT)
	$Tween.start()
	yield(get_tree().create_timer(1.6),"timeout")
	$TrainPassing.butterfly_is_free = false


# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Clickable_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and $TrainPassing/Title1.modulate == Global.COLOR_DEFAULT:
		if event.button_index == BUTTON_LEFT:
			if not event.pressed:
				$TrainPassing.butterfly_is_free = false
				$TrainPassing/Butterfly.playing = true
				$Tween.interpolate_property($TrainPassing/Title1, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 2, Tween.EASE_IN)
				$Tween.interpolate_property($TrainPassing/Title2, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 2, Tween.EASE_IN)
				$Tween.interpolate_property($TrainPassing/NatureSound, "volume_db", -12, -60, 3, Tween.EASE_IN_OUT)
				$Tween.start()
				$TrainPassing/TrainPassingSound.play()
				yield(get_tree().create_timer(3.2),"timeout")
				
				$TrainPassing.train_start = true
				yield(get_tree().create_timer(2.7),"timeout")
				
				$Fade/AnimationPlayer.play("fade_out")
				$Tween.interpolate_property(get_node("../Ressources/TrainInteriorSound"), "volume_db", -60, -2, 0.8, Tween.EASE_IN_OUT)
				$Tween.start()
				get_node("../Ressources/TrainInteriorSound").play()
				yield(get_tree().create_timer(1.5),"timeout")
				$Tween.interpolate_property($TrainPassing/TrainPassingSound, "volume_db", -12, -60, 6)
				$Tween.start()
				$TrainPassing.is_titlescreen_visible = false
				$TrainPassing.visible = false
				
				$Fade/AnimationPlayer.play("fade_in")
				$TrainInteriorScene/Madeleines/Clickable/CollisionShape2D.disabled = false
