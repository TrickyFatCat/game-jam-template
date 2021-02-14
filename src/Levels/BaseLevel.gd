#* Base level script

class_name BaseLevel
extends Node

const LOAD_DEALAY_TIME : float = 0.5

export(Array, AudioStream) var level_music := []


func _init() -> void:
	init()


func _ready() -> void:
	ready()
	yield(get_tree().create_timer(LOAD_DEALAY_TIME), "timeout")
	Events.emit_signal("level_loaded")
	MusicPlayer.play_random_track(level_music)
	level_music = []


func init() -> void:
	pass


func ready() -> void:
	pass
