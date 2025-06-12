class_name Asteroid
extends Node2D

const step_size: float = 0.4
const ASTEROID_SCENE: PackedScene = preload("res://scenes/asteroid.tscn")

var r: int
var new_points: PackedVector2Array = PackedVector2Array();
var angle: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var is_breakable: bool = true
var breaks: int = 0

func _ready() -> void:	
	pass


func _process(delta: float) -> void:
	position += velocity * delta
	screen_wrap()
	if Input.is_action_just_pressed("Free"):
		queue_free()


static func spawn(pos: Vector2, scale_factor: float = 1) -> Asteroid:
	var this = ASTEROID_SCENE.instantiate()
	var outline: Line2D = this.get_node("Area2D/Outline")
	var collider: CollisionPolygon2D = this.get_node("Area2D/CollisionPolygon2D")
	this.r = randi_range(45 * scale_factor, 85 * scale_factor)
	this.velocity.x = randi_range(-100, 100)
	this.velocity.y = randi_range(-100, 100)
	this.position = pos
	this.new_points = PackedVector2Array()
	outline.width = 3.0
	
	this.angle = 0.0
	while (this.angle < TAU):
		var x: float = cos(this.angle) * this.r + randf_range(0.0, this.r * 0.4)
		var y: float = sin(this.angle) * this.r + randf_range(0.0, this.r * 0.4)
		var point = Vector2(x, y)
		this.angle += this.step_size
		this.new_points.append(point)
		
	this.new_points.append(this.new_points[0])
	outline.set_points(this.new_points)
	collider.set_polygon(this.new_points)
	return this


func screen_wrap() -> void:
		if position.x > Main.screen_size.x + 20:
			position.x = -20
		if position.x < -20:
			position.x = Main.screen_size.x + 20
		if position.y > Main.screen_size.y + 20:
			position.y = -20
		if position.y < -20:
			position.y = Main.screen_size.y + 20
	
