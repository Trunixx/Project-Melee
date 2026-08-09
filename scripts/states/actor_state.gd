class_name ActorState extends State

# TODO: Check if these constants occupy more memory or not (they get assigned at every state) 

const IDLE = "Idle"
const WALKING = "Walking"
const RUNNING = "Running"
const SPRINTING = "Sprinting"
const TURNSKID = "Turnskid"

const PRESLIDING = "Presliding"
const SLIDING = "Sliding"
const POSTSLIDING = "Postsliding"

const PREJUMP = "Prejump"
const JUMPING = "Jumping"

const LONGPREJUMP = "Longprejump"
const LONGJUMPING = "Longjumping"

const FALLING = "Falling"

const COMBAT = "Combat"

#const FALLSTUN = "Fallstun"

var actor : Actor

var state_name : String = get_script().get_global_name().to_lower()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	actor = owner as Actor
	assert(actor != null, "The ActorState state type must be used only in the Actor scene. It needs the owner to be an Actor node.")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
