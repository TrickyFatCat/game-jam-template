extends Node

var game_data = "res://game_data.bin" # TODO Switch to user directory


func _init() -> void:
	pause_mode = PAUSE_MODE_PROCESS

func _ready() -> void:
	pass


func save_game() -> void:
	var file = File.new()
	file.open_encrypted_with_pass(game_data, File.WRITE, "Password")
	# TODO add variables for saving here
	file.close()
	print_debug("Game Saved")


func load_game() -> void:
	var file = File.new()

	if not file.file_exists(game_data):
		save_game()

	file.open_encrypted_with_pass(game_data, File.READ, "Password")
	# TODO add variable to read here
	file.close()
	print_debug("Game Loaded")

