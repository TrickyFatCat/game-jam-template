#* This script contains logic of the main menu.

tool
extends BaseMenu

export(String, FILE, "*.tscn") var starting_level

onready var menuConfirm #:= $MenuConfirm
onready var _menu_body : CenterContainer = $MenuBody


func _ready() -> void:
	_set_menu_buttons()
	_set_buttons_active(false)
	Events.connect("transition_screen_opened", self, "_activate_menu")
	#menuConfirm.connect("yes_pressed", self, "_confirm_action")
	#menuConfirm.connect("no_pressed", self, "_decline_action")
	get_button("ButtonStart").connect("button_up", self, "_on_button_start_pressed")
	get_button("ButtonQuit").connect("button_up", self, "_on_button_quit_pressed")


func _on_button_start_pressed() -> void:
	_set_buttons_active(false)
	print_debug("start_game")
	Events.emit_signal("load_level", {"target_level": "next"})


func _on_button_quit_pressed() -> void:
	_switch_menu_visibility(false)
	Events.emit_signal("quit_game")
	#menuConfirm.open_menu()
	#action_to_confirm = Actions.QUIT_GAME


func _activate_menu() -> void:
	_set_buttons_active(true)
	_focus_first_button()


func _confirm_action() -> void:
	if action_to_confirm == Actions.QUIT_GAME:
		Events.emit_signal("quit_game")


func _decline_action() -> void:
	_switch_menu_visibility(true)


func _switch_menu_visibility(is_visible: bool) -> void:
	_menu_body.visible = is_visible
	_set_buttons_active(is_visible)

	if is_visible:
		_focus_first_button()
	else:
		_release_focus()
