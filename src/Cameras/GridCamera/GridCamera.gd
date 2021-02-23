class_name GridCamera
extends BaseCamera

var grid_pos : Vector2 = Vector2.ZERO

export(NodePath) var target_node_path := "" setget _set_target_node

onready var _grid_size : Vector2 = get_viewport().get_visible_rect().size
onready var _target_node := get_node(target_node_path)

func init() -> void:
	# warning-ignore:return_value_discarded
	Events.connect("level_loaded", self, "_snap_camera")


# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
	pass


func _update_position() -> void:
	var x : float = floor(_target_node.global_position.x / _grid_size.x)
	var y : float = floor(_target_node.global_position.y / _grid_size.y)
	var new_pos : Vector2 = Vector2(x, y)
	
	if grid_pos == new_pos:
		return
		
	grid_pos = new_pos
	position = grid_pos * _grid_size


func _snap_camera() -> void:
	if _target_node:
		_grid_size = get_viewport().get_visible_rect().size
		_grid_size *= camera.zoo
		_update_position()
		set_physics_process(true)
	else:
		set_physics_process(false)


func _set_target_node(value: String) -> Node:
	target_node_path = value
	_target_node = get_node(target_node_path)
	return _target_node
