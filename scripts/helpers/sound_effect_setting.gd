class_name SoundEffect 
extends Resource
## Sound effect resource, used to configure unique sound effects for use with the AudioManager. Passed to [method AudioManager.create_2d_audio_at_location()] and [method AudioManager.create_audio()] to play sound effects.

## Stores the different types of sounds effects available to be played to distinguish them from another. Each new SoundEffect resource created should add to this enum, to allow them to be easily instantiated via [method AudioManager.create_2d_audio_at_location()] and [method AudioManager.create_audio()].
enum SOUND_EFFECT_TYPE {
	UI_HOVER,
	UI_BUTTON_PRESS,
	TEST_SOUND,
}

## Stores the different buses
enum BUS {
	MASTER,
	MUSIC,
	UI,
	VOICE,
	AMBIENCE,
	SFX,
}

@export_range(0, 10) var limit: int = 5 ## Maximum number of this SoundEffect to play simultaneously before culled. A limit of 0 means unlimited.
@export var type: SOUND_EFFECT_TYPE ## The unique sound effect in the [enum SOUND_EFFECT_TYPE] to associate with this effect. Each SoundEffect resource should have it's own unique [enum SOUND_EFFECT_TYPE] setting.
@export var sound_effects: Array[AudioStream] ## The [AudioStream] audio resource to play.
@export var bus: BUS = BUS.SFX ## The bus to route the sound to (defaults to SFX).
@export_range(-40, 20) var volume: float = 0 ## The volume of the [member sound_effect].
@export_range(0.0, 12.0, 0.1) var pitch_randomness: float = 0.0 ## Maximum random pitch variation in semitones.
@export_range(0.0, 12.0, 0.1) var volume_randomness: float = 0.0 ## Maximum volume variation in dB.

var randomizer : AudioStreamRandomizer

var audio_count : int = 0 ## The number of instances of this [AudioStream] currently playing.

func get_audio_stream() -> AudioStreamRandomizer:
	if randomizer == null:
		randomizer  = AudioStreamRandomizer.new()
		
		for sound in sound_effects:
			randomizer.add_stream(-1, sound) # -1 means that it automatically appends at the end of the array
		
		randomizer.random_pitch_semitones = pitch_randomness
		randomizer.random_volume_offset_db = volume_randomness
		
	return randomizer

## Adds [param amount] to  [member audio_count]. 
func increment_audio_count(amount: int = 1) -> void:
	audio_count = max(0, audio_count + amount)
## Subtracts [param amount] from [member audio_count]. 
func decrement_audio_count(amount: int = 1) -> void:
	audio_count = max(0, audio_count - amount)
	
## Checks whether the audio limit is reached. Returns true if the [member audio_count] is more or equal than the [member limit].
func has_reached_limit() -> bool:
	if limit == 0:
		return false
	return audio_count >= limit

## Connected to the [member sound_effect]'s finished signal to decrement the [member audio_count].
func on_audio_finished() -> void:
	decrement_audio_count()
	
func get_bus_string() -> String:
	match bus:
		BUS.MASTER:
			return "Master"
		BUS.MUSIC:
			return "Music"
		BUS.UI:
			return "UI"
		BUS.VOICE:
			return "Voice"
		BUS.AMBIENCE:
			return "Ambience"
		BUS.SFX:
			return "SFX"
	push_error("Bus name ", bus, " not valid! Defaulting to SFX")
	return "SFX"
