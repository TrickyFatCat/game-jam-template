extends State


# warning-ignore:unused_argument
func unhandled_input(event: InputEvent) -> void:
	return


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	Events.emit_signal("transition_started")
	return


func exit() -> void:
	if TransitionScreen.target_state == TransitionScreen.state_opened:
		Events.emit_signal("transition_screen_opened")
	elif TransitionScreen.target_state == TransitionScreen.state_closed:
		Events.emit_signal("transition_screen_closed")
	return
