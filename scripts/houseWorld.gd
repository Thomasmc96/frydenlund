extends Node2D

@onready var player = $Player

var enter_south = false
var enter_west = false
var enter_stairs_up = false

func _ready():
	player.position.x = Global.current_pos_x
	player.position.y = Global.current_pos_y

func _process(_delta):
	leave_house_west()
	leave_house_south()
	enter_first_floor()

func _on_door_body_entered(body):
	if body is Player:
		Global.changing_scene = true;
		enter_west = true

func _on_door_body_exited(body):
	if body is Player:
		Global.changing_scene = false
		enter_west = false

func _on_door_south_body_entered(body):
	if body is Player:
		Global.changing_scene = true;
		enter_south = true

func _on_door_south_body_exited(body):
	if body is Player:
		Global.changing_scene = false
		enter_south = false
		
func _on_stairs_up_body_entered(body):
	if body is Player:
		Global.changing_scene = true;
		enter_stairs_up = true

func _on_stairs_up_body_exited(body):
	if body is Player:
		Global.changing_scene = false
		enter_stairs_up = false

func leave_house_west():
	if Global.changing_scene && enter_west:
		Global.current_pos_x = Global.world_house_door_pos_x
		Global.current_pos_y = Global.world_house_door_pos_y
		get_tree().change_scene_to_file("res://scenes/world.tscn")

func leave_house_south():
	if Global.changing_scene && enter_south:
		Global.current_pos_x = Global.world_house_door_south_pos_x
		Global.current_pos_y = Global.world_house_door_south_pos_y
		get_tree().change_scene_to_file("res://scenes/world.tscn")

func enter_first_floor():
	if Global.changing_scene && enter_stairs_up:
		Global.current_pos_x = Global.house_first_floor_world_stairs_down_pos_x
		Global.current_pos_y = Global.house_first_floor_world_stairs_down_pos_y
		get_tree().change_scene_to_file("res://scenes/houseFirstFloorWorld.tscn")
