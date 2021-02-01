extends Node2D


func _ready():
	yield(get_tree().create_timer(0.1),"timeout")
	$Fade/AnimationPlayer.play("fade_in")
	$TrainArrivalSound.play()
	
	yield(get_tree().create_timer(2),"timeout")
	$Tween.interpolate_property($Train, "position", Vector2(-1450, 33), Vector2(-960, 33), 4, Tween.TRANS_SINE, Tween.EASE_OUT)
	$Tween.start()
	
	yield(get_tree().create_timer(5),"timeout")
	$SmokeSound.play()
	yield(get_tree().create_timer(0.7),"timeout")
	$DoorSlidingSound.play()
	$Tween.interpolate_property($Train/Door, "offset", Vector2(0, 0), Vector2(12, 0), 0.5, Tween.TRANS_SINE)
	$Tween.start()
	
	yield(get_tree().create_timer(1.5),"timeout")
	$Flash.play()
	yield(get_tree().create_timer(0.1),"timeout")
	$Illumination/AnimationPlayer.play("flash")
	yield(get_tree().create_timer(0.05),"timeout")
	$Fade/AnimationPlayer.play("blackscreen")
	$Cursor.visible = false
	$Photo.visible = true
	yield(get_tree().create_timer(1),"timeout")
	$Tween.interpolate_property($PhotoColored, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 3.5)
	$Tween.start()
	yield(get_tree().create_timer(0.05),"timeout")
	$PhotoColored.visible = true
	
	yield(get_tree().create_timer(5.5),"timeout")
	$Photo.visible = false
	$Tween.interpolate_property($PhotoColored, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 1)
	$Tween.start()
	
	yield(get_tree().create_timer(1.5),"timeout")
	get_node("..").load_scene(get_node("..").creditsscene)
