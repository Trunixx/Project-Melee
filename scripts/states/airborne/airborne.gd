class_name Airborne extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.reset_coyote_time()
	
func exit() -> void:
	actor.is_accelerating_descent = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.view.face_from_sign(actor.get_input_x())
	
	if actor.is_accelerating_descent:
		actor.apply_gravity(actor.stats.gravity * 0.60, delta)
	
	if actor.is_on_floor(): 
		if actor.previous_y_speed > 500: # HACK: magic numba
			finished.emit(StatePaths.LANDING)
		else:
			finished.emit(StatePaths.GROUNDED)
	else:
		actor.previous_y_speed = actor.velocity.y
		
	if actor.is_colliding_with_wall() and actor.get_input_x() != 0: #and actor.get_input_x() != actor.mid_wall_detector.get_collision_normal().x:
		finished.emit(StatePaths.WALL)
	
	if Input.is_action_just_pressed("jump"):
		actor.jump_buffer_timer.start()
