extends Node2D

class_name World

var current_scene: Node

@onready var fade_layer = $FadeLayer
@onready var animation_player = $FadeLayer/ColorRect/AnimationPlayer
@onready var fade_rect = $FadeLayer/ColorRect
@onready var loadingLabel = $FadeLayer/ColorRect/LoadingLabel

const LEVEL_PATHS: Array[String] = [
	"res://ui/hud.tscn",
	"res://scenes/levels/level1.tscn",
	"res://scenes/levels/level2.tscn",
	"res://scenes/levels/level3.tscn",
	"res://scenes/levels/level4.tscn",
	"res://scenes/levels/game_over.tscn",
	"res://scenes/levels/credits.tscn"
]

func _ready():
	current_scene = null
	fade_layer.visible = false
	LevelVariables.connect("current_level_changed", Callable(self, "_on_current_level_changed"))
	goto_scene(0)
	
func _on_current_level_changed(new_scene: int) -> void:
	goto_scene(new_scene)

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if event and event.is_action_pressed("open_pause_menu"):
			LevelVariables.show_pause_menu = true

func goto_scene(scene_index: int):
	if (scene_index == 4):
		$Music.stop()
	if (scene_index == 0):
		$Music.play()
	if scene_index != 0 and scene_index != 5:
		await fade_in()
		build_scene(scene_index)
		await fade_out()
	else:
		build_scene(scene_index)
		
func build_scene(scene_index: int) -> void:
	if current_scene:
		current_scene.queue_free()
		showPrintOnConsole("Level %s is free" % current_scene.name)
		
	current_scene = load(LEVEL_PATHS[scene_index]).instantiate()
	add_child(current_scene)
	move_child(current_scene, 0)
		
func fade_in() -> void:
	loadingLabel.visible = true
	fade_layer.visible = true
	animation_player.play("fade_out")
	await animation_player.animation_finished
	
func fade_out() -> void:
	loadingLabel.visible = false
	animation_player.play("fade_in")
	await animation_player.animation_finished
	fade_layer.visible = false
	
func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)
