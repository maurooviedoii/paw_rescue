extends CharacterBody2D

@export var speed := 60.0
@onready var raycast := $RayCast2D
@onready var sprite := $AnimatedSprite2D
@onready var collision := $Area2D/CollisionShape2D
@onready var ratSound := $AudioStreamPlayer2D
@onready var timer = $Timer

var direction := Vector2.LEFT
var flip_cooldown = 0.0

func _ready() -> void:
	play_sound_with_cooldown()

func _physics_process(delta):
	flip_cooldown -= delta
	velocity = direction * speed
	move_and_slide()
	if raycast.is_colliding() and flip_cooldown <= 0:
		call_deferred("_turn_around")
		
func _turn_around():
	direction *= -1
	raycast.target_position.x *= -1
	sprite.flip_h = direction.x > 0
	flip_cooldown = 0.3

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:		
		if body.global_position.y < global_position.y:
			disable_visible()
			disable_collision()
			stop_timer()
			
func disable_visible() -> void:
	visible = false
	set_deferred("monitoring", false)
	
func disable_collision() -> void:
	collision.set_deferred("disabled", true)
	
func stop_timer() -> void: 
	timer.stop()
	
func start_timer() -> void: 
	timer.start()
	
func play_sound_with_cooldown():
	ratSound.play()
	start_timer()
	
func _on_timer_timeout() -> void:
	play_sound_with_cooldown()

func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)
