class_name Airborne extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.reset_coyote_time()
	
func exit() -> void:
	actor.is_accelerating_descent = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.view.face_from_sign(actor.get_input_x())
	# XD why is it syntactically correct???
	# I should change it to a normal condition but it makes me giggle everytime so I ain't gonna do that
	actor.apply_gravity(actor.stats.gravity * 0.60, delta) if actor.is_accelerating_descent else "don't worry bout it bro"
	
	if actor.is_on_floor():
		finished.emit(StatePaths.GROUNDED)
		
	if actor.is_colliding_with_wall() and actor.get_input_x() != 0: #and actor.get_input_x() != actor.mid_wall_detector.get_collision_normal().x:
		finished.emit(StatePaths.WALL)
	
	if Input.is_action_just_pressed("jump"):
		actor.jump_buffer_timer.start()
		
	if Input.is_action_pressed("sliding"):
		actor.sliding_buffer_timer.start()
		actor.is_accelerating_descent = true
	
	if Input.is_action_just_released("sliding"):
		actor.sliding_buffer_timer.stop()
		actor.is_accelerating_descent = false
