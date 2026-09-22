class_name Wall extends ActorState

# FIXME: Sometimes it enters this state without going into a child

func enter(_previous_state_path: String, _data := {}) -> void:
	# HACK: So if you're not running you don't walljump with a weird speed
	# DESIGN: Consider changing how the air movement works
	actor.previous_speed = actor.stats.maximum_air_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(_delta: float) -> void:
	if (Input.is_action_just_pressed("jump") or actor.is_jump_buffer_on()) and not actor.is_ledge_grabbing:
		finished.emit(StatePaths.AIRBORNE_WALLJUMPING)
		return
	
	if actor.is_high_ledge_detected() and not Input.is_action_pressed("sliding"):
		finished.emit(StatePaths.WALL_LEDGEGRAB, {"position" : "high"})
		return
	
	if actor.is_mid_ledge_detected() and not Input.is_action_pressed("sliding"):
		finished.emit(StatePaths.WALL_LEDGEGRAB, {"position" : "mid"})
		return
		
	if actor.is_low_ledge_detected() and not Input.is_action_pressed("sliding"):
		finished.emit(StatePaths.WALL_LEDGEGRAB, {"position" : "low"})
		return
	
	# HACK: These conditions below make it so that it doesn't get stuck in the Wall state
	# but it still goes here for a frame
	
	# Look into the "finished.emit(StatePaths.WALL)" parts of code of Grounded and Airborne
	# it's because you use direction != 0.0, so if it's opposite it still triggers
	if not actor.is_ledge_grabbing:
		if actor.is_colliding_with_wall():
			if Input.is_action_pressed("up") and actor.current_wall_stamina > 0.0:
				finished.emit(StatePaths.WALL_CLIMBING)
			else:
				finished.emit(StatePaths.WALL_SCRAPING)
		
		if not actor.is_colliding_with_wall():
			if actor.is_on_floor():
				finished.emit(StatePaths.GROUNDED)
			else:
				finished.emit(StatePaths.AIRBORNE_FALLING)
