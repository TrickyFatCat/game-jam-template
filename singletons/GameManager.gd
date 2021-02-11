extends Node


const LEVEL_NEXT : String = "next"
const LEVEL_RESTART : String = "restart"
const LEVEL_EXIT : String = "exit"
const QUIT_GAME : String = "quit"
const MUSIC_FADE : float = 0.5

var player : Player
var transition_command : String


func _ready() -> void:
	Events.connect("load_level", self, "_start_level_loading")
	Events.connect("restart_level", self, "_start_level_restart")
	Events.connect("quit_game", self, "_start_quitting_game")
	Events.connect("transition_screen_closed", self, "_process_transition_command")
	Events.connect("level_loaded", self, "_on_level_loaded")
	Events.connect("level_exit", self, "_start_exit_to_main_menu")


func _process_transition_command() -> void:
	if Utility.is_game_paused():
		Utility.unpause_game()
		
	match transition_command:
		LEVEL_NEXT:
			LevelController.load_next_level()
			# TODO implement level loading by ID
			pass
		LEVEL_RESTART:
			# TODO implement level restart
			pass
		LEVEL_EXIT:
			LevelController.load_main_menu()
			pass
		QUIT_GAME:
			get_tree().quit()
			pass
		_:
			LevelController.load_level_by_id(int(transition_command))
			pass


func _start_level_loading(msg: Dictionary = {}) -> void:
	if "target_level" in msg:
		transition_command = msg.target_level
	else:
		transition_command = LEVEL_NEXT

	TransitionScreen.start_transition()


func _start_quitting_game() -> void:
	transition_command = QUIT_GAME
	_on_level_change()


func _start_level_restart() -> void:
	transition_command = LEVEL_RESTART
	_on_level_change()


func _start_exit_to_main_menu() -> void:
	transition_command = LEVEL_EXIT
	_on_level_change()


func _on_level_loaded() -> void:
	TransitionScreen.start_transition()
	_start_playing_level_music()


func _start_playing_level_music() -> void:
	var music_tracks = get_tree().current_scene.level_music()
	var track
	
	if music_tracks.size == 0:
		return
	elif music_tracks.size == 1:
		track = music_tracks[0]
	else:
		track = music_tracks[randi() % music_tracks.size()]
	
	MusicPlayer.play_track(track, MUSIC_FADE)


func _on_level_change() -> void:
	TransitionScreen.start_transition()
	MusicPlayer.stop_track(MUSIC_FADE)
