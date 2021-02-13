#* Add this script to the timer if you want to destroy object automatically in some time.
#* Alternatively, you can use create_lifespan_timer() methods in Utility.gd to create such timer in runtime using code.

extends Timer

onready var parent = get_parent()

var is_active : bool = true


func _init() -> void:
	one_shot = true
	autostart = true


func _ready() -> void:
	if not is_active:
		return
	
	yield(get_parent(), "ready")
	connect("timeout", parent, "queue_free")


func _set_is_active(value: bool) -> void:
	is_active = value
	stop()
