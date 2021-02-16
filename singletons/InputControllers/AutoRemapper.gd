#* This scripo automatically remaps action's events if a player use different from QWERTY latin keyboard layout.

extends Node


const Layout = {
	QWERTY = "QWERTY",
	AZERTY = "AZERTY",
	QZERTY = "QZERTY",
	DVORAK = "DVORAK",
	NEO = "NEO",
	COLEMAK = "COLEMAK",
	ERROR = "ERROR"
}

var _keyboard_layout : String = Layout.QWERTY
var _default_input_map := {}


func _init():
	# Save the default input map into a dictionary
	for action in InputMap.get_actions():
		_default_input_map[action] = InputMap.get_action_list(action)


func _unhandled_input(event: InputEvent) -> void:
		
	if InputManager.current_input_device == InputManager.InputDevice.KEYBOARD:
		var current_keyboard_layout = OS.get_latin_keyboard_variant()
		
		if current_keyboard_layout == Layout.ERROR:
			push_error("Can'get latin keyboard variant %s" % self.name)
			return
		
		if current_keyboard_layout != _keyboard_layout:
			match current_keyboard_layout:
				Layout.QWERTY:
					_remap_to_qwerty()
					pass
				Layout.AZERTY:
					_remap_to_azerty()
					pass
				Layout.QZERTY:
					_remap_to_qzerty()
					pass
				Layout.DVORAK:
					_remap_to_dvorak()
					pass
				Layout.NEO:
					_remap_to_neo()
					pass
				Layout.COLEMAK:
					_remap_to_colemak()
					pass
			
			print_debug("Keybindings were remapped from %s to %s" % [_keyboard_layout, current_keyboard_layout])
			_keyboard_layout = current_keyboard_layout


func _remap_to_qwerty() -> void:
	_remap_to_default_inputmap()
	pass


func _remap_to_azerty() -> void:
	_remap_event("ui_up", KEY_W, KEY_Z)
	pass


func _remap_to_qzerty() -> void:
	_remap_event("ui_up", KEY_W, KEY_Z)
	pass


func _remap_to_dvorak() -> void:
	_remap_event("ui_up", KEY_W, KEY_COMMA)
	_remap_event("ui_down", KEY_S, KEY_O)
	pass


func _remap_to_neo() -> void:
	_remap_event("ui_up", KEY_W, KEY_V)
	_remap_event("ui_down", KEY_S, KEY_I)
	pass


func _remap_to_colemak() -> void:
	_remap_event("ui_down", KEY_S, KEY_R)
	pass


# Use this method to remap actions
func _remap_event(action: String, old_key: int, new_key: int) -> void:
	if not InputMap.has_action(action):
		push_error("Action %s not found in InputMap." % action)
		return
	
	var old_event = InputEventKey.new()
	old_event.scancode = old_key
	
	if not InputMap.action_has_event(action, old_event):
		push_error("Action %s doesnt have InputEvent %s" % [action, old_event.as_text()])
		return
		
	var new_event = InputEventKey.new()
	new_event.scancode = new_key
	
	InputMap.action_erase_event(action, old_event)
	InputMap.action_add_event(action, new_event)


# Use this function to remap to default input map
# Be careful with this function, use it for only one layout strictly
# I consider QWERTY as a default for everyone
func _remap_to_default_inputmap() -> void:
	for action in InputMap.get_actions():
		InputMap.erase_action(action)
		
	for action in _default_input_map:
		InputMap.add_action(action)
		for event in _default_input_map[action]:
			InputMap.action_add_event(action, event)
