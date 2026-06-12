class_name Sprinting extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_ground_move(delta, actor.stats.sprinting_multiplier)
	actor.do_move(delta, actor.stats.gravity)
	
	if not actor.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_released("sprinting"):
		finished.emit(RUNNING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(LONGPREJUMP)
	elif is_equal_approx(actor.get_input_x(), 0.0):
		finished.emit(IDLE)
