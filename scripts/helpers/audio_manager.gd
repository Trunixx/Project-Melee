extends Node2D

var sound_effect_dict: Dictionary = {}

@export var sound_effects: Array[SoundEffect]

func _ready() -> void:
	for sound_effect: SoundEffect in sound_effects:
		sound_effect_dict[sound_effect.type] = sound_effect

# Creates a sound effect at a specific location
func create_2d_audio_at_location(type: SoundEffect.SOUND_EFFECT_TYPE, location: Vector2) -> void:
	var new_2D_audio : AudioStreamPlayer2D = _assign_audio_features("AudioStreamPlayer2D", type, location)
	add_child(new_2D_audio)
	new_2D_audio.play()

# Creates a sound effect
func create_audio(type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	var new_audio : AudioStreamPlayer = _assign_audio_features("AudioStreamPlayer", type)
	add_child(new_audio)
	new_audio.play()

# Helper function that actually creates the sound
func _assign_audio_features(class_type: String, type: SoundEffect.SOUND_EFFECT_TYPE, location: Vector2 = Vector2.ZERO) -> Node:
	if not sound_effect_dict.has(type):
		push_error("Audio Manager failed to find setting for type ", type)
		return null
		
	var sound_effect: SoundEffect = sound_effect_dict[type]
	
	if not sound_effect.has_not_reached_limit():
		return null
	
	sound_effect.increment_audio_count()
	
	var new_audio : Node
	
	if class_type == "AudioStreamPlayer2D":
		new_audio = AudioStreamPlayer2D.new()
		new_audio.position = location
	elif class_type == "AudioStreamPlayer": 
		new_audio = AudioStreamPlayer.new()
	else:
		push_error("Wrong node type: ", class_type)
		return null
		
	new_audio.bus = sound_effect.get_bus_string()
	new_audio.stream = sound_effect.sound_effect
	new_audio.volume_db = sound_effect.volume
	new_audio.pitch_scale = sound_effect.pitch_scale
	new_audio.pitch_scale += randf_range(-sound_effect.pitch_randomness, sound_effect.pitch_randomness)
	new_audio.finished.connect(sound_effect.on_audio_finished)
	new_audio.finished.connect(new_audio.queue_free)
	
	return new_audio
