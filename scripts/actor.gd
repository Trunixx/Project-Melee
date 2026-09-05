class_name Actor extends CharacterBody2D

@export var stats : Resource

@onready var view: Node2D = $View
@onready var animation_player: AnimationPlayer = $View/AnimationPlayer
@onready var camera_zoomer: AnimationPlayer = $Camera/CameraZoomer

# Stuff related to jumping QoL
@onready var edge_detector: RayCast2D = $View/EdgeDetector
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var sliding_buffer_timer: Timer = $SlidingBufferTimer
@onready var coyote_buffer_timer: Timer = $CoyoteBufferTimer

# Runtime movement state
enum MovementMode {
	WALK,
	RUN,
	SPRINT
}
var previous_speed : float
var movement_mode : MovementMode = MovementMode.RUN

# Runtime combat state
# TODO: Consider putting them in something more combat related and less generic
# TODO: Consider removing this variable, you can get it from the state
var is_in_combat : bool
var is_threatened : bool

# Input state
var direction_queue = []

func _ready() -> void:
	jump_buffer_timer.wait_time = stats.jump_buffer_time
	sliding_buffer_timer.wait_time = stats.sliding_buffer_time
	coyote_buffer_timer.wait_time = stats.coyote_buffer_time
	
# The code in this function makes it so that you can override your current direction
# even if you keep holding the key
func _unhandled_input(_event: InputEvent) -> void:
	for input in ["move_left","move_right"]:
		if Input.is_action_just_pressed(input):
			direction_queue.erase(input)
			direction_queue.push_back(input)
		if Input.is_action_just_released(input):
			direction_queue.erase(input)
	if Input.is_action_pressed("sprinting"):
		movement_mode = MovementMode.SPRINT
	elif Input.is_action_pressed("walking"):
		movement_mode = MovementMode.WALK
	else:
		movement_mode = MovementMode.RUN
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

# These below are the functions called in the appropriate states
# TODO: Can you make the functions below more DRY?
func apply_gravity(gravity : float, delta : float):
	velocity.y += gravity * delta
	
func apply_default_move(delta : float, speed_mult : float = 1.0):
	var input_x = get_input_x()
	velocity.x = move_toward(velocity.x, input_x * stats.move_force * speed_mult, stats.ground_acceleration * delta)

func apply_combat_move(delta : float, speed_mult : float = 1.0):
	var input_x = get_input_x()
	velocity.x = move_toward(velocity.x, input_x * stats.move_force * speed_mult, stats.combat_acceleration * delta)
	
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
	velocity.x = move_toward(velocity.x, input_x * max(previous_speed,stats.move_force), stats.air_acceleration * delta)
	
func apply_jump_move(delta : float, speed_mult : float = 1.0):
	var input_x = get_input_x()
	velocity.x = move_toward(velocity.x, input_x * stats.move_force * speed_mult, stats.air_acceleration * delta)
	
func apply_sliding_move(delta : float):
	var input_x = get_input_x()
	var friction : float
	
	if input_x != 0.0 and velocity.x != 0.0 and sign(input_x) == sign(velocity.x):
		friction = stats.sliding_friction_direction
		
	elif input_x == 0.0:
		friction = stats.sliding_friction_directionless
		
	else:
		friction = stats.sliding_friction_opposite
		
	velocity.x = move_toward(velocity.x, 0, friction * delta)
	
# This function gets called after one of the above to apply gravity,
# movement and face the character in the right direction
func do_move(delta : float, gravity : float = stats.gravity):
	apply_gravity(gravity, delta)
	move_and_slide()
