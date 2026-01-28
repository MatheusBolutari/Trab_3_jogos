extends Control

var main = load("res://Cenas/main.tscn") 

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(main)

func _on_button_2_pressed() -> void:
	get_tree().quit()
