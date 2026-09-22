class_name Walljumping extends ActorState

# FIXME: Staying in this state makes you sometimes jump directly up

func enter(previous_state_path: String, data := {}) -> void:
	actor.velocity.x = actor.stats.jump_force * actor.view.scale.x * -1
	actor.velocity.y = -actor.stats.jump_force
	actor.animation_player.play("jumping")
	
func physics_update(delta: float) -> void:	
	actor.apply_jumping_move(delta/2)
	actor.do_move(delta, actor.stats.gravity * actor.stats.gravity_jump_multiplier)
	actor.apply_jumping_move(delta/2)
	
	if actor.velocity.y > actor.stats.jumping_speed_threshold:
		finished.emit(StatePaths.AIRBORNE_FALLING)
