extends CharacterBody2D

class_name Player

enum STATES {WALKING, IDLE}
@onready var animated_sprite = %AnimatedSprite2D

const speed = 50
var state = STATES.IDLE

var mouse_location = null

func _physics_process(_delta):
	mouse_location = get_global_mouse_position() - self.position
	
	var direction = Input.get_vector("left", "right", "up", "down")
	if direction.x == 0 and direction.y == 0:
		state = STATES.IDLE
	elif direction.x != 0 or direction.y != 0:
		state = STATES.WALKING
	
	velocity = direction * speed
	move_and_slide()
	
	play_animation(direction)
	
func play_animation(direction: Vector2):
	if state == STATES.IDLE:
			animated_sprite.play("idle")
	elif state == STATES.WALKING:
		if direction.y == -1:
			animated_sprite.play("walk_n")
		if direction.x == 1:
			animated_sprite.play("walk_e")
		if direction.y == 1:
			animated_sprite.play("walk_s")
		if direction.x == -1:
			animated_sprite.play("walk_w")
			
		if direction.x > 0.5 and direction.y < -0.5:
			animated_sprite.play("walk_ne")
		if direction.x > 0.5 and direction.y > 0.5:
			animated_sprite.play("walk_se")
		if direction.x < -0.5 and direction.y > 0.5:
			animated_sprite.play("walk_sw")
		if direction.x < -0.5 and direction.y < -0.5:
			animated_sprite.play("walk_nw")
