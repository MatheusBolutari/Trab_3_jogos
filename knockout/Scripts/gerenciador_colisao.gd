extends Node

signal p_hit

func _on_colisao_bd_body_entered(body: Node3D) -> void:
	p_hit.emit()

func _on_colisao_be_body_entered(body: Node3D) -> void:
	p_hit.emit()
