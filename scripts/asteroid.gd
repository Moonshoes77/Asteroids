#TODO: Figure out a better way to handle the "constructor" function 'spawn()'
#TODO: Keep velocity from changing to opposite direction when asteroids split

class_name Asteroid
extends Node2D

const step_size: float = 0.4
const ASTEROID_SCENE: PackedScene = preload("res://scenes/asteroid.tscn")
@onready var collider: CollisionPolygon2D = $Area2D/CollisionPolygon2D
var outline: Line2D
var r: int
var new_points: PackedVector2Array = PackedVector2Array();
var angle: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var breaks: int = 0
enum Size {LARGE, MEDIUM, SMALL}
var size : Size 

signal bullet_hit(asteroid: Asteroid)


#Basically a class constructor. 
static func spawn(pos: Vector2, instance_size: Size) -> Asteroid:
	var new_asteroid = ASTEROID_SCENE.instantiate()
	new_asteroid.outline = new_asteroid.get_node("Area2D/Outline")
	new_asteroid.collider = new_asteroid.get_node("Area2D/CollisionPolygon2D")
	new_asteroid.velocity.x = randi_range(-100, 100)
	new_asteroid.velocity.y = randi_range(-100, 100)
	new_asteroid.size = instance_size
	new_asteroid.position = pos
	new_asteroid.new_points = PackedVector2Array()
	new_asteroid.outline.width = 3.0
	
	match instance_size:
		Size.LARGE:
			new_asteroid.r = randi_range(65, 85)
		Size.MEDIUM:
			new_asteroid.r = randi_range(35, 55)
		Size.SMALL:
			new_asteroid.r = randi_range(15, 30)
	
	new_asteroid.angle = 0.0
	while (new_asteroid.angle < TAU):
		var x: float = cos(new_asteroid.angle) * new_asteroid.r + randf_range(0.0, new_asteroid.r * 0.3)
		var y: float = sin(new_asteroid.angle) * new_asteroid.r + randf_range(0.0, new_asteroid.r * 0.3)
		var point = Vector2(x, y)
		new_asteroid.angle += new_asteroid.step_size
		new_asteroid.new_points.append(point)
		
	new_asteroid.new_points.append(new_asteroid.new_points[0])
	new_asteroid.outline.set_points(new_asteroid.new_points)
	new_asteroid.collider.set_polygon(new_asteroid.new_points)
	return new_asteroid


func screen_wrap() -> void:
		if position.x > Main.screen_size.x + 20:
			position.x = -20
		if position.x < -20:
			position.x = Main.screen_size.x + 20
		if position.y > Main.screen_size.y + 20:
			position.y = -20
		if position.y < -20:
			position.y = Main.screen_size.y + 20


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body is Bullet):
		body.queue_free()
		bullet_hit.emit(self)
		queue_free()
	elif (body is Player):
		body.die()


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	position += velocity * delta
	screen_wrap()
	if Input.is_action_just_pressed("Free"):
		queue_free()
	if Input.is_action_just_pressed("Info"):
		print("size: ", size)
