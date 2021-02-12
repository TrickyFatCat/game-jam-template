
extends Node

const NUM_PLAYERS : int = 10

var bus : String = "master"

var available : Array = []  # The available players.

var queue : Array = []  # The queue of sounds to play.

func _init() -> void:
	pause_mode = PAUSE_MODE_PROCESS

func _ready() -> void:
	# Create the pool of AudioStreamPlayer nodes.
	for i in NUM_PLAYERS:
		var audio_player := AudioStreamPlayer.new()
		add_child(audio_player)
		available.append(audio_player)
		audio_player.connect("finished", self, "_on_stream_finished", [audio_player])
		audio_player.bus = bus


func _on_stream_finished(stream: AudioStreamPlayer) -> void:
	# When finished playing a stream, make the player available again.
	available.append(stream)


func play(sound_path: String) -> void:
	queue.append(sound_path)


func _process(delta: float) -> void:
	# Play a queued sound if any players are available.
	if not queue.empty() and not available.empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()
