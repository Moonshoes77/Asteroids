class_name Player_Manager
extends Node

var Player_Instance = preload("res://scenes/player.tscn")
var current_lives;
const MAX_LIVES = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("player_manager loaded")
	current_lives = MAX_LIVES + 1
	spawn()
	
func spawn():
	var player = Player_Instance.instantiate();
	player.position.x = Main.screen_size.x / 2
	player.position.y = Main.screen_size.y / 2
	get_parent().add_child(player)
	
