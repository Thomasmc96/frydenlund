extends CharacterBody2D

class_name Player

enum STATES {WALKING, IDLE}
@onready var animated_sprite = %AnimatedSprite2D
@onready var joystick = $Camera2D/Joystick

const speed = 50
var state = STATES.IDLE

var mouse_location = null

func _physics_process(_delta):
	mouse_location = get_global_mouse_position() - self.position

	if (OS.has_feature('web_android') || OS.has_feature('web_ios')):
		joystick_movement()		
	else:
		keyboard_movement()
		joystick.visible = false


	
func play_animation(direction: Vector2):
	if state == STATES.IDLE:
			animated_sprite.play("idle")
	elif state == STATES.WALKING:
		if direction.y < -0.9:
			animated_sprite.play("walk_n")
		if direction.x > 0.9:
			animated_sprite.play("walk_e")
		if direction.y > 0.9:
			animated_sprite.play("walk_s")
		if direction.x < -0.9:
			animated_sprite.play("walk_w")
			
		if direction.x > 0.5 and direction.y < -0.5:
			animated_sprite.play("walk_ne")
		if direction.x > 0.5 and direction.y > 0.5:
			animated_sprite.play("walk_se")
		if direction.x < -0.5 and direction.y > 0.5:
			animated_sprite.play("walk_sw")
		if direction.x < -0.5 and direction.y < -0.5:
			animated_sprite.play("walk_nw")


func keyboard_movement():
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 and direction.y == 0:
		state = STATES.IDLE
	elif direction.x != 0 or direction.y != 0:
		state = STATES.WALKING
	
	velocity = direction.normalized() * speed
	move_and_slide()
	play_animation(direction)
	
func joystick_movement():
	var direction = joystick.posVector
	if direction.x == 0 and direction.y == 0:
		state = STATES.IDLE
	elif direction.x != 0 or direction.y != 0:
		state = STATES.WALKING
		
	if direction:
		velocity = direction * speed
	else:
		velocity = Vector2(0,0)
	
	move_and_slide()
	play_animation(direction)
	
