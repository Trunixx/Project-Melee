extends CanvasLayer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
		
func _on_resume_button_pressed() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	UIManager.close_all_menus()
	
func _on_settings_button_pressed() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	UIManager.open_menu(ScenePaths.SETTINGS)

func _on_main_menu_button_pressed() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	get_tree().change_scene_to_packed(ScenePaths.MAIN_MENU)
	UIManager.close_current_menu()
