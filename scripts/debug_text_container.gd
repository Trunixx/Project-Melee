extends GridContainer

@onready var state_label_data: Label = $StateLabelData
@onready var velocity_label_data: Label = $VelocityLabelData

# HACK: This shouldn't be done, but I need something fast to debug
@onready var state_machine: StateMachine = $"../StateMachine"
@onready var actor: Actor = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_label_data.text = state_machine.state.name
	velocity_label_data.text = var_to_str(actor.velocity.x)
