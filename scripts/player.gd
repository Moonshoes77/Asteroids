extends CharacterBody2D

const MAX_ACCEL: int = 8
const MAX_SPEED: int = 300
var screen_size := DisplayServer.window_get_size()
var accel: float = 1.0
var heading: float = get_rotation() - PI/2 

func thrust():
	velocity.x += cos(heading) * accel
	velocity.y += sin(heading) * accel
	velocity = velocity.limit_length(MAX_SPEED)
	if accel < MAX_ACCEL:
		accel += 0.5
		
func get_heading():
	heading = get_rotation() - PI/2

func screen_wrap():
	if position.x > screen_size.x:
		position.x = 0
	if position.x < 0:
		position.x = screen_size.x
	if position.y > screen_size.y:
		position.y = 0
	if position.y < 0:
		position.y = screen_size.y
	
func _ready():
	position.x = screen_size.x / 2
	position.y = screen_size.y / 2

func _physics_process(_delta):
	if Input.is_action_pressed("rotate_left"):
		rotate(-0.04)
		get_heading()
	if Input.is_action_pressed("rotate_right"):
		rotate(0.04)
		get_heading()
	if Input.is_action_pressed("accelerate"):
		thrust()
	if !Input.is_action_pressed("accelerate"):
		if accel > 1:
			accel -= 0.5
		velocity *= 0.995
	
	screen_wrap()
	move_and_slide()
	
	
		
	print(rotation)
	print("accel: ", accel)
	print("velocity: ", velocity)
