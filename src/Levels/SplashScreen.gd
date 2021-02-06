extends BaseLevel

const SPLASH_DURATION : float = 0.5

export(String, FILE, "*.tscn") var next_level

var _splash_timer : Timer


func _on_SplashTimer_timeout() -> void:
	Events.emit_signal("load_level", {"target_level": next_level})

func init() -> void:
	_splash_timer = Timer.new()
	self.add_child(_splash_timer)
	_splash_timer.name = "SplashTimer"
	_splash_timer.wait_time = SPLASH_DURATION
	_splash_timer.connect("timeout", self, "_on_SplashTimer_timeout")
	Events.connect("transition_screen_opened", _splash_timer, "start")
