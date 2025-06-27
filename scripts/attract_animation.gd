class_name Attract_Screen
extends Node



func _ready() -> void:
	add_roids(7)


func add_roids(num: int, size: Asteroid.Size = Asteroid.Size.LARGE, pos = 0):
	if (pos is int):
		for i in range(num):
			var posX = randi_range(0, Main.screen_size.x)
			var posY = randi_range(0, Main.screen_size.y)
			var new_roid = Asteroid.spawn(Vector2(posX, posY), size)
			new_roid.z_index = -1
			new_roid.z_as_relative = false
			get_parent().add_child(new_roid)
