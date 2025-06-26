#TODO: revisit deceleration code.
#TODO: Fix bug that occasionally causes bullets to die early

class_name Player
extends CharacterBody2D

const MAX_ACCEL: int = 10
const MAX_SPEED: int = 300
const DECEL_RATE: float = 0.015
var counter: int = 0;
var accel: float = 3.0
var heading: float = get_rotation() - PI/2 
var Bullet_Instance = preload("res://scenes/bullet.tscn")

signal player_death

func thrust(strength: float = 0.5):	
	if !$thrusterSFX.is_playing():
		$thrusterSFX.play()
	velocity.x += cos(heading) * accel
	velocity.y += sin(heading) * accel
	velocity = velocity.limit_length(MAX_SPEED)
	if accel < MAX_ACCEL:
		accel += strength	


func get_heading():
	heading = get_rotation() - PI/2


func screen_wrap():
	if position.x > Main.screen_size.x + 10:
		position.x = -10
	if position.x < -10:
		position.x = Main.screen_size.x + 10
	if position.y > Main.screen_size.y + 10:
		position.y = -10
	if position.y < -10:
		position.y = Main.screen_size.y + 10


func shoot():
	var bullet = Bullet_Instance.instantiate()
	bullet.dir = rotation - PI/2
	bullet.parent_velocityX = abs(velocity.x)
	bullet.parent_velocityY = abs(velocity.y)
	bullet.pos = $gun.global_position
	bullet.rot = $gun.global_rotation
	get_parent().add_child(bullet)
	$gunSFX.play()


func decelerate():
	if (abs(velocity.x) > 10):
		velocity.x = move_toward(velocity.x, 0.0, abs(velocity.x *DECEL_RATE))
	else:
		velocity.x = move_toward(velocity.x, 0.0, 0.1)
	if   (abs(velocity.y) > 10):
		velocity.y = move_toward(velocity.y, 0.0, abs(velocity.y * DECEL_RATE))
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
		$ship/flame.visible = true
		
	if Input.is_action_just_released("accelerate"):
			$ship/flame.visible = false
			$thrusterSFX.stop()
			
	if !Input.is_action_pressed("accelerate"):
		decelerate()
		accel = move_toward(accel, 3.0, 0.25)
		
	counter += 1
	if counter >= 5:
		$ship/flame.scale.x *= -1
		counter = 0


func _ready():
	position.x = Main.screen_size.x / 2.0
	position.y = Main.screen_size.y / 2.0
	$ship/flame.visible = false

func die():
	print("You dead")
	player_death.emit()
	queue_free()
	
	
func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()
	update()

func _physics_process(_delta: float) -> void:	
	screen_wrap()
	move_and_slide()
