class_name Crouch extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.sliding_buffer_timer.stop()
	
func exit() -> void:
	actor.previous_x_speed = actor.velocity.x 
	actor.sliding_buffer_timer.stop()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
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
		return
		
	# Sliding
	if Input.is_action_just_pressed("sliding"):
		finished.emit(StatePaths.GROUNDED_IDLE)
		return
		
	# Idle
	if is_zero_approx(actor.get_input_x()):
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
