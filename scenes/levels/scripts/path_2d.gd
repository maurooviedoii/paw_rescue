extends Path2D

@export var speed: float = 0.3
var isProgress:= true

func _physics_process(delta: float) -> void:
	if $PathFollow2D.progress_ratio <= 0.01:
		isProgress = true
	
	if $PathFollow2D.progress_ratio <= 0.99 && isProgress:
		$PathFollow2D.progress_ratio += delta * speed
	else:
		isProgress = false
		$PathFollow2D.progress_ratio -= delta * speed
