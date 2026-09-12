class_name Actor extends CharacterBody2D

@export var stats : Resource

@onready var view: Node2D = $View
@onready var animation_player: AnimationPlayer = $View/AnimationPlayer
@onready var camera_zoomer: AnimationPlayer = $Camera/CameraZoomer

# Raycasts
@onready var edge_detector: RayCast2D = $View/EdgeDetector
@onready var low_wall_detector: RayCast2D = $View/LowWallDetector
@onready var mid_wall_detector: RayCast2D = $View/MidWallDetector
@onready var high_wall_detector: RayCast2D = $View/HighWallDetector

# Timers
@onready var jump_buffer_timer: Timer = $JumpBufferTimer
@onready var sliding_buffer_timer: Timer = $SlidingBufferTimer
@onready var wall_buffer_timer: Timer = $WallBufferTimer
@onready var coyote_buffer_timer: Timer = $CoyoteBufferTimer

# Runtime movement state
enum MovementMode {
	WALK,
	RUN,
	SPRINT
}
var previous_speed : float
var movement_mode : MovementMode = MovementMode.RUN
var coyote_timed_out : bool = false
var wall_cling_timed_out : bool = false

# Runtime combat state
# DESIGN: Consider putting them in something more combat related and less generic
# TODO: Consider removing this variable, you can get it from the state
var is_in_combat : bool
var is_threatened : bool

# Input state
var direction_queue = []

func _ready() -> void:
	jump_buffer_timer.wait_time = stats.jump_buffer_time
	sliding_buffer_timer.wait_time = stats.sliding_buffer_time
	coyote_buffer_timer.wait_time = stats.coyote_buffer_time
	wall_buffer_timer.wait_time = stats.wall_buffer_time
	
# The code in this function makes it so that you can override your current direction
# even if you keep holding the key
func _unhandled_input(_event: InputEvent) -> void:
	for input in ["move_left","move_right"]:
		if Input.is_action_just_pressed(input):
			direction_queue.erase(input)
			direction_queue.push_back(input)
		if Input.is_action_just_released(input):
			direction_queue.erase(input)
			
	if Input.is_action_just_pressed("sprinting"):
		movement_mode = MovementMode.SPRINT if movement_mode != MovementMode.SPRINT else MovementMode.RUN
	elif Input.is_action_just_pressed("walking"):
		movement_mode = MovementMode.WALK if movement_mode != MovementMode.WALK else MovementMode.RUN
		
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

# Coyote time stuff
func start_coyote_time() -> void:
	coyote_timed_out = false
	coyote_buffer_timer.start()
func reset_coyote_time() -> void:
	coyote_timed_out = false
	coyote_buffer_timer.stop()
func _on_coyote_buffer_timer_timeout() -> void:
	coyote_timed_out = true
	
func is_colliding_with_wall() -> bool:
	var is_colliding: bool = low_wall_detector.is_colliding() or mid_wall_detector.is_colliding() or high_wall_detector.is_colliding()
	if is_colliding:
		wall_buffer_timer.start()
	return is_colliding
	
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
	velocity.x = move_toward(velocity.x, input_x * stats.move_force, stats.turnskid_deceleration * delta)
	
func apply_stop_move(delta : float):
	velocity.x = move_toward(velocity.x, 0, stats.ground_friction * delta)
		
func apply_ground_move(delta : float, speed_mult : float = 1.0):
	if sign(velocity.x) != sign(get_input_x()) and velocity.x != 0:
		apply_skid_move(delta)
	else:
		apply_default_move(delta,speed_mult)
		
# DESIGN: Consider splitting this in 3 functions depending on actor grounded state, and another one for wall jumping
func apply_air_move(delta : float, speed_mult : float = 1.0):
	var input_x = get_input_x()
	velocity.x = move_toward(velocity.x, input_x * max(abs(previous_speed) * speed_mult,stats.move_force), stats.air_acceleration * delta)
	
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

func apply_wall_sliding_move(delta : float):
	velocity.y = move_toward(velocity.y, stats.wall_speed, stats.wall_acceleration * delta)
	
# This function gets called after one of the above to apply gravity,
# movement and face the character in the right direction
func do_move(delta : float, gravity : float = stats.gravity):
	apply_gravity(gravity, delta)
	move_and_slide()
