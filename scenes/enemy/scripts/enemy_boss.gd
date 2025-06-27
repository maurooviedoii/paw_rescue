extends CharacterBody2D

@export var speed: float = 100.0
@export var move_range: float = 100.0
@export var gravity: float = 800.0
@export var jump_force: float = -300.0
@export var bullet_scene: PackedScene

var direction := 1
var origin_x := 0.0
var left_limit := 0.0
var right_limit := 0.0
var sprite: AnimatedSprite2D
var can_move := true

func _ready():
	velocity = Vector2.ZERO
	origin_x = global_position.x
	left_limit = origin_x - move_range
	right_limit = origin_x + move_range
	sprite = $AnimatedSprite2D

func _physics_process(delta):
	if can_move:
		velocity.x = direction * speed
		if global_position.x <= left_limit:
			global_position.x = left_limit 
			direction = 1
		elif global_position.x >= right_limit:
			global_position.x = right_limit
			direction = -1
		if is_on_floor():
			if sprite.animation != "Walk" or not sprite.is_playing():
				sprite.play("Walk")
		else:
			if sprite.animation != "Jump" or not sprite.is_playing():
				sprite.play("Jump")
	else:
		velocity.x = 0.0

	velocity.y += gravity * delta
	move_and_slide()

func jump():
	if is_on_floor():
		velocity.y = jump_force

func _on_jump_timer_timeout() -> void:
	if can_move:
		jump()

func _on_shoot_timer_timeout() -> void:
	can_move = false

	sprite.play("Attack")
	await sprite.animation_finished
	
	var bullet: Area2D = bullet_scene.instantiate()
	var randomNumber: int = randi() % get_tree().get_nodes_in_group("bullets").size()
	var markerSelected: Marker2D = get_tree().get_nodes_in_group("bullets")[randomNumber]
	bullet.global_position = markerSelected.position
	add_child(bullet)
	
	await bullet.tree_exited

	can_move = true
