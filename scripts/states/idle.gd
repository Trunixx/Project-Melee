class_name Idle extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	actor.animation_player.play(state_name)
	
func exit() -> void:
	pass
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.do_move_by_mode("idle", delta)
	
	if not actor.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_just_pressed("jump"):
		finished.emit(PREJUMP)
	elif Input.is_action_pressed("walking") and (Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right")):
		finished.emit(WALKING)
	elif Input.is_action_just_pressed("move_left") or Input.is_action_just_pressed("move_right"):
		finished.emit(RUNNING)
