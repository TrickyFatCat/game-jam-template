class_name BaseTrigger
extends Area2D

signal target_entered()
signal target_exited()
signal trigger_activated()
signal trigger_deactivated()

export(bool) var is_oneshot := false
export(bool) var is_interactable := false

var _is_target_inside : bool = false setget ,get_is_target_inside
var _is_activated : bool = false setget ,get_is_activated


func get_is_target_inside() -> bool:
	return _is_target_inside


func get_is_activated() -> bool:
	return _is_activated


func _init() -> void:
	connect("body_entered", self, "_on_body_entered")
	connect("body_exited", self, "_on_body_exited")


func _unhandled_input(event: InputEvent) -> void:
	if is_interactable and _is_target_inside and event.is_action_pressed("interact"):
		if not _is_activated:
			_activate_trigger()
		else:
			_deactivate_trigger() 


func _on_body_entered(body: KinematicBody2D) -> void:
	_is_target_inside = true
	emit_signal("target_entered")
	
	if not is_interactable:
		_activate_trigger()


func _on_body_exited(body: KinematicBody2D) -> void:
	_is_target_inside = false
	emit_signal("target_entered")
	
	if not is_interactable:
		_deactivate_trigger()


func _activate_trigger() -> void:
	if not _is_activated:
		_is_activated = true
		emit_signal("trigger_activated")
	

func _deactivate_trigger() -> void:
	if _is_activated and not is_oneshot:
		_is_activated = false
		emit_signal("trigger_deactivated")
