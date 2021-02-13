#* This is a basic menu controller class. It contains basic functions.
#* Inherit all menu scripts from this class

class_name BaseMenu
extends Control

# warning-ignore:unused_signal
signal deactivated
# warning-ignore:unused_signal
signal activated

enum Actions {
	LEVEL_RESTART,
	LEVEL_EXIT,
	QUIT_GAME
}

export(bool) var is_active := true setget _set_is_active

var menu_buttons : Array
var action_to_confirm : int
var _confirmation_menu : Control

onready var _menu_body : CenterContainer = $MenuBody


func _ready() -> void:
	_set_menu_buttons()
	ready()


func ready() -> void:
	pass


func open_menu() -> void:
	self.is_active = true
	_focus_first_button()


func close_menu() -> void:
	self.is_active = false
	_release_focus()


func get_button(button_name: String) -> Node:
	return get_node("MenuBody/VBoxContainer/Buttons/%s" % button_name)


func _set_menu_buttons() -> void:
	menu_buttons = $MenuBody/VBoxContainer/Buttons.get_children()


func _set_is_active(value: bool) -> void:
	is_active = value
	visible = value
	_set_buttons_active(value)
	_on_change_is_active(value)


# warning-ignore:unused_argument
func _on_change_is_active(value: bool) -> void:
	#* Write additional logic on activation here
	pass

func _set_buttons_active(value: bool) -> void:
	for button in menu_buttons:
		button.is_active = value


func _focus_first_button() -> void:
	_focus_button(0)


func _focus_button(button_index: int) -> void:
	menu_buttons[button_index].grab_focus()


func _release_focus() -> void:
	if get_focus_owner():
		get_focus_owner().release_focus()


func _confirm_action() -> void:
	#* Write logic on action confirmation
	#* Requires using menu confirmation node
	pass


func _decline_action() -> void:
	#* Write logic on action confirmation
	#* Requires using menu confirmation node
	pass


func _switch_menu_visibility(is_visible: bool) -> void:
	_menu_body.visible = is_visible
	_set_buttons_active(is_visible)

	if is_visible:
		_focus_first_button()
	else:
		_release_focus()


func _show_confirmation_menu(action_id: int) -> void:
	_switch_menu_visibility(false)
	_confirmation_menu.open_menu()
	action_to_confirm = action_id


# This method helps to avoid cyclic calls
func _connect_to_confirmation_menu() -> void:
	_confirmation_menu = $ConfirmationMenu
	# warning-ignore:return_value_discarded
	_confirmation_menu.connect("yes_pressed", self, "_confirm_action")
	# warning-ignore:return_value_discarded
	_confirmation_menu.connect("no_pressed", self, "_decline_action")
