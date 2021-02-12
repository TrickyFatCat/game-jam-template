
#* This singleton controlling current active input device.
#* It needs for changing HUD icons and for controlling player aiming and camera.

extends Node

enum InputDevice {
	KEYBOARD,
	GAMEPAD
}

const JOY_DEADZONE : float = 0.3
const JOY_ID_DEFAULT : int = 0

var current_input_device : int = InputDevice.KEYBOARD
var joy_id_current : int = JOY_ID_DEFAULT

func _input(event: InputEvent) -> void:
	if (event is InputEventKey or event is InputEventMouse or event is InputEventMouseMotion) and not is_current_input_keyboard():
		current_input_device = InputDevice.KEYBOARD
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		Events.emit_signal("input_device_changed", current_input_device)
		return

	if (event is InputEventJoypadButton or event is InputEventJoypadMotion) and not is_current_input_gamepad():
		if event is InputEventJoypadMotion and (get_analog_right_direction(event.device) != Vector2.ZERO or get_analog_left_direction(event.device) != Vector2.ZERO):
			return

		joy_id_current = event.device
		current_input_device = InputDevice.GAMEPAD
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		Events.emit_signal("input_device_changed", current_input_device)
		return


func _ready() -> void:
	get_viewport().warp_mouse(OS.get_real_window_size() / 2)


static func get_joy_analog_direction(joy_index: int, axis_x: int, axis_y: int) -> Vector2:
	if joy_index < 0:
		push_error("Gamepad with index %s not found" % joy_index)
		return Vector2.ZERO

	var joy_x = Input.get_joy_axis(joy_index, axis_x)
	var joy_y = Input.get_joy_axis(joy_index, axis_y)
	var joy_direction = Vector2(joy_x, joy_y)

	if joy_direction.length() <= JOY_DEADZONE:
		joy_direction = Vector2.ZERO

	return joy_direction


static func get_analog_right_direction(joy_index: int = JOY_ID_DEFAULT) -> Vector2:
	return get_joy_analog_direction(joy_index, JOY_ANALOG_RX, JOY_ANALOG_RY)


static func get_analog_left_direction(joy_index: int = JOY_ID_DEFAULT) -> Vector2:
	return get_joy_analog_direction(joy_index, JOY_ANALOG_LX, JOY_ANALOG_LY)


func is_current_input_keyboard() -> bool:
	return current_input_device == InputDevice.KEYBOARD


func is_current_input_gamepad() -> bool:
	return current_input_device == InputDevice.GAMEPAD
