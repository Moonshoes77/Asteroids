extends Node

# Stores inputs received from Main node and checks for cheat strings
#TODO: Add cheat effects
#TODO: Add variable length cheats 

var input = Array(["", "", "", "", "", "", ""], TYPE_STRING,"",null)

func _ready() -> void:
	var main = get_parent()
	main.input_stored.connect(_on_main_input_stored)
	print("cheat_listener loaded")


func _on_main_input_stored(_input: String) -> void:
	input.pop_front()
	input.append(_input)
	check_input()
	


func check_input() -> void:
	match "".join(input).to_lower():
		"rosebud":
			print("$$$")
