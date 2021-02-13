extends Node

const LEVELS : Array = [
	"res://levels/splash/SplashScreenGodot.tscn",
	"res://levels/splash/SplashScreenJam.tscn",
	"res://levels/splash/SplashScreenTeam.tscn",
	"res://levels/menus/MainMenuLevel.tscn",
	"res://levels/game/TestLevel.tscn"
]
const MAIN_MENU_ID : int = 3

var current_level_id : int = 0


func _init() -> void:
	pause_mode = PAUSE_MODE_PROCESS

func load_level_by_id(id: int) -> void:
	if id < 0 or id >= LEVELS.size():
		push_error("Level id %i hasn't been found. Level loading aborted" % id)
		return
	
	get_tree().change_scene(LEVELS[id])


func load_main_menu() -> void:
	load_level_by_id(MAIN_MENU_ID)
	current_level_id = MAIN_MENU_ID


func load_next_level() -> void:
	var new_level_id = current_level_id + 1
	
	if new_level_id >= LEVELS.size():
		print_debug("last level")
		load_main_menu()
		return;

	get_tree().change_scene(LEVELS[new_level_id])
	current_level_id += 1
	pass
