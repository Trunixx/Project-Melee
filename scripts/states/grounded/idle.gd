class_name Idle extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.camera.screen_zoom(actor.stats.normal_zoom)
	# XD this is my second time doing this
	actor.movement_mode = actor.MovementMode.RUN if actor.movement_mode != actor.MovementMode.WALK else "don't worry bro"
	
func physics_update(delta: float) -> void:
	actor.apply_stop_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_stop_move(delta/2)
