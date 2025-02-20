extends Control

@export var nameOnTag: String

@onready var label = $NinePatchRect/Label

func _ready():
	label.text = nameOnTag
