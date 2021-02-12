extends Node


static func get_facing_direction(target: Node2D) -> Vector2:
	return Vector2.RIGHT.rotated(target.rotation)


static func get_player_position() -> Vector2:
	return GameManager.player.global_position


static func get_direction_to_player(target: Node2D) -> Vector2:
	return (get_player_position() - target.global_position).normalized()


static func get_distance_to_player(target: Node2D) -> float:
	return get_player_position().distance_to(target.global_position)


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
