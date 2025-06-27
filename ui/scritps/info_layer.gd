extends CanvasLayer

func _ready() -> void:
	$AnimatedSprite2D.play("default")
	LevelVariables.connect("show_info_layer_changed", Callable(self, "_on_info_layer_changed"))
	_on_info_layer_changed(LevelVariables.show_info_layer)
	
func _physics_process(_delta: float) -> void:
	$LifePointsLabel.text = ("%.0fx" % PlayerVariables.get_life_points())
	$BonesCollected.text = ("%.0f/%.0f" % [LevelVariables.bones_collected, LevelVariables.all_bones_in_current_level])
	
func _on_info_layer_changed(value: bool) -> void:
	visible = value
