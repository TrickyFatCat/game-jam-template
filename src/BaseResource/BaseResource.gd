# This is a base resource class.
# You can use it to make hit points, stamina points and etc.

class_name BaseResource
extends Node

signal value_decreased(current_value, max_value)
signal value_increased(current_value, max_value)
signal value_max_increased(current_value, max_value)
signal value_max_decreased(current_value, max_value)
signal value_zero(current_value, max_value)

const VALUE_MIN : float = 0.0

export(float) var value_init := 0.0
export(float) var value_max := 0.0 setget set_value_max, get_value_max

var value_current : float = 0.0 setget ,get_value_current


func _inint() -> void:
	value_current = value_max if value_init <= 0 else value_init


func decrease_value(amount: float) -> float:
	value_current -= amount
	value_current = max(value_current, VALUE_MIN)

	if value_current > 0:
		emit_signal("value_decreased", value_current, value_max)
	else:
		emit_signal("value_zero", value_current, value_max)
	
	return value_current


func decrease_max_value(amount: float) -> float:
	value_max -= amount
	value_max = max(value_max, VALUE_MIN)
	
	if value_max > 0:
		emit_signal("value_max_decreased", value_current, value_max)
		
		if value_current > value_max:
			value_current = value_max
	else:
		value_current = value_max
		emit_signal("value_zero", value_current, value_max)
		
	return value_max


func increase_value_limited(amount: float) -> float:
	value_current = move_toward(value_current, value_max, amount)
	emit_signal("value_increased", value_current, value_max)
	
	return value_current


func increase_value(amount: float) -> float:
	value_current += amount
	emit_signal("value_increased", value_current, value_max)
	
	return value_current


func increase_max_value(amount: float) -> float:
	value_max += amount
	emit_signal("value_max_increased", value_current, value_max)
	
	return value_max


func set_value_max(value: float) -> float:
	if value <= 0.0:
		push_error("Can't set max value less or equal zero. Node %s in %s." % [name, get_path()])
		return value_max
	
	value_max = value
	
	if value_current > value_max:
		value_current = value_max
	
	return value_max


func get_value_max() -> float:
	return value_max


func get_value_current() -> float:
	return value_current


func get_normalized_value() -> float:
	return value_current / value_max
