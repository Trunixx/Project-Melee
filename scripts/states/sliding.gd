class_name Sliding extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.velocity.x += actor.stats.sliding_speed_bonus * actor.get_input_x()
	actor.animation_player.play(state_name)
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_sliding_move(delta)
	actor.do_move(delta, actor.stats.gravity)
	
	if not actor.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump") or Input.is_action_just_released("sliding") or abs(actor.velocity.x) < 40:
		finished.emit(POSTSLIDING)
