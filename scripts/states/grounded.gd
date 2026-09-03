class_name Grounded extends ActorState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)
	actor.view.face_from_sign(actor.get_input_x())

	if not actor.is_on_floor():
		finished.emit("Airborne/Falling")
		return

	if (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped() and not Input.is_action_pressed("sprinting")):
		if Input.is_action_pressed("sprinting"):
			finished.emit("Grounded/Longprejump")
		else:
			finished.emit("Grounded/Prejump")
		return
		
	if Input.is_action_just_pressed("sliding") or not actor.sliding_buffer_timer.is_stopped():
		finished.emit("Slide/Presliding")
		return
		
	if sign(actor.get_input_x()) != sign(actor.velocity.x) and abs(actor.velocity.x) > actor.stats.move_force:
		finished.emit("Grounded/Turnskid")
		return
	elif is_equal_approx(actor.get_input_x(), 0.0):
		finished.emit("Grounded/Idle")
		return
		
	if Input.is_action_just_pressed("combat"):
		finished.emit("Combat")	
		return
