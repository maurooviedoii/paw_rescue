extends Node2D

@export var cloud_speed: int = 32

func _ready() -> void:
	showPrintOnConsole("#########################Level %s is starting.#########################" % self.name)
	LevelVariables.current_level = 4
	showPrintOnConsole("%s is defined." % self.name)
	LevelVariables.bones_collected = 0
	showPrintOnConsole("Bones collected are reset.")
	LevelVariables.all_bones_in_current_level = get_node("Bones").get_child_count()
	showPrintOnConsole("Bones in %s are counted." % self.name)
	PlayerVariables.updateLastPortionCollectionLocation(get_node("Player").global_position)
	showPrintOnConsole("Last position is update for initial position in %s." % self.name)
	LevelVariables.show_info_layer = true
	showPrintOnConsole("Info layer is shown at %s." % self.name)
	showPrintOnConsole("#########################%s is ready to play#########################" % self.name)
	$MusicTense.play()
	
func _physics_process(delta: float) -> void:
	if !$Dog/AnimatedSprite2D.is_playing():
		$Dog/AnimatedSprite2D.visible = false
		LevelVariables.current_level = 6
	_moveClouds(delta)
	
func _moveClouds(delta: float) -> void:
	$Parallax2D/Clouds.motion_offset.x -= cloud_speed * delta
	
func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)


func _on_hit_area_2_body_entered(body: Node2D) -> void:
	if body.name.to_lower().contains("player"):
		$CharacterBody2D.queue_free()
		showPrintOnConsole("Dog tuched by player")
		$Dog/AnimatedSprite2D.play("saved")
		$Dog.set_deferred("disabled", true)
		$Dog/CollisionShape2D.set_deferred("disabled", true)
		
		
