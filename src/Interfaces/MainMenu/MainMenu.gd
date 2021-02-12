#* This script contains logic of the main menu.

tool
extends BaseMenu

export(String, FILE, "*.tscn") var starting_level

onready var _confirmation_menu : Control = $ConfirmationMenu
onready var _menu_body : CenterContainer = $MenuBody


func _ready() -> void:
	_set_menu_buttons()
	_set_buttons_active(false)
	Events.connect("transition_screen_opened", self, "_activate_menu")
	_confirmation_menu.connect("yes_pressed", self, "_confirm_action")
	_confirmation_menu.connect("no_pressed", self, "_decline_action")
	get_button("ButtonStart").connect("button_up", self, "_on_button_start_pressed")
	get_button("ButtonQuit").connect("button_up", self, "_on_button_quit_pressed")


func _on_button_start_pressed() -> void:
	_set_buttons_active(false)
	print_debug("start_game")
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


func _switch_menu_visibility(is_visible: bool) -> void:
	_menu_body.visible = is_visible
	_set_buttons_active(is_visible)

	if is_visible:
		_focus_first_button()
	else:
		_release_focus()
