# Simple pause menu logic

extends BaseMenu

signal resume_pressed
signal restart_pressed
signal exit_pressed


func ready() -> void:
	# warning-ignore:return_value_discarded
	get_button("ButtonResume").connect("button_up", self, "_on_resume_up")
	# warning-ignore:return_value_discarded
	get_button("ButtonRestart").connect("button_up", self, "_on_restart_up")
	# warning-ignore:return_value_discarded
	get_button("ButtonExit").connect("button_up", self, "_on_exit_up")
	_connect_to_confirmation_menu()

func _on_resume_up() -> void:
	self.is_active = false
	emit_signal("resume_pressed")
	Events.emit_signal("menu_pause_closed")
	Utility.unpause_game()


func _on_restart_up() ->  void:
	_show_confirmation_menu(Actions.LEVEL_RESTART)
	emit_signal("restart_pressed")


func _on_exit_up() -> void:
	emit_signal("exit_pressed")
	_show_confirmation_menu(Actions.LEVEL_EXIT)
	

func _confirm_action() -> void:
	match action_to_confirm:
		Actions.LEVEL_RESTART:
			Events.emit_signal("restart_level")
			pass
		Actions.LEVEL_EXIT:
			Events.emit_signal("level_exit")
			pass


func _decline_action() -> void:
	_switch_menu_visibility(true)
