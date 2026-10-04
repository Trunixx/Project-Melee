extends MarginContainer

@onready var v_box_container: VBoxContainer = $ScrollContainer/MarginContainer/VBoxContainer
@onready var settings: ActorStats = GameSettings.actor_stats

func _ready() -> void:
	create_settings_menu()
	
func create_settings_menu() -> void:
	if settings:
		for property in settings.get_property_list():
			if property.usage & PROPERTY_USAGE_GROUP:
				_create_header(property.name)
				continue
				
			if property.usage & PROPERTY_USAGE_SUBGROUP:
				_create_subheader(property.name)
				continue
				
			if property.type not in [TYPE_INT, TYPE_FLOAT]:
				continue
			
			var row := HBoxContainer.new()
			
			var label := Label.new()
			label.text = property.name.capitalize()
			
			var input  := LineEdit.new()
			input.text = str(settings.get(property.name))
			
			input.text_submitted.connect(
				func(value : String) -> void:
					match property.type:
						TYPE_FLOAT:
							settings.set(property.name, value.to_float())
						TYPE_INT:
							settings.set(property.name, value.to_int())
			)
			
			row.add_child(label)
			row.add_child(input)
			v_box_container.add_child(row)
		
func _create_header(name : String) -> void:
	if name == "Resource":
		return
	var row := HBoxContainer.new()
	var label := Label.new()
	
	label.text = name.capitalize()
	label.add_theme_font_size_override("font_size", label.get_theme_font_size("font_size")*2)
	row.add_child(label)
	
	v_box_container.add_child(row)

func _create_subheader(name : String) -> void:
	if name == "Resource":
		return
	var row := HBoxContainer.new()
	var label := Label.new()
	
	label.text = name.capitalize()
	label.add_theme_font_size_override("font_size", label.get_theme_font_size("font_size")*1.5)
	row.add_child(label)
	
	v_box_container.add_child(row)
