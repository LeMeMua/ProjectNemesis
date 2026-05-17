extends Node
class_name StateMachines
@onready var controlled_node = self.owner
@export var default_state: StateBase
var current_state: StateBase = null

func _ready() -> void:
	var initial_state := _resolve_state(default_state)
	if initial_state:
		current_state = initial_state
		_enter_state_recursive(initial_state)

	else:
		push_warning("StateMachine default_state is not set or could not be resolved")

func change_to(new_state: String) -> void:
	var next_state := get_node_or_null(new_state) as StateBase
	if not next_state:
		push_warning("StateMachine state not found: %s" % new_state)
		return
	if current_state:
		_finalize_state_recursive(current_state)
	current_state = next_state
	_enter_state_recursive(current_state)

func _process(delta: float) -> void:
	if current_state:
		_process_recursive(current_state, delta)

func _physics_process(delta: float) -> void:
	if current_state:
		_physics_process_recursive(current_state, delta)

func _input(event: InputEvent) -> void:
	if current_state:
		_input_recursive(current_state, event)

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		_unhandled_input_recursive(current_state, event)

func _unhandled_key_input(event: InputEvent) -> void:
	if current_state:
		_unhandled_key_input_recursive(current_state, event)

func _process_recursive(state: StateBase, delta: float) -> void:
	var parent := state.get_parent()
	if parent is StateBase:
		_process_recursive(parent, delta)
	if state.has_method("on_process"):
		state.on_process(delta)

func _physics_process_recursive(state: StateBase, delta: float) -> void:
	var parent := state.get_parent()
	if parent is StateBase:
		_physics_process_recursive(parent, delta)
	if state.has_method("on_physics_process"):
		state.on_physics_process(delta)

func _input_recursive(state: StateBase, event: InputEvent) -> void:
	var parent := state.get_parent()
	if parent is StateBase:
		_input_recursive(parent, event)
	if state.has_method("on_input"):
		state.on_input(event)

func _unhandled_input_recursive(state: StateBase, event: InputEvent) -> void:
	var parent := state.get_parent()
	if parent is StateBase:
		_unhandled_input_recursive(parent, event)
	if state.has_method("on_unhandled_input"):
		state.on_unhandled_input(event)

func _unhandled_key_input_recursive(state: StateBase, event: InputEvent) -> void:
	var parent := state.get_parent()
	if parent is StateBase:
		_unhandled_key_input_recursive(parent, event)
	if state.has_method("on_unhandled_key_input"):
		state.on_unhandled_key_input(event)

func _enter_state_recursive(state: StateBase) -> void:
	var parent := state.get_parent()
	if parent is StateBase:
		_enter_state_recursive(parent)
	state.controlled_node = controlled_node
	state.state_machine = self
	prints("StateMachine", controlled_node.name, "start state", state.name)
	state.start()

func _finalize_state_recursive(state: StateBase) -> void:
	var parent := state.get_parent()
	if parent is StateBase:
		_finalize_state_recursive(parent)
	state.end()

func _resolve_state(state_ref) -> StateBase:
	if state_ref is StateBase:
		return state_ref
	if state_ref is NodePath or state_ref is String:
		return get_node_or_null(state_ref) as StateBase
	return null
