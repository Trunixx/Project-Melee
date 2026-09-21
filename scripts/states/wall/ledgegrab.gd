class_name LedgeGrab extends ActorState

func enter(_previous_state_path: String, data := {}) -> void:
	actor.is_ledge_grabbing = true
	actor.ledge_grab_start_position = actor.position
	actor.position_offset = Vector2.ZERO
	# I tried using play_section_with_markers but it doesn't change the sprite 🫩
	if data.get("position") == "high":
		actor.animation_player.play("ledge_grab")
		actor.animation_player.seek(0.0, true)
		
	elif data.get("position") == "mid":
		actor.animation_player.play("ledge_grab")
		actor.animation_player.seek(0.2, true)

	elif data.get("position") == "low":
		actor.animation_player.play("ledge_grab")
		actor.animation_player.seek(0.3667, true)
	actor.ledge_grab_initial_offset = actor.position_offset
	
func exit() -> void:
	actor.is_ledge_grabbing = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.view.face_from_sign_delayed(actor.get_input_x())
	actor.apply_ledge_grab_move()
	
	if not actor.animation_player.is_playing():
		finished.emit(StatePaths.GROUNDED)
