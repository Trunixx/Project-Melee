class_name Combat extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_combat_move(delta, actor.stats.combat_multiplier)
	actor.do_move_no_face(delta, actor.stats.gravity)
	
	if not actor.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped():
		finished.emit(PREJUMP)
	elif Input.is_action_just_pressed("combat"):
		finished.emit(IDLE)
