class_name ActorState extends State

var actor : Actor

@onready var state_name: String = name.to_lower()

func _ready() -> void:
	await owner.ready
	actor = owner as Actor
	assert(actor != null, "The ActorState state type must be used only in the Actor scene. It needs the owner to be an Actor node.")
	
func _process(_delta: float) -> void:
	pass
