extends Node

const MAIN_MENU_PATH : String = "res://levels/Menus/MainMenu.tscn"
const LEVELS : Array = [
	"res://levels/splash/SplashScreenGodot.tscn",
	"res://levels/splash/SplashScreenJam.tscn",
	"res://levels/splash/SplashScreenTeam.tscn"
]

var current_level : BaseLevel
var current_level_id : int = 0

func load_level_by_id(id: int) -> void:
	if id < 0 or id >= LEVELS.size():
		push_error("Level id %i hasn't been found. Level loading aborted" % id)
		return
	
	get_tree().change_scene(LEVELS[id])


func load_main_menu() -> void:
	# get_tree().change_scene(MAIN_MENU_PATH)
	pass


func load_next_level() -> void:
	var new_level_id = current_level_id + 1
	
	if new_level_id >= LEVELS.size():
		print_debug("last level")
		load_main_menu()
		return;
	# if current_level.level_id > -1:
	# 	var new_level_id = current_level.level_id + 1
		
	# 	if new_level_id >= LEVELS.size():
	# 		load_main_menu()
	# 		return

	get_tree().change_scene(LEVELS[new_level_id])
	pass
