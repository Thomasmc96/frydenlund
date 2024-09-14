extends CharacterBody2D

class_name Laban

const RiseHearth = preload("res://scripts/riseHearth.gd")

enum STATES {WALKING, IDLE}
@onready var animated_sprite = %AnimatedSprite2D

const speed = 80
var state = STATES.IDLE

var player_in_area = false
var player: Player = null

func _physics_process(delta):
	animated_sprite.play("idle")
	if player_in_area:
		if Input.is_action_just_pressed("interact"):
			var riseHearth = RiseHearth.new()
			riseHearth.riseHearth($Area2D.global_position, get_parent())


func _on_area_2d_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body

func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_area = false
