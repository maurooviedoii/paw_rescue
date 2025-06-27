extends Node2D

var alpha := 1.0
var fading_out := true
var speed := 1.5

@onready var labelPressAnyButton := $Panel/LabelPressAnyButton

func _ready() -> void:
	LevelVariables.show_info_layer = false
	LevelVariables.show_pause_menu = false
	#$Music.play()

func _input(event: InputEvent) -> void:
	if event.is_pressed():
		if event is InputEventKey:
			LevelVariables.current_level = 0
			showPrintOnConsole("Any button is pressed -> %s " % OS.get_keycode_string((event as InputEventKey).keycode))

func _physics_process(delta: float) -> void:
	if fading_out:
		alpha -= delta * speed
		if alpha <= 0.0:
			alpha = 0.0
			fading_out = false
	else:
		alpha += delta * speed
		if alpha >= 1.0:
			alpha = 1.0
			fading_out = true
	labelPressAnyButton.modulate.a = alpha
	
func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)
