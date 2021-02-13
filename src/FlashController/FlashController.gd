#* This script created flashing effect using shd_fill.shader
#* Add it as a child node to your sprites

extends Node

signal flash_started()
signal flash_finished()

const MIN_FLASH_ALPHA: float = 0.0
const MAX_FLASH_ALPHA: float = 1.0

export(float) var flash_duration_time := 0.35

var is_oneshot : bool = true
var _is_active : bool = false setget , get_is_active
var _flash_tween : Tween

onready var material : ShaderMaterial = get_parent().material


func get_is_active() -> bool:
	return _is_active


func _init(flash_duration: float) -> void:
	_flash_tween = Utility.create_new_tween("FlashTween")
	_flash_tween.connect("tween_all_completed", self, "_restart_flash")
	flash_duration_time = flash_duration


func start_flash(flash_once: bool = true) -> void:
	is_oneshot = flash_once
	_start_tween()
	_is_active = true


func stop_flash() -> void:
	if _flash_tween.is_active():
		_flash_tween.stop_all()
	
	_set_flash_alpha(0.0)
	_is_active = false
	emit_signal("flash_finished")


func _set_flash_alpha(value: float) -> void:
	value = clamp(value, MIN_FLASH_ALPHA, MAX_FLASH_ALPHA)
	material.set_shader_param("u_alpha", value)


func _start_tween() -> void:
	_flash_tween.interpolate_method(
		self,
		"_set_flash_alpha",
		MAX_FLASH_ALPHA,
		MIN_FLASH_ALPHA,
		flash_duration_time,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	_flash_tween.start()


func _restart_flash() -> void:
	if not is_oneshot:
		_start_tween()
	else:
		emit_signal("flash_finished")
		_is_active = false
