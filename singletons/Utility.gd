# This singleton contains some useful functions
extends Node


static func get_facing_direction(target: Node2D) -> Vector2:
	return Vector2.RIGHT.rotated(target.rotation)


static func get_player_position() -> Vector2:
	return GameManager.player.global_position


static func get_direction_to_object(initial_object: Node2D, target_object: Node2D) -> Vector2:
	return (initial_object.global_position - target_object.global_position).normalized()


static func get_distance_to_oject(initial_object: Node2D, target_object: Node2D) -> float:
	return initial_object.global_position.distance_to(target_object.global_position)


static func get_random_index(array: Array) -> int:
	return randi() % array.size()


static func get_random_index_weight(array_of_weights: Array) -> int:
	var weight_sum = 0
	var weight_total = 0
	var result
	
	for i in array_of_weights.size():
		weight_sum += array_of_weights[i]
	
	var dice_roll = randi() % weight_sum + 1
	
	for i in array_of_weights.size():
		weight_total += array_of_weights[i]
		
		if dice_roll <= array_of_weights[i]:
			result = i
	
	return result


# Converts given time in seconds in mm:ss:msms format
static func convert_time(time: float) -> String:
	var minutes = time / 60
	var seconds = int(time) % 60
	var miliseconds = int(fmod(time, seconds) * 1000)

	if seconds < 1:
		seconds = int(time + 1) % 60
		miliseconds = int(fmod(time, seconds) * 1000)
		seconds = 0

	if miliseconds < 0:
		minutes = 0
		seconds = 0
		miliseconds = 0
	
	return "%02d:%02d.%03d" % [minutes, seconds, miliseconds]


func pause_game() -> void:
	get_tree().paused = true


func unpause_game() -> void:
	get_tree().paused = false

#* Use this function to create timers
#* If you need to create oneshot timer, use create_timer() function in yield()
func create_new_timer(
	parent,
	duration : float = 1,
	is_oneshot : bool = false,
	is_autostarted : bool = false,
	name : String = "Timer"
) -> Timer:
	var new_timer = Timer.new();
	parent.add_child(new_timer)
	new_timer.wait_time = duration
	new_timer.one_shot = is_oneshot
	new_timer.autostart = is_autostarted
	new_timer.name = name
	return new_timer


func create_new_tween(
	parent,
	name : String = "Tween"
 ) -> Tween:
	var new_tween = Tween.new()
	parent.add_child(new_tween)
	new_tween.name = name
	return new_tween


func create_lifespan_timer(parent, duration : float) -> Timer:
	var lifespan_timer = create_new_timer(parent, duration, true, true, "LifespanTimer")
	lifespan_timer.connect("timeout", parent, "queue_free")
	return lifespan_timer
