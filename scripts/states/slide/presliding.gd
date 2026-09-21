class_name Presliding extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.sliding_buffer_timer.stop()
	
func physics_update(delta: float) -> void:
	actor.apply_sliding_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_sliding_move(delta/2)

	if Input.is_action_just_released("sliding"):
		finished.emit(StatePaths.SLIDE_POSTSLIDING)
	elif not actor.animation_player.is_playing():
		finished.emit(StatePaths.SLIDE_SLIDING)
