class_name Actor extends CharacterBody2D

@export var stats : Resource

@onready var view: Node2D = $View
@onready var animation_player: AnimationPlayer = $View/AnimationPlayer

# Stuff related to jumping QoL
@onready var edge_detector: RayCast2D = $View/EdgeDetector
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var sliding_buffer_timer: Timer = $SlidingBufferTimer

var direction_queue = []

func _unhandled_input(_event: InputEvent) -> void:
	for input in ["move_left","move_right"]:
		if Input.is_action_just_pressed(input):
			direction_queue.erase(input)
			direction_queue.push_back(input)
		if Input.is_action_just_released(input):
			direction_queue.erase(input)
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer.start()
	if Input.is_action_just_pressed("sliding"):
		sliding_buffer_timer.start()
		
# TODO: Check if these methods can be put in the actor_state class for the SRP 
func get_input_x() -> float:
	if direction_queue.is_empty():
		return 0.0

	match direction_queue.back():
		"move_left": return -1.0
		"move_right": return 1.0
		_: return 0.0
	
func apply_gravity(gravity : float, delta : float):
	velocity.y += gravity * delta
	
func apply_default_move(delta : float, speed_mult : float = 1.0):
	var input_x = get_input_x()
	velocity.x = move_toward(velocity.x, input_x * stats.move_force * speed_mult, stats.ground_acceleration * delta)

func apply_skid_move(delta : float):
	var input_x = get_input_x()
	velocity.x = move_toward(velocity.x, input_x * stats.move_force, stats.ground_deceleration * delta)
	
func apply_stop_move(delta : float):
	velocity.x = move_toward(velocity.x, 0, stats.ground_friction * delta)
		
func apply_ground_move(delta : float, speed_mult : float = 1.0):
	if sign(velocity.x) != sign(get_input_x()) and velocity.x != 0:
		apply_skid_move(delta)
	else:
		apply_default_move(delta,speed_mult)

func apply_air_move(delta : float):
	var input_x = get_input_x()
	velocity.x = move_toward(velocity.x, input_x * max(stats.previous_speed,stats.move_force), stats.air_acceleration * delta)
	
func apply_jump_move(delta : float, speed_mult : float = 1.0):
	var input_x = get_input_x()
	velocity.x = move_toward(velocity.x, input_x * stats.move_force * speed_mult, stats.air_acceleration * delta)
	
func apply_sliding_move(delta : float):
	velocity.x = move_toward(velocity.x, 0, stats.sliding_friction * delta)
	
func do_move(delta : float, gravity : float = stats.gravity):
	apply_gravity(gravity, delta)
	view.face_from_velocity(velocity.x)
	move_and_slide()
