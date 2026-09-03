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
	# DEBUG: print states
	if Input.is_action_just_pressed("test_button"):
		for active_state in active_states:
			print(active_state)
		print("\n")	

func _transition_to_next_state(target_state_path: String, data := {}) -> void:
	if not has_node(target_state_path):
		printerr(owner.name + ": Trying to transition to state " + target_state_path + " but it does not exist.")
		return
		
	var previous_state_path := state.get_path()
	var target_state : State = get_node(target_state_path)
	
	var target_branch : Array[State] = _get_state_hierarchy(target_state)
	
	# HACK: fix the fact that it exits the same states
	print("Whats the target?")
	for thing in target_branch:
		print(thing)
		
	print("Whats the active states?")
	for thing in active_states:
		print(thing)
		
	print("First for")
	for i in range(active_states.size() - 1, -1, -1):
		if target_branch[i] != active_states[i]:
			print(target_branch[i])
			print(active_states[i])
			active_states[i].exit()
			active_states.pop_back()
			
	print("Active states:")
	for thing in active_states:
		print(thing)
		
	print("Target states:")
	for thing in target_branch:
		print(thing)
	
	print("Second for")
	for i in range(active_states.size(), target_branch.size(), 1):
			active_states.push_back(target_branch[i])
			print(active_states[i])
			active_states[i].enter(previous_state_path, data)
			
	print("Active states:")
	for thing in active_states:
		print(thing)
		
	print("Before state")
	print(state)
	state = target_state
	print("After state")
	print(state)

func _get_state_hierarchy(state_node : State) -> Array[State]:
	var hierarchy : Array[State]
	
	var current : Node = state_node
	
	while current is State:
		hierarchy.push_front(current)
		current = current.get_parent()
	
	return hierarchy
	
