class_name Turnskid extends ActorState


func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
		
func physics_update(delta: float) -> void:
	actor.apply_skid_move(delta/2)
	actor.do_move(delta, actor.stats.gravity)
	actor.apply_skid_move(delta/2)
	
	# This helps with not going over edges if you overshoot a jump
	# Heh... High five, brain.
	if not actor.edge_detector.is_colliding():
		actor.position.x += actor.view.scale.x * 2
		
	if not sign(actor.get_input_x()) != sign(actor.velocity.x):
		finished.emit(StatePaths.GROUNDED)
	
	
