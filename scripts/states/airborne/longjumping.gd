class_name Longjumping extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	var input_x = actor.get_input_x()
	# These two lines avoid giving momentum if changing direction between prejump and jump
	if sign(actor.previous_speed) == sign(input_x):
		actor.velocity.x = abs(actor.previous_speed) * input_x
	actor.velocity.y -= actor.stats.long_jump_force
	actor.animation_player.play("long_jumping")
	
func physics_update(delta: float) -> void:
	actor.apply_jumping_move(delta/2)
	actor.do_move(delta, actor.stats.gravity * actor.stats.gravity_long_jump_multiplier)
	actor.apply_jumping_move(delta/2)

	if actor.velocity.y > actor.stats.long_jumping_speed_threshold or Input.is_action_just_released("jump"):
		finished.emit(StatePaths.AIRBORNE_FALLING)
