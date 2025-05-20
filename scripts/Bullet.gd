extends CharacterBody2D
var pos: Vector2
var rot: float
var dir: float
var speed = 450
var parent_velocityX: int
var parent_velocityY: int
var lifespan : float = 180.0
var screen_size := DisplayServer.window_get_size()

func screen_wrap():
	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x
	if position.y > screen_size.y:
		position.y = 0
	if position.y < 0:
		position.y = screen_size.y
		
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
func _physics_process(_delta):
	velocity = Vector2(speed, 0).rotated(dir)
	screen_wrap()
	move_and_slide()
	check_life()
