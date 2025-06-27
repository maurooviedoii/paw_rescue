extends Area2D

@export var speed: float = 250.0
var direction: Vector2 = Vector2.LEFT
@onready var sprite = $AnimatedSprite2D

func _ready() -> void:
	sprite.play("default")

func _physics_process(delta: float) -> void:
	position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func _on_body_entered(body: Node2D) -> void:
	if(body.name.to_lower().contains("player")):
		LevelVariables.bullet_touched = true
		queue_free()
		LevelVariables.bullet_touched = false
