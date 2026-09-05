class_name Airborne extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.coyote_buffer_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)
	
	# FIXME: Repeats code from the Grounded state
	if not actor.coyote_buffer_timer.is_stopped() and (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped()):
		# This avoids making the jump shorter if started in coyote time
		if not actor.coyote_buffer_timer.is_stopped():
			actor.velocity.y = 0.0
		if actor.movement_mode == actor.MovementMode.SPRINT:
			finished.emit(StatePaths.JUMP_LONG_PREJUMP)
		else:
			finished.emit(StatePaths.JUMP_PREJUMP)
		return
		
	if actor.is_on_floor():
		if is_equal_approx(actor.get_input_x(), 0.0):
			finished.emit(StatePaths.GROUNDED_IDLE)
		elif Input.is_action_pressed("walking"):
			finished.emit(StatePaths.GROUNDED_WALKING)
		else:
			finished.emit(StatePaths.GROUNDED_RUNNING )
