extends Node2D


onready var game_manager = get_node("..")


func _ready():
	$text_part1.modulate = Global.COLOR_TRANPARENT
	$text_part2.modulate = Global.COLOR_TRANPARENT
	$text_part3.modulate = Global.COLOR_TRANPARENT
	$text_part4.modulate = Global.COLOR_TRANPARENT
	
	if Global.language == "eng":
		$text_part1.bbcode_text = "\"When from a distant past nothing subsists ..."
		$text_part2.bbcode_text = """


... more fragile but more enduring, the smell and taste are still vivid ..."""
		$text_part3.bbcode_text = """





... like souls that wear without flinching, the immense edifice of memory.\" """
	
	$Logo.modulate = Global.COLOR_BLACK
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	Global.logo_visible = true
	yield(get_tree().create_timer(1),"timeout")
	
	$Tween.interpolate_property($Logo, "modulate", Global.COLOR_BLACK, Global.COLOR_DEFAULT, 1, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(0.5),"timeout")
	
	$LogoSound.play()
	yield(get_tree().create_timer(1.5),"timeout")

	$Tween.interpolate_property($Logo, "modulate", Global.COLOR_DEFAULT, Global.COLOR_BLACK, 0.5, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(0.8),"timeout")
	
	
	yield(get_tree().create_timer(0.8),"timeout")
	$Tween.interpolate_property($text_part1, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 1.5, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(3.8),"timeout")
	$Tween.interpolate_property($text_part2, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 1.5, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(5.2),"timeout")
	$Tween.interpolate_property($text_part3, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 1.5, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(2),"timeout")
	$Tween.interpolate_property($text_part4, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 5, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(5),"timeout")
	
	$Tween.interpolate_property($text_part1, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 0.5, Tween.TRANS_SINE)
	$Tween.interpolate_property($text_part2, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 0.5, Tween.TRANS_SINE)
	$Tween.interpolate_property($text_part3, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 0.5, Tween.TRANS_SINE)
	$Tween.interpolate_property($text_part4, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 0.5, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(0.8),"timeout")
	
	
	Global.logo_visible = false
	game_manager.load_scene(game_manager.title_screen)
