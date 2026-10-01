extends Node

var menu_stack: Array[Node] = []

var is_holding : bool = false
var pause_was_held : bool = false
@onready var hold_pause_timer: Timer = Timer.new()

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	hold_pause_timer.wait_time = 0.5
	add_child(hold_pause_timer)
	hold_pause_timer.timeout.connect(_on_pause_hold)
	
func _unhandled_input(event: InputEvent) -> void:
	if hold_pause_timer:
		if event.is_action_pressed("pause") and not is_holding:
			is_holding = true
			pause_was_held = false
			hold_pause_timer.start()

		elif event.is_action_released("pause"):
			is_holding = false
			hold_pause_timer.stop()
			
			if not pause_was_held:
				if UIManager.menu_stack.is_empty():
					UIManager.open_menu(ScenePaths.PAUSE)
				else:
					UIManager.close_current_menu()

		elif event.is_action_pressed("pause") and hold_pause_timer.is_stopped():
			if not UIManager.menu_stack.is_empty():
				UIManager.close_all_menus()
			
		if event.is_action_pressed("debug_menu"):
			if UIManager.menu_stack.is_empty():
				UIManager.open_menu(ScenePaths.SETTINGS)
			else:
				UIManager.close_current_menu()
				
func _on_pause_hold() -> void:
	pause_was_held = true
	UIManager.close_all_menus()
	
func open_menu(menu : PackedScene) -> void:
	if not menu_stack.is_empty():
		menu_stack.back().hide()

	var instantiated_menu := menu.instantiate()
	add_child(instantiated_menu)

	menu_stack.push_back(instantiated_menu)
	_update_pause_state()
	
func close_current_menu() -> void:
	if menu_stack.is_empty():
		return
		
	var current_menu : Node = menu_stack.pop_back()
	current_menu.queue_free()
	
	if not menu_stack.is_empty():
		menu_stack.back().show()
	
	_update_pause_state()

func close_all_menus() -> void:
	if menu_stack.is_empty():
		return
		
	for menu in menu_stack:
		menu.queue_free()
	
	menu_stack.clear()
		
	_update_pause_state()
	
func _update_pause_state() -> void:
	get_tree().paused = not menu_stack.is_empty()
