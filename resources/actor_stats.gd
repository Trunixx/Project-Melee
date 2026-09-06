class_name ActorStats extends Resource

# Used when calculating gravity
@export_group("Gravity")
@export var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var gravity_jump_reduction : float = 0.8
@export var gravity_long_jump_reduction : float = 0.9

# Used as a move impulse
@export_group("Move")
@export_subgroup("Impulse")
@export var move_force : float = 120.0

# Used to boost speed
@export_subgroup("Multipliers")
@export var running_multiplier : float = 1.5
@export var sprinting_multiplier : float = 2.5

# Used when starting to move
@export_subgroup("Acceleration")
@export var ground_acceleration : float = 600.0
@export var air_acceleration : float = 200.0

# Used when reversing the direction of the movement
@export_subgroup("Deceleration")
@export var ground_deceleration : float = 1200.0

# Used when stopping
@export var ground_friction : float = 800.0

# Used when in combat
@export_subgroup("Combat")
@export var combat_acceleration : float = 1200.0
@export var combat_multiplier : float = 0.8

# Used as a jump impulse
@export_group("Jump")
@export_subgroup("Impulse")
@export var jump_force : float = 250.0
@export var long_jump_force : float = 225.0

# Used to slow down character before jumping
@export_subgroup("Multipliers")
@export var prejump_speed_multiplier : float = 2.5
@export var longprejump_speed_multiplier : float = 2.0

# Used to make character go faster when jumping
@export var jumping_speed_multiplier : float = 1.5
@export var longjumping_speed_multiplier : float = 2.5

# Used when sliding
@export_group("Sliding")
@export var sliding_friction_direction : float = 100.0
@export var sliding_friction_directionless : float = 200.0
@export var sliding_friction_opposite : float = 400.0
@export var sliding_speed_bonus : float = 150.0

# Used as the buffer timers wait time
@export_group("Buffer timers")
@export var jump_buffer_time : float = 0.25
@export var sliding_buffer_time : float = 0.3
@export var coyote_buffer_time : float = 0.08
