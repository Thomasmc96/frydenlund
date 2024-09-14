extends Node2D

func _ready():
	rise()
	
func rise():
	$AnimationPlayer.play("rise")
	await get_tree().create_timer(1).timeout
	queue_free()
