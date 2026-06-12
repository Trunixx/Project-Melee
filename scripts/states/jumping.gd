class_name Jumping extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	var input_x = actor.get_input_x()
	if sign(actor.stats.previous_speed) == sign(input_x):
		actor.velocity.x = abs(actor.stats.previous_speed) * input_x
	actor.velocity.y -= actor.stats.jump_force
	actor.animation_player.play(state_name)
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_jump_move(delta, actor.stats.jumping_speed_multiplier)
	actor.do_move(delta, actor.stats.gravity)
	
	if actor.velocity.y >= 0:
		finished.emit(JUMPFALLING)
