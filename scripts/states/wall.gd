class_name Wall extends ActorState

# TODO: Timer when jumping off the wall
func enter(_previous_state_path: String, _data := {}) -> void:
	# HACK: So if you're not running you don't walljump with a weird speed
	# DESIGN: Consider changing how the air movement works
	actor.previous_speed = actor.stats.move_force *  1.5 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	if actor.is_on_floor():
		finished.emit(StatePaths.GROUNDED)
		return
	
	if Input.is_action_just_pressed("jump"):
		finished.emit(StatePaths.WALL_WALLJUMPING)
		return
	
	if actor.is_colliding_with_wall():
		finished.emit(StatePaths.WALL_SCRAPING)
