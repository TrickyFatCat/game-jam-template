#* Simple music player

extends AudioStreamPlayer

signal music_started()
signal music_finished()

const MIN_VOLUME : float = -80.0
const DEFAULT_FADE_TIME : float = 0.25

var _fade_tween : Tween
var volume_factor : float = 0.0 setget set_volume

var _default_volume : float


func _init() -> void:
	_fade_tween = Utility.create_new_tween(self, "FadeTween")
	_fade_tween.connect("tween_all_completed", self, "_on_fade_ended")
	_default_volume = volume_db
	set_volume(0.0)


func _on_fade_ended() -> void:
	if playing and volume_factor == 0.0:
		playing = false
		emit_signal("music_finished")


func play_track(track : AudioStream, fade_time : float = DEFAULT_FADE_TIME, track_volume : float = _default_volume) -> void:
	_default_volume = track_volume
	
	if volume_db > track_volume:
		set_volume(volume_factor)
	
	stream = track
	playing = true
	emit_signal("music_started")
	_fade_in(fade_time)


func stop_track(fade_time : float = DEFAULT_FADE_TIME) -> void:
	_fade_out(fade_time)


func set_volume(value: float) -> void:
	volume_factor = value
	volume_db = lerp(MIN_VOLUME, _default_volume, volume_factor)


func _fade_in(fade_time: float = DEFAULT_FADE_TIME) -> void:
	_start_tween(0.0, 1.0, fade_time)


func _fade_out(fade_time: float = DEFAULT_FADE_TIME) -> void:
	_start_tween(1.0, 0.0, fade_time)


func _start_tween(initial_value: float, target_value: float, fade_time : float) -> void:
	_fade_tween.interpolate_method(
		self,
		"set_volume",
		initial_value,
		target_value,
		fade_time,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN
	)
	_fade_tween.start()
