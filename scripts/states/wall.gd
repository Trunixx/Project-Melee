class_name Wall extends ActorState

# TODO: Timer when jumping off the wall

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.velocity.y = 0.0
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, 0)
	actor.view.face_from_sign(actor.get_input_x())
	
	if not actor.is_colliding_with_wall() and not actor.is_on_floor():
		finished.emit(StatePaths.AIRBORNE_FALLING)
		return
	if actor.is_on_floor():
		finished.emit(StatePaths.GROUNDED)
		return
	
	if Input.is_action_just_pressed("jump"):
		finished.emit(StatePaths.WALL_WALLJUMPING)
		return
	
	if is_equal_approx(actor.get_input_x(), 0.0):
		finished.emit(StatePaths.WALL_SCRAPING)
	elif not actor.wall_cling_timed_out:
		finished.emit(StatePaths.WALL_CLINGED)
	else:
		finished.emit(StatePaths.WALL_SCRAPING)
