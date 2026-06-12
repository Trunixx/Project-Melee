class_name Jumping extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.velocity.y -= actor.stats.jump_force
	actor.animation_player.play(state_name)
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_jump_move(delta, actor.stats.previous_speed, actor.stats.jumping_speed_multiplier)
	actor.do_move(delta, actor.stats.gravity)
	
	if actor.velocity.y >= 0:
		finished.emit(JUMPFALLING)
