extends Node2D

@onready var sprite := $Area2D/AnimatedSprite2D
@onready var eatSound := $AudioStreamPlayer2D
@onready var collision := $Area2D/CollisionShape2D

func _ready() -> void:
	eatSound.stream_paused = true
	sprite.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		showPrintOnConsole("Portion touched")
		#incresesPlayerLife()
		disable_collision()
		disable_visible()
		active_sound()
		#Bianca - Coloquei aqui pro checkpoint triggar com a coleta do pote ao inves do ganho de vida
		PlayerVariables.updateLastPortionCollectionLocation(global_position)

#Bianca - Desativei esses codigos pro ganho de vida ficar só com os ossos
#func incresesPlayerLife() -> void:
	#PlayerVariables.increaseLifePoint()
	#PlayerVariables.updateLastPortionCollectionLocation(global_position)

func disable_visible() -> void:
	visible = false
	set_deferred("monitoring", false)
	
func disable_collision() -> void:
	collision.set_deferred("disabled", true)
	
func active_sound() -> void:
	eatSound.play(1)
	await get_tree().create_timer(1).timeout
	eatSound.stop()
	
func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)
