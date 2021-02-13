# This is a base resource class.
# You can use it to make hit points, stamina points and etc.

class_name BaseResource
extends Node

signal value_decreased()
signal value_increased()
signal value_max_increased()
signal value_max_decreased()
signal value_zero()

const VALUE_MIN : float = 0.0

export(float) var value_init := 0.0
export(float) var value_max := 0.0 setget set_value_max, get_value_max

var _value_current : float = 0.0 setget ,get_value_current


func _inint() -> void:
	_value_current = value_max if value_init <= 0 else value_init


func decrease_value(amount: float) -> float:
	_value_current -= amount
	_value_current = max(_value_current, VALUE_MIN)

	if _value_current > 0:
		emit_signal("value_decreased")
	else:
		emit_signal("value_zero")
	
	return _value_current


func decrease_max_value(amount: float) -> float:
	value_max -= amount
	value_max = max(value_max, VALUE_MIN)
	
	if value_max > 0:
		emit_signal("value_max_decreased")
		
		if _value_current > value_max:
			_value_current = value_max
	else:
		_value_current = value_max
		emit_signal("value_zero")
		
	return value_max


func increase_value_limited(amount: float) -> float:
	_value_current += amount
	_value_current = min(_value_current, value_max)
	emit_signal("value_increased")
	
	return _value_current


func increase_value(amount: float) -> float:
	_value_current += amount
	emit_signal("value_increased")
	
	return _value_current


func increase_max_value(amount: float) -> float:
	value_max += amount
	emit_signal("value_max_increased")
	
	return value_max


func set_value_max(value: float) -> float:
	if value <= 0.0:
		push_error("Can't set max value less or equal zero. Node %s in %s." % [name, get_path()])
		return 0.0
	
	value_max = value
	
	if _value_current > value_max:
		_value_current = value_max
	
	return value_max


func get_value_max() -> float:
	return value_max


func get_value_current() -> float:
	return _value_current
