extends BaseLevel

const SPLASH_DURATION : float = 0.5

var _splash_timer : Timer


func _on_SplashTimer_timeout() -> void:
	Events.emit_signal("load_level")


func init() -> void:
	_splash_timer = Utility.create_new_timer(self, SPLASH_DURATION, true)
	# warning-ignore:return_value_discarded
	_splash_timer.connect("timeout", self, "_on_SplashTimer_timeout")
	# warning-ignore:return_value_discarded
	Events.connect("transition_screen_opened", _splash_timer, "start")
