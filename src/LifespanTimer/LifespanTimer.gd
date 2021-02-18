#* Add this script to the timer if you want to destroy object automatically in some time.
#* Alternatively, you can use create_lifespan_timer() methods in Utility.gd to create such timer in runtime using code.

extends Timer

onready var parent = get_parent()


func _init(duration: float) -> void:
	one_shot = true
	wait_time = duration


func _ready() -> void:
	yield(get_parent(), "ready")
	connect("timeout", parent, "queue_free", [CONNECT_ONESHOT])
	start()
