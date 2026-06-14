class_name Postsliding extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	
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
	elif Input.is_action_just_pressed("jump") and Input.is_action_pressed("sprinting") or not actor.jump_buffer_timer.is_stopped() and actor.animation_player.current_animation_position > 0.1:
		finished.emit(LONGPREJUMP)
	elif Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped() and actor.animation_player.current_animation_position > 0.1:
		finished.emit(PREJUMP)
	elif not actor.animation_player.is_playing() and not Input.is_action_pressed("sprinting"):
		finished.emit(RUNNING)
	elif not actor.animation_player.is_playing() and Input.is_action_pressed("sprinting"):
		finished.emit(SPRINTING)
