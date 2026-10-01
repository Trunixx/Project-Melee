extends CanvasLayer

const SETTINGS = preload("uid://bjncayqwu40am")
const MAIN_MENU = preload("uid://cq328d1cexggs")

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	resume()

func pause() -> void:
	show()
	get_tree().paused = true
	
func resume() -> void:
	hide()
	get_tree().paused = false
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		if get_tree().paused:
			resume()
			return
			
		else:
			pause()
			return
		
func _on_resume_button_pressed() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	resume()

func _on_settings_button_pressed() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	var menu := SETTINGS.instantiate()
	add_child(menu)

func _on_main_menu_button_pressed() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	resume()
	get_tree().change_scene_to_packed(MAIN_MENU)
