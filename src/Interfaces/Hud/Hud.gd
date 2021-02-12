class_name Hud
extends Control

export(bool) var is_active := true setget _set_is_active

func _set_is_active(value: bool) -> void:
	is_active = value
	visible = value

#* Implement your Hud logic here
