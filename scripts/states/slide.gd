class_name Slide extends ActorState

# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.apply_sliding_move(delta)
	actor.do_move(delta, actor.stats.gravity)

	if not actor.is_on_floor():
		finished.emit("Airborne/Falling")
		return

	if (Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped()):
		finished.emit("Grounded/Prejump")
		return

func exit() -> void:
	actor.stats.previous_speed = actor.velocity.x
