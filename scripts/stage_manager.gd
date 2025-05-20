extends Node

var stage: int
var lives: int 
var score: int = 0

enum Difficulty {EASY, NORMAL, HARD} 
var input = Array(["", "", "", "", "", "", ""], TYPE_STRING,"",null)
const MAX_INPUT_LENGTH: int = 6


func _input(event: InputEvent) -> void:
	if event is InputEventKey && !event.is_pressed():
		store_input(event)
	#else:
		#pass


func store_input(event):
	input.pop_front()
	input.append(OS.get_keycode_string(event.keycode))
	print(input)
	check_input(event)

func check_input(event):
	if "".join(input).to_lower() == "pissboy":
		print("Pissboy activated!")

func _ready() -> void:
	#print(Difficulty)
	print(input)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
