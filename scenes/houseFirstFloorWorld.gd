extends Node2D

@onready var player = $Player

var enter_stairs_down = false

func _ready():
	player.position.x = Global.current_pos_x
	player.position.y = Global.current_pos_y

func _process(delta):
	enter_ground_floor()


func enter_ground_floor():
	if Global.changing_scene && enter_stairs_down:
		Global.current_pos_x = Global.house_world_stairs_up_pos_x
		Global.current_pos_y = Global.house_world_stairs_up_pos_y
		get_tree().change_scene_to_file("res://scenes/houseWorld.tscn")


func _on_area_2d_body_entered(body):
	if body is Player:
		Global.changing_scene = true
		enter_stairs_down = true


func _on_area_2d_body_exited(body):
	if body is Player:
		Global.changing_scene = false
		enter_stairs_down = false
