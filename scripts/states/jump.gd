class_name Jump extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)
	
	if actor.velocity.y > 0:
		finished.emit(StatePaths.AIRBORNE_FALLING)
