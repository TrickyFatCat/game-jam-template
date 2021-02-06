#* Base state class. Inherit all new states from this class

class_name State, "res://assets/EngineIcons/icon_state.svg"
extends Node

onready var stateMachine: Node = _get_state_machine(self)
# var stateMachine : StateMachine


# warning-ignore:unused_argument
func unhandled_input(event: InputEvent) -> void:
	#* Here you can write logic which will be called in unhandled input
    #! DO NOT USE _unhandled_input() in inherited class
	return


# warning-ignore:unused_argument
func physics_process(delta: float) -> void:
	#* Here you can write logic which will be called in _physics_process()
    #! DO NOT USE _physics_process() in inherited class
	return


# warning-ignore:unused_argument
func enter(msg: Dictionary = {}) -> void:
	#* Here you can write logic which will be called on entering state
	return


func exit() -> void:
	#* Here you can write logic which will be called on exiting state
	return


func _get_state_machine(node: Node) -> Node:
	if node != null and !node.is_in_group("state_machine"):
		return  _get_state_machine(node.get_parent())
	return node


func is_previous_state(state_name: String) -> bool:
	return stateMachine.previous_state.name == state_name
