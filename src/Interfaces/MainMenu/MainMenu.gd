#* This script contains logic of the main menu.

tool
extends BaseMenu


func ready() -> void:
	_set_buttons_active(false)
	# warning-ignore:return_value_discarded
	Events.connect("transition_screen_opened", self, "_activate_menu")
	# warning-ignore:return_value_discarded
	get_button("ButtonStart").connect("button_up", self, "_on_button_start_pressed")
	# warning-ignore:return_value_discarded
	get_button("ButtonQuit").connect("button_up", self, "_on_button_quit_pressed")
	_connect_to_confirmation_menu()


func _on_button_start_pressed() -> void:
	_set_buttons_active(false)
	Events.emit_signal("load_level", {"target_level": "next"})


func _on_button_quit_pressed() -> void:
	_switch_menu_visibility(false)
	action_to_confirm = Actions.QUIT_GAME
	_confirmation_menu.open_menu()


func _activate_menu() -> void:
	_set_buttons_active(true)
	_focus_first_button()


func _confirm_action() -> void:
	if action_to_confirm == Actions.QUIT_GAME:
		Events.emit_signal("quit_game")


func _decline_action() -> void:
	_switch_menu_visibility(true)
