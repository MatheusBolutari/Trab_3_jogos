extends Control

var cena_inicial = load("res://Cenas/tela_inicial.tscn")

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(cena_inicial)
