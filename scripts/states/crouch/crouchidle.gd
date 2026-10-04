class_name CrouchIdle extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.animation_player.play("crouch_idle")
	actor.camera.screen_zoom(actor.stats.normal_crouch_zoom)
	
func physics_update(delta: float) -> void:
	actor.apply_stop_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_stop_move(delta/2)
