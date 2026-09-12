class_name Airborne extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.reset_coyote_time()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity)
	actor.view.face_from_sign(actor.get_input_x())
	
	if actor.is_on_floor():
		finished.emit(StatePaths.GROUNDED)
		
	if actor.is_colliding_with_wall():
		finished.emit(StatePaths.WALL)
