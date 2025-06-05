class_name Stage_Manager
extends Node

var stage: int
var score: int = 0
var asteroid: PackedScene = preload("res://scenes/asteroid.tscn")
var difficulty: = Difficulty.NORMAL


enum Difficulty {EASY, NORMAL, HARD} 

func _ready() -> void:
	print("stage_manager loaded")
	
	for i in range(4):
		var roid = asteroid.instantiate()
		roid.position.x = randi_range(0, DisplayServer.window_get_size().x)
		roid.position.y = randi_range(0, DisplayServer.window_get_size().y)
		get_parent().add_child(roid)
