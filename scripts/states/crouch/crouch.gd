class_name Crouch extends ActorState

func exit() -> void:
	actor.previous_speed = actor.velocity.x 
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)
	actor.view.face_from_sign(actor.get_input_x())
			
	# Falling and coyote is over
	if not actor.is_on_floor():
		if actor.coyote_timed_out:
			finished.emit(StatePaths.AIRBORNE_FALLING)
			return
		if actor.coyote_buffer_timer.is_stopped():
			actor.start_coyote_time()
		
	# Jump
	if Input.is_action_just_pressed("jump") or actor.is_jump_buffer_on():
		finished.emit(StatePaths.AIRBORNE_JUMPING)

	# Sliding
	if Input.is_action_just_pressed("sliding"):
		finished.emit(StatePaths.GROUNDED_IDLE)
		return
		
	# Idle
	if is_equal_approx(actor.get_input_x(), 0.0):
		finished.emit(StatePaths.CROUCH_IDLE)
		return
		
	# Combat
	if Input.is_action_just_pressed("combat"):
		finished.emit(StatePaths.COMBAT)
		return

	# Movement
	match actor.movement_mode:
		actor.MovementMode.WALK:
			finished.emit(StatePaths.CROUCH_RUNNING)
			
		actor.MovementMode.RUN:
			finished.emit(StatePaths.CROUCH_RUNNING)

		actor.MovementMode.SPRINT:
			finished.emit(StatePaths.CROUCH_SPRINTING)
