extends MarginContainer

@onready var v_box_container: VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer
var rebinding_button : Button

func _ready() -> void:
	create_inputs_menu()

func _input(event: InputEvent) -> void:
	if rebinding_button:
		if event is InputEventKey and event.pressed:
			var action := rebinding_button.name
			
			InputMap.action_erase_events(action)
			InputMap.action_add_event(action, event)
			
			rebinding_button.text = event.as_text()
			rebinding_button = null
			
			get_viewport().set_input_as_handled()

func create_inputs_menu() -> void:
	for action in InputMap.get_actions():
		if not action.begins_with("ui_"):
			var row := HBoxContainer.new()
			
			var label := Label.new()
			label.text = action.capitalize()
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
			label.custom_minimum_size = Vector2(150, 100)

			row.add_child(label)
			
			for action_event in InputMap.action_get_events(action):
				var button := Button.new()
				button.name = action
				button.text = action_event.as_text()#.replace(" - Physical", "")
				button.connect("pressed", _rebind_key.bind(button))
				row.add_child(button)
				button.custom_minimum_size = Vector2(150, 100)
				
			v_box_container.add_child(row)

func _rebind_key(button: Button) -> void:
	rebinding_button = button
	button.text = "Waiting for input..."
