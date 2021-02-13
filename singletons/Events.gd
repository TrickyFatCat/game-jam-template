extends Node

# Level signals
# warning-ignore:unused_signal
signal load_level(msg)
# warning-ignore:unused_signal
signal restart_level()
# warning-ignore:unused_signal
signal level_loaded()
# warning-ignore:unused_signal
signal level_started()
# warning-ignore:unused_signal
signal level_finished()
# warning-ignore:unused_signal
signal level_exit()
# warning-ignore:unused_signal
signal level_failed()

# Player signals
# warning-ignore:unused_signal
signal player_spawned()
# warning-ignore:unused_signal
signal player_dead()

# Hud signals
# TODO clean these signals, some of them are excessive
# warning-ignore:unused_signal
signal open_menu_pause()
# warning-ignore:unused_signal
signal close_menu_pause()
# warning-ignore:unused_signal
signal menu_pause_opened()
# warning-ignore:unused_signal
signal menu_pause_closed()

# Transition signals
# warning-ignore:unused_signal
signal transition_screen_opened()
# warning-ignore:unused_signal
signal transition_started()
# warning-ignore:unused_signal
signal transition_screen_closed()

# Game saver signals
# warning-ignore:unused_signal
signal save_game()
# warning-ignore:unused_signal
signal load_game()
# warning-ignore:unused_signal
signal game_saved()
# warning-ignore:unused_signal
signal game_loaded()

# Other signals
# warning-ignore:unused_signal
signal shake_camera(duration, frequency, amplitude, priority)
# warning-ignore:unused_signal
signal quit_game()
# warning-ignore:unused_signal
signal input_device_changed(device_index)
