extends Node2D

var sound_effect_dict : Dictionary = {}
@export var sound_effects : Array[SoundEffect]

var audio_pool : Array[AudioStreamPlayer] = []
var audio_2d_pool : Array[AudioStreamPlayer2D] = []

# Populates the dictionary from the exported array
func _ready() -> void:
	for sound_effect: SoundEffect in sound_effects:
		sound_effect_dict[sound_effect.type] = sound_effect

# Creates a sound effect
func create_audio(type: SoundEffect.SOUND_EFFECT_TYPE) -> void:
	var new_audio : AudioStreamPlayer = _assign_audio_features("AudioStreamPlayer", type)
	if new_audio:
		new_audio.play()
	
# Creates a sound effect at a specific location
func create_2d_audio_at_location(type: SoundEffect.SOUND_EFFECT_TYPE, location: Vector2) -> void:
	var new_2d_audio : AudioStreamPlayer2D = _assign_audio_features("AudioStreamPlayer2D", type, location)
	if new_2d_audio:
		new_2d_audio.play()
	
# Helper function that actually creates the sound
func _assign_audio_features(class_type: String, type: SoundEffect.SOUND_EFFECT_TYPE, location: Vector2 = Vector2.ZERO) -> Node:
	if not sound_effect_dict.has(type):
		push_error("Audio Manager failed to find setting for type: ", type)
		return null
		
	if class_type != "AudioStreamPlayer2D" and class_type != "AudioStreamPlayer":
		push_error("Wrong node type: ", class_type)
		return null

	var sound_effect: SoundEffect = sound_effect_dict[type]
	
	if sound_effect.has_reached_limit():
		return null
	
	sound_effect.increment_audio_count()
	
	var new_audio : Node = _get_available_audio_player(class_type)
	
	if class_type == "AudioStreamPlayer2D":
		new_audio.position = location
	new_audio.bus = sound_effect.get_bus_string()
	new_audio.stream = sound_effect.get_audio_stream()
	new_audio.volume_db = sound_effect.volume
	
	for connection in new_audio.finished.get_connections():
		new_audio.finished.disconnect(connection["callable"])
	
	new_audio.finished.connect(sound_effect.on_audio_finished)
	
	return new_audio

# Helper function that gets a player in the pool
func _get_available_audio_player(class_type: String) -> Node:
	var selected_audio_pool
	match class_type:
		"AudioStreamPlayer2D":
			selected_audio_pool = audio_2d_pool
		"AudioStreamPlayer":
			selected_audio_pool = audio_pool
		_:
			push_error("Invalid audio player type: ", class_type)
			return null
			
	for player in selected_audio_pool:
		if not player.playing:
			return player
	
	@warning_ignore("incompatible_ternary")
	var player = AudioStreamPlayer2D.new() if class_type == "AudioStreamPlayer2D" else AudioStreamPlayer.new()
	selected_audio_pool.append(player)
	add_child(player)
	
	return player
