class_name Stage_Manager
extends Node

var stage: int
var score: int = 0
var asteroid: PackedScene = preload("res://scenes/asteroid.tscn")
var difficulty: = Difficulty.NORMAL


enum Difficulty {EASY, NORMAL, HARD} 

func _ready() -> void:
	print("stage_manager loaded")	
	add_roids(4)
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Free"):
		add_roids(4)	

func add_roids(num: int):
	for i in range(num):
		var posX = randi_range(0, DisplayServer.window_get_size().x)
		var posY = randi_range(0, DisplayServer.window_get_size().y)
		get_parent().add_child(Asteroid.spawn(Vector2(posX, posY)))
	
