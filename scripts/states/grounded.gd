class_name Grounded extends ActorState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)
	actor.view.face_from_sign(actor.get_input_x())
			
	if not actor.is_on_floor() and actor.coyote_buffer_timer.is_stopped():
		finished.emit(StatePaths.AIRBORNE_FALLING)
		return
			
	if (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped()):
		if actor.movement_mode == actor.MovementMode.SPRINT:
			finished.emit(StatePaths.JUMP_LONG_PREJUMP)
		else:
			finished.emit(StatePaths.JUMP_PREJUMP)
		return
		
	if Input.is_action_just_pressed("sliding") or not actor.sliding_buffer_timer.is_stopped():
		finished.emit(StatePaths.SLIDE_PRESLIDING)
		return
		
	if Input.is_action_just_pressed("combat"):
		finished.emit(StatePaths.COMBAT)	
		return
		
	if sign(actor.get_input_x()) != sign(actor.velocity.x) and abs(actor.velocity.x) > actor.stats.move_force:
		finished.emit(StatePaths.GROUNDED_TURNSKID)
		return
	elif is_equal_approx(actor.get_input_x(), 0.0):
		finished.emit(StatePaths.GROUNDED_IDLE)
		return
	
	match actor.movement_mode:
		actor.MovementMode.WALK:
			finished.emit(StatePaths.GROUNDED_WALKING)

		actor.MovementMode.RUN:
			finished.emit(StatePaths.GROUNDED_RUNNING )

		actor.MovementMode.SPRINT:
			finished.emit(StatePaths.GROUNDED_SPRINTING)
