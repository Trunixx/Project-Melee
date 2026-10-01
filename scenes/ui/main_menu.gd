extends CanvasLayer

func _on_new_game_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	get_tree().change_scene_to_packed(ScenePaths.DEBUG_LEVEL_1)
	# TODO: Change it to a scene selector scene

func _on_continue_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	get_tree().change_scene_to_packed(ScenePaths.DEBUG_LEVEL_1)
	# TODO: Change it to check save files

func _on_settings_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	UIManager.open_menu(ScenePaths.SETTINGS)
	
func _on_credits_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	await get_tree().create_timer(0.1).timeout
	UIManager.open_menu(ScenePaths.CREDITS)

func _on_quit_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	await get_tree().create_timer(0.1).timeout
	get_tree().quit()
