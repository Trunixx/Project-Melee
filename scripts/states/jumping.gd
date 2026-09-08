class_name Jumping extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	var input_x = actor.get_input_x()
	# These two lines avoid giving momentum if changing direction between prejump and jump
	if sign(actor.previous_speed) == sign(input_x):
		actor.velocity.x = abs(actor.previous_speed) * input_x
	actor.velocity.y -= actor.stats.jump_force
	actor.animation_player.play(state_name)
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.do_move(delta, actor.stats.gravity * actor.stats.gravity_jump_multiplier)
	actor.apply_jump_move(delta, actor.stats.jumping_speed_multiplier)
	
	if actor.velocity.y > 0:
		finished.emit(StatePaths.AIRBORNE_FALLING)
