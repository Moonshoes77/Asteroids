class_name Main
extends Node

signal input_stored
var Player_Manager_Instance = preload("res://scenes/player_manager.tscn")
var Stage_Manager_Instance = preload("res://scenes/stage_manager.tscn")
var Cheat_Listener = preload("res://scenes/cheat_listener.tscn")
static var screen_size = DisplayServer.window_get_size()

func _input(event: InputEvent) -> void:
	if event is InputEventKey && !event.is_pressed():
		store_input(event)

func store_input(event) -> void:
	var key_input : String = OS.get_keycode_string(event.keycode)
	input_stored.emit(key_input)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	var player = Player_Manager_Instance.instantiate()
	var stage_manager = Stage_Manager_Instance.instantiate()
	var cheat_listener = Cheat_Listener.instantiate()
	add_child(cheat_listener)
	add_child(player)
	add_child(stage_manager)
	print_tree_pretty()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
