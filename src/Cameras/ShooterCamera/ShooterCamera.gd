class_name ShooterCamera
extends BaseCamera

const CAMERA_FOLLOW_SPEED : float = 0.1

export var offset: = Vector2(80.0, 80.0)
export var camera_range: = Vector2(0.0, 200.0)


func _update_position() -> void:
	var distance_ratio : float
	var target_position : Vector2

	match InputManager.current_input_device:
		InputManager.InputDevice.KEYBOARD:
			var mouse_position := get_local_mouse_position()
			distance_ratio = clamp(mouse_position.length(), camera_range.x, camera_range.y) / camera_range.y
			target_position = distance_ratio * mouse_position.normalized() * offset
			pass
		InputManager.InputDevice.GAMEPAD:
			var joy_direction = InputManager.get_analog_right_direction(InputManager.joy_id_current)
			if joy_direction != Vector2.ZERO:
				distance_ratio = joy_direction.length()
				target_position = distance_ratio * joy_direction * offset
			pass
		
	camera.position = lerp(camera.position, target_position, CAMERA_FOLLOW_SPEED)
