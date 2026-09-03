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
	
	if Input.is_action_just_released("sliding"):
		finished.emit("Slide/Postsliding")
	elif not actor.animation_player.is_playing():
		finished.emit("Slide/Sliding")
