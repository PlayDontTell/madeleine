extends Node2D

var lang_screen = "res://levels/LangScreen.tscn"
var logoscreen = "res://levels/Logoscene.tscn"
var title_screen = "res://levels/Titlescreen.tscn"
var puzzles = "res://levels/Levels.tscn"
var end_screen = "res://levels/EndScreen.tscn"
var creditsscene = "res://levels/Creditsscene.tscn"


func _ready():
	if Global.DEV_MODE:
		load_scene(puzzles)
	else:
		
		load_scene(lang_screen)


func load_scene(scene):
	if scene == title_screen and not Global.DEV_MODE:
		yield(get_tree().create_timer(0.9),"timeout")
		$Ressources/Music.play()
	
	if scene == end_screen:
		$Ressources/Tween.interpolate_property($Ressources/TrainInteriorSound, "volume_db", -12, -60, 2)
		$Ressources/Tween.start()
	
	if scene == creditsscene:
		$Ressources/Tween.interpolate_property($Ressources/Music, "volume_db", -12, -60, 6)
		$Ressources/Tween.start()
	
	# Load the next room and the ui node.
	var next_scene = ResourceLoader.load(scene)
	
	# Instance the next room and the ui node.
	var current_scene = next_scene.instance()
	
	yield(get_tree(), "idle_frame")
	
	if get_child_count() > 0:
		for i in get_children():
			if not i.name == "Ressources":
				remove_child(i)
				i.queue_free()
	
	add_child(current_scene)
