class_name Longjumping extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.velocity.y -= actor.stats.long_jump_force
	actor.animation_player.play(state_name)
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.do_move_by_mode("jump", delta, actor.stats.longjump_speed_bonus, actor.stats.longjumping_speed_multiplier, actor.stats.jump_gravity)

	if actor.velocity.y >= 0:
		finished.emit(LONGJUMPFALLING)
