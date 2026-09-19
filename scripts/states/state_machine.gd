class_name StateMachine extends Node

## The initial state of the state machine. If not set, the first child node is used.
@export var initial_state : State

## The current state of the state machine.
@onready var state : State = initial_state if initial_state != null else get_child(0)
@onready var active_states : Array[State] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for state_node : State in find_children("*", "State"):
		state_node.finished.connect(_transition_to_next_state)
		
	# State machines usually access data from the root node of the scene they're part of: the owner.
	# We wait for the owner to be ready to guarantee all the data and nodes the states may need are available.
	await owner.ready
	
	# Call the enter function of the initial states
	active_states = _get_state_hierarchy(state)
	for active_state : State in active_states:
		active_state.enter("", {})

func _process(delta: float) -> void:
	for active_state : State in active_states:
		active_state.update(delta)

func _physics_process(delta: float) -> void:
	for active_state : State in active_states:
		active_state.physics_update(delta)

func _unhandled_input(event: InputEvent) -> void:
	for active_state : State in active_states:
		active_state.handle_input(event)

func _transition_to_next_state(target_state_path: String, data := {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return

	var previous_state_path := state.get_path()
	var target_state: State = get_node(target_state_path)

	var target_branch: Array[State] = _get_state_hierarchy(target_state)

	var common_depth := 0
	var max_common_depth : int = min(active_states.size(), target_branch.size())

	while common_depth < max_common_depth:
		if active_states[common_depth] != target_branch[common_depth]:
			break
		common_depth += 1

	for i in range(active_states.size() - 1, common_depth - 1, -1):
		active_states[i].exit()
		active_states.pop_back()

	for i in range(common_depth, target_branch.size()):
		active_states.push_back(target_branch[i])
		active_states[i].enter(previous_state_path, data)

	state = target_state
	
func _get_state_hierarchy(state_node : State) -> Array[State]:
	var hierarchy : Array[State]
	
	var current : Node = state_node
	
	while current is State:
		hierarchy.push_front(current)
		current = current.get_parent()
	
	return hierarchy

func get_string_state_hierarchy(state_node : State) -> String:
	var hierarchy : Array[State] = _get_state_hierarchy(state_node)
	var return_string : String
	for i in range(0, hierarchy.size()):
		return_string += hierarchy[i].name
		if i != hierarchy.size() - 1:
			return_string += "/"
	return return_string
