class_name LedgeGrab extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.animation_player.play("ledge_grab")
	actor.is_ledge_grabbing = true
	actor.position_offset = Vector2.ZERO
	actor.ledge_grab_start_position = actor.position

func exit() -> void:
	actor.is_ledge_grabbing = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.view.face_from_sign_delayed(actor.get_input_x())
	actor.apply_ledge_grab_move()
	
	if not actor.animation_player.is_playing():
		finished.emit(StatePaths.GROUNDED)
