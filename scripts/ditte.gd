extends CharacterBody2D

class_name Ditte

enum STATES {WALKING, IDLE, NEW_DIR}
@onready var animated_sprite = %AnimatedSprite2D
@onready var timer = %Timer

const speed = 30
var state = STATES.IDLE
var is_roaming = true
var is_chatting = false
var direction = Vector2.RIGHT


func _physics_process(delta):
	if state == STATES.IDLE or state == STATES.NEW_DIR:
		$AnimatedSprite2D.play("idle")
	elif state == STATES.WALKING and !is_chatting:
		if direction.x == -1:
			$AnimatedSprite2D.play("walk_w")
		if direction.x == 1:
			$AnimatedSprite2D.play("walk_e")
		if direction.y == -1:
			$AnimatedSprite2D.play("walk_n")
		if direction.y == 1:
			$AnimatedSprite2D.play("walk_s")
			
	if is_roaming:
		match state:
			STATES.IDLE:
				pass
			STATES.NEW_DIR:
				direction = chooseRandom([Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN])
			STATES.WALKING:
				move(delta)	

func chooseRandom(array):
	array.shuffle()
	return array.front()

func move(delta):
	if !is_chatting:
		velocity = direction * speed
		move_and_slide()

func _on_timer_timeout():
	timer.wait_time = chooseRandom([0.5, 1, 1.5])
	state = chooseRandom(STATES.values())
