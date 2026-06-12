class_name Falling extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.do_move_by_mode("air", delta)

	if actor.is_on_floor():
		if is_equal_approx(actor.get_input_x(), 0.0):
			finished.emit(IDLE)
		elif Input.is_action_pressed("walking"):
			finished.emit(WALKING)
		else:
			finished.emit(RUNNING)
