extends Node2D

var facing := 1.0

@onready var actor: Actor = $".."
var is_wall_turning_timer_stopped : bool = false

func face_from_sign(vel_x: float) -> void:
	if vel_x == 0.0:
		return
	facing = sign(vel_x)
	scale.x = facing

func face_from_mouse() -> void:
	if get_viewport().get_mouse_position().x >= (get_viewport().get_visible_rect().size.x/2)+30:
		facing = 1.0
	elif get_viewport().get_mouse_position().x <= (get_viewport().get_visible_rect().size.x/2)-30:
		facing = -1.0
	else: 
		pass
	scale.x = facing
	
func face_from_sign_delayed(vel_x: float) -> void:
	if sign(scale.x) != sign(vel_x) and sign(vel_x) != 0 and actor.wall_turning_buffer_timer.is_stopped() and not is_wall_turning_timer_stopped:
		actor.wall_turning_buffer_timer.start()
		is_wall_turning_timer_stopped = false
	if actor.wall_turning_buffer_timer.is_stopped() and is_wall_turning_timer_stopped:
		face_from_sign(vel_x)
		is_wall_turning_timer_stopped = false

func _on_wall_turning_buffer_timer_timeout() -> void:
	is_wall_turning_timer_stopped = true
