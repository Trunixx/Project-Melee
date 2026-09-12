class_name Walljumping extends ActorState

# TODO: Fix this mess

func enter(previous_state_path: String, data := {}) -> void:
	actor.velocity.x = 0.0
	actor.velocity.x += 200 * actor.view.scale.x * -1
	actor.velocity.y -= actor.stats.jump_force
	actor.animation_player.play("jumping")
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity * actor.stats.gravity_jump_multiplier)
	actor.apply_air_move(delta)
	
	if actor.velocity.y > 0:
		finished.emit(StatePaths.AIRBORNE_FALLING)
