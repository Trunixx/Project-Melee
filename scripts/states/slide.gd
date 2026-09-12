class_name Slide extends ActorState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)

	if not actor.is_on_floor():
		# TODO: Transition state to animate the fall, or consider leaving it like this
		finished.emit(StatePaths.SLIDE_POSTSLIDING)
		return

	if (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped()):
		if actor.movement_mode == actor.MovementMode.SPRINT:
			finished.emit(StatePaths.AIRBORNE_LONGJUMPING)
		else:
			finished.emit(StatePaths.AIRBORNE_JUMPING)
			return
