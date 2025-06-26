class_name Bullet
extends CharacterBody2D

var pos: Vector2
var rot: float
var dir: float
var speed = 450
var parent_velocityX: int
var parent_velocityY: int
var lifespan : float = 85.0

func screen_wrap():
	if position.x > Main.screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = Main.screen_size.x
	if position.y > Main.screen_size.y:
		position.y = 0
	if position.y < 0:
		position.y = Main.screen_size.y
		
func check_life():
	lifespan -= 1
	if lifespan <= 0:
		queue_free()
	#print("lifespan: ", lifespan)

# Called when the node enters the scene tree for the first time.
func _ready():
	global_position = pos
	global_rotation = rot - PI / 2


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	velocity = Vector2(speed, 0).rotated(dir)
	screen_wrap()
	check_life()
	move_and_slide()
