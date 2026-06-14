class_name Presliding extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.sliding_buffer_timer.stop()
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_sliding_move(delta)
	actor.do_move(delta, actor.stats.gravity)
	
	if not actor.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_released("sliding"):
		finished.emit(POSTSLIDING)
	elif Input.is_action_just_pressed("jump") and Input.is_action_pressed("sprinting") or not actor.jump_buffer_timer.is_stopped():
		finished.emit(LONGPREJUMP)
	elif Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped():
		finished.emit(PREJUMP)
	elif not actor.animation_player.is_playing():
		finished.emit(SLIDING)
