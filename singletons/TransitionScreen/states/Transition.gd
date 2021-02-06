extends State


func unhandled_input(event: InputEvent) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	Events.emit_signal("transition_started")
	return


func exit() -> void:
	return