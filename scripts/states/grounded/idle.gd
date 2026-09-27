class_name Idle extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.camera.screen_zoom(actor.stats.normal_zoom)
	
func physics_update(delta: float) -> void:
	actor.apply_stop_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_stop_move(delta/2)
