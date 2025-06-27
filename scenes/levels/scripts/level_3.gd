extends Node2D


func _ready() -> void:
	showPrintOnConsole("#########################Level %s is starting.#########################" % self.name)
	showPrintOnConsole("%s is defined." % self.name)
	LevelVariables.bones_collected = 0
	showPrintOnConsole("Bones collected are reset.")
	LevelVariables.all_bones_in_current_level = get_node("Bones").get_child_count()
	showPrintOnConsole("Bones in %s are counted: %s." % [self.name, str(LevelVariables.all_bones_in_current_level)])
	PlayerVariables.updateLastPortionCollectionLocation(get_node("Player").global_position)
	showPrintOnConsole("Last position is update for initial position in %s." % self.name)
	LevelVariables.show_info_layer = true
	$Player/Camera2D/AmbienceSound.play()
	$Player/Camera2D/Music.play()
	$PlatformsUpDown/Platform/PlatformSound.play()
	showPrintOnConsole("Info layer is shown at %s." % self.name)
	showPrintOnConsole("#########################%s is ready to play#########################" % self.name)
	
func _physics_process(delta: float) -> void:
	if !$Dog/AnimatedSprite2D.is_playing():
		$Dog/AnimatedSprite2D.visible = false
		LevelVariables.current_level = 4

func _on_dog_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		showPrintOnConsole("Dog tuched by player")
		$Dog/AnimatedSprite2D.play("saved")
		$Dog.set_deferred("disabled", true)
		$Dog/CollisionShape2D.set_deferred("disabled", true)
		
func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)
