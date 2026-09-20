class_name CrouchRunning extends ActorState

func enter(previous_state_path: String, data := {}) -> void:
	# HACK Animation name
	actor.animation_player.play("crouch_walking")

func handle_input(event: InputEvent) -> void:
	pass
	
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	actor.apply_ground_move(delta, actor.stats.crouch_running_multiplier)
