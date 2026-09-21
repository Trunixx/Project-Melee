class_name CrouchIdle extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play("crouch_idle")
	
func physics_update(delta: float) -> void:
	actor.apply_stop_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_stop_move(delta/2)
