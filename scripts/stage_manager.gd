class_name Stage_Manager
extends Node

var stage: int
var score: int = 0
enum Difficulty {EASY, NORMAL, HARD} 
var difficulty: = Difficulty.NORMAL



func _ready() -> void:
	print("stage_manager loaded")	
	add_roids(4, Asteroid.Size.LARGE)
	
	
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Free"):
		add_roids(4, Asteroid.Size.LARGE)	

 
func add_roids(num: int, size: Asteroid.Size = Asteroid.Size.LARGE, pos = 0):
	#default case, used to add a stage's initial asteroids
	if (pos is int):
		for i in range(num):
			var posX = randi_range(0, DisplayServer.window_get_size().x)
			var posY = randi_range(0, DisplayServer.window_get_size().y)
			var new_roid = Asteroid.spawn(Vector2(posX, posY), size)
			get_parent().add_child(new_roid)
			new_roid.bullet_hit.connect(_on_bullet_hit)
	#used when asteroids split on hits
	elif (pos is Vector2):
		for i in range(num):
			var posX = pos.x
			var posY = pos.y
			var new_roid = Asteroid.spawn(Vector2(posX, posY), size)
			get_parent().add_child.call_deferred(new_roid)
			new_roid.bullet_hit.connect(_on_bullet_hit)

func _on_bullet_hit(asteroid: Asteroid):
	handle_asteroid_hit(asteroid)
	
func handle_asteroid_hit(roid: Asteroid):
	var pos = roid.position
	var size = roid.size
	match size:
		0:
			add_roids(3, size + 1, pos)
		1:
			add_roids(2, size + 1, pos)
		2:
			pass
