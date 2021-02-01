extends Node2D


func _ready():
	$text_part1.modulate = Global.COLOR_TRANPARENT
	$text_part2.modulate = Global.COLOR_TRANPARENT
	
	if Global.language == "eng":
		$text_part1.bbcode_text = """


[center]Coding and Art
by Ivan Voirol"""
		$text_part2.bbcode_text = """
[center]Music

\"Memories of a Lost Autumn\"
Composed by Jonathan Shaw
 (www.jshaw.co.uk)[/center]"""
	
	yield(get_tree().create_timer(0.8),"timeout")
	$Tween.interpolate_property($text_part1, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 1, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(3),"timeout")
	$Tween.interpolate_property($text_part1, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 1, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
	
	yield(get_tree().create_timer(0.8),"timeout")
	$Tween.interpolate_property($text_part2, "modulate", Global.COLOR_TRANPARENT, Global.COLOR_DEFAULT, 1, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(3),"timeout")
	$Tween.interpolate_property($text_part2, "modulate", Global.COLOR_DEFAULT, Global.COLOR_TRANPARENT, 1, Tween.TRANS_SINE)
	$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
