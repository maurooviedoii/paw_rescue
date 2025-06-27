extends Control

func _ready() -> void:
	LevelVariables.show_info_layer = false
	LevelVariables.show_pause_menu = false

func _on_button_new_game_pressed() -> void:
	LevelVariables.current_level = 1

func _on_button_options_pressed() -> void:
	pass # Replace with function body.

func _on_button_exit_pressed() -> void:
	get_tree().quit()
