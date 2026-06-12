class_name ActorStats extends Resource

@export var move_force : float = 120.0

@export var gravity : float = ProjectSettings.get_setting("physics/2d/default_gravity")
@export var jump_gravity : float = max(ProjectSettings.get_setting("physics/2d/default_gravity") - 300, 680)

@export var jump_force : float = 250.0
@export var long_jump_force : float = 200.0

@export var jump_speed_bonus : float = 200
@export var longjump_speed_bonus : float = 300

@export var prejump_speed_multiplier : float = 2.5
@export var longprejump_speed_multiplier : float = 2.0

@export var jumping_speed_multiplier : float = 1.5
@export var longjumping_speed_multiplier : float = 2.5

@export var running_multiplier : float = 1.5
@export var sprinting_multiplier : float = 2.0

@export var ground_acceleration : float = 600.0
@export var air_acceleration : float = 180.0

@export var ground_friction : float = 1000.0
