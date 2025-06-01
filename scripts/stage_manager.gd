extends Node

var stage: int
var score: int = 0

enum Difficulty {EASY, NORMAL, HARD} 


func _ready() -> void:
	print("stage_manager loaded")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
