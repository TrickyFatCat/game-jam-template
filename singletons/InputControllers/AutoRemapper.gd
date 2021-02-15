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


func _input(event: InputEvent) -> void:
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
					_remap_to_colemac()
					pass
			
			_keyboard_layout = current_keyboard_layout
			print_debug("Keybindings were remapped.")


func _remap_to_qwerty() -> void:
	pass


func _remap_to_azerty() -> void:
	pass


func _remap_to_qzerty() -> void:
	pass


func _remap_to_dvorak() -> void:
	pass


func _remap_to_neo() -> void:
	pass


func _remap_to_colemac() -> void:
	pass
