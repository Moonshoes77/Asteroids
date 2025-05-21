extends Node

const Player = preload("res://scenes/player.tscn")
signal input_stored


func _input(event: InputEvent) -> void:
	if event is InputEventKey && !event.is_pressed():
		store_input(event)

func store_input(event):
	var key_input : String = OS.get_keycode_string(event.keycode)
	input_stored.emit(key_input)




# Called when the node enters the scene tree for the first time.
func _ready():
	var player = Player.instantiate()
	add_child(player)
	print("main scene loaded")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
