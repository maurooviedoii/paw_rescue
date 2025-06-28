extends Control

@export var cloud_speed: int = 22

func _ready() -> void:
	LevelVariables.show_info_layer = false
	LevelVariables.show_pause_menu = false
	
	$margin_container_buttons/box_container_buttons/button_new_game/btn_new_game_bone_left.visible = false
	$margin_container_buttons/box_container_buttons/button_new_game/btn_new_game_bone_right.visible = false
	$margin_container_buttons/box_container_buttons/button_options/btn_options_right.visible = false
	$margin_container_buttons/box_container_buttons/button_options/btn_options_left.visible = false
	$margin_container_buttons/box_container_buttons/button_exit/btn_exit_right.visible = false
	$margin_container_buttons/box_container_buttons/button_exit/btn_exit_left.visible = false
	
func _physics_process(delta: float) -> void:
	_moveClouds(delta)
	
func _moveClouds(delta: float) -> void:
	$Parallax2D/ParallaxLayer.motion_offset.x -= cloud_speed * delta

func _on_button_new_game_pressed() -> void:
	LevelVariables.current_level = 1

func _on_button_options_pressed() -> void:
	pass # Replace with function body.

func _on_button_exit_pressed() -> void:
	get_tree().quit()

func _on_button_new_game_mouse_entered() -> void:
	$margin_container_buttons/box_container_buttons/button_new_game/btn_new_game_bone_left.visible = true
	$margin_container_buttons/box_container_buttons/button_new_game/btn_new_game_bone_right.visible = true


func _on_button_new_game_mouse_exited() -> void:
	$margin_container_buttons/box_container_buttons/button_new_game/btn_new_game_bone_left.visible = false
	$margin_container_buttons/box_container_buttons/button_new_game/btn_new_game_bone_right.visible = false

func _on_button_options_mouse_entered() -> void:
	$margin_container_buttons/box_container_buttons/button_options/btn_options_right.visible = true
	$margin_container_buttons/box_container_buttons/button_options/btn_options_left.visible = true

func _on_button_options_mouse_exited() -> void:
	$margin_container_buttons/box_container_buttons/button_options/btn_options_right.visible = false
	$margin_container_buttons/box_container_buttons/button_options/btn_options_left.visible = false

func _on_button_exit_mouse_entered() -> void:
	$margin_container_buttons/box_container_buttons/button_exit/btn_exit_right.visible = true
	$margin_container_buttons/box_container_buttons/button_exit/btn_exit_left.visible = true

func _on_button_exit_mouse_exited() -> void:
	$margin_container_buttons/box_container_buttons/button_exit/btn_exit_right.visible = false
	$margin_container_buttons/box_container_buttons/button_exit/btn_exit_left.visible = false
