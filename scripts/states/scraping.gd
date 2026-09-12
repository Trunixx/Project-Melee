class_name Scraping extends ActorState

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.animation_player.play(state_name)
	actor.velocity.y = -actor.stats.wall_speed
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.do_move(delta, 0)
	actor.apply_wall_sliding_move(delta)
