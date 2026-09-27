class_name Climbing extends ActorState

# FIMXE: if I start climbing when already colliding the very top it never ledge grabs

func enter(_previous_state_path: String, _data := {}) -> void:
	actor.animation_player.play("climbing")
	actor.velocity = Vector2.ZERO
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	actor.view.face_from_sign_delayed(actor.get_input_x())
	
	actor.apply_climbing_move(delta/2)
	actor.do_move(delta)
	actor.apply_climbing_move(delta/2)
	actor.camera.screen_zoom(clamp(actor.stats.normal_zoom - actor.velocity.y/1000 + 0.25, 2.5, 3.25))

	actor.current_wall_stamina -= actor.stats.wall_stamina_drain_rate * delta
	
	if not actor.is_colliding_with_wall():
		finished.emit(StatePaths.AIRBORNE_FALLING)
		return
