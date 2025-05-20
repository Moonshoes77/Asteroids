extends Node

var input = Array(["", "", "", "", "", "", ""], TYPE_STRING,"",null)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_main_input_stored(_input) -> void:
	input.pop_front()
	input.append(_input)
	check_input()

func check_input():
	if "".join(input).to_lower() == "rosebud":
		print("$$$")
