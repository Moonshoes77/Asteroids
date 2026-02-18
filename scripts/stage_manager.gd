class_name Stage_Manager
extends Node

var stage: int = 1
var current_score: int = 0
enum Difficulty {EASY, NORMAL, HARD} 
var difficulty: = Difficulty.NORMAL


func _ready() -> void:
	print("stage_manager loaded")	
	init_stage(stage)


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Free"):
		stage = 1
		init_stage(stage)
	check_asteroid_count()


func init_stage(stage_num: int):
	add_roids(stage_num + 2, Asteroid.Size.LARGE)
	print("Stage: ", stage)

 
func add_roids(num: int, size: Asteroid.Size = Asteroid.Size.LARGE, pos = 0):
	#default case, used to add a stage's initial asteroids
	if (pos is int):
		for i in range(num):
			var posX = randi_range(0, Main.screen_size.x)
			var posY = randi_range(0, Main.screen_size.y)
			var new_roid = Asteroid.spawn(Vector2(posX, posY), size)
			get_parent().add_child(new_roid)
			new_roid.add_to_group("asteroids")
			new_roid.bullet_hit.connect(_on_bullet_hit)

	#used when asteroids split on hits
	elif (pos is Vector2):
		for i in range(num):
			var posX = pos.x
			var posY = pos.y
			var new_roid = Asteroid.spawn(Vector2(posX, posY), size)
			add_child.call_deferred(new_roid)
			new_roid.bullet_hit.connect(_on_bullet_hit)
			new_roid.add_to_group("asteroids")


func _on_bullet_hit(asteroid: Asteroid):
	var pos = asteroid.position
	var size = asteroid.size
	match size:
		0:
			add_roids(3, size + 1, pos)
			update_score(10)
		1:
			add_roids(2, size + 1, pos)
			update_score(20)
		2:
			update_score(50)
			pass

func update_score(score: int):
	current_score += score

func check_asteroid_count():
	if Engine.get_physics_frames() % 10 == 0:
		if get_tree().get_node_count_in_group("asteroids") == 0:
			print("Stage %s complete" %[stage])
			print("Score: ", current_score)
			stage += 1
			init_stage(stage)
