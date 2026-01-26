extends Node

signal attack

func _on_mao_direita_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		attack.emit("dano")

func _on_mao_esquerda_body_entered(body: Node3D) -> void:
	if body.name == "Player":
		attack.emit("dano")
