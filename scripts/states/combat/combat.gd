class_name Combat extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.camera_zoomer.play("zoom_in")
	
	
func exit() -> void:
	actor.camera_zoomer.play("zoom_out")
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_combat_move(delta, actor.stats.combat_multiplier)
	actor.do_move(delta, actor.stats.gravity)
	actor.view.face_from_mouse()

	if not actor.is_on_floor():
		finished.emit(StatePaths.AIRBORNE_FALLING)
	elif Input.is_action_just_pressed("jump") or actor.is_jump_buffer_on():
		finished.emit(StatePaths.AIRBORNE_JUMPING)
	elif Input.is_action_just_pressed("combat"):
		finished.emit(StatePaths.GROUNDED)
