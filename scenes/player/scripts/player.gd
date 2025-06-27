extends CharacterBody2D

@export var speed: float = 200.0
@export var jump_velocity: float = -400.0
@export var gravity: float = 900.0
@export var acceleration: float = 1000.0
@export var friction: float = 800.0

@onready var sprite := $AnimatedSprite2D

func _ready() -> void:
	LevelVariables.connect("bullet_touched_changed", Callable(self, "_on_bullet_touched_changed"))
	
func _on_bullet_touched_changed(bullet_touched: bool) -> void:
	if bullet_touched:
		move_to_closest_checkpoint_behind()
		reduceLife()

func _physics_process(delta: float) -> void:
	var direction = Vector2.ZERO
	apply_gravity(delta)
	handleInput(direction, delta)
	move_and_slide()
	update_animation()
		
func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		velocity.y = 0
		
func handleInput(direction: Vector2, delta: float) -> void:
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1

	if direction.x != 0:
		velocity.x = move_toward(velocity.x, direction.x * speed, acceleration * delta)
	else:
		velocity.x = move_toward(velocity.x, 0, friction * delta)

	if is_on_floor() and Input.is_action_just_pressed("move_up"):
		velocity.y = jump_velocity
		
func update_animation() -> void:
	if not is_on_floor():
		$BarkSoundTimer.stop()
		sprite.play("jump")
		if velocity.x != 0:
			sprite.flip_h = velocity.x < 0
	elif velocity.x != 0:
		$BarkSoundTimer.stop()
		sprite.play("walk")
		sprite.flip_h = velocity.x < 0
	elif $BarkSound.playing:
		sprite.play("bark")
	else:
		if $BarkSoundTimer.is_stopped():
			$BarkSoundTimer.start()
		sprite.play("default")
			
func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name.to_lower().contains("basefall") or body.name.to_lower().contains("bossbullet")):
		move_to_closest_checkpoint_behind()
		reduceLife()

func move_to_closest_checkpoint_behind() -> void:
	showPrintOnConsole("Collide with BaseFall!")
	showPrintOnConsole("Moved to marker -> %s " % PlayerVariables.get_last_portion_collected_location())
	global_position = PlayerVariables.get_last_portion_collected_location()

func reduceLife() -> void:
	PlayerVariables.reduceLifePoint()
	showPrintOnConsole("Life reduce to -> %s " % str(PlayerVariables.get_life_points()))
	if PlayerVariables.get_life_points() == 0:
		LevelVariables.current_level = 5
		PlayerVariables.resetLifePoints()

func showPrintOnConsole(message: String) -> void:
	if OS.is_debug_build():
		print(message)

func _on_bark_sound_timer_timeout() -> void:
	$BarkSound.play()
	await get_tree().create_timer(3).timeout
	$BarkSound.stop()
