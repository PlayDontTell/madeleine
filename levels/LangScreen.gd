extends Node2D


onready var game_manager = get_node("..")


func _ready():
	yield(get_tree().create_timer(0.1), "timeout")
	$Fade/AnimationPlayer.play("fade_in")


func _on_FR_mouse_entered():
	Global.mouse_hovering_count += 1
	$Background/cache_1.visible = false


func _on_FR_mouse_exited():
	if Global.mouse_hovering_count > 0:
		Global.mouse_hovering_count -= 1
	$Background/cache_1.visible = true


func _on_ENG_mouse_entered():
	Global.mouse_hovering_count += 1
	$Background/cache_2.visible = false


func _on_ENG_mouse_exited():
	if Global.mouse_hovering_count > 0:
		Global.mouse_hovering_count -= 1
	$Background/cache_2.visible = true


func _on_FR_pressed():
	Global.language = "fr"
	launch_game()


func _on_ENG_pressed():
	Global.language = "eng"
	launch_game()

func launch_game():
	$Fade/AnimationPlayer.play("fade_out")
	yield(get_tree().create_timer(0.8), "timeout")
	game_manager.load_scene(game_manager.logoscreen)
