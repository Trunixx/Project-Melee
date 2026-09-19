extends GridContainer

@onready var state_label_data: Label = $StateLabelData
@onready var velocity_label_data: Label = $VelocityLabelData
@onready var timer_label_data: Label = $TimerLabelData

@onready var timer_label_prefix: Label = $TimerLabelPrefix

# HACK DEBUG: This should be done with signals, but I needed something fast to debug
@onready var state_machine: StateMachine = $"../StateMachine"
@onready var actor: Actor = $".."

@onready var tracked_timer : Timer = actor.get_node("JumpBufferTimer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	timer_label_prefix.text = tracked_timer.name

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_label_data.text = state_machine.get_string_state_hierarchy(state_machine.state)
	velocity_label_data.text = "x: " + var_to_str(actor.velocity.x) + " y: " + var_to_str(actor.velocity.y)
	timer_label_data.text = var_to_str(snapped(tracked_timer.wait_time - tracked_timer.time_left, 0.01))
