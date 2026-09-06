class_name Airborne extends ActorState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)
	
	if actor.is_on_floor():
		if is_equal_approx(actor.get_input_x(), 0.0):
			finished.emit(StatePaths.GROUNDED_IDLE)
		elif Input.is_action_pressed("walking"):
			finished.emit(StatePaths.GROUNDED_WALKING)
		else:
			finished.emit(StatePaths.GROUNDED_RUNNING)
