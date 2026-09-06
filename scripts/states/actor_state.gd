class_name ActorState extends State

var actor : Actor

@onready var state_name: String = name.to_lower()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await owner.ready
	actor = owner as Actor
	assert(actor != null, "The ActorState state type must be used only in the Actor scene. It needs the owner to be an Actor node.")
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
