class_name Walking extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
		
func exit() -> void:
	actor.stats.previous_speed = actor.velocity.x
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_ground_move(delta)
	
	if is_equal_approx(actor.get_input_x(), 0.0):
		finished.emit("Grounded/Idle")
	elif Input.is_action_pressed("sprinting"):
		finished.emit("Grounded/Sprinting")
	elif not Input.is_action_pressed("walking"):
		finished.emit("Grounded/Running")
