class_name Postsliding extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	
func physics_update(delta: float) -> void:
	actor.apply_sliding_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_sliding_move(delta/2)

	if not actor.animation_player.is_playing():
		finished.emit(StatePaths.GROUNDED)
