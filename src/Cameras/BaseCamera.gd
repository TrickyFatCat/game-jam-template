class_name BaseCamera
extends Position2D

onready var camera: Camera2D = $PlayerCamera
onready var cameraShaker := $PlayerCamera/CameraShaker


func _init() -> void:
	# warning-ignore:return_value_discarded
	Events.connect("shake_camera", self, "apply_camera_shake")
	init()


func _ready() -> void:
	ready()


func _physics_process(delta: float) -> void:
	physics_process(delta)


func apply_camera_shake(
	duration: float = 0.2,
	frequency: float = 15.0,
	amplitude: int = 16,
	priority: int = 0
	) -> void:
	cameraShaker.start(duration, frequency, amplitude, priority)


func init() -> void:
	pass


func ready() -> void:
	pass


# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
	pass


func _update_position() -> void:
	pass
