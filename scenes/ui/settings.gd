extends CanvasLayer

var tabs : Dictionary = {}

@onready var tab_container: TabContainer = $MarginContainer/TabContainer

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	for child in tab_container.get_children():
		tabs[child.name.to_lower()] = child
