class_name Walljumping extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.velocity.x = actor.stats.jump_force * actor.view.scale.x * -1
	actor.velocity.y = -actor.stats.jump_force
	actor.view.face_from_sign(actor.get_input_x())
	actor.animation_player.play("jumping")
	
func physics_update(delta: float) -> void:	
	actor.apply_jumping_move(delta/2)
	actor.do_move(delta, actor.stats.gravity * actor.stats.gravity_jump_multiplier)
	actor.apply_jumping_move(delta/2)
	
	if actor.velocity.y > actor.stats.jumping_speed_threshold:
		finished.emit(StatePaths.AIRBORNE_FALLING)
