extends Control

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func close_settings() -> void:
	queue_free()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		get_viewport().set_input_as_handled()
		close_settings()
