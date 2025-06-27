extends Panel

@onready var animation_player = $AnimationPlayer

func _on_baloon_timer_timeout() -> void:
	visible = true
	animation_player.play("fade_in")
	await animation_player.animation_finished
	animation_player.play("fade_out")
	await animation_player.animation_finished
	visible = false
