class_name Wall extends ActorState

# TODO: Timer when jumping off the wall

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.view.face_from_sign(actor.get_input_x())
	
	if not actor.is_colliding_with_wall() and not actor.is_on_floor() and actor.wall_buffer_timer.is_stopped():
		finished.emit(StatePaths.AIRBORNE_FALLING)
		return
	if actor.is_on_floor():
		finished.emit(StatePaths.GROUNDED)
		return
	
	if Input.is_action_just_pressed("jump"):
		finished.emit(StatePaths.WALL_WALLJUMPING)
		return
	
	else:
		finished.emit(StatePaths.WALL_SCRAPING)
