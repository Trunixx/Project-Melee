extends Node2D

var sound_effect_dict: Dictionary = {}

@export var sound_effects: Array[SoundEffect]


func _ready() -> void:
	for sound_effect: SoundEffect in sound_effects:
		sound_effect_dict[sound_effect.type] = sound_effect

## Creates a sound effect at a specific location if the limit has not been reached. Pass [param location] for the global position of the audio effect, and [param type] for the SoundEffect to be queued.
func create_2d_audio_at_location(location: Vector2, type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	if sound_effect_dict.has(type):
		var sound_effect: SoundEffect = sound_effect_dict[type]
		if sound_effect.has_open_limit():
			sound_effect.change_audio_count(1)
			var new_2D_audio: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
			add_child(new_2D_audio)
			new_2D_audio = _assign_audio_features(sound_effect, new_2D_audio, location)
			new_2D_audio.play()

## Creates a sound effect if the limit has not been reached. Pass [param type] for the SoundEffect to be queued.
func create_audio(type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	if sound_effect_dict.has(type):
		var sound_effect: SoundEffect = sound_effect_dict[type]
		if sound_effect.has_open_limit():
			sound_effect.change_audio_count(1)
			var new_audio: AudioStreamPlayer = AudioStreamPlayer.new()
			add_child(new_audio)
			new_audio = _assign_audio_features(sound_effect, new_audio)
			new_audio.play()
		
func _assign_audio_features(sound_effect: SoundEffect, audio_stream_player: Node, location: Vector2 = Vector2.ZERO) -> Node:
	if audio_stream_player is AudioStreamPlayer2D:
		audio_stream_player.position = location
	if audio_stream_player is AudioStreamPlayer2D or audio_stream_player is AudioStreamPlayer:
		audio_stream_player.bus = sound_effect.bus
		audio_stream_player.stream = sound_effect.sound_effect
		audio_stream_player.volume_db = sound_effect.volume
		audio_stream_player.pitch_scale = sound_effect.pitch_scale
		audio_stream_player.pitch_scale += randf_range(-sound_effect.pitch_randomness, sound_effect.pitch_randomness)
		audio_stream_player.finished.connect(sound_effect.on_audio_finished)
		audio_stream_player.finished.connect(audio_stream_player.queue_free)
	else:
		push_error("Audio Manager failed to find setting for type ", sound_effect.type)
	return audio_stream_player
