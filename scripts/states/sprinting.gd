class_name Sprinting extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
		
func exit() -> void:
	actor.stats.previous_speed = actor.velocity.x 
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_ground_move(delta, actor.stats.sprinting_multiplier)
	
	if not Input.is_action_pressed("sprinting"):
		if Input.is_action_pressed("walking"):
			finished.emit("Grounded/Walking")
		else:
			finished.emit("Grounded/Running")
	elif Input.is_action_just_pressed("jump") or not actor.jump_buffer_timer.is_stopped():
		finished.emit("Grounded/Longprejump")
	
