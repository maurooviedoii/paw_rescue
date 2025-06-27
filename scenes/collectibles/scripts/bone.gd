extends Node2D

@onready var sprite := $Area2D/AnimatedSprite2D
@onready var eatSound := $AudioStreamPlayer2D
@onready var collision := $Area2D/CollisionShape2D

func _ready() -> void:
	eatSound.stream_paused = true
	sprite.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		showPrintOnConsole("Bone touched")
		increasesBonesCollected()
		disable_collision()
		disable_visible()
		active_sound()
		#Bianca - Coloquei aqui pra triggar com a coleta dos ossos
		incresesPlayerLife()

func disable_visible() -> void:
	visible = false
	set_deferred("monitoring", false)
	
func disable_collision() -> void:
	collision.set_deferred("disabled", true)
	
func active_sound() -> void:
	eatSound.play()
	await get_tree().create_timer(1).timeout
	eatSound.stop()
	
func increasesBonesCollected() -> void:
	LevelVariables.bones_collected += 1

#Bianca - Aqui eu adicionei isso pro player ganhar vida a cada 10 ossos coletados
func incresesPlayerLife() -> void:
	if LevelVariables.bones_collected % 10 == 0 and LevelVariables.bones_collected > 0:
		PlayerVariables.increaseLifePoint()

func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)
