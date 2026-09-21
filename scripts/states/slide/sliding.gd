class_name Sliding extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	if actor.sliding_boost_timer.is_stopped():
		actor.velocity.x += actor.stats.sliding_speed_bonus * actor.get_input_x()
		actor.sliding_boost_timer.start()
	
func physics_update(delta: float) -> void:
	actor.apply_sliding_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_sliding_move(delta/2)

	if Input.is_action_just_released("sliding"):
		finished.emit(StatePaths.SLIDE_POSTSLIDING)
	if abs(actor.velocity.x) < actor.stats.minimum_sliding_speed:
		finished.emit(StatePaths.CROUCH)
