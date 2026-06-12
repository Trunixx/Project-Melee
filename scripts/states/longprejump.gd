class_name Longprejump extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.jump_buffer_timer.stop()
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_stop_move(delta)
	actor.do_move(delta, actor.stats.gravity)
	
	if not actor.edge_detector.is_colliding():
		actor.velocity.x = 0
		
	if not actor.is_on_floor():
		finished.emit(FALLING)
	elif not actor.animation_player.is_playing():
		finished.emit(LONGJUMPING)
