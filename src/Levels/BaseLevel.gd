#* Base level script

class_name BaseLevel
extends Node

const LOAD_DEALAY_TIME : float = 0.5


func _init() -> void:
	init()


func _ready() -> void:
	ready()
	yield(get_tree().create_timer(LOAD_DEALAY_TIME), "timeout")
	Events.emit_signal("level_loaded")


func init() -> void:
	pass


func ready() -> void:
	pass
