extends GridContainer

@onready var value_label_prefix: Label = $ValueLabelPrefix
@onready var timer_label_prefix: Label = $TimerLabelPrefix

@onready var state_label_data: Label = $StateLabelData
@onready var velocity_label_data: Label = $VelocityLabelData
@onready var value_label_data: Label = $ValueLabelData
@onready var timer_label_data: Label = $TimerLabelData

# HACK DEBUG: This should be done with signals, but I needed something fast to debug
@onready var state_machine: StateMachine = $"../StateMachine"
@onready var actor: Actor = $".."

@onready var tracked_value : float = actor.current_wall_stamina
@onready var tracked_timer : Timer = actor.get_node("JumpBufferTimer")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	value_label_prefix.text = "Current stamina"
	timer_label_prefix.text = tracked_timer.name
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	state_label_data.text = state_machine.get_string_state_hierarchy(state_machine.state)
	velocity_label_data.text = "x: " + var_to_str(actor.velocity.x) + " y: " + var_to_str(actor.velocity.y)
	value_label_data.text = var_to_str(actor.current_wall_stamina)
	timer_label_data.text = var_to_str(snapped(tracked_timer.wait_time - tracked_timer.time_left, 0.01))
