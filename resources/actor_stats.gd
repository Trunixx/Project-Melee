class_name ActorStats extends Resource

# TODO: Tune the gravity values
# Used when calculating gravity
@export var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")

# Used as a move impulse
@export var move_force : float = 120.0

# Used as a jump impulse
@export var jump_force : float = 250.0
@export var long_jump_force : float = 225.0

# Used to slow down character before jumping
@export var prejump_speed_multiplier : float = 2.5
@export var longprejump_speed_multiplier : float = 2.0

# Used to make character go faster when jumping
@export var jumping_speed_multiplier : float = 1.5
@export var longjumping_speed_multiplier : float = 2.5

# Used as the buffer timers wait time
@export var jump_buffer_time : float = 0.25
@export var sliding_buffer_time : float = 0.25

# Used to boost speed
@export var running_multiplier : float = 1.5
@export var sprinting_multiplier : float = 2.0

# Used when starting to move
@export var ground_acceleration : float = 600.0
@export var air_acceleration : float = 100.0

# Used when reversing the direction of the movement
@export var ground_deceleration : float = 1200.0

# Used when stopping
@export var ground_friction : float = 800.0

# Used when sliding
@export var sliding_friction : float = 100.0
@export var sliding_speed_bonus : float = 100.0

# The following variables are calculated and edited during the game execution

# Used when keeping fall momentum
# Assigned when leaving a "movement" state
@export var previous_speed : float
