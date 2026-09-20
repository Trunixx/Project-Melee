class_name CrouchIdle extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	# HACK Animation name
	actor.animation_player.play("crouch_idle")
	
func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_stop_move(delta)
