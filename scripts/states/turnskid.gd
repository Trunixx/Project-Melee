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
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			finished.emit("Grounded/Running")
		elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") and Input.is_action_pressed("walking"):
			finished.emit("Grounded/Walking")
		elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right") and Input.is_action_pressed("sprinting"):
			finished.emit("Grounded/Sprinting")
		elif is_equal_approx(actor.get_input_x(), 0.0):
			finished.emit("Grounded/Idle")
