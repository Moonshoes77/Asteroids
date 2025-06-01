extends Node

var Player = preload("res://scenes/player.tscn")
var current_lives;
const MAX_LIVES = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("player_manager loaded")
	current_lives = MAX_LIVES + 1
	spawn()
	
func spawn():
	var player = Player.instantiate();
	player.position.x = player.screen_size.x / 2
	player.position.y = player.screen_size.y / 2
	get_parent().add_child(player)
	current_lives -= 1
	
