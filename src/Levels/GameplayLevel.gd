extends BaseLevel

var _gameplay_ui_resource = preload("res://src/Interfaces/GameplayUi/GameplayUi.tscn")

func ready() -> void:
	var gameplay_ui = _gameplay_ui_resource.instance()
	add_child(gameplay_ui)
