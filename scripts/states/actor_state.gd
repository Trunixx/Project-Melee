class_name ActorState extends State

const IDLE = "Idle"
const WALKING = "Walking"
const RUNNING = "Running"
const SPRINTING = "Sprinting"
const TURNSKID = "Turnskid"
const SLIDING = "Sliding"
const PREJUMP = "Prejump"
const JUMPING = "Jumping"
const LONGPREJUMP = "Longprejump"
const LONGJUMPING = "Longjumping"
const FALLING = "Falling"
const LONGJUMPFALLING = "Longjumpfalling"
const JUMPFALLING = "Jumpfalling"
const FALLSTUN = "Fallstun"

var actor : Actor

var state_name : String = get_script().get_global_name().to_lower()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	actor = owner as Actor
	assert(actor != null, "The ActorState state type must be used only in the Actor scene. It needs the owner to be an Actor node.")
	actor.jump_buffer_timer.wait_time = actor.stats.jump_buffer_time
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
