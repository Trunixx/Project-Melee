class_name Scraping extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.animation_player.play("wall_landing")
	#actor.velocity.y = -actor.stats.wall_speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.view.face_from_sign_delayed(actor.get_input_x())
	
	actor.apply_wall_sliding_move(delta/2)
	actor.do_move(delta, 0)
	actor.apply_wall_sliding_move(delta/2)
	
	actor.camera.screen_zoom(clamp(actor.stats.normal_zoom - actor.velocity.y/1000 + 0.25, 2.5, 3.25))
	
	if actor.is_on_floor():
		finished.emit(StatePaths.GROUNDED)
		return
		
	if not actor.is_colliding_with_wall():
		finished.emit(StatePaths.AIRBORNE_FALLING)
		return
