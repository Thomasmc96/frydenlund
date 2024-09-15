extends CharacterBody2D

class_name Ditte

const RiseHearth = preload("res://scripts/riseHearth.gd")
@onready var timer = %Timer
@onready var animated_sprite = %AnimatedSprite2D
@onready var area = $Area2D

enum STATES {WALKING, IDLE, NEW_DIR}

const speed = 30
var state = STATES.IDLE
var is_roaming = true
var is_chatting = false
var direction = Vector2.RIGHT

var player_in_area = false
var player: Player = null

func _physics_process(delta):
	if !is_chatting:
		if state == STATES.IDLE or state == STATES.NEW_DIR:
			animated_sprite.play("idle")
		elif state == STATES.WALKING:
			if direction.x == -1:
				animated_sprite.play("walk_w")
			if direction.x == 1:
				animated_sprite.play("walk_e")
			if direction.y == -1:
				animated_sprite.play("walk_n")
			if direction.y == 1:
				animated_sprite.play("walk_s")
			
	if is_roaming:
		match state:
			STATES.IDLE:
				pass
			STATES.NEW_DIR:
				direction = chooseRandom([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			STATES.WALKING:
				move(delta)	
				
	if player_in_area:
		if Input.is_action_just_pressed("interact"):
			is_chatting = true;
			var riseHearth = RiseHearth.new()
			riseHearth.riseHearth(area.global_position, get_parent())
			
			timer.stop()
			timer.wait_time = 5
			timer.start()
			
			getLookingDirection(player)


func getLookingDirection(object):
	var x_position_diff = object.position.x - area.global_position.x
	var y_position_diff = object.position.y - area.global_position.y

	if abs(x_position_diff) > abs(y_position_diff):
		if x_position_diff > 0:
			animated_sprite.play("idle_e")
		else:
			animated_sprite.play("idle_w")
	else:
		if y_position_diff > 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("idle_n")

func chooseRandom(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		velocity = direction * speed
		move_and_slide()

func _on_timer_timeout():
	is_chatting = false
	timer.wait_time = chooseRandom([0.5, 1, 1.5])
	state = chooseRandom(STATES.values())

func _on_area_2d_body_entered(body):
	if body is Player:
		player_in_area = true
		player = body

func _on_area_2d_body_exited(body):
	if body is Player:
		player_in_area = false
