extends Node

const Player = preload("res://scenes/player.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = Player.instantiate()
	add_child(player)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("exit"):
		get_tree().quit()
