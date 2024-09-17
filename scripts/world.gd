extends Node2D

@onready var player = $Player


func _ready():
	player.position.x = Global.current_pos_x
	player.position.y = Global.current_pos_y

func _process(_delta):
	enter_house()

func _on_house_door_body_entered(body):
	if body is Player:
		Global.changing_scene = true;
		
func _on_house_door_body_exited(body):
	if body is Player:
		Global.changing_scene = false

func enter_house():
	if Global.changing_scene:
		Global.current_pos_x = Global.house_world_door_pos_x
		Global.current_pos_y = Global.house_world_door_pos_y
		get_tree().change_scene_to_file("res://scenes/houseWorld.tscn")

