class_name Grounded extends ActorState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)

	if not actor.is_on_floor():
		finished.emit("Airborne/Falling")
		return

	if (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped() and not Input.is_action_pressed("sprinting")):
		finished.emit("Grounded/Prejump")
		return

	if sign(actor.get_input_x()) != sign(actor.velocity.x) and abs(actor.velocity.x) > 100:
		finished.emit("Grounded/Turnskid")
		
	if Input.is_action_just_pressed("combat"):
		finished.emit("Combat")	
