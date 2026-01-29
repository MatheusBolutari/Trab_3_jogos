extends Control

@onready var v_box_container: VBoxContainer = $VBoxContainer
@export var velocidade : float
var inicio = load("res://Cenas/tela_inicial.tscn")


func _process(delta: float) -> void:
	v_box_container.position.y -= velocidade* delta
	if v_box_container.position.y + v_box_container.size.y < 0:
		get_tree().change_scene_to_packed(inicio)
