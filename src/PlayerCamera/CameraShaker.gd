extends Node

const TRANS := Tween.TRANS_SINE
const EASE := Tween.EASE_IN_OUT

var amplitude : int = 0
var priority : int = 0
var _frequency_timer : Timer
var _duration_timer : Timer
var _shake_tween : Tween

onready var _camera : Camera2D = get_parent()


func _on_FrequencyTimer_timeout() -> void:
	_new_shake()
 

func _on_DurationTimer_timeout() -> void:
	_reset()
	_frequency_timer.stop()


func _init() -> void:
	_frequency_timer = Timer.new()
	self.add_child(_frequency_timer)
	_frequency_timer.name = "FrequencyTimer"
	_frequency_timer.connect("timeout", self, "_on_FrequencyTimer_timeout")
	
	_duration_timer = Timer.new()
	self.add_child(_duration_timer)
	_duration_timer.name = "DurationTimer"
	_duration_timer.connect("timeout", self, "_on_DurationTimer_timeout")

	_shake_tween = Tween.new()
	_shake_tween.name = "ShakeTween"
	self.add_child(_shake_tween)



func start(
	duration: float = 0.2,
	frequency: float = 15.0,
	shake_amplitude: int = 16,
	shake_priority: int = 0
	) -> void:
	if shake_priority >= self.priority:
		amplitude = shake_amplitude
		_duration_timer.wait_time = duration
		_frequency_timer.wait_time = 1 / frequency
		_duration_timer.start()
		_frequency_timer.start()
		_new_shake()


func _new_shake() -> void:
	var rand = Vector2.ZERO
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
# warning-ignore:return_value_discarded
	_shake_tween.interpolate_property(
		_camera,
		"offset",
		_camera.offset,
		rand,
		_frequency_timer.wait_time,
		TRANS,
		EASE
	)
# warning-ignore:return_value_discarded
	_shake_tween.start()


func _reset() -> void:
# warning-ignore:return_value_discarded
	_shake_tween.interpolate_property(
		_camera, "offset",
		_camera.offset,
		Vector2.ZERO,
		_frequency_timer.wait_time,
		TRANS,
		EASE
	)
# warning-ignore:return_value_discarded
	_shake_tween.start()
	priority = 0
