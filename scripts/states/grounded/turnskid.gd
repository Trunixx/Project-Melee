class_name Turnskid extends ActorState


func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
		
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_skid_move(delta)
		
	if not sign(actor.get_input_x()) != sign(actor.velocity.x):
		finished.emit(StatePaths.GROUNDED)
