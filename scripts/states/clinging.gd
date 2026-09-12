class_name Clinging extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.start_wall_cling_timer()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.velocity.y = 0.0
	
	if actor.wall_cling_timed_out:
		finished.emit(StatePaths.WALL_SCRAPING)
