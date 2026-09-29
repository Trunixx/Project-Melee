class_name Landing extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.previous_zoom = actor.camera.target_zoom
	actor.camera.screen_zoom(2.85) 
	actor.camera.screen_shake(actor.previous_y_speed/200, actor.animation_player.current_animation_length)
	
func exit() -> void:
	actor.camera.screen_zoom(actor.previous_zoom)
	
func physics_update(delta: float) -> void:
	#actor.apply_stop_move(delta/2)
	#actor.do_move(delta, actor.stats.gravity)
	#actor.apply_stop_move(delta/2)
	actor.velocity = Vector2.ZERO
	
	if not is_zero_approx(actor.get_input_x()) and not actor.animation_player.is_playing():
		finished.emit(StatePaths.GROUNDED)
		return
