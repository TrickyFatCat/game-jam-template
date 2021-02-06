extends Node


static func get_facing_direction(target: Node2D) -> Vector2:
	return Vector2.RIGHT.rotated(target.rotation)


static func get_player_position() -> Vector2:
	return GameManager.player.global_position


static func get_direction_to_player(target: Node2D) -> Vector2:
	return (get_player_position() - target.global_position).normalized()


static func get_distance_to_player(target: Node2D) -> float:
    return get_player_position().distance_to(target.global_position)
    

func is_game_paused() -> bool:
    return get_tree().paused


func pause_game() -> void:
    get_tree().paused = true


func unpause_game() -> void:
    get_tree().paused = false