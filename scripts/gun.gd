extends Node2D


func _ready() -> void:
	rotation = get_parent().rotation
	
func _process(_delta: float) -> void:
	rotation = get_parent().rotation
		
