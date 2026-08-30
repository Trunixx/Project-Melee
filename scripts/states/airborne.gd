class_name Airborne extends ActorState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.apply_air_move(delta)
	actor.do_move(delta, actor.stats.gravity)

	if actor.is_on_floor():
		if is_equal_approx(actor.get_input_x(), 0.0):
			finished.emit("Grounded/Idle")
		elif Input.is_action_pressed("walking"):
			finished.emit("Grounded/Walking")
		else:
			finished.emit("Grounded/Running")
