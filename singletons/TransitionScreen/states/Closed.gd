extends State


func unhandled_input(event: InputEvent) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	Events.emit_signal("transition_screen_closed")


func exit() -> void:
	return
