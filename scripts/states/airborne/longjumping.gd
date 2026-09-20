class_name Longjumping extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	var input_x = actor.get_input_x()
	# These two lines avoid giving momentum if changing direction between prejump and jump
	if sign(actor.previous_speed) == sign(input_x):
		actor.velocity.x = abs(actor.previous_speed) * input_x
	actor.velocity.y -= actor.stats.long_jump_force
	# HACK: Animation name
	actor.animation_player.play("long_jumping")
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_air_move(delta)
	
	if actor.velocity.y > actor.stats.longjumping_speed_threshold:
		finished.emit(StatePaths.AIRBORNE_FALLING)
