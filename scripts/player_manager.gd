class_name Player_Manager
extends Node

var Player_Instance = preload("res://scenes/player.tscn")
var current_lives;
const MAX_LIVES = 3
enum State {ALIVE, DEAD}
var player_state: State

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("player_manager loaded")
	spawn_player()
	
func _process(_delta: float) -> void:
	if (Input.is_action_just_pressed("Free")):
		if (player_state == State.DEAD):
			spawn_player()
	if (Input.is_action_just_pressed("Info")):
		print(get_tree().get_node_count_in_group("asteroids"))
		print(get_tree().get_nodes_in_group("asteroids"))
	
	
func spawn_player():
	var player = Player_Instance.instantiate();
	player.position.x = Main.screen_size.x / 2.0
	player.position.y = Main.screen_size.y / 2.0
	get_parent().add_child(player)
	player.player_death.connect(_on_player_death)
	player_state = State.ALIVE
	
func _on_player_death():
	player_state = State.DEAD
