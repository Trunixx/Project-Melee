class_name Sliding extends ActorState
#TODO: Make this a parent state, treat acceleration differenly based on slope as well, don't change the facing like the airborn state, don't trigger the turnskid
func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.velocity.x += actor.stats.sliding_speed_bonus * actor.get_input_x()
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_sliding_move(delta)
	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_released("sliding") or abs(actor.velocity.x) < 20:
		finished.emit("Grounded/Postsliding")
