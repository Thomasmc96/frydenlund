extends Node

class_name RiseHearth

var hearth = preload("res://scenes/hearth.tscn")

func rise(start_pos, parent):
	var hearth_instance = hearth.instantiate()
	hearth_instance.global_position = start_pos
	parent.add_child(hearth_instance)
