class_name Asteroid
extends Node2D

@export_range(0.0, 0.9, 0.02) var step_size: float = 0.4
@onready var outline: Line2D = $Area2D/Outline
@onready var collider: CollisionPolygon2D = $Area2D/CollisionPolygon2D

var r: int
var new_points: PackedVector2Array = PackedVector2Array();
var angle: float = 0.0
var velocity: Vector2 = Vector2.ZERO


func _ready() -> void:
	generate()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta
	screen_wrap()
		

func generate() -> void:
	r = randi_range(45, 85)
	outline.width = 3.0
	velocity.x = randi_range(-100, 100)
	velocity.y = randi_range(-100, 100)
	angle = 0.0
	new_points = PackedVector2Array()
	while (angle < TAU):
		var x: float = cos(angle) * r + randf_range(0.0, r * 0.4)
		var y: float = sin(angle) * r + randf_range(0.0, r * 0.4)
		var point = Vector2(x, y)
		angle += step_size
		new_points.append(point)
	new_points.append(new_points[0])
	outline.set_points(new_points)
	collider.set_polygon(new_points)
	
func screen_wrap() -> void:
		if position.x > Main.screen_size.x + 20:
			position.x = -20
		if position.x < -20:
			position.x = Main.screen_size.x + 20
		if position.y > Main.screen_size.y + 20:
			position.y = -20
		if position.y < -20:
			position.y = Main.screen_size.y + 20
	
