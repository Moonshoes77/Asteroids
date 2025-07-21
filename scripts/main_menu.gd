extends Control

var Attract_Animation = Attract_Screen.new()

func _ready() -> void:
	add_child(Attract_Animation)

func _process(_delta: float) -> void:
		if Input.is_action_just_pressed("exit"):
			get_tree().quit()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn")


func _on_exit_pressed() -> void:
	get_tree().quit()
