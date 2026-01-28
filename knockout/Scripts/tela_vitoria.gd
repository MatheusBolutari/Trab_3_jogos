extends Control

var tela_inicial = load("res://Cenas/tela_inicial.tscn")
var creditos

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(tela_inicial)
	
func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_button_3_pressed() -> void:
	pass # Replace with function body.
