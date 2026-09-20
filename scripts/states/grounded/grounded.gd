class_name Grounded extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.current_wall_stamina = actor.stats.wall_stamina
	pass
	
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
		if actor.movement_mode == actor.MovementMode.SPRINT:
			finished.emit(StatePaths.AIRBORNE_LONGJUMPING)
		else:
			finished.emit(StatePaths.AIRBORNE_JUMPING)
		return

	# Sliding
	if Input.is_action_just_pressed("sliding") or not actor.sliding_buffer_timer.is_stopped():
		if is_equal_approx(actor.get_input_x(), 0.0):
			finished.emit(StatePaths.CROUCH)
		else:
			finished.emit(StatePaths.SLIDE_PRESLIDING)
		return

	# Combat
	if Input.is_action_just_pressed("combat"):
		finished.emit(StatePaths.COMBAT)
		return

	# Turnskid
	if sign(actor.get_input_x()) != sign(actor.velocity.x) \
			and abs(actor.velocity.x) > actor.stats.move_force:
		finished.emit(StatePaths.GROUNDED_TURNSKID)
		return

	# Idle
	if is_equal_approx(actor.get_input_x(), 0.0):
		finished.emit(StatePaths.GROUNDED_IDLE)
		return

	# Movement
	match actor.movement_mode:
		actor.MovementMode.WALK:
			finished.emit(StatePaths.GROUNDED_WALKING)

		actor.MovementMode.RUN:
			finished.emit(StatePaths.GROUNDED_RUNNING)

		actor.MovementMode.SPRINT:
			finished.emit(StatePaths.GROUNDED_SPRINTING)
