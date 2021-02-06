tool
class_name StateMachine, "res://assets/EngineIcons/icon_stateMachine.svg"
extends Node

export(NodePath) var initial_state = NodePath()

onready var state: State = get_node(initial_state) setget set_state
onready var previous_state: State = state


func _init() -> void:
	add_to_group("state_machine")


func _get_configuration_warning() -> String:
	var warning: String = "The initial state must be defined."
	return warning if !initial_state else ""


func _ready() -> void:
	if !Engine.editor_hint:
		yield(owner, "ready")
		state.enter()


func _unhandled_input(event: InputEvent) -> void:
	state.unhandled_input(event)


func _physics_process(delta: float) -> void:
	if !Engine.editor_hint:
		state.physics_process(delta)


func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	if !has_node(target_state_path):
		return
	
	var target_state: = get_node(target_state_path)
	state.exit()
	self.state = target_state
	state.enter(msg)


func set_state(value: State) -> void:
	previous_state = state
	state = value


func is_previous_state(state_name: String) -> bool:
	return previous_state.name == state_name


func is_current_state(state_name: String) -> bool:
	return state.name == state_name

