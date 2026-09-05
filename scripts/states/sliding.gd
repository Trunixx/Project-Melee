class_name Sliding extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	# HACK: make this more dynamic maybe with a curve and a timer to avoid slide spam ?
	if abs(actor.velocity.x) < 400:
		actor.velocity.x += actor.stats.sliding_speed_bonus * actor.get_input_x()
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:	
	if Input.is_action_just_pressed("jump") or Input.is_action_just_released("sliding") or abs(actor.velocity.x) < 20:
		finished.emit("Slide/Postsliding")
	#TODO: make a crouch state as a Grounded leaf
