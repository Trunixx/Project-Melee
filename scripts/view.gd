extends Node2D

var facing := 1

func face_from_velocity(vel_x: float) -> void:
	if vel_x == 0.0:
		return
	facing = sign(vel_x)
	scale.x = facing
