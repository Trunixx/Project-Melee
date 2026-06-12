class_name Longprejump extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.do_move_by_mode("prejump", delta, 0.0, actor.stats.longprejump_speed_multiplier)
	
	if not actor.is_on_floor():
		finished.emit(FALLING)
	elif not actor.animation_player.is_playing():
		finished.emit(LONGJUMPING)
