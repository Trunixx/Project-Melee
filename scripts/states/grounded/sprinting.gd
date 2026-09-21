class_name Sprinting extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	
func physics_update(delta: float) -> void:
	actor.apply_ground_move(delta/2, actor.stats.sprinting_multiplier)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_ground_move(delta/2, actor.stats.sprinting_multiplier)
