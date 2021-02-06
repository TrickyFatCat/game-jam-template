extends Node

# Level signals
signal load_level(msg)
signal restart_level()
signal level_loaded()
signal level_started()
signal level_finished()
signal level_exit()

# Player signals
signal player_spawned()
signal player_dead()

# Hud signals
# TODO clean these signals, some of them are excessive
signal open_menu_pause()
signal close_menu_pause()
signal menu_pause_opened()
signal menu_pause_closed()

# Transition signals
signal transition_screen_opened()
signal transition_screen_closed()

# Game saver signals
signal save_game()
signal load_game()
signal game_saved()
signal game_loaded()

# Other signals
signal shake_camera(duration, frequency, amplitude, priority)
signal quit_game()
signal input_device_changed(device_index)
