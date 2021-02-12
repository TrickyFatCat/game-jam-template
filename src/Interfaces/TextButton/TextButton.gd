#* A siple text button
#! ATTENTION! Most of logic here is a hack, as the base logic of Button node is ruined by mouse hovering.
#! I hope the problem will be solved in the future.
# TODO check if the hovering bug is fixed.

extends Button
class_name TextButton

export(Color) var font_color_normal = Color.whitesmoke
export(Color) var font_color_focus = Color.orange
export(Color) var font_color_hover = Color.orange # TODO add color change on hover
export(Color) var font_color_press = Color.yellow
export(Color) var font_color_disable = Color.gray # TODO add color change on disable

var is_mouse_inside : bool = false
var is_active : bool = true setget _set_is_active # Deactivates the button but doesn't change its appearance

onready var _button_label : Label = $ButtonLabel


func _init() -> void:
	connect("mouse_entered", self, "_on_mouse_enter")
	connect("mouse_exited", self, "_on_mouse_exit")
	connect("focus_entered", self, "_on_focus_entered")
	connect("focus_exited", self, "_on_focus_exited")
	connect("button_down", self, "_on_button_down")
	connect("button_up", self, "_on_button_up")
	Events.connect("input_device_changed", self, "_switch_mouse_filter")


func _ready() -> void:
	# TODO get rid off this hack
	_button_label.text = text
	_button_label.visible = true
	text = ""


func on_button_up() -> void:
	#* Write logic for your button in this function
	pass


func _on_mouse_enter() -> void:
	is_mouse_inside = true
	grab_focus()


func _on_mouse_exit() -> void:
	is_mouse_inside = false


func _on_focus_entered() -> void:
	_change_font_color(font_color_focus)


func _on_focus_exited() -> void:
	_change_font_color(font_color_normal)


func _on_button_down() -> void:
	_change_font_color(font_color_press)


func _on_button_up() -> void:
	_change_font_color(font_color_focus)
	on_button_up()


func _change_font_color(color: Color) -> void:
	_button_label.add_color_override("font_color", color)
		

func _switch_mouse_filter(_device_index: int) -> void:
	if InputManager.is_current_input_keyboard():
		mouse_filter = MOUSE_FILTER_STOP
		return
		
	if InputManager.is_current_input_gamepad():
		mouse_filter = MOUSE_FILTER_IGNORE
		return


func _set_is_active(value: bool) -> void:
	is_active = value
	disabled = not value
	_change_font_color(font_color_normal)

	if disabled:
		mouse_filter = MOUSE_FILTER_IGNORE
		focus_mode = FOCUS_NONE
	else:
		_switch_mouse_filter(InputManager.current_input_device)
		focus_mode = FOCUS_ALL
