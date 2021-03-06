#* Basic confirmation menu script

extends BaseMenu

signal yes_pressed
signal no_pressed


func ready() -> void:
	# warning-ignore:return_value_discarded
	get_button("Yes").connect("button_up", self, "_on_yes_pressed")
	# warning-ignore:return_value_discarded
	get_button("No").connect("button_up", self, "_on_no_pressed")


func _on_yes_pressed() -> void:
	emit_signal("yes_pressed")


func _on_no_pressed() -> void:
	close_menu()
	emit_signal("no_pressed")
