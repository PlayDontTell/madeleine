extends Node2D


var time: float = 0
var is_titlescreen_visible: bool = true
export var title_frequency: float = 2
export var title_amplitude: float = 4
var butterfly_is_free: bool = true
var butterfly_flying_time: float = 0
var butterfly_direction: float = -1
var train_start: bool = false
export var butterfly_speed: float = 36
export var train_speed: float = 300


func _ready():
	$Butterfly.position.y = 28


func _process(delta):
	time += delta
	
	if is_titlescreen_visible:
		var movement_part_1 = sin(time * title_frequency) * title_amplitude
		var movement_part_2 = -sin(time * title_frequency) * title_amplitude
		$Title1.position.y += movement_part_1 * delta
		$Title2.position.y += movement_part_2 * delta
		
		if not butterfly_is_free:
			$Butterfly.playing = true
			butterfly_flying_time += delta
			$Butterfly.position.x += butterfly_speed * delta
			$Butterfly.position.y += sin($Butterfly.position.x * 0.1) * 20 * delta - 0.002 * $Butterfly.position.x * butterfly_direction
			
		if butterfly_direction == -1 and butterfly_flying_time >= 2.8:
			$Butterfly.position = Vector2(93, 53)
			butterfly_is_free = true
			butterfly_direction = 1
			butterfly_flying_time = 0
			$Butterfly.playing = false
			animate_butterfly()
		
		if train_start:
			$Train.position.x += train_speed * delta


func animate_butterfly():
	if butterfly_is_free:
		yield(get_tree().create_timer(2 + randi() % 4),"timeout")
		animate_butterfly()
		$Butterfly.playing = true
		yield(get_tree().create_timer(0.6 + randi() % 2),"timeout")
		$Butterfly.playing = not butterfly_is_free
	else:
		$Butterfly.playing = true
