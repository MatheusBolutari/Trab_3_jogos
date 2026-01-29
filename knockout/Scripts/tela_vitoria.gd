extends Control

var tela_inicial = load("res://Cenas/tela_inicial.tscn")
var creditos = load("res://Cenas/creditos.tscn")

func  _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed() -> void:
	get_tree().change_scene_to_packed(tela_inicial)
	
func _on_button_2_pressed() -> void:
	get_tree().quit()

func _on_button_3_pressed() -> void:
	get_tree().change_scene_to_packed(creditos)
