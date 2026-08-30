class_name Turnskid extends ActorState


func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_skid_move(delta)
		
	if not sign(actor.get_input_x()) != sign(actor.velocity.x):
		if not is_equal_approx(actor.get_input_x(), 0.0):
			if Input.is_action_pressed("sprinting"):
				finished.emit("Grounded/Sprinting")
			elif Input.is_action_pressed("walking"):
				finished.emit("Grounded/Walking")
			elif is_equal_approx(actor.get_input_x(), 0.0):
				finished.emit("Grounded/Idle")
			else:
				finished.emit("Grounded/Running")
