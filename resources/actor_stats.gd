class_name ActorStats extends Resource

# Used when calculating gravity
@export_group("Gravity")
@export var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var gravity_jump_multiplier : float = 0.85
@export var gravity_long_jump_multiplier : float = 0.75

# Used as a move impulse
@export_group("Move")
@export_subgroup("Impulse")
@export var move_force : float = 120.0

# Used to boost or reduce speed
@export_subgroup("Multipliers")
@export var walking_multiplier : float = 1.0
@export var running_multiplier : float = 1.5
@export var sprinting_multiplier : float = 2.5
@export var crouch_running_multiplier : float = 0.75
@export var crouch_sprinting_multiplier : float = 1.25

# Used when starting to move
@export_subgroup("Acceleration")
@export var ground_acceleration : float = 600.0
@export var air_acceleration : float = 600.0

# Used on walls
@export_subgroup("Wall")
@export var wall_acceleration : float = 200.0
@export var wall_slightly_forced_acceleration : float = 200.0
@export var wall_forced_acceleration : float = 600.0
@export var wall_strong_forced_acceleration : float = 800.0

@export var wall_forced_speed : float = 400.0
@export var wall_scraping_high_speed_threshold : float = 300.0
@export var wall_speed : float = 200.0
@export var wall_climbing_speed : float = 100.0
@export var wall_stamina : float = 200.0
@export var wall_stamina_drain_rate : float = 100.0

# Used when reversing the direction of the movement
@export_subgroup("Deceleration")
@export var turnskid_deceleration : float = 1000.0
# Used when stopping
@export var ground_friction : float = 800.0
@export var air_friction : float = 500.0

# Used when in combat
@export_subgroup("Combat")
@export var combat_acceleration : float = 1200.0
@export var combat_multiplier : float = 0.8

# Used as a jump impulse
@export_group("Jump")
@export var maximum_air_speed : float = move_force * 1.5
@export_subgroup("Impulse")
@export var jump_force : float = 250.0
@export var long_jump_force : float = 225.0

@export_subgroup("Thresholds")
@export var jumping_speed_threshold : float = 100.0
@export var long_jumping_speed_threshold : float = 200.0

# Used when sliding
@export_group("Sliding")
@export var sliding_friction_direction : float = 100.0
@export var sliding_friction_directionless : float = 200.0
@export var sliding_friction_opposite : float = 400.0
@export var sliding_speed_bonus : float = 150.0
@export var minimum_sliding_speed : float = 5.0
@export var maximum_sliding_speed : float = 400.0

@export var crouching_speed_threshold : float = 120.0
@export var sliding_falling_speed_threshold : float = 100.0
@export var sliding_gravity : float = gravity/3

# Used as the buffer timers wait time
@export_group("Buffer Timers")
@export var jump_buffer_time : float = 10.15
@export var sliding_buffer_time : float = 0.3
@export var coyote_buffer_time : float = 0.15
@export var wall_turning_buffer_time : float = 0.3

@export var sliding_boost_time : float = 1.5
