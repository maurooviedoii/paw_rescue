extends CanvasLayer

func _ready() -> void:
	$Control/Panel/VBoxContainer/button_resume.process_mode = Node.PROCESS_MODE_ALWAYS
	$Control/Panel/VBoxContainer/back_to_home.process_mode = Node.PROCESS_MODE_ALWAYS
	$Control/Panel/VBoxContainer/button_quit.process_mode = Node.PROCESS_MODE_ALWAYS
	LevelVariables.connect("show_pause_menu_changed", Callable(self, "_on_pause_menu_changed"))
	_on_pause_menu_changed(LevelVariables.show_pause_menu)
	
func _on_pause_menu_changed(value: bool) -> void:
	visible = value
	get_tree().paused = value
	
func _on_button_resume_pressed() -> void:
	showPrintOnConsole("Resume game")
	LevelVariables.show_pause_menu = false

func _on_button_quit_pressed() -> void:
	showPrintOnConsole("Quit game")
	get_tree().quit()

func _on_back_to_home_pressed() -> void:
	showPrintOnConsole("Back to main menu")
	LevelVariables.current_level = 0
	get_tree().paused = !get_tree().paused

func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)
