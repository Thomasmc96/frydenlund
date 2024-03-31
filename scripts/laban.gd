extends CharacterBody2D

class_name Laban

enum STATES {WALKING, IDLE}
@onready var animated_sprite = %AnimatedSprite2D

const speed = 80
var state = STATES.IDLE

func _physics_process(delta):
	animated_sprite.play("idle")
