extends CharacterBody2D

const MAX_ACCEL: int = 10
const MAX_SPEED: int = 300
const BASE_DECEL_RATE: float = 0.015
const MAX_DECEL_RATE: float = 0.1
var screen_size := DisplayServer.window_get_size()
var accel: float = 3.0
var heading: float = get_rotation() - PI/2 
var Bullet = preload("res://scenes/bullet.tscn")


func thrust(strength: float = 0.5):
	velocity.x += cos(heading) * accel
	velocity.y += sin(heading) * accel
	velocity = velocity.limit_length(MAX_SPEED)
	if accel < MAX_ACCEL:
		accel += strength	


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


func shoot():
	var bullet = Bullet.instantiate()
	bullet.dir = rotation - PI/2
	bullet.parent_velocityX = abs(velocity.x)
	bullet.parent_velocityY = abs(velocity.y)
	bullet.pos = $Gun.global_position
	bullet.rot = $Gun.global_rotation
	get_parent().add_child(bullet)


func decelerate():
	if (abs(velocity.x) > 10):
		velocity.x = move_toward(velocity.x, 0.0, abs(velocity.x * BASE_DECEL_RATE))
	else:
		velocity.x = move_toward(velocity.x, 0.0, 0.1)
	if   (abs(velocity.y) > 10):
		velocity.y = move_toward(velocity.y, 0.0, abs(velocity.y * BASE_DECEL_RATE))
	else:
		velocity.y = move_toward(velocity.y, 0.0, 0.1)


func update():
	if Input.is_action_pressed("rotate_left"):
		rotate(-0.04)
		get_heading()
	if Input.is_action_pressed("rotate_right"):
		rotate(0.04)
		get_heading()
	if Input.is_action_pressed("accelerate"):
		thrust()
		$flame.visible = true
	if Input.is_action_just_released("accelerate"):
			$flame.visible = false
	if !Input.is_action_pressed("accelerate"):
		decelerate()
		accel = move_toward(accel, 3.0, 0.25)


func _ready():
	position.x = screen_size.x / 2.0
	position.y = screen_size.y / 2.0
	$flame.visible = false


func print_player_info():
	print(rotation)
	print("accel: ", accel)
	print("velocity: ", velocity)
	print("rotation: ", rotation)
	print("Gun rotation: ", $Gun.rotation)

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta: float) -> void:
	
	update()
	screen_wrap()
	move_and_slide()
	print_player_info()
