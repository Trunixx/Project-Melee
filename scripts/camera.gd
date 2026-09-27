extends Camera2D

@onready var actor: Actor = $".."

# Shake stuff
var shake_intensity: float = 0.0
var active_shake_time: float = 0.0

var shake_decay: float = 5.0

var shake_time: float = 0.0
var shake_time_speed: float  =  20.0

var noise = FastNoiseLite.new()

# Zoom stuff
var target_zoom: float = 3.0
var zoom_speed: float = 4.0

func _ready() -> void:
	randomize()

func _process(delta: float) -> void:
	# Applies the shake
	if active_shake_time > 0.0:
		shake_time += delta * shake_time_speed
		active_shake_time -= delta
		
		offset = Vector2(
			noise.get_noise_2d(shake_time, 0) * shake_intensity,
			noise.get_noise_2d(0, shake_time) * shake_intensity
		)
		
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
	else:
		offset = lerp(offset, Vector2.ZERO, 10.5 * delta)
	
	# Applies the zoom
	zoom = zoom.lerp(Vector2.ONE  * target_zoom, 1.0  - exp(-zoom_speed *  delta))
	
	# Makes it follow the player better when falling at high speeds
	position_smoothing_speed = max(5.0, move_toward(position_smoothing_speed, max(0.0, actor.velocity.y/60), 10 * delta))
	
func screen_shake(intensity: int, time: float):
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = time
	shake_time = 0.0
	
func screen_zoom(zoom: float = target_zoom, speed: float = zoom_speed):
	target_zoom = zoom
	zoom_speed = speed
