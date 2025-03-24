extends Node2D

@onready var player = $Player

var enter_south = false
var enter_west = false

func _ready():
	player.position.x = Global.current_pos_x
	player.position.y = Global.current_pos_y

func _process(_delta):
	enter_house_west()
	enter_house_south()

func _on_house_door_body_entered(body):
	if body is Player:
		Global.changing_scene = true;
		enter_west = true;
		
func _on_house_door_body_exited(body):
	if body is Player:
		Global.changing_scene = false
		enter_west = false;
		
func _on_house_door_south_body_entered(body):
	if body is Player:
		Global.changing_scene = true
		enter_south = true;

func _on_house_door_south_body_exited(body):
	if body is Player:
		Global.changing_scene = false;
		enter_south = false;

func enter_house_west():
	if Global.changing_scene && enter_west:
		Global.current_pos_x = Global.house_world_door_pos_x
		Global.current_pos_y = Global.house_world_door_pos_y
		get_tree().change_scene_to_file("res://scenes/houseWorld.tscn")

func enter_house_south():
	if Global.changing_scene && enter_south:
		print('asd2')
		Global.current_pos_x = Global.house_world_door_south_pos_x
		Global.current_pos_y = Global.house_world_door_south_pos_y
		get_tree().change_scene_to_file("res://scenes/houseWorld.tscn")


