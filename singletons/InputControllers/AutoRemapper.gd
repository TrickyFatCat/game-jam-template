#* This scripo automatically remaps action's events if a player use different from QWERTY latin keyboard layout.

extends Node

const LAYOUT := [
	"QWERTY",
	"AZERTY",
	"QZERTY",
	"DVORAK",
	"NEO",
	"COLEMAK",
	"ERROR"
]

var _keyboard_layout : String = "QWERTY"


func _input(event: InputEvent) -> void:
	if InputManager.current_input_device == InputManager.InputDevice.KEYBOARD:
		var current_keyboard_layout = OS.get_latin_keyboard_variant()
		
		if current_keyboard_layout == LAYOUT[6]:
			push_error("Can'get latin keyboard variant %s" % self.name)
			return
		
		if current_keyboard_layout != _keyboard_layout:
			# Here must be written remapping logic
			
			_keyboard_layout = current_keyboard_layout
			pass
		
		print_debug(current_keyboard_layout)
	pass
