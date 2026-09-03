class_name Grounded extends ActorState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)
	actor.view.face_from_sign(actor.get_input_x())

	if not actor.is_on_floor():
		finished.emit("Airborne/Falling")
		return

	if (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped() and not Input.is_action_pressed("sprinting")):
		finished.emit("Grounded/Prejump")
		return

	if sign(actor.get_input_x()) != sign(actor.velocity.x) and abs(actor.velocity.x) > 150.0:
		print(actor.get_input_x())
		print(actor.velocity.x)
		print()
		finished.emit("Grounded/Turnskid")
	
	elif is_equal_approx(actor.get_input_x(), 0.0):
		finished.emit("Grounded/Idle")
		
	if Input.is_action_just_pressed("combat"):
		finished.emit("Combat")	
