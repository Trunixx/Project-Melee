class_name Airborne extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.coyote_buffer_timer.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.apply_air_move(delta)
	actor.do_move(delta, actor.stats.gravity)
	
	# FIXME: Repeats code from the Grounded state
	if not actor.coyote_buffer_timer.is_stopped() and (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped()):
		# This avoids making the jump shorter if started in coyote time
		if not actor.coyote_buffer_timer.is_stopped():
			actor.velocity.y = 0.0
		if Input.is_action_pressed("sprinting"):
			finished.emit("Grounded/Longprejump")
		else:
			finished.emit("Grounded/Prejump")
		return
		
	if actor.is_on_floor():
		if is_equal_approx(actor.get_input_x(), 0.0):
			finished.emit("Grounded/Idle")
		elif Input.is_action_pressed("walking"):
			finished.emit("Grounded/Walking")
		else:
			finished.emit("Grounded/Running")
