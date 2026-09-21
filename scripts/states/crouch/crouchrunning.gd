class_name CrouchRunning extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play("crouch_walking")
	
func physics_update(delta: float) -> void:
	actor.apply_ground_move(delta/2, actor.stats.crouch_running_multiplier)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_ground_move(delta/2, actor.stats.crouch_running_multiplier)
