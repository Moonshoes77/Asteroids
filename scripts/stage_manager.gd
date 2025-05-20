extends Node

var stage: int
var lives: int 
var score: int = 0

enum Difficulty {EASY, NORMAL, HARD} 
var input = Array([], TYPE_STRING,"",null)


func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		input.push_back(OS.get_keycode_string(event.keycode))
		print(input)
	#else:
		#pass


func store_input():
	pass


func _ready() -> void:
	print(Difficulty)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	store_input()
