class_name Slide extends ActorState

func exit() -> void:
	actor.previous_speed = actor.velocity.x
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)

	if not actor.is_on_floor():
		finished.emit(StatePaths.AIRBORNE_FALLING)
		return

	if (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped()):
		if actor.movement_mode == actor.MovementMode.SPRINT:
			finished.emit(StatePaths.JUMP_LONG_PREJUMP)
		else:
			finished.emit(StatePaths.JUMP_PREJUMP)
			return
