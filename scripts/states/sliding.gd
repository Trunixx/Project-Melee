class_name Sliding extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	if actor.sliding_boost_timer.is_stopped():
		actor.velocity.x += actor.stats.sliding_speed_bonus * actor.get_input_x()
		actor.sliding_boost_timer.start()
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:	
	actor.apply_sliding_move(delta)
	
	if Input.is_action_just_released("sliding") or abs(actor.velocity.x) < 20:
		finished.emit(StatePaths.SLIDE_POSTSLIDING)
	# TODO: make a crouch state as a Grounded leaf
