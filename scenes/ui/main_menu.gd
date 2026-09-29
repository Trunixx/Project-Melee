extends Control

const DEBUG_LEVEL_1 = preload("uid://b2nd0rupfwexx")

const CREDITS = preload("uid://3rqnfndasryu")

func _on_new_game_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)


func _on_continue_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	get_tree().change_scene_to_packed(DEBUG_LEVEL_1)

func _on_options_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)


func _on_credits_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	get_tree().change_scene_to_packed(CREDITS)

func _on_quit_button_button_down() -> void:
	AudioManager.create_audio(SoundEffect.SOUND_EFFECT_TYPE.UI_BUTTON_PRESS)
	await get_tree().create_timer(0.2).timeout
	get_tree().quit()
