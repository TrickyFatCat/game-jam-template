#* Simple game over menu in which player can restart or exit to a main menu

extends BaseMenu

signal restart_pressed
signal exit_pressed


func ready() -> void:
	_set_buttons_active(is_active)
	get_button("ButtonRestart").connect("button_up", self, "_button_restart_pressed")
	get_button("ButtonExit").connect("button_up", self, "_button_exit_pressed")
	_connect_to_confirmation_menu()


func _button_restart_pressed() -> void:
	_set_buttons_active(false)
	Events.emit_signal("restart_level")


func _button_exit_pressed() -> void:
	_show_confirmation_menu(Actions.LEVEL_EXIT)


func _confirm_action() -> void:
	if action_to_confirm == Actions.LEVEL_EXIT:
		Events.emit_signal("level_exit")


func _decline_action() -> void:
	_switch_menu_visibility(true)
