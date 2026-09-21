class_name Falling extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	
	
func physics_update(delta: float) -> void:
	actor.apply_falling_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_falling_move(delta/2)
