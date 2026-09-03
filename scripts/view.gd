extends Node2D

var facing := 1

func face_from_velocity(vel_x: float) -> void:
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
